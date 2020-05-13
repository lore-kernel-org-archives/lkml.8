Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73AACA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2CB20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbgEMMew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:34:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728726AbgEMMev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:34:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B4B9AA4F;
        Wed, 13 May 2020 12:34:52 +0000 (UTC)
Date:   Wed, 13 May 2020 14:34:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200513123448.GL17734@linux-b0ei>
References: <20200428121828.GP28637@dhcp22.suse.cz>
 <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
 <20200428154532.GU28637@dhcp22.suse.cz>
 <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
 <20200429142106.GG28637@dhcp22.suse.cz>
 <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
 <20200513062652.GM413@jagdpanzerIV.localdomain>
 <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
 <20200513100413.GH17734@linux-b0ei>
 <20564555-7b84-f716-5dcd-978f76ad459a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20564555-7b84-f716-5dcd-978f76ad459a@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-05-13 20:03:53, Tetsuo Handa wrote:
> On 2020/05/13 19:04, Petr Mladek wrote:
> >> What is wrong with adding NO_CONSOLES ?
> > 
> > How does it differ from KERN_DEBUG? The debug messages:
> > 
> >   + can be disabled via sysfs
> >   + might reach console when this loglevel is enabled
> 
> KERN_NO_CONSOLES is different from KERN_DEBUG in that KERN_NO_CONSOLES
> itself does not affect userspace daemon's judgement (whether to filter
> KERN_$LOGLEVEL messages).

And that is the evil thing about it. It goes around the loglevel
filtering.

The administrator wants to decide what messages are important for him.
NO_CONSOLES would mess with this decision. Some messages would suddenly
get hidden on console but appear in userspace. Users would need to
investigate what the hell is happening. They would need to find the
new sysfs knob to restore the expected behavior, etc.

I am strongly against this.

Please, use the existing loglevels to hide messages on
console. Configure your filter to store them in userspace.

Best Regards,
Petr
