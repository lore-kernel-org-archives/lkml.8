Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C80C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DF420659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny13oo+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgBEJ2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:28:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37196 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgBEJ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:28:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so906998pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 01:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=liob+tcspnBh7kjnzeK4GDhJtl3bgaUNO40RmaJUskg=;
        b=Ny13oo+2/v8HZux/gQqptKX/feLcx/SPhfu1sSFbZGi7EiDPe3YTQ2MIQfV4Hglze5
         Obh0QfSNSthtLjKLd5BSSYrwDRj7lqSe5LASBPEXuZuN5cSXE0P9/2KoAHzgE/RuMEIC
         z3FrE1eXaSEUgn57j7A12rmGdDV2I9N3k3JQKbmgbwdIWvlRqP+t1RDmRQL5sdR28a2+
         gMu05bWsmuh/RuRfYAdSvRIiGuNXHWiogUhG6g91w3OMN5EHMO18AmHbewv37NKCDcvg
         /0CNwvWzFKm8knuGy4NxwGTVEuqz/L6LkmQaJcazaasdwdzxaqwtVL7txzqP1USkjVwe
         GuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=liob+tcspnBh7kjnzeK4GDhJtl3bgaUNO40RmaJUskg=;
        b=GaLm++Lyb3dZmvMK3GrBcvJhZbcWpDzXtmzN8Whq62ohu8Hj2S/OfOVImROfRigxWV
         wLBU3tv0J5uOE3Y+ZHp5icrC+5k/zyVVmLOL+8i/ent6TweY2CbEKJG08sqmzfBSDD3S
         GZXHIK8BYUJUx+vuyaWb4UmAugDa5LuMzO+KgfKNBwZo+7jQc7xcEa/h8iwxMC3WooNC
         67C9a1KDrW6cpWZ68hziSlnqZZkQn0h+oT0i5w6O+mrkhv1TM8AxGHTmLYcCakpPlf+t
         FS4G1ITCT9tiDb2fplbctAu+HZX5W0c7ynBsCjnW62Q6hAKEgPS6IXK775i3kMpyes8L
         diSw==
X-Gm-Message-State: APjAAAUs/A5CzNGTQbxTze4f2ETUbWRg+i+q7I9tYplOXiMq40b48YhR
        3RB/MkDh1ZnRtBA3PRCFuXk=
X-Google-Smtp-Source: APXvYqzUYD89tqXl79RKxou+u3SeMQ0FtR+fULgDjk/MJ00FgHfxk1gW7p/8zC4D8efHq3LFNXJ8ng==
X-Received: by 2002:a62:5447:: with SMTP id i68mr36327053pfb.44.1580894909513;
        Wed, 05 Feb 2020 01:28:29 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id d3sm26115099pfn.113.2020.02.05.01.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 01:28:28 -0800 (PST)
Date:   Wed, 5 Feb 2020 18:28:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        lijiang <lijiang@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
Message-ID: <20200205092826.GL41358@google.com>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
 <20200205044848.GH41358@google.com>
 <20200205050204.GI41358@google.com>
 <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
 <20200205063640.GJ41358@google.com>
 <877e11h0ir.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877e11h0ir.fsf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/05 10:00), John Ogness wrote:
> On 2020-02-05, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >>>> So there is a General protection fault. That's the type of a
> >>>> problem that kills the boot for me as well (different backtrace,
> >>>> tho).
> >>> 
> >>> Do you have CONFIG_RELOCATABLE and CONFIG_RANDOMIZE_BASE (KASLR)
> >>> enabled?
> >> 
> >> Yes. These two options are enabled.
> >> 
> >> CONFIG_RELOCATABLE=y
> >> CONFIG_RANDOMIZE_BASE=y
> >
> > So KASLR kills the boot for me. So does KASAN.
> 
> Sergey, thanks for looking into this already!

Hey, no prob! I can't see how and why that would be KASLR related,
and most likely it's not. Probably we just hit some fault sooner
with it enabled.

So far it seems that reads from /dev/kmsg are causing problems
on my laptop, but it's a bit hard to debug.

Nothing printk-related in my boot params.

	-ss
