Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296DDC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 03:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0869B207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 03:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb/74Vi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgGSDnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 23:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgGSDnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 23:43:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90BBC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 20:43:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ch3so8422415pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 20:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1T+jh3W0scfcnuMl49PwBnYGAGM1oxS7ItKUJQINCeQ=;
        b=hb/74Vi3K6fWinqsDmMmRpLg0iU4bTITUl88+EjkSaYsj1wAgJuZG4vRaHVdmKWdG0
         oEOF3tamNVmX5GkgGKnMtxsg+xGCpLue5v3p0akz+ph3pvyYk2hr6Zbnft5a+gk2Sopw
         7w5L7l3pUQ4ot7ZuMZzzaKPROB/PwGHrqkl2qXAQ5bL7pI3RiHXnvpiXvoNFl9Bm5uC/
         HLjfipCUu6vBKMr8K+a4C8tQtPf6PWVr9Nycwzk7284HtBdo9LlLMjiJa8O+f6hZZaYt
         DMAm4+uoJvrbdcStt9c7zAFwrZ2T5d6nCGXfYyXRHNHQIvN0R2FPRo9TXuLg3yj+EfQw
         l2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1T+jh3W0scfcnuMl49PwBnYGAGM1oxS7ItKUJQINCeQ=;
        b=OdRODhaZigo2LGF5vJZ4lKaWyMjldEEVODtu3J2BELZ+44c2ctmP4vZja/5p8ddXjC
         PmAzY5oJ3Jtv6hEAHKpIpYHOhiXAc4bScQQJhlI2e6Y1A9lNLXeXp3RsXrzetDRRwn5M
         AUcMDbOOhdMZdX1Rk978QZpF6jDJ01+P8FO6P7wjAo3DhOWjB167wB4lmx5YwpsMDceu
         Vlp0jK/AYWFbKwg3LeVyT+YKdKiIiuBywVzhg7wSk7ohkH55Mh2CzifHZKdmaW9A50R4
         VY3Eo/MOPjwe//0hNlf9in7CdsocPaWuCLcKX/rzQClhZCcf1xyq90Ew40mJic4inpsp
         VnJA==
X-Gm-Message-State: AOAM532qyLx0zjPvDRVe7geD849TSceQnpBTRhRw1ydmfxYVlFM2RyIg
        6yXt9pnoEQXUuBbYowZeZXU=
X-Google-Smtp-Source: ABdhPJwOzfXrGodK4X9wqgPOinhduh1qLcO2IjhVoI8/76munxpfiVXlFyQSgGn4Vpa9eAPnyzMqpQ==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr13073419plz.8.1595130194284;
        Sat, 18 Jul 2020 20:43:14 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id cv7sm6752345pjb.9.2020.07.18.20.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 20:43:13 -0700 (PDT)
Date:   Sun, 19 Jul 2020 12:43:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
Message-ID: <20200719034312.GA566736@jagdpanzerIV.localdomain>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de>
 <20200718121053.GA691245@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718121053.GA691245@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On (20/07/18 14:10), Marco Elver wrote:
> 
> It seems this causes a regression observed at least with newline-only
> printks. I noticed this during -next testing because various debugging
> tools (K*SAN, lockdep, etc.) use e.g. pr_{err,warn,info}("\n") to format
> reports.
> 
> Without wanting to wait for a report from one of these debugging tools,
> a simple reproducer is below. Without this patch, the expected newline
> is printed.

Empty/blank lines carry no valuable payload, could you please explain
why do you consider this to be a regression?

	-ss
