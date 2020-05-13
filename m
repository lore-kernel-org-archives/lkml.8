Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA81C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90682065D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389116AbgEMPUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:20:46 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52441 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgEMPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:20:46 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04DFK6RG086103;
        Thu, 14 May 2020 00:20:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Thu, 14 May 2020 00:20:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04DFK6RQ086100
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 14 May 2020 00:20:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200427062117.GC486@jagdpanzerIV.localdomain>
 <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
 <20200428121828.GP28637@dhcp22.suse.cz>
 <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
 <20200428154532.GU28637@dhcp22.suse.cz>
 <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
 <20200429142106.GG28637@dhcp22.suse.cz>
 <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
 <20200513062652.GM413@jagdpanzerIV.localdomain>
 <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
 <20200513100413.GH17734@linux-b0ei>
 <20564555-7b84-f716-5dcd-978f76ad459a@i-love.sakura.ne.jp>
 <20200513095503.7488b0d6@gandalf.local.home>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5f272afb-2d74-c051-ce0a-4332ff080ef3@i-love.sakura.ne.jp>
Date:   Thu, 14 May 2020 00:20:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513095503.7488b0d6@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/13 22:55, Steven Rostedt wrote:
> On Wed, 13 May 2020 20:03:53 +0900
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> 
>> I think that basically only oops (e.g. WARN()/BUG()/panic()) messages worth
>> printing to consoles and the rest messages do not worth printing to consoles.
>> Existing KERN_$LOGLEVEL is too rough-grained.
> 
> Why don't you look into having a "noconsole" command line option that will
> not print anything to the consoles but oops messages.

Well, such global option can be as harmful as "ignore_loglevel" command line
option in that we have to worry about how per-console loglevel can co-exist.

The idea of per-console loglevel is to allow specifying different threshold
based on characteristics of each console while the effect of ignore_loglevel
is to disallow specifying different threshold. (I'm wondering whether
ignore_loglevel should be valid under CONSOLE_LOGLEVEL_SILENT, for
CONSOLE_LOGLEVEL_SILENT says "don't print to consoles" while ignore_loglevel
says "always print to consoles".)

If we want to implement per-console loglevel in the future, shouldn't we first
deprecate the conflicting "ignore_loglevel" command line option (and get rid
of it by asking users to use LOGLEVEL_DEBUG as console loglevel)?

The idea of "noconsole" command line option is to disallow printing almost all
messages regardless of KERN_$LOGLEVEL while the idea of per-console loglevel is
to allow printing some messages based on KERN_$LOGLEVEL.

> 
> Sounds more like what you would like, and something that perhaps would be
> acceptable by the larger community.

More we introduce global switches, more difficult to introduce fine-grained
switches (e.g. per-console loglevel).
