Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07444C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66C220738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YgFQOIXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHCKnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:43:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:53999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgHCKnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596451368;
        bh=6ZdvDRYWWS7W/6/oWpKYAUXrrNsMjE9GC1lFAPjaEbw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YgFQOIXpoeE0isYRbE+//h9fGfSrM8aL7YJADOrNEOolBREQDdrjYWZgecMGW2XZb
         0VnfeCrPgyOO4/yLsmGWWlAgaYqFj+dktiNElbM6ZxNilnTrh6W8CQMZBkxMVpHq8O
         EcrdV2wZY/LIQzwVm4qp4DtoT5U/3NqukT++M8hg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.148.26] ([217.61.148.26]) by web-mail.gmx.net
 (3c-app-gmx-bap36.server.lan [172.19.172.106]) (via HTTP); Mon, 3 Aug 2020
 12:42:48 +0200
MIME-Version: 1.0
Message-ID: <trinity-b0ca2ee2-259a-4a1e-86ee-63b093202060-1596451368067@3c-app-gmx-bap36>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Aw: Re: Re: [PATCH v2 1/5] drm/mediatek: config component output by
 device node port
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 3 Aug 2020 12:42:48 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAAOTY__TsqrfRX-z+DE0+X_UzxBqChJ+VdyQG6z9N6Qr4bn2Kg@mail.gmail.com>
References: <20200728111800.77641-1-frank-w@public-files.de>
 <20200728111800.77641-2-frank-w@public-files.de>
 <CAAOTY_8nm0KDHFzOX9+qTTHOUd0Vik063J+rScu_y-hTBTkrCQ@mail.gmail.com>
 <trinity-2bdb3521-256a-4d4d-928a-be9b8c179d4c-1596355539029@3c-app-gmx-bs58>
 <CAAOTY__TsqrfRX-z+DE0+X_UzxBqChJ+VdyQG6z9N6Qr4bn2Kg@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:9vlPvrNuItAQckw+6Ztr8lZ2c93kbfFS161DRt6sRjSdDULNAQlBMNQB3GV/A6BxYIa+v
 0wTqKAVV/0jzVQPBNcW0QKpI8hY0RaP73QzX4DpYLEFzxg5do1dVhrUZZMRaGDDUMWIueRHUlTU8
 I8kQ69OzYmW5ViqJ8J2jSM+k1Q+z19cHIrSuC9bR2diMxNvC4nhekLn41fYjAnG1kO5EkmLO6zLR
 RHumKNb7xPc8lspeBR96Xz/qavYqtpJBM6ZjIZLoFxpmtqsRtVau9sZbJT7FTbu+AgKwRU9KZvCM
 64=
X-UI-Out-Filterresults: notjunk:1;V03:K0:LmNch36Mr4A=:JD93BKiMGIJiXySOkV52id
 N6pKQF65QAVqSn9LU7LQEgkFHs84FX758r47lR3woRap5WbCDsfWaHk1ajDGlpUQMZeEUBOkr
 /CXLr+XW4q5Cw+/voF+S08eF+3mH9gfkiwESM4dbO+WleliG7YY6zguuOTuRtIRgH585NtCML
 E2CjEQ6mzHQfFIMeFSabZnn0/6R/qcSCNNmJX2D3BvTrem1I8gRS3FGix5OT8KNmkBb65Bn2u
 X3xMEnCYZEqIoA+3UHlAlNWyObtxLumQw0lAXqalFnBt8iEAIJju8/qglfgRvnanEvkpZcS+I
 uH81zKy1/XlqfhY/63qGbx0GpwnRgKnPmvXohJLgNooKDKC59kFah8G//BcA5kvxBdhwCZtRt
 8fXByWsWTTKHRD0sUKPFyU0EzTv3675AWMYeDzk334tAGim1t5+LRG4h1akxkT3+UJzcypy62
 2A5EvKQIMV6nMuWNUraGLmJ6zEuwhyYPC6VsEVPzAq2xB3SOn7nU+Y+2FqFdLWbq7Fob4PJca
 CEo/btnLGCfLwrtjRZhp9YkEnPXXf3/xg9ZhklsRFj9KeLYLQOwvuiW6lXK0g2QF/gkzRUXuW
 yeSp30plsVMwxJQJyAw0PJtyopinMrbnaFlbjKTU7Xi1aO0Dp2P+0Wjb+CSCivXbYeRDthqLP
 gzLaSccrtNvAfSVL69W8m3OOtEHw0Oo56mu5ZwjmvWD0UzHr6lgPHjmVhRPQ8jdoZJOU=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> Gesendet: Montag, 03. August 2020 um 01:47 Uhr
> Von: "Chun-Kuang Hu" <chunkuang.hu@kernel.org>

> Now I just care about the bls to dpi. So in mediatek,disp.txt, you
> just need to add a Optional properties - port (input and output), and
> modify mediatek,dpi.txt for its input port.

you mean something like this is enough:

Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt

   argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.tx=
t
   for details.

+Optional properties:
+- port (input and output) see ../../media/video-interfaces.txt
+
 Examples:

Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt:

 Optional properties:
 - pinctrl-names: Contain "default" and "sleep".
+- port: Input port node with endpoint definition, this can be connected t=
o <chipid>-disp-pwm

 Example:

should i link to pwm/pwm-mtk-disp.txt in doc?

regards Frank
