Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32412C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4C52084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgAOVKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:10:19 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57708 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgAOVKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:10:19 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 00FLA4QN086498;
        Thu, 16 Jan 2020 06:10:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Thu, 16 Jan 2020 06:10:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 00FL9xV5086456
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 16 Jan 2020 06:10:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch] mm, oom: dump stack of victim when reaping failed
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <alpine.DEB.2.21.2001141519280.200484@chino.kir.corp.google.com>
 <20200115084336.GW19428@dhcp22.suse.cz>
 <9a7cbbf0-4283-f932-e422-84b4fb42a055@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.2001151223040.13588@chino.kir.corp.google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <84fddb8e-a23b-e970-c8e9-74aa2fe2716d@i-love.sakura.ne.jp>
Date:   Thu, 16 Jan 2020 06:09:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001151223040.13588@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/01/16 5:27, David Rientjes wrote:
> I'm 
> currently tracking a stall in oom reaping where the victim doesn't always 
> have a lock held so we don't know where it's at in the kernel; I'm hoping 
> that a stack for the thread group leader will at least shed some light on 
> it.
> 

This change was already proposed at
https://lore.kernel.org/linux-mm/20180320122818.GL23100@dhcp22.suse.cz/ .

And according to that proposal, it is likely i_mmap_lock_write() in dup_mmap()
in copy_process(). We tried to make that lock killable but we gave it up
because nobody knows whether it is safe to do make it killable.
