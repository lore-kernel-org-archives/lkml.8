Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF4EC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED4820732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEVQs03g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgCSICC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:02:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40797 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCSICC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:02:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so721604plk.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 01:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u9I0K1i6lFI4gaPnMkUskjsZvi7Mdl+pohuc3TDlzKo=;
        b=GEVQs03gACbZupRv7CyqkNCE3CBeiq3/FPKXyXCXOH8lDEtiLQ0qdAxd01QgR1NZAh
         lCV0cOzxIWKZVuOSoEM2W2O2bFRtpfmz7zfPKcioBYDWm5alhAVWqicfDcdpItjmK8Nn
         H/hOGO13MskJfqDqYqv6bnsZSNbN8Gq0gJIKLazYvsFU72BSJRe+MGWAd9m7vmPcLnsf
         PFcULofNC1OhaVZ68ZsWZVDa17G1rd5zy8tsA7pzFFtGip/ZAHnS38zGSZO2/ovH9o9S
         1gbfKVzzTj4ETAAgsL9+MT2CckKm88qzKA8vUhJduvUM+0ITPzsv4wWsiwG8DoS+GrG5
         sH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=u9I0K1i6lFI4gaPnMkUskjsZvi7Mdl+pohuc3TDlzKo=;
        b=jLN3ULdczALh2uxGFrmXSJHUY/GnfTB7frDTGNPV9//hVVhQoaJVnNdOdPZomuxVx2
         2/sQyiKno+pG1LafsAuIzybbeRAoC3W++OMADa3iSBVp7F5SqAlaPZEoBzy7qYdjJ6R1
         e9GyZtKf4UYEAGOza0eEtmHunGH/B/TWWrxzqHEmj4MnqX/Lttq9gJ3R15Kt9AAt9zRQ
         CdNPt4gCmhWnHPuzwyeiWwAZbNSuGZ62e0TIWeF5CN+KBftvpzbYsuVPq5KnuYJfSHQL
         tkjaZV9Jh8NUiZiHN25j8V7+0Xdv5nP92DA+i8n0ayL7/bu/m6pGbIOv2XNKdeGA0WUi
         pazA==
X-Gm-Message-State: ANhLgQ2bwyKzjmWrGB1M5sziGlK0/dp6Y/fEGVG1XLvX0e3ZhKkNKpol
        UUY/s+VDwJmTL5p7EDj7ygo=
X-Google-Smtp-Source: ADFU+vvJq5VhiLkbqqQdObaWi+FRjyyWdGunx5t0D1/8ovc39pQQMh6BZiZyvUtO37ZmI9qqWJBzHw==
X-Received: by 2002:a17:90a:ff05:: with SMTP id ce5mr2370717pjb.83.1584604919731;
        Thu, 19 Mar 2020 01:01:59 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e14sm1344303pfn.196.2020.03.19.01.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 01:01:58 -0700 (PDT)
Date:   Thu, 19 Mar 2020 17:01:56 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH 3/3] watchdog: Turn console verbosity on when
 reporting softlockup
Message-ID: <20200319080156.GC24020@google.com>
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
 <20200315170903.17393-4-erosca@de.adit-jv.com>
 <20200317021818.GD219881@google.com>
 <20200318180525.GA5790@lxhi-065.adit-jv.com>
 <20200319064836.GB24020@google.com>
 <16373.1584603506@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16373.1584603506@turing-police>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/19 03:38), Valdis Klētnieks wrote:
> On Thu, 19 Mar 2020 15:48:36 +0900, Sergey Senozhatsky said:
> 
> > So the issue is that when we bump `console_loglevel' or `ignore_loglevel'
> > we lift restrictions globally. For all CPUs, for all contexts which call
> > printk(). This may have negative impact. Fuzzing is one example. It
> > usually generates a lot of printk() noise, so lifting global printk()
> > log_level restrictions does cause problems. I recall that fuzzing people
> > really disliked the
> > 			old_level = console_loglevel
> > 			console_loglevel = new_level
> > 			....
> > 			console_loglevel = old_level
> >
> > approach. Because if lets all CPUs and tasks to pollute serial logs.
> > While what we want is to print messages from a particular CPU/task.
> 
> Well... how does this sound for a RFC idea?  We already have CONFIG_PRINTK_TIME
> and CONFIG_PRINTK_CALLER.  How about adding an option to allow printing the
> calling CPU as well, or just extend CALLER to print [pid/cpu] rather than just
> [pid]?

IIRC, CONFIG_PRINTK_CALLER prints pid when printk() caller is a
running task, and CPU-id otherwise.

It was added by fuzzing people, because it's almost (or "simply")
impossible to get through serial logs sometimes.

	-ss
