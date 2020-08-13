Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34CDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741BD20716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7KGzsT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMLzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMLzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:55:33 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554BBC061384
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:54:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p37so2702092pgl.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6TUg3OqVgwPUQPxxlDPJAnVvD/b4nl9aq+UQKwnVlcQ=;
        b=W7KGzsT1W+1I4nEf9dSr4Rb2Al6uyVtrIYFegz9QH2PUdL4l5phEMJJiXc2gDPebi1
         1hLnaVwc52kkz0KQ6fKQNjhZOaxgHHzdw1Euip6gpxDlniZKfwq2HRwP15dqJuz54gBx
         1U18Ei0FeO97sRofUHQjp4RfE9hHb+0dVI4sF/IdjM9tIf8RP3RSXQ+HjQt3zbt+mH8W
         6E7s5MNKR0jfRKJhRpHd4TIyVfdWrua9gzzlm7Cst2XSe7bsvYpSb6WVWKr982wuDnVC
         gbZWo3R1TttYbo/abE64BAybhcVecArX/SIsTfe8h7qQyaMFETOhnn6ViF7vTP3yBw35
         3qZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6TUg3OqVgwPUQPxxlDPJAnVvD/b4nl9aq+UQKwnVlcQ=;
        b=Y+ms7g7AD/ILb7zeTnQdANADbbmXB0ZIMbnoIfYXo7eYyDgMLy0l89mbT6xRKSdpte
         Hy23DZuM3MKnjGDFv0ih3smh50MW63RfvaHwISIXm9cpidAcdadI79BmyfCMnh7uEE1R
         VCPtKgYWliWbUWofVG8h4J0D/+/O1v5gvGUZ/EFHXcjJtfJga4RxJHnJwt4FOxiZ91eg
         WLo1ly/jVtnN+kJ5m643iMxD+cXENECD+cWyepdmUzGjSlK4EFh8hphg7v5trGpMXIIQ
         Wg15nmELEFN+ekyD4sGCTJqDhJrhOd0nzW/igUMgZot3Sc5KZRhCjo3A6dVo2WEkZeOO
         t3YQ==
X-Gm-Message-State: AOAM5304yQ1tYyr74lUpKYMh8WEipRu5ONU/gMJfPQr6MeiZpm69uR+L
        J5e4PGmJm7grU/se0bSvC3P+C40T
X-Google-Smtp-Source: ABdhPJyc89SG6w0uXT54MOk2TmujM6CGfkss+meq1shT/JfMlmW1qipWykw1LDWpkARv48b2+V4KJA==
X-Received: by 2002:aa7:9386:: with SMTP id t6mr4153429pfe.220.1597319678782;
        Thu, 13 Aug 2020 04:54:38 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id m23sm5035651pgv.43.2020.08.13.04.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 04:54:37 -0700 (PDT)
Date:   Thu, 13 Aug 2020 20:54:35 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200813115435.GB483@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813084136.GK12903@alley>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/08/13 10:41), Petr Mladek wrote:
> > My concerns about this idea:
> > 
> > - What if the printk user does not correctly terminate the cont message?
> >   There is no mechanism to allow that open record to be force-finalized
> >   so that readers can read newer records.
> 
> This is a real problem. And it is the reason why the cont buffer is
> currently flushed (finalized) by the next message from another context.

I understand that you think that this should be discussed and addressed
later in a separate patch, but, since we are on pr_cont topic right now,
can we slow down and maybe re-think what is actually expected from
pr_cont()? IOW, have the "what is expect from this feature" thread?

For instance, is missing \n the one and only reason why printk-s from
another context flush cont buffer now? Because I can see some more reasons
for current behaviour and I'd like to question those reasons.

I think what Linus said a long time ago was that the initial purpose of
pr_cont was

	pr_info("Initialize feature foo...");
	if (init_feature_foo() == 0)
		pr_cont("ok\n");
	else
		pr_cont("not ok\n");

	And if init_feature_foo() crashes the kernel then the first printk()
	form panic() will flush the cont buffer.

We can handle this by realizing that new printk() message has LOG_NEWLINE
and has different log_level (not pr_cont), maybe.

Let's look at the more general case:

CPU0					.. CPU255
pr_info("text");
					pr_alert("boom\n");
pr_cont("1);
pr_cont("2\n");

Do we really need to preliminary flush CPU0 pr_cont buffer in this
case? There is no connection between messages from CPU0 and CPU255.
Maybe (maybe!) what matters here is keeping the order of messages
per-context rather than globally system-wide?

	-ss
