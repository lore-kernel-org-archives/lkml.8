Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC51C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469992071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM0aeA93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbgFOUxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbgFOUxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:53:07 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAC5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:53:06 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id q69so4269701vkq.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rd4Bis913EpujGhElYgLSI0ncb8QZecIrdrVCVnTyvU=;
        b=nM0aeA93ECFWHCKDPneEvVWYbTCJNJCR7S3x/XI/ufOnkzmrXx/3IjGE2e6U8L8IgH
         ey3ihVrxR2tidqY9+CsotwvLuwTjCpwcuUB19G79WA4ZKvcwSVcYdL8vv1G7z8mtFYEG
         PZv1IGvAul6VpAJ9Obe/HowpGv2nXBSlr6DEKQHHelfPpxSnt++GHOTR60oSpOA1j4mi
         u8TpyhMlvdRAJo0iLXKZMo6nXJA3dHaYS/iHz7a1bJv5L0idTgkbPKZQ3tB0qyu2h3+a
         AaIKDsmM4ys66TGHt7yc7LPAKJyxuFzfPa9ifFN/lVdCmIi0UIjnH21JTH5Y/ZHtgaHG
         K+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rd4Bis913EpujGhElYgLSI0ncb8QZecIrdrVCVnTyvU=;
        b=RVuIgKgweHCNv+rnSffsvTZNOtSb7/7i7MD8QegMGUishHuEcWpOYA7BVnwZgqTxyM
         /zYx6E4mZBl50bjYQtWEBhXoBQ0SNOhdcz4r2+fPhURkdyuXTMcQgv9sOruZB9XTLXfN
         IF1Y04fm1OEn/hqTeKtG/XGD3O3bhsmcxG4qajoqZvC4+Ln0DJ800DvnnJsXb/5bovsl
         4qQavwkSY4gKHCEeflSzuI34Fm46GYqlprwPoYC6jKY22v6esBy7phIQXxeZVHss3peZ
         KaUC3LuTyIGT9+WMALYrRq/6COI/rzueFRSGlYOSPAHs4Lsnc4clnbjjGbubhkEEwFwk
         OPLw==
X-Gm-Message-State: AOAM531g0E5KbUFFFLB54LtKt+96Ee/jsc6VtvxLLqWZKje0HiND+e4P
        FrizlEEg/hCpALeQ8+CQM12D54285riWUf9LAg2WuQ==
X-Google-Smtp-Source: ABdhPJzOp7CDb158DLfIByrJ44QMnSbWFFRepHNfECeGsYF3nkqgrk1sY1z0A6P22bD32zGwRbFzq8ir4s8adjYbJWE=
X-Received: by 2002:a1f:a8d0:: with SMTP id r199mr5021498vke.26.1592254386172;
 Mon, 15 Jun 2020 13:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-10-jim.cromie@gmail.com> <20200615132856.GF31238@alley>
In-Reply-To: <20200615132856.GF31238@alley>
From:   jim.cromie@gmail.com
Date:   Mon, 15 Jun 2020 14:52:40 -0600
Message-ID: <CAJfuBxw6Q_Szmzhcjv1fDJN6dULkeSnjvR2KXh0M07OdXwzhVw@mail.gmail.com>
Subject: Re: [PATCH v2 09/24] dyndbg: add maybe(str,"") macro to reduce code
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 7:28 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Sat 2020-06-13 09:57:23, Jim Cromie wrote:

> From my POV this makes the code less readable. Open coding is much
> more clear than an ambiguous macro name.
>
> Best Regards,
> Petr

Im going with Joes approach, which addresses your concerns too

thanks
