Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9969C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8152465A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EXJ9Jpxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgAOWoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:44:10 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37546 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbgAOWoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:44:10 -0500
Received: by mail-vs1-f68.google.com with SMTP id x18so11502956vsq.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 14:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbsE7yB3eGOjL7w6M5aCw+NaQ3bQ1Ie1J3/rIfgrCSM=;
        b=EXJ9JpxfQFkpbNO5ovU9r+uWdsKb6mmP3FVs0MzgAX1M0W5ezFJiXtx8rkazXI2s1M
         +fUMgeM4ULCcj/ldqsgpEm3+8rYCC0mLe1fn9fAoRPYgkZL+X4xaIE0elUZk9iBF++/y
         oNXg8Luw40ipFqpEBdGl33Y8JFZRautwdT438=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbsE7yB3eGOjL7w6M5aCw+NaQ3bQ1Ie1J3/rIfgrCSM=;
        b=Kn90VtRfLrp3AMDS9v6B6eg/SUnkw53Bb8elM9HdyIMWs3B4PNsDAGgxQnX8XeZ2pd
         J/QKpedCqcfDIcU5FZaQOlHKjmESrRJUf3Hvm+JHQiAfQNGrXNVDnkNsy78unZqaTiIB
         hGy7CCzm/PN/mysusQtFuJd7yl/ILTfZv6Siy2Fw2jGwhnVPJ2n1ELVDI+nMSTbOATEW
         WFJ22O0GmQOPCRfcB4OWFc41H2+0/i91e3t/fybRYlFEtucO2hWRgbgK7in/r9awe++g
         OQHwdCWtjzO4EJoYqUFmhyCh8HBt2OkazoL/n10wJhVxIwPCyV0mdOIssDNkM7bo1qsJ
         efKA==
X-Gm-Message-State: APjAAAWgKejFhKxm8HuoRTnZhGM0K0SFUHW3qxeqsNfijgsBcMOHd3ZU
        dto1FJstEdkBLZdbX9sFhNcA1iHOxQY=
X-Google-Smtp-Source: APXvYqzB6nsZQwPRnJHvgy4s9KLPkgGj4GQ06WbmLadS0XFU70ayh0pxtkg9E6CAs2ELLjRZ+o/xzA==
X-Received: by 2002:a67:d011:: with SMTP id r17mr5641438vsi.159.1579128248341;
        Wed, 15 Jan 2020 14:44:08 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id k6sm4902533vsc.26.2020.01.15.14.44.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 14:44:07 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id z24so6936147uam.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 14:44:06 -0800 (PST)
X-Received: by 2002:ab0:2006:: with SMTP id v6mr17735083uak.22.1579128246442;
 Wed, 15 Jan 2020 14:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20200110101802.4491-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20200110101802.4491-1-saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Jan 2020 14:43:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Voec=RNabf7eqMDd68J7KCgVpNwvUxaz6SVwGMnrCppQ@mail.gmail.com>
Message-ID: <CAD=FV=Voec=RNabf7eqMDd68J7KCgVpNwvUxaz6SVwGMnrCppQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add iommus property to QUP0 and QUP1
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 10, 2020 at 2:18 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Define iommus property for QUP0 and QUP1 with the proper SID
> and mask. Below SMMU global faults are seen without this during
> boot and when using i2c touchscreen.
>
> QUP0:
> arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 15000000.iommu: GFSR 0x00000002, GFSYNR0 0x00000002, GFSYNR1 0x00000043, GFSYNR2 0x00000000
>
> QUP1:
> arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 15000000.iommu: GFSR 0x00000002, GFSYNR0 0x00000002, GFSYNR1 0x000004c3, GFSYNR2 0x00000000
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Fixes: ba3fc6496366 ("arm64: dts: sc7180: Add qupv3_0 and qupv3_1")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
