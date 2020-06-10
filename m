Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BFAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109ED20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2Pg1DmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgFJCYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:24:49 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120D4C05BD1E;
        Tue,  9 Jun 2020 19:24:49 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r2so478593ioo.4;
        Tue, 09 Jun 2020 19:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WL9w6hwM5zwERLskxjbOw8ThwKl4nB9IVsOxgE1aSfw=;
        b=b2Pg1DmQL9P+qQbJmBlRhO8NtpM4v3VMQ3hqoRVe0OUmgjuHXJJ+Rr5F39s5GpmdXk
         +wjMGJrBl414GoAbQN8cMUvAROoa42COk6SQXHMt7bm95zIzlwAmmBM0p+oiPgdZLVuK
         /hTQPh5DyFQpc1aeP0cmN2YWXrywKrrWLCVXJh8Vp8+3v5FbKoZzJB0T9f3Gx7ONVfxy
         nU5kt9sin5zr/8zBfNCCHUJD3Oh2QS1+XXm6HTliGLMG5L1UHz34nH2/c3CuyT07mkd3
         kSbk1lSZN++4YQN866MC4lXH53k8czjtdWiFvCzeA/XmsxY9xZk0T7sER6W+Hy6Z5itS
         eEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WL9w6hwM5zwERLskxjbOw8ThwKl4nB9IVsOxgE1aSfw=;
        b=q+O+eT8SI9+KqdJRGbSibKVx6zR3VREcxOJa/IT2dH518OVgEuUzPjw6U5WIwzgTAU
         Q5Z7iiHeh9wJ+B/FiGqWm5CCCLFQ+EH0TtvbPSQLBNarQ7IvIIkXRPwSAiAifXLc3zod
         YeSEVJv7N4edPr3HpWmGYybb9PsRnoS1KQ7LGDtVWUYJ6gM5yQTUyjqdFyTETirEgxb8
         KBk9TZaIk/b4sEkRKyOHtpeLztiYYLrKaggzohke/yShqcswHfdexNTNi4ZG6JP5ZPXN
         +wHvk+Wi39BrYZ5+MgXRbm+qYbWNdhGKVV/XEkp1nPlAEwmtIkn//yK3ha5uQ4AaDy4x
         0IoQ==
X-Gm-Message-State: AOAM530pmJbvNJw4iUcmv8uVR0nD4tsio5/xmc6N4K9f2I+QJnV9SgnK
        zdzNR0kWUUCbLCQ4msn4/N+aujX+ymP1KE+WGbo=
X-Google-Smtp-Source: ABdhPJzJL0VW4ZqrcmeuZtWCByNYhsDAOHjCX0d7VNmCxG+zN5Y4+GfRIxYqtLeW9H5uN1evIqiHkRYY0zBAWwV8mZQ=
X-Received: by 2002:a05:6602:2431:: with SMTP id g17mr1167430iob.3.1591755888469;
 Tue, 09 Jun 2020 19:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
 <1591605038-8682-3-git-send-email-dillon.minfei@gmail.com>
 <90df5646-e0c4-fcac-d934-4cc922230dd2@arm.com> <CAL9mu0+__0Z3R3TcSrj9-kPxsyQHKS9WqK1u58P0dEZ+Jd-wbQ@mail.gmail.com>
 <20200609153646.GA17969@lst.de> <031034fb-b109-7410-3ff8-e78cd12a5552@arm.com>
 <b0c85637-4646-614b-d406-49aa72ce52e1@arm.com> <20200609173455.GA25467@lst.de>
In-Reply-To: <20200609173455.GA25467@lst.de>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Wed, 10 Jun 2020 10:24:10 +0800
Message-ID: <CAL9mu0KejK9JRrJg5tFb5xKGjaEYr=XRpvGB2nuBfnhLeBMdng@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm-nommu: Add use_reserved_mem() to check if device
 support reserved memory
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux@armlinux.org.uk, Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

I tested your changes, it's working fine on stm32f429-disco(armv7m,
without cache) board.
you can submit a separate patch for dma-direct support on non-mmu
platform, i will drop mine.

thanks.

best regards.

Dillon,
On Wed, Jun 10, 2020 at 1:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jun 09, 2020 at 05:25:04PM +0100, Vladimir Murzin wrote:
> > Even though commit mentions ARM, I do not see how mmap would continue
> > to work for NOMMU with dma-direct. ARM NOMMU needs it's own DMA operations
> > only in cases where caches are implemented or active, in other cases it
> > fully relies on dma-direct.
>
> > It looks to me that we either should provide NOMMU variant for mmap in
> > dma/direct or (carefully) fix dma/mapping.
>
> I think dma-direct is the right place, the common helpers in
> dma/mapping.c are basically the red headed stepchilds for misc
> IOMMU drivers not covered by dma-iommu only.

Yes, thanks Christoph's input.
