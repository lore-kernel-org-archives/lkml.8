Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320EEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DAA2078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gGzsFUEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFMNWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgFMNWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 09:22:09 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF8DC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:22:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g18so9244883qtu.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sF3gKi34xsTEXIQvllX7g+i6XIfblAENNKgle9i5I1M=;
        b=gGzsFUEYTZ45YYyX2GFO7hiIZld+W5DVjPXFl73f5htN40e5xBFreftHUYM7MH8b3S
         R/0GbmwCnzcz/7QMx6Gq1v2xmX2f8PxlizfRp058LCQk+b7Rmmnx2Wjf4zwiSlRnsguZ
         yKVV+3JLXA+4wKkNsDBDMaSKWFVsuTpOc1rFaJDw83kQM4EX7LtSiw4kcX915aRB9mki
         rqVHRX7es+AhFM0PLWuZheWjsiSgiGk0D8JPaiWU4d/x3HivRQq55UNUYiG7x/4+1Qfm
         l3BJpONRpzVqAM/OdMa664rtLr0LkOsBrRxyEz8ZtbJ46n4oDozpH/mZzYey/6mRSiCd
         QB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sF3gKi34xsTEXIQvllX7g+i6XIfblAENNKgle9i5I1M=;
        b=HXWB7pwAAOoc2N30CvuNa/VW7SEeOCCe5sBbrvpaB4/v2nDmeRq356ZVHfZ5KdH4Ud
         BxvDBoNIepMIofZMuPrfyofRZdqtYnT6oYn1VXKnGSyNsqrK/bfZhe20Lwum8T4t9EcG
         jvFtlHyKMjZGeFJ6uO9DR2hqxSB081F+5piCWwWBDN/fdUuoz/nrgTk2IoYdqPOyVC3h
         9HX+R5Sy/uGhOImPZpnG2pDMk8lTbZ9Hy86xmkbtqYIpgCeOGED/osHmgFLzR6I2jfZF
         z7vdQzYBFmVevley226HrGL7dscqVDnPKtzpq+e9lDZpva3I2zmRMzmv3cmgeijUgu1P
         XjOA==
X-Gm-Message-State: AOAM531A8GGTTDnFrcWFLHi7jEtmMfyN9cr3xNh38mih3C4SCPq9UpvY
        MZs1H84fwtmIFApm8ZIs3RD/1x/PeY6gYglCGiBBAZIE
X-Google-Smtp-Source: ABdhPJwc9KSSN0yQfnXu0AhBUxCrBKiH3n8XxcdWZjgDSD6mRDCbz3N6esVmrzlKah0AL85DJBv2qvp0KSjOs5xrZ4U=
X-Received: by 2002:ac8:1bc1:: with SMTP id m1mr7421059qtk.57.1592054526799;
 Sat, 13 Jun 2020 06:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <159192148730.1475.8112596092479045470.tglx@nanos.tec.linutronix.de>
 <159192148975.1475.16272172258276079370.tglx@nanos.tec.linutronix.de> <159192782831.28098.9074267506729348260.pr-tracker-bot@kernel.org>
In-Reply-To: <159192782831.28098.9074267506729348260.pr-tracker-bot@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 13 Jun 2020 15:21:55 +0200
Message-ID: <CACT4Y+Z53-_X0+Bo3uGEgR0Da3oC0V7ROEpkpJPT+OVK1Zj4xQ@mail.gmail.com>
Subject: Re: [GIT pull V2] locking/kcsan for v5.8
To:     pr-tracker-bot@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 4:10 AM <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Fri, 12 Jun 2020 00:24:49 -0000:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-kcsan-2020-06-11
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/b791d1bdf9212d944d749a5c7ff6febdba241771

Thomas, thank you for rebasing all of this!
