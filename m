Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFC9C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 18:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A770208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589135711;
	bh=gw0X1uYwEpOlE7m8gpH+rVYWQgSFS085MuL6f5uAZsQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1Kl5yw3dWK/Ff1NhaJUH9AjGf597OU4S0Fjurj1K3sTvT5ButedfooV/e9QR2C/RJ
	 LaLBt0UZwOo1Rb6gNfhnXtCHUDaH556CvoIglUPAn4zYyvyzV3WHOGUiEDlxnkS0fQ
	 5VoTjgh+Cj2ds8wKvGG31peGIlHJnr7w3F0L3iUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgEJSfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 14:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgEJSfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 14:35:09 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5C0C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 11:35:07 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x73so5591793lfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 11:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmGhiEm22t+3OQvDts0G7B0MglaOf7LPWER0GV6uNyI=;
        b=FnNwK+FpYxSe49d2HF2HI88DOsvdX7SLIXAH4QIjADNVX8Unc9CioH4sANmElWVzRY
         KS6OL4IOKrQpg/mOQkEYEEC5ONLCRvfQlJyTg25V777MtM2gNyAJHNG+qwbYKjOXD3bu
         R1cqqjG57VB79qMeUjZa9gGCfcfb6/ox3xyGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmGhiEm22t+3OQvDts0G7B0MglaOf7LPWER0GV6uNyI=;
        b=H8h2kOe74Kl7nZAKxBxQEg3o/VUBAiX2WHSEWPG7SbEVLz8+TR2fGs+FsEZR8OBInR
         F+StZnnz78ZJ0AiINOxnI8qaAo+FxEClMvkgI2Zd2+xEP7k7uxISXdhNOLkj2AUEn9O1
         YwZbv9VdSO1aMv6b23puYmAuPyClwh8jNpTkG4jmTe3etlbCCGbKiNMKn35hnhDRgPfw
         JAGwJ3fstBUh61OQns6UjRnA0cs44eKxhPAqUutK41ODCfodi7XinIAI/1O2J0dhquK8
         q0tRwCaYmiecqlR6Mj4nVL1CsiP7z2R6PiEU+i2ZXnxxAips3ZBHRhUcwvcM5cudUOLq
         nLOw==
X-Gm-Message-State: AOAM533/Azih7XaRU2hEuJAJIoejBo9NiQCn3+4R6tA9d5ft0kUSNv2M
        dyy3TUKgfQ5hpTMUMDMgB1U5ifId8ic=
X-Google-Smtp-Source: ABdhPJwccV4LaWQ7CGzVqWkdwdtKVUjkDn4RU9waI39Ywn7qRetM/ySf3y1rxN5phzhP+lSpxzvn8A==
X-Received: by 2002:a05:6512:691:: with SMTP id t17mr7602176lfe.85.1589135705963;
        Sun, 10 May 2020 11:35:05 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j19sm7929123lfh.19.2020.05.10.11.35.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 11:35:05 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id s9so5588403lfp.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 11:35:05 -0700 (PDT)
X-Received: by 2002:ac2:58c8:: with SMTP id u8mr8563575lfo.142.1589135704829;
 Sun, 10 May 2020 11:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200510122634.GA32616@8bytes.org>
In-Reply-To: <20200510122634.GA32616@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 May 2020 11:34:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wht3yDtJ6zka=DNaB8Nymh-zmUMZhGaC8yFz29nuW-EsA@mail.gmail.com>
Message-ID: <CAHk-=wht3yDtJ6zka=DNaB8Nymh-zmUMZhGaC8yFz29nuW-EsA@mail.gmail.com>
Subject: Re: [git pull] IOMMU Fixes for Linux v5.7-rc4
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 5:26 AM Joerg Roedel <joro@8bytes.org> wrote:
>
>            The first race condition was around
>           the non-atomic update of the domain page-table root pointer
>           and the variable containing the page-table depth (called
>           mode). This is fixed now be merging page-table root and mode
>           into one 64-bit field which is read/written atomically.

This seems a bit odd.

The pointer part is always page-aligned, and the "mode" is just three bits.

Why isn't it just encoded as one pointer with the low three bits being the mode?

The thing is, the 64-bit atomic reads/writes are very expensive on
32-bit x86. If it was just a native pointer, it would be much cheaper
than an "atomic64_t".

                Linus
