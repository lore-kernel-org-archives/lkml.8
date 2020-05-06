Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3069C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816832084D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1384l/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgEFCdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729509AbgEFCdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:33:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35C6C061A0F;
        Tue,  5 May 2020 19:33:34 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id t3so539545qkg.1;
        Tue, 05 May 2020 19:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcP618iUXG0oqvLPr7DNo5hRWczpuu2twtPmXxdhVpw=;
        b=R1384l/6yWHB4ooeXERU+zst6yVVl4qdVKUOLKPDL0IFR5k6aI6g7gRjbAuwT4BzKA
         Z6KH+95F2q4yXt//grj2uZFTWLNoNm8Lu5dIBlqAf5q0PVULxKpDhwpgZFvf7hcM1z7o
         JWEEw5dFLm4KLFcz3u7lzAjqWTBHjwaPx8OKXuovGeWFo+iTfTDqNgZ8cVEmx2m0Vs6k
         EANIs7E1P/Hmi/gKrN2ZVtZbqWaVt+JTnGqrK3+DtfWnoQ9itU1GBE/rj7qiUUNBnx8m
         YJeMGceUIQe7nPht9WV59pnmBnFXycdSyUqerr4PwnHuvfUnVMkw7uFBR3BIpqH5dNjA
         mXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcP618iUXG0oqvLPr7DNo5hRWczpuu2twtPmXxdhVpw=;
        b=k8pq+1jvN/xTFQLTx2Sw8R3oL1IKm7Mt5RFCp1vv1izecsHk92eQitkfekL2DQuC85
         YEjESykZugT8ImT1Aa3Zn2kNVPf+Xvx17xqPlY7tyxjpjnq5utcFtj5RlCeDzlRemzuR
         AzQfpQ4c0n8ptexAGLynMpEI6kPi+zGZYVeVLcC2oecCW8tBPyhMBVTuPOBDk9zSshB1
         X5CY0eLMjGZs2N8NxgHsucyaeeWH9IEmaUNvzAmf3XjHFJfiKJtfLlSCOdegsndBkZaD
         nuM7Ky7GrHVtItoRYuKUO6poJMfHTbYQ2+fL/7tAzwUEIJdJS1J4nzFl/wZduauw23og
         Aihg==
X-Gm-Message-State: AGi0PuYAfhpEWmOZfN4PXB7AZ4m/Mx5EsEN5oHIYMzx6tJ6c+SpTzx9U
        Xaj5WPpv1VMokyI1h9KwJv24cakBYcVUr8LemYo=
X-Google-Smtp-Source: APiQypKPqLRAV/6/dDdwBHpa1YXOYCMpbodQ4y1LcTQnjLMmx87XtQKGZI8fOwO9Tnx5Ay5TOzZj8htcdEBmp+Z16mI=
X-Received: by 2002:a05:620a:89d:: with SMTP id b29mr6804070qka.103.1588732414259;
 Tue, 05 May 2020 19:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588320655.git.shengjiu.wang@nxp.com> <a933bafd2d6a60a69f840d9d4b613337efcf2816.1588320656.git.shengjiu.wang@nxp.com>
 <20200501102158.GA5276@sirena.org.uk>
In-Reply-To: <20200501102158.GA5276@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 6 May 2020 10:33:23 +0800
Message-ID: <CAA+D8ANDHHejFD1rYmFOG24yivpEJa+xO-WpVr=Vzfz9yW9H7g@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_esai: Add support for imx8qm
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, May 1, 2020 at 6:23 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, May 01, 2020 at 04:12:05PM +0800, Shengjiu Wang wrote:
> > The difference for esai on imx8qm is that DMA device is EDMA.
> >
> > EDMA requires the period size to be multiple of maxburst. Otherwise
> > the remaining bytes are not transferred and thus noise is produced.
>
> If this constraint comes from the DMA controller then normally you'd
> expect the DMA controller integration to be enforcing this - is there no
> information in the DMA API that lets us know that this constraint is
> there?

No, I can't find one API for this.
Do you have a recommendation?

best regards
wang shengjiu
