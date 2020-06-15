Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F99BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 01:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F7920714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 01:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btQDyFIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgFOBks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 21:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgFOBkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 21:40:47 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42837C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 18:40:47 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id i1so13776507ils.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 18:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e0R0VcS82iMwtgZz8mDW0AfEhPJWl21echQTG38Nq4A=;
        b=btQDyFItD/dzzYytZaJICxNL2j4kX8r/ybSZ7LZH7D6Cg9pfqseumhhy5dGaFcDKwL
         vC5ek3gz1NJPgcJAaQgroSmJdxB3FIdFdHp1UTleNI+UsMXDmg5lOJArN9D2dI5/k5lK
         NPxZSjIs2qtsY8gITxf566WCJUj/gOAxhywCjNJqLVsR5HvXdMYtShnylghafmW/DH8g
         6UkEz3gi0F8Sg4/4rKMJcYreUhrU7cv5U2t1IsRzfNC2G8/lYNJFF6Q7DXWMECv19n1n
         sJnHSC7c6r5dgNfiGCwRq4NHLtJhh8eqKjR6XwzgmeBy0k9+IoFvT3+um2XnDrB+iPtM
         pn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0R0VcS82iMwtgZz8mDW0AfEhPJWl21echQTG38Nq4A=;
        b=d9oV0i00+F662Y+p88n1bET+po7DLuzc0UQCh0iG6pysaIC8ln6Ier7tpWTa3jK0bE
         VvPzNadednkUQIR8yI6SUK6UPMxuLCi+7D2kZ+A73bPYgz1U3TSIpBNyYMOOWN2NubwR
         7jQH8zgdUJ+HHBtGKz2CBrsadqplesqf0kirTzdctme91OUKAW8+5BfEExlpVGdopoc9
         kxHycvTVn2pgK82OsdWS26SySuKtykFv829znDJRjq3xv+4ib+t0UKo1/eRvZ9ODG/Du
         IRfVeuvcuTptn+pisbVbRY1vp+8ZWpJi5vx1Owrp+rDcOzqFgFaba/W2H43aAAcftXG0
         a+OQ==
X-Gm-Message-State: AOAM532LgN62t/tCaEusuthEiPoMvomKAPuy9TXdEMG4uDRc1ObXUa86
        MHc1LLNO7mTWDor47EwhPIwqyEjeU/QcHFj3SI0=
X-Google-Smtp-Source: ABdhPJyC5GjuCF51Z5GQ47Ise61BeRl68fQIj7IKVEa+S3q0RWKKAaQA5yK+8ufNhfFhpRmFIhI8YFVd1X+yYTrqHPM=
X-Received: by 2002:a92:da03:: with SMTP id z3mr24836292ilm.258.1592185246142;
 Sun, 14 Jun 2020 18:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <37af499e-2b8b-7e78-ed4b-0aaf711fcb38@csgroup.eu> <20200614233235.121432-1-gthelen@google.com>
In-Reply-To: <20200614233235.121432-1-gthelen@google.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 15 Jun 2020 11:40:35 +1000
Message-ID: <CAOSf1CHjrFb3J6t0HQXQVVM-PEgAcaCADA8mcwYVi4mpq+f3Yw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/powernv/pci: use ifdef to avoid dead code
To:     Greg Thelen <gthelen@google.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 9:33 AM Greg Thelen <gthelen@google.com> wrote:
>
> Commit dc3d8f85bb57 ("powerpc/powernv/pci: Re-work bus PE
> configuration") removed a couple pnv_ioda_setup_bus_dma() calls.  The
> only remaining calls are behind CONFIG_IOMMU_API.  Thus builds without
> CONFIG_IOMMU_API see:
>   arch/powerpc/platforms/powernv/pci-ioda.c:1888:13: error: 'pnv_ioda_setup_bus_dma' defined but not used
>
> Move pnv_ioda_setup_bus_dma() under CONFIG_IOMMU_API to avoid dead code.

Doh! Thanks for the fix.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
