Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCEAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E6F208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391007AbgF2V2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbgF2Smn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:43 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C04C031C72
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:05:31 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w17so14451735oie.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rX104BbGwOQ14WsCLGGZ1Udo7R4aRoXzrV5bYBGECLY=;
        b=pW4C4F/OUJpdUCOrpTi2yo30JR7s34mAU9cr4kTkBCrwRYnsbFz50WNJ8XS75uUXgC
         sCCKpfSSc+ShGdkG4VdSREK/ckIdyGjrednyaasSM78yfiaMeWsWvJlb6Bo/vjHOdcJF
         YJH+YZnsD/KMCiKz2RCsDCKG5mvYMtIOqAWj7+P26Z4YAMc0tcmL0sM2hAygR6YC/buF
         HkAy0HK1Y2lkD/UzQnyDztiHChBMe+HAXTx6zDLlEo4WMMQ3I/AZ9XC3FFwek9H5YsMJ
         Z8jRcJdkFIPztxeBSEdOorABLZ5jvjM5Trj5/zwC6Gy/AmayH5grRmUjmJq5nimhLj6L
         MVMQ==
X-Gm-Message-State: AOAM530HTxA3njjSWk1v1VZtN7mzaqyxfPqhgWQa/OHHmThYE7dLbsoF
        VPkUokgk/KcXi08uuEZxU6BpOPaQmuwFWEVHuxgT0w==
X-Google-Smtp-Source: ABdhPJwsvity5Fqa3Bi5hbSxakVB8FJykdbCncdXMItCKPpxk9NXvAeHCG+2YII5PZLpL5lQcwoU0I3VjdwnVcZx9k8=
X-Received: by 2002:aca:1801:: with SMTP id h1mr8338348oih.148.1593453930463;
 Mon, 29 Jun 2020 11:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200527133942.GA10408@embeddedor>
In-Reply-To: <20200527133942.GA10408@embeddedor>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jun 2020 20:05:19 +0200
Message-ID: <CAMuHMdUXaW9PwBcLwct5S=dUduN9drpZ5nMYdB_QvpVpeK=V1Q@mail.gmail.com>
Subject: Re: [PATCH] m68k: Use sizeof_field() helper
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:34 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
> Make use of the sizeof_field() helper instead of an open-coded version.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.9 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
