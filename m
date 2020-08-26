Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7769F21775
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598450981;
	bh=tFCjOr0R190PpkARyCST3lICzYxM/ZthkVfxCLXvO3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RWgplfijlpfenKa8a8KU2KRsgXs92dv7Blg2j1b5Znk3nJXus0zZ5How4DQ3cEshB
	 UzRdMxlN+Tgf9i69dlat+VM1bNSX2tmWHyWq8f15kQ7arab1sZUSiAVrPE9q/Uf/CJ
	 kCqNckNHxW0m2uwELvVHdlrRlsvMZdr2qnf0cS4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgHZOJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgHZOJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:09:38 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B672177B;
        Wed, 26 Aug 2020 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598450978;
        bh=tFCjOr0R190PpkARyCST3lICzYxM/ZthkVfxCLXvO3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iXopgi9PAVg0rrLF6wEKxQewKaaUQDYBze+2jEaVk3n/xv5J5iZPg1oo+H/0nE+hc
         KIKTV3/yGeCT7/HvF/J1fb2gV8lgEbgzBUkr1M4TMcV96LCqPWZ9wlViOwyWc76+M6
         r+c8g+Lw0+uu2f7K6K2iUb1xLLhkIGlP63ci6O6Y=
Received: by mail-ot1-f50.google.com with SMTP id i11so1580248otr.5;
        Wed, 26 Aug 2020 07:09:38 -0700 (PDT)
X-Gm-Message-State: AOAM530rVZz0VwL5d+lzp4fVJKrrANga4zkcBXFaa150wVo8btuE6gsU
        KCuBM62kD5QmYy0GrMbJfaCtEMXYy6ISuEntJw==
X-Google-Smtp-Source: ABdhPJxb7HPcDBydxGstFvQOelSqMG94Ig9YQ9BwLO3iFb/F7xuuVOY2fu9j0ePFE7T0hzpHztUfdayGVmXN8L1pIJk=
X-Received: by 2002:a9d:7f84:: with SMTP id t4mr10340661otp.192.1598450977458;
 Wed, 26 Aug 2020 07:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200820052827.2642164-1-ikjn@chromium.org> <20200826085450.508556-1-ikjn@chromium.org>
In-Reply-To: <20200826085450.508556-1-ikjn@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Aug 2020 08:09:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLVe2yg8RdSZprV00xu0X32Tk69t_jC1Td-TF+z1BYheA@mail.gmail.com>
Message-ID: <CAL_JsqLVe2yg8RdSZprV00xu0X32Tk69t_jC1Td-TF+z1BYheA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: spi: Convert spi-mtk-nor to json-schema
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 2:54 AM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Convert Mediatek ARM SOC's serial NOR flash controller binding
> to json-schema format.
>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
> v2: remove unnecessary quotes, set interrupts as required,
>     add unevaluatedProperties:false
> ---
>  .../bindings/spi/mediatek,spi-mtk-nor.yaml    | 85 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi-mtk-nor.txt   | 47 ----------
>  2 files changed, 85 insertions(+), 47 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-mtk-nor.txt

Reviewed-by: Rob Herring <robh@kernel.org>
