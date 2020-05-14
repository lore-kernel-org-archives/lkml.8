Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB5CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B47206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgENQ0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:26:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:59880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgENQ0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:26:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7FF9CACB1;
        Thu, 14 May 2020 16:26:16 +0000 (UTC)
Date:   Thu, 14 May 2020 18:26:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200514162612.GR17734@linux-b0ei>
References: <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
 <20200513062652.GM413@jagdpanzerIV.localdomain>
 <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
 <20200513100413.GH17734@linux-b0ei>
 <20200513104938.GW29153@dhcp22.suse.cz>
 <d66c38d9-dd97-072d-e1a7-949e9573b38d@i-love.sakura.ne.jp>
 <20200513121942.GK17734@linux-b0ei>
 <2173e3ac-7d5e-24da-0c1e-6472df905767@i-love.sakura.ne.jp>
 <20200514080053.GN17734@linux-b0ei>
 <7af6fc77-986a-8a6a-ea93-b807db44413c@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af6fc77-986a-8a6a-ea93-b807db44413c@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-05-14 20:23:55, Tetsuo Handa wrote:
> On 2020/05/14 17:00, Petr Mladek wrote:
> > On Wed 2020-05-13 21:59:23, Tetsuo Handa wrote:
> >> On 2020/05/13 21:19, Petr Mladek wrote:
> >>> On Wed 2020-05-13 20:24:24, Tetsuo Handa wrote:
> >>>> On 2020/05/13 19:49, Michal Hocko wrote:
> >>>>> On Wed 13-05-20 12:04:13, Petr Mladek wrote:
> >>>>>> What is so special about  OOM dump task so that it would deserve such
> >>>>>> complications?
> >>>  
> >>>> I don't think dump_tasks() is important information to be printed on consoles.
> >>>> But since somebody might think dump_tasks() is important information to be
> >>>> printed on consoles, I suggest switching KERN_NO_CONSOLES using e.g. sysctl.
> >>>
> >>> You might achieve the same with DEBUG loglevel. Or do I miss anything?
> >>
> >> Use of KERN_DEBUG affects userspace syslog daemon. We will have to ask administrators
> >> to configure syslog daemon not to filter KERN_DEBUG messages. And administrators will
> >> be bothered by needless KERN_DEBUG messages. Also,
> > 
> > What about using KERN_INFO then? Is there still the same problem?
> 
> dump_tasks() is already using KERN_INFO, and the same problem remains. KERN_INFO cannot
> prevent printk() from printing to consoles unless console loglevel is tuned. And tuning
> console loglevel can prevent all KERN_INFO from printing to consoles. What I want is a
> method for allowing administrators to control whether to print each message to consoles.
> Such method will be by definition controlled via "+ loglevel assigned to each message".

This does not make much sense to me. KERN_NO_CONSOLES would be another
global flag. If you enable/disable its functionality, it would affect
all strings with this flag (not only the ones used by OOM killer).

I am not going to comment the rest. We are going in circles and I do
not know how to better explain my concerns.


> Given that said, if KERN_NO_CONSOLES is not acceptable, I have to again
> battle against Michal Hocko regarding how to offload OOM-related messages,
> like Sergey Senozhatsky estimated
> 
>   "I'd say that lockless logbuf probably will land sometime around 5.8+.
>   Async printk() - unknown."

One problem there is a lack of reviewers.

Best Regards
Petr
