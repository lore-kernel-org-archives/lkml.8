Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A9FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DFC2074B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1blGyMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgEaRV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 13:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgEaRV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 13:21:27 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3386C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 10:21:26 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y123so4328019vsb.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Xa/p3RaMPdMpv3FkdDhw9giyhla/nXQ8S7VUYfYelU=;
        b=N1blGyMGEesI/w0cTCqn1JLZRsPhzLgmL8b7poUytOtcMfxrv/8BRxLI1gEHwW/pHL
         8/JVLy6/khC/1Bd5a6ZtT5+Gt30EBuMTkd4O69hEM/NEtQq99hnfzH7iR+UzQBewM8IC
         w/p4fCwGcgni6uNWXT4gvaT6iSskORVqXmtsbKdl9k4XRmdBy/7AxZYRK2QUl+kBthQ8
         Hp4fLxTq2wkWx6mzf31ZitMBhJ+Yufov4Olvdq2pYcUh9dFlsWFYl76RlywiqptG8tx+
         orBNgugCjNNHIM/oihj8oPAzwfoN9QV9sm9X6DW4jp1cYvm7jFhCxA+L0LaaIkIcPL3p
         TTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Xa/p3RaMPdMpv3FkdDhw9giyhla/nXQ8S7VUYfYelU=;
        b=g+2kL2Flx4EVSyrVLwge9/BNZsNXGrmwl2hC1UUai1Xtdb15f3U/1WD8bymyLo0nCW
         922sFmxvOoqb/Omj7HTo8f+GnS7TjyDuqYDYJtXVahqgL8SZ+eYKMaWQPA5a8ANrYdRB
         U04jk8tpCXawNZnyfVNbaRo66Mv4TO8dugbKsGB95NH/4p0HeryBlA0QMsbcV7YLoCgT
         vmSmeeB9bvz/qa/fb+V/hK5Q9XxVdtch31b1NQCqumX06bc1lguTEeedpYs42E31R6Hn
         w2DybD4Bjydn3xWt2Eg4kow8UEC6/frUa/VM1RUyHSnIyALc0g+WAsvKTuGG1cs3cGBs
         FdQg==
X-Gm-Message-State: AOAM530B0bSiFNlwFiv9pNCyD/Vw4OE9r6ua70osDIWcI5gzuGx2ZEnR
        tjehuZHo2blMaVIlgKqwlji7pMHDt41Mem44mzrUfLSr
X-Google-Smtp-Source: ABdhPJyfvtjYG1xFWvdx3xyMMdPAFclI8zaoUQj5xqoppnPv4mptGwW1XT8bAVegyZzNi/1+UCGvJYjFqK7DpBuKVWE=
X-Received: by 2002:a67:c18a:: with SMTP id h10mr156735vsj.186.1590945686020;
 Sun, 31 May 2020 10:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200531131237.24781-1-realwakka@gmail.com>
In-Reply-To: <20200531131237.24781-1-realwakka@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Sun, 31 May 2020 18:18:12 +0100
Message-ID: <CACvgo50SzjUe6usELF33qXW3BWZmH5U4ynPTBorZLDrG-Nx2Pw@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: Optimize compute_crc(), blend()
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020 at 14:12, Sidong Yang <realwakka@gmail.com> wrote:
>
> Optimize looping pixels in compute_crc() and blend(). Calculate
> src_offset in start of looping horizontally and increase it.
> It's better than calculating in every pixels.
>
When you say "optimize" have you observed any actual benefits of the
patch - be that smaller binary, faster execution time, etc?
If there are - mentioned them in the commit message. Otherwise, it
doesn't optimise anything.

A while back, I've suggested something similar [1] mostly for cosmetic
purposes - doubt there's much benefits beyond that.

HTH
-Emil
[1] https://patchwork.freedesktop.org/patch/365177/#comment_674314
