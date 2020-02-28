Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413C1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD59246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAE+pu2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgB1MCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:02:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33099 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1MCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:02:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so1185492plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 04:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yoYBPtnaZb+dsaMtRbFZZgJjJNpEV4Emt5G/64vjIWo=;
        b=CAE+pu2wC+YkG0I7jOxQCWrI6Fdvpu2buiDlT0jVEGbFPXVKals0sZ+UTHnOqE8rMx
         HjyA8U9+dIL+DtbhHoR+gnrlv1ZgoUCJNVW9QsLYctJ5kB2j5lFYLBMoidLgQHfFy7eM
         7EB3lZaF0ZrGq5lg08DnbnzgjM2pFtgiWOXVch8wP/EduHbzKYLIMvzXGpVzUe86vG2h
         ovc3X1dGximw6Cl4Gky1LYv8G95MWSehhO1bIfrx138neNKPdJooFY3PmJEHqZpmEDWc
         c1ByryRyuXCGYZa+PlGAisDbPDKHRmv+BWCwCm1Lzk6CoDv2UUjOSpDcwlORgpgPTZH0
         Mv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yoYBPtnaZb+dsaMtRbFZZgJjJNpEV4Emt5G/64vjIWo=;
        b=trcC1rxd2JMymuYTw3kLJE28vr+5LBYq0K9Roem73W6f+uxfOKmNtHWUaSDoGAS2l1
         gpQjzepc8z2q8Ss8AIPSsz6ayDP5kTvAzd1rFEBVhwmKWsiP4UKsEogRVa9Kqt2oC+c6
         9Dz9JmGcHi1zBfKaezFXLKXPiHyk6pK43xm5nKLyMxDT4eZj+JrltEXFzNwpAD5zRIGR
         IEv5tr+/4rFzWzEGfUVx38MVxJaIJtNXJxYSd30avFCYAh8M6UfN4g/eA2D+4ySwjbbc
         cPYtfV13Fu3kIk3T9X2V+ansBiGIUq3getVy4jbOGm9asqaykVL/y/AfRTyERelF5RXO
         lFqg==
X-Gm-Message-State: APjAAAXfxGbOgb2PSHu5V3OHDglrwOZwss26Z37x70OpiM17VJ122G46
        InUDuPTt1U4tr5f6zDpwj0c=
X-Google-Smtp-Source: APXvYqwMRB1regKmf+96/BYuMzBSmytSq2FcvdNSrcw6s2IWpNDG8HElcrkRkS+xK1l93dpdmuLBLg==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr3830593plk.121.1582891361330;
        Fri, 28 Feb 2020 04:02:41 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id w11sm10182347pgh.5.2020.02.28.04.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 04:02:40 -0800 (PST)
Date:   Fri, 28 Feb 2020 21:02:38 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Message-ID: <20200228120238.GC121952@google.com>
References: <aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com>
 <20200227123633.GB962932@kroah.com>
 <42d3ce5c-5ffe-8e17-32a3-5127a6c7c7d8@camlintechnologies.com>
 <e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com>
 <20200228031306.GO122464@google.com>
 <87r1yfvzy5.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1yfvzy5.fsf@linutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/28 10:11), John Ogness wrote:
[..]
> >> >>> My test scenario for bisecting was:
> >> >>> 1. run 'dmesg --follow' as root
> >> >>> 2. run 'echo t > /proc/sysrq-trigger'
> >> >>> 3. If trace appears in dmesg output -> good, otherwise, bad. If trace doesn't appear in output of 'dmesg --follow', re-running it will show the trace.
> >> >>>
> >> >>> I ran my tests on Debian 10.3 with configuration based directly on one from 4.19.0-8-amd64 (4.19.98-1) in Qemu.
> >> >>> I could reproduce the same issue on several boards with x86 and ARMv7 CPUs alike, with 100% reproducibility.
> >
> > This is very-very odd... Hmm.
> > Just out of curiosity, what happens if you comment out that
> > printk() entirely?
> >
> > printk_deferred() should not affect the PRINTK_PENDING_WAKEUP path.
> 
> It is the printk_deferred() causing the issue. This is relatively early,
> so perhaps something is not yet properly initialized.
> 
> > Either we never queue wakeup irq_work(), e.g. because
> > waitqueue_active() never lets us to do so or because `(curr_log_seq !=
> > log_next_seq)' is always zero
> 
> wake_up_klogd() is called and the waitqueue (@log_wait) is
> active. irq_work_queue() is called, but the work function,
> wake_up_klogd_work_func(), is never called.
> 
> Perhaps @wake_up_klogd_work gets broken somehow. I'm looking into it.

Thanks.

The interesting part here is that @wake_up_klogd_work is per-CPU. So
while I can imagine that, for instance, boot-CPU would get busted, but
not sure I see why all CPUs would experience problems. Maybe we hit
that randomness warning for every CPU during bring up? Then maybe some
more randomness-related patches need to be backported to 4.19?

	-ss
