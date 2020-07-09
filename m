Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBE3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6031020708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy4sTVlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGIBUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 21:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgGIBUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 21:20:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B206BC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 18:20:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k71so355764pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 18:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9wp2uuYqQCsVKeYWk11GhZvm2h99kAzGdX25kLtU8Hg=;
        b=Hy4sTVlx95tDv2gNZDztajHESAeMZsKHJiZByEsmxmuRkq517MHYCsUEQ/NY0QwOyF
         gW48o1e/2Swyhx5zOk/69yz9nSnn4VDY+IOEXEbBEzVVwK7TLIztlfI/bKtgAIjgnAsB
         9/UtQO6hEHyQ/9z9g9OP6GLhpx3X678s52oYeJGTAhpQ5dIDYZUKsKQZy88bPPXkmN+0
         FpekCDafRfzMDwrE7qos7lPtTnUEQVc7faZj8s0+mxckJs0Hwj4Pr9PzyNoGHsPQC4YK
         fLBuo9BDli693l5K7REN9CF2B+gu6DRgF88m+Fi0yL5H4jL5mB8VeJJ1MnKa9HPof3Po
         wcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9wp2uuYqQCsVKeYWk11GhZvm2h99kAzGdX25kLtU8Hg=;
        b=joj8FFgYONRuo6Ke9vhQG/dhZ6eeacsJiAg/3BvKZEjyom320ol6gPBWPsuQlrneXn
         LbLCVfxUgiuHYjHemVc7EPwVFKRdX+3JdwFaGz6DEwVSlJkIxVMUtimPu2veLJj+wJHD
         kjugkuy5PGJ7vYV7uW2sGogF5+K1RN2NqegAAcPBXqlta3/H820j8DPsGtLG62irseVR
         N5mmtSFFWfz5VxX8xleHQWHke19MMneCd9sQKNlBAJVWoOLVU1ZONuXlq6WYVlxqWCRf
         xvsp0cmk27NiczbkJEH9BsHyTnvmLvTsZJub5U5rSDH/SUZ5+lnIpVN9z0CJb91/NLeb
         DWnw==
X-Gm-Message-State: AOAM5316cNGeuruDUsQbbC+XanBQURfLK9Lny7dTgmUCfZlroeEFqAvB
        biYrnRVWYGogIqvEiHBZIWs=
X-Google-Smtp-Source: ABdhPJy+R1jOF5cWjtikWK3l8SKGr20H6T0uYpLKAT/rxUOKfF8vvUXaHNmzDTeiyzGA/Mc8CJMZxg==
X-Received: by 2002:a17:90a:ce96:: with SMTP id g22mr12475681pju.9.1594257632033;
        Wed, 08 Jul 2020 18:20:32 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 15sm631566pjs.8.2020.07.08.18.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 18:20:31 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 9 Jul 2020 10:20:31 +0900
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
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
Subject: Re: [PATCH v4 3/4] Revert "printk: lock/unlock console only for new
 logbuf entries"
Message-ID: <20200709012031.GA580805@jagdpanzerIV.localdomain>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
 <20200707145932.8752-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707145932.8752-4-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/07 17:05), John Ogness wrote:
> This reverts commit 3ac37a93fa9217e576bebfd4ba3e80edaaeb2289.
> 
> This optimization will not apply once the transition to a lockless
> printk is complete. Rather than porting this optimization through
> the transition only to remove it anyway, just revert it now to
> simplify the transition.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
