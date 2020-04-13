Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D692AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F742072A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389805AbgDMW5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:57:01 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:65287 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgDMW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:56:59 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03DMun99007358;
        Tue, 14 Apr 2020 07:56:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Tue, 14 Apr 2020 07:56:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03DMui66007278
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 14 Apr 2020 07:56:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] umh: fix memory leak on execve failure
To:     Vincent Minet <v.minet@criteo.com>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200413154244.18583-1-v.minet@criteo.com>
 <20200413154925.GA18663@criteo.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a4cd5557-2466-7826-bf82-5d91ff96a13c@i-love.sakura.ne.jp>
Date:   Tue, 14 Apr 2020 07:56:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413154925.GA18663@criteo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 2020/04/14 0:49, Vincent Minet wrote:
> In my case, execve fails with ENOENT on a Tomoyo enabled kernel. It doesn't seem
> like CONFIG_BPFILTER and CONFIG_SECURITY_TOMOYO are compatible as it is.

Thanks for the report. Yes, I know this is a potential problem since 3.19 and
this is a practical problem since 4.18, as explained at
https://lkml.kernel.org/r/f8099e95-c0fc-d133-471e-e0ba97d2230e@i-love.sakura.ne.jp .

> 
> The UMH is executed via "do_execve_file", so we'll have bprm->filename set to
> "none". This causes the following call chain to fail and search_binary_handler()
> to return ENOENT.
>   search_binary_handler() ->
>   security_bprm_check() ->
>   tomoyo_bprm_check_security() ->
>   tomoyo_find_next_domain() ->
>   tomoyo_realpath_nofollow()
> 
> I don't really know how to solve this. As I understand it, you really need
> a "valid" pathname for Tomoyo and it's not obvious what that should be for the
> user-mode blob.

It seems that Al wants to change __do_execve_file(), as commented at
https://lkml.kernel.org/r/20200329031702.GB23230@ZenIV.linux.org.uk .
Bringing tomoyo_realpath_nofollow() to __do_execve_file() (in other words,
solve AT_SYMLINK_NOFOLLOW path and !AT_SYMLINK_NOFOLLOW path at the same
time) will be the right (from the perspective of race-free) solution. But
I don't know an API that allows resolving !AT_SYMLINK_NOFOLLOW path starting
 from AT_SYMLINK_NOFOLLOW path. I need to wait for Al, for I can't implement
race-free solution from TOMOYO side.
