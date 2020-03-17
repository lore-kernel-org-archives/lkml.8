Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E754C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDD5205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584452042;
	bh=ubR0JrKy3jQmSPnc1EN0k8pifk/MO4gNg2fiNHZs1bk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ownvvRVVOVx7KP3WGbvOwMDZKTV4xsEFiOavHpj2AmCKhw/MG9F6h1klhAvR2PM1/
	 T099kbr0ptTGs/2CldFec6UKDOyege6YhQWPzUUA0Us1r95JsJpJUvDp00yb5w6tzN
	 ynnMCLRDElXsrOiqYeWljs97zXkOfaNFStPNrftc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCQNeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgCQNeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:34:00 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46A0A2075E;
        Tue, 17 Mar 2020 13:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584452039;
        bh=ubR0JrKy3jQmSPnc1EN0k8pifk/MO4gNg2fiNHZs1bk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g3CzeVFOQaYZV9EheV69Kl+xkmd1VoLN2Wadwenh/r8KcYQ60hrSyk5Lbn1PK30sK
         Q4CytD2x0XH9MlGQyMissAw5uULD8w7X0phEjWX4dUJ3mwTh0hyJBtx8vSnjEQwCA+
         fIzjtRVSvLR0Q2zQu2wOaLp/d2c1uYoZYTgUNpwk=
Received: by mail-ed1-f52.google.com with SMTP id v6so11328153edw.8;
        Tue, 17 Mar 2020 06:33:59 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3pjZsVoNxCWV1kGT/PaMUH0PhXG9Xu5tNjK/JMr9FdK8+dUOLH
        BSMcceHzfMa48TDB2d8Y131I9dQSa7Q2d4FFrw==
X-Google-Smtp-Source: ADFU+vvl8fdjLZSjGkoy60pvuqiGdObvt/Ojt0xErZdZ41QZdboB+pIFrAwQ1zW7Jvg5alkgMZgvmRSvdeoEemfJOIo=
X-Received: by 2002:a17:906:4bc3:: with SMTP id x3mr4209614ejv.38.1584452037617;
 Tue, 17 Mar 2020 06:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200311071823.117899-1-jitao.shi@mediatek.com>
 <20200311071823.117899-2-jitao.shi@mediatek.com> <c46e49e6-846f-4f41-a8e3-57d5503e1cd7@baylibre.com>
In-Reply-To: <c46e49e6-846f-4f41-a8e3-57d5503e1cd7@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 17 Mar 2020 21:33:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8B+AS9uUvazfg_OtvnaW8kJVbyNB-FVUYh5MPMuJnf8g@mail.gmail.com>
Message-ID: <CAAOTY_8B+AS9uUvazfg_OtvnaW8kJVbyNB-FVUYh5MPMuJnf8g@mail.gmail.com>
Subject: Re: [PATCH v13 1/6] dt-bindings: media: add pclk-sample dual edge property
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com, linux-mediatek@lists.infradead.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

I agree with Neil, so please base on Boris' effort to negotiate with bridge=
.

Regards,
Chun-Kuang Hu

Neil Armstrong <narmstrong@baylibre.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=881=
1=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:53=E5=AF=AB=E9=81=93=EF=
=BC=9A

>
> Hi,
>
> On 11/03/2020 08:18, Jitao Shi wrote:
> > Some chips's sample mode are rising, falling and dual edge (both
> > falling and rising edge).
> > Extern the pclk-sample property to support dual edge.
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/media/video-interfaces.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/media/video-interfaces.t=
xt b/Documentation/devicetree/bindings/media/video-interfaces.txt
> > index f884ada0bffc..da9ad24935db 100644
> > --- a/Documentation/devicetree/bindings/media/video-interfaces.txt
> > +++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
> > @@ -118,8 +118,8 @@ Optional endpoint properties
> >  - data-enable-active: similar to HSYNC and VSYNC, specifies the data e=
nable
> >    signal polarity.
> >  - field-even-active: field signal level during the even field data tra=
nsmission.
> > -- pclk-sample: sample data on rising (1) or falling (0) edge of the pi=
xel clock
> > -  signal.
> > +- pclk-sample: sample data on rising (1), falling (0) or both rising a=
nd
> > +  falling (2) edge of the pixel clock signal.
> >  - sync-on-green-active: active state of Sync-on-green (SoG) signal, 0/=
1 for
> >    LOW/HIGH respectively.
> >  - data-lanes: an array of physical data lane indexes. Position of an e=
ntry
> >
>
> This changes the bus format, but we recently introduced a bus format nego=
ciation
> between bridges to avoid adding such properties into DT, and make bus for=
mat setup
> dynamic between an encoder and a bridge.
>
> It would be great to use that instead.
>
> Neil
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
