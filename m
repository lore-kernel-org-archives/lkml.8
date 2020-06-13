Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBF1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 00:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF37F20739
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 00:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPt/wr9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFMA37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 20:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgFMA35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 20:29:57 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF740C03E96F;
        Fri, 12 Jun 2020 17:29:55 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l12so11743239ejn.10;
        Fri, 12 Jun 2020 17:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HombnuJvbLxDTQ6sqGxdyIkWc6G1lg94qCABceA1Ino=;
        b=VPt/wr9bW7x5xMg3i821agO69xeL0wlCpPbQ465okWfllTGeLkNhlt+/90pxMfhr3d
         myUX3fSJB3N2nWypqya2H9kJF4EKbVOdQeO2ye2hYmot//7HbzbrEwdJLxPBwhY/4bgm
         2CRpCCR44bMqXlPZjvMiaK+P5nNfS+UPfTYnKEU0MhiOiKYWMVwq8TVXIIn1R8IbrPJg
         PNj7CnoGOwV4K5W5FPJ8ilQtQeIM+tXC123TWUTSAQhrzfOwprKdHYSXL5MIrrAWcVk0
         cJhrOWspDDeQ55dgvfFY7Y4fGSWc3TpLCzanOZXzs2/gM+FsP69b9WkPOJ34KJ5P59SP
         Whuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HombnuJvbLxDTQ6sqGxdyIkWc6G1lg94qCABceA1Ino=;
        b=h5rxoS5x2mHkRcMWVaPReNzUgPgCTvRpHCFPoXQEaNHLhnWot6cuNg3x27C9VW7k1r
         68iK+/FUb0b6Smx3bGYZU25EYHqsnHXo/67Li+O/gm518SWvjYCtHLWq+9qB2Wl2555P
         L/RMSPK3JmWHchEVN9Zw1FiYZ+gFo9jV2M2AJlOO4o7HsHIYBKSyfmI/CWGKbpe4wfk5
         U7vv5ONQdDzYvryUTCzoyxFVlmBLCwRP2MhRISdxvDenSj5yZ703DvFTtB68H40cn+h/
         8m7qSrRG0U4Scgv2rJY+cnsxPh43RYhlk1FHJtJXTjdVN3tK9yVgME1/txRGOVI0jnhT
         U4rQ==
X-Gm-Message-State: AOAM531ZJe+0yGh9suABbuXuB8xoW3C1S/ZoF8Ry9IdTEw5D1cimKnJ7
        Lt4ynumeMM39Ax6DAbrMWkCWHHLSKqNoGmWfnQEMPhtd
X-Google-Smtp-Source: ABdhPJx7X94KgqodtNOiXEGPBOHI5pEiVB0IuVvR2Ko2Hgf423ti+OcH9A+8DdYryY37rpvpqfWMLOMr+EuMabIZieg=
X-Received: by 2002:a17:906:6403:: with SMTP id d3mr15322186ejm.386.1592008194697;
 Fri, 12 Jun 2020 17:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200611091139.8525-1-joro@8bytes.org>
In-Reply-To: <20200611091139.8525-1-joro@8bytes.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 12 Jun 2020 17:29:42 -0700
Message-ID: <CAEdQ38G_uCPiZ5voj5QP5H0sPUZjASWLLRGQ=VYaWgo+8FekPw@mail.gmail.com>
Subject: Re: [PATCH] alpha: Fix build around srm_sysrq_reboot_op
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 2:14 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> The patch introducing the struct was probably never compile tested,
> because it sets a handler with a wrong function signature. Wrap the
> handler into a functions with the correct signature to fix the build.
>
> Fixes: 0f1c9688a194 ("tty/sysrq: alpha: export and use __sysrq_get_key_op()")
> Cc: Emil Velikov <emil.l.velikov@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---

Thanks, applied.
