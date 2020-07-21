Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FB7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C47721702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XN5HhjfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgGUMRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgGUMRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:17:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675AFC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:17:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 88so10702752wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KT7CX+sV+20uXbQeUHLKwJRh4dFo+b84KZ0oSyhNRfY=;
        b=XN5HhjfATGppAb/bzZwx8DxcgGcmmNsfzUyvlDJbm81UC3NYyMUkLKRGe1kgn+OioN
         wm62TH5oghm13XAMiQZPfo4536IJO2M8FJ48AkSV2otgbMJdjnx0Xbu/FCtqXlq3VIRS
         wz8b04vcCyn7Haf9oOhgl7eESlHwNtiPMKgcTNbJ0GSQP0ntKnyuLUUqii9U6Z8TTReC
         Zt0rgtUu+Fltegl0jRDJKNwDRqqjt1asnuZqJJvXm3llD+6dLI4f25XxShnNoWGYRusB
         Ir+vN0coE9A7NpH/r4VfaGPtx4W0ShW6FBYDR/TLQSsp7kGJaW7izkFCyym4eEGA8Ak1
         k+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KT7CX+sV+20uXbQeUHLKwJRh4dFo+b84KZ0oSyhNRfY=;
        b=rjmumSr3E4zriPSlyM0qTXUeVi/i5G7HLurV159b+xA7pFfIksmPfATn77Z/U/nGHE
         CJ8s7XnLBY1IkOrpTJEgsM6ZyoY/F8lyCEkJ6sHQVjRVE/mrx/cfjk6GpQnfZSlaDGSJ
         xCe+fG93Q7mWOfCvI+fkwBDSrRbgvPD2btng8r3wNrNQvQI1HRhNpUDEsNG7u0RWwsyn
         sbwklWupPQwgRq0USwEVlOC5YMB0DxnwHGt1pDtesmDxK4knTBJy5lYIEJ4y3lfr1GAd
         mx7jgZm8sPOA+LT+BGbrQOq/pRNRBXMPsXNknwhhdH8exKVZOsM2/TTqEsf6vZ/bArYq
         HQVw==
X-Gm-Message-State: AOAM532alb4wsDAZygR5DaiDC4C7sF4My3we8e36PdtWIjycFuyJdgQM
        OVO01YFIcgBgh9dSlA41r9HN8xnD5OPoJr0uwaOtXA==
X-Google-Smtp-Source: ABdhPJx4z7MCM5tpI6zvfRV8FQfJ9qttJ8tedgub4aMmQrbH0qjxyJ964ZeuquruCLa0CB/KJmQaM62p2OFpzYEaoxI=
X-Received: by 2002:adf:f44b:: with SMTP id f11mr14490610wrp.114.1595333830109;
 Tue, 21 Jul 2020 05:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200708164936.9340-1-nsaenzjulienne@suse.de> <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
 <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de> <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
 <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de> <20200721112842.GB27356@lst.de>
 <d073fc344a4ec458aa3456b6838e2000f042f8e2.camel@suse.de>
In-Reply-To: <d073fc344a4ec458aa3456b6838e2000f042f8e2.camel@suse.de>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 21 Jul 2020 17:46:33 +0530
Message-ID: <CAMi1Hd3=ZNBWKoUgFVxxDus==N=70EKdT7j2at6FfPDBCo7PAQ@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 at 17:07, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Tue, 2020-07-21 at 13:28 +0200, Christoph Hellwig wrote:
> > On Tue, Jul 21, 2020 at 01:15:23PM +0200, Nicolas Saenz Julienne
> > wrote:
> > > I'm at loss at what could be failing here. Your device should be
> > > able
> > > to address the whole 8GB memory space, which AFAIK is the max
> > > available
> > > on that smartphone family. But maybe the device-tree is lying, who
> > > knows...
> >
> > Maybe we should give your patch to allocate from CMA but check the
> > address a try?  (just because we can..)
>
> Yes, good idea!
>
> Amir, could you also test this patch[1] (having reverted the one that
> casues trouble) and report on whether it boots or not?

Can't boot with that patch either.

Regards,
Amit Pundir


>
> Regards,
> Nicolas
>
> [1] https://lore.kernel.org/linux-iomhttps://lore.kernel.org/linux-iom
> mu/fe14037b02fd887a73cd91c115dccc4485f8446e.camel@suse.de/T/#t
>
>
