Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3890DCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4252078C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgEMMTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:19:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:42272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEMMTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:19:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D36DAF4C;
        Wed, 13 May 2020 12:19:47 +0000 (UTC)
Date:   Wed, 13 May 2020 14:19:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200513121942.GK17734@linux-b0ei>
References: <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
 <20200428154532.GU28637@dhcp22.suse.cz>
 <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
 <20200429142106.GG28637@dhcp22.suse.cz>
 <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
 <20200513062652.GM413@jagdpanzerIV.localdomain>
 <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
 <20200513100413.GH17734@linux-b0ei>
 <20200513104938.GW29153@dhcp22.suse.cz>
 <d66c38d9-dd97-072d-e1a7-949e9573b38d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66c38d9-dd97-072d-e1a7-949e9573b38d@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-05-13 20:24:24, Tetsuo Handa wrote:
> On 2020/05/13 19:49, Michal Hocko wrote:
> > On Wed 13-05-20 12:04:13, Petr Mladek wrote:
> >> What is so special about  OOM dump task so that it would deserve such
> >> complications?
 
> I don't think dump_tasks() is important information to be printed on consoles.
> But since somebody might think dump_tasks() is important information to be
> printed on consoles, I suggest switching KERN_NO_CONSOLES using e.g. sysctl.

You might achieve the same with DEBUG loglevel. Or do I miss anything?

> There is per-console loglevel proposal (which allows selecting "some" console
> backends). But it is based on KERN_$LOGLEVEL which is too rough-grained.

IMHO, developers already have troubles to decide between the existing
8 loglevels. And it is easier because the names describe the severity.

NO_CONSOLES would be different. The effect is almost[*] clear. But only
few people would know the background why it was introduced and where
to use it.

I know that it is meant as a modifier, like LOGLEVEL_SCHED and
KERN_CONT. But this is another reason to avoid it. We already have
huge pain with these two modifiers. They both do not work well.

[*] It will have no effect when it was disabled by a sysfs knob.

Best Regards,
Petr
