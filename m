Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF76C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBEB20738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lXZJddLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgHUKgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgHUKfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:35:36 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8F5C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:35:36 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k12so1221683otr.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfdWudG0h0q5CaIQdMWXtuPOgO5LF8y0CpSBc1t8Vmo=;
        b=lXZJddLsySTWLGE+UKv+3I86NhQqIIkV25M4nrFxsyNqk9bRGqRcr/4gkY5vkypS3r
         wOPaCUxWj0gLJv835VT/xORv9cX8tCUo6OPSPVTSyJeHT2tLG5KU8SaeHkzuAU8g9g3P
         sB8dCJJ+xxPfWuX2xnQJgFAjw346ICZ01pnVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfdWudG0h0q5CaIQdMWXtuPOgO5LF8y0CpSBc1t8Vmo=;
        b=RfqxEKu6RRcXQkLi5yA83jqMquD34Nl2SCyuu7b2XlwDTJIlP8a1n1lGcvdEqboEh7
         E69QWJVlEZJGzjl0wHLIA3Fw3K7F8mIKGB1zkvoFXCmrrJeQLdpR+CoCxC5AHKz7WJli
         z4gRctbtIp1eiiFPqaflxs3nl2pODMRq4RKrU4XhvQ8ctSv20geniWuBf6NUMRBkqKSM
         +A4dE4ziSeAuc/eheH2X+faF3qpKwoahBn4rPkw1704mn5IY2aToDxV9bl1esmQ8CwJU
         f+us6KUcnDHcBErgld/wq4FLTuZXLvLzhKYyqpICrM9J5O2dn5Exw5ajEOaxPZP597wC
         aQGg==
X-Gm-Message-State: AOAM532ODqBj/7pvKHqzVrWYO0h1T4M5LEDXwoVjpv9nxAZ5MJAZvjxF
        j+Sp+SCKgBexI3ouO4OAlFHKOLKKMQRlevRi
X-Google-Smtp-Source: ABdhPJwl9ZFVKWkTOiXwoZYPSAWzvG/od1mfAGxi4QDvY0yFxYFOxcpSNC4icbvUgMN/V1CkSpNUyQ==
X-Received: by 2002:a05:6830:158a:: with SMTP id i10mr1505573otr.72.1598006133116;
        Fri, 21 Aug 2020 03:35:33 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id r5sm297838otq.5.2020.08.21.03.35.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 03:35:32 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id l204so1135605oib.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:35:31 -0700 (PDT)
X-Received: by 2002:a05:6808:196:: with SMTP id w22mr1229658oic.55.1598006131352;
 Fri, 21 Aug 2020 03:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200713060842.471356-1-acourbot@chromium.org>
 <20200713060842.471356-3-acourbot@chromium.org> <CAGb2v66rFAb6eczD=ct68b7Q60ZvFyMCRN6XdY-rUAbk6zVupw@mail.gmail.com>
In-Reply-To: <CAGb2v66rFAb6eczD=ct68b7Q60ZvFyMCRN6XdY-rUAbk6zVupw@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 21 Aug 2020 19:35:20 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXZ4WoRcdpO42RAbBJZGdWteE76=jMM2HjTfMukUYf4Qg@mail.gmail.com>
Message-ID: <CAPBb6MXZ4WoRcdpO42RAbBJZGdWteE76=jMM2HjTfMukUYf4Qg@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] dt-bindings: media: mtk-vcodec: document SCP node
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 3:20 PM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> On Mon, Jul 13, 2020 at 2:09 PM Alexandre Courbot <acourbot@chromium.org> wrote:
> >
> > The mediatek codecs can use either the VPU or the SCP as their interface
> > to firmware. Reflect this in the DT bindings.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > index b6b5dde6abd8..7aef0a4fe207 100644
> > --- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > +++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > @@ -19,7 +19,9 @@ Required properties:
> >  - iommus : should point to the respective IOMMU block with master port as
> >    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> >    for details.
> > -- mediatek,vpu : the node of video processor unit
> > +One of the two following nodes:
> > +- mediatek,vpu : the node of the video processor unit, if using VPU.
> > +- mediatek,scp : the noode of the SCP unit, if using SCP.
>
>                          ^ typo / extra o

Fixed, thanks!
