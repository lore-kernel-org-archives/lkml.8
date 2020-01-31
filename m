Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D331CC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5192214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580482602;
	bh=Fbo07jQcDehzcQlRBI+lJd0rapqIcWAeWwHOs5pWDU0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kKfojEps2ZwuCrDtwse82vllya5PIJFxDFBRpG55pYmRl/Ygjch2gCGpiyz+c5RaX
	 +TS4N5Xvsw99G8iHgEn5/xklFBSObcAHSNAX3fE/JaL4p+CnE77McSk1nl3MuxOpUs
	 6vhSHH/QGN/MdzhWknzyvzSiovhbEdZTJxY8n+/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgAaO4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:56:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbgAaO4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:56:41 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25312214D8;
        Fri, 31 Jan 2020 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580482600;
        bh=Fbo07jQcDehzcQlRBI+lJd0rapqIcWAeWwHOs5pWDU0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LjM+TLEJnKgOcwwtfkbvxqhOmEgOhgh3vtClqWg2f+oBqlUWyraPTIGWWSLcxgaGE
         6aCUUD835+zmkwOVFAwitulnuTBxL6fptObyDu5FvkTGFZKB8GFPcgxHR5t5fG/wAO
         NjjnlNk86wJMBBXe4NPCkSNR7WEgqAA3/f6ucq+g=
Received: by mail-qt1-f172.google.com with SMTP id w47so5587792qtk.4;
        Fri, 31 Jan 2020 06:56:40 -0800 (PST)
X-Gm-Message-State: APjAAAUdDcb/8zwC5dy7vVqrKCSl+GoNUJMv7h5evn1WcJgFhtA+w+ex
        eQRB+Av7w1UfGIRdqFoUSPgnELBB4/ZKPz5WMg==
X-Google-Smtp-Source: APXvYqwUU7ztApQ6WbiV1zy8jHYJO4SrzOW/4hVpbUEXlnLzCr4/Ofde7F3GuB6r+Rpd4kga4ExE8pOJK1L4+T90Dq0=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr10888419qtp.224.1580482599278;
 Fri, 31 Jan 2020 06:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20200124114914.27065-1-dafna.hirschfeld@collabora.com>
 <CAL_JsqKgNzY=KF8XzuGjw2NogBawfi0gh9ytrk_nw_Ewg2QDdg@mail.gmail.com>
 <9c4a971f-6a65-594e-4a79-9e2aa16e58cb@collabora.com> <d9888d47-f320-57f4-5773-454673e5762d@ti.com>
In-Reply-To: <d9888d47-f320-57f4-5773-454673e5762d@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 31 Jan 2020 08:56:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL8DMhwUhn5RG6X5X=d20rmJyDWx-apecC_eAYLSGQppA@mail.gmail.com>
Message-ID: <CAL_JsqL8DMhwUhn5RG6X5X=d20rmJyDWx-apecC_eAYLSGQppA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fix compilation error of the example in intel,lgm-emmc-phy.yaml
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>, dafna3@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 6:21 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>
>
> On 24/01/20 7:59 pm, Dafna Hirschfeld wrote:
> >
> >
> > On 24.01.20 15:03, Rob Herring wrote:
> >> On Fri, Jan 24, 2020 at 5:49 AM Dafna Hirschfeld
> >> <dafna.hirschfeld@collabora.com> wrote:
> >>>
> >>> Running:
> >>> export
> >>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> >>>
> >>> 'make dt_binding_check'
> >>>
> >>> gives a compilation error. This is because in the example there
> >>> is the label 'emmc-phy' but labels are not allowed to have '-' sing.
> >>> Replace the '-' with '_' to fix the error.
> >>>
> >>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> >>
> >> There's a fix from the author, but you're first to get the fix
> >> correct, so:
> > Oh, sorry, I was not aware of that.
> > Dafna
> >
> >>
> >> Fixes: 5bc999108025 ("dt-bindings: phy: intel-emmc-phy: Add YAML
> >> schema for LGM eMMC PHY")
> >> Acked-by: Rob Herring <robh@kernel.org>
> >>
> >> Kishon, Please apply these soon as linux-next is broken.
> >>
>
> merged now, Thanks!

And please drop or revert this. It's still has failures:

Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dts:23.13-33:
Warning (reg_format): /example-0/chiptop@e0200000/emmc-phy@a8:reg:
property has invalid length (8 bytes) (#address-cells == 2,
#size-cells == 1)
Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dt.yaml:
Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dt.yaml:
Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dt.yaml:
Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dts:21.33-26.13:
Warning (avoid_default_addr_size):
/example-0/chiptop@e0200000/emmc-phy@a8: Relying on default
#address-cells value
Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dts:21.33-26.13:
Warning (avoid_default_addr_size):
/example-0/chiptop@e0200000/emmc-phy@a8: Relying on default
#size-cells value


I'll send out a complete fix and take via the DT tree so maybe we can
have an rc1 that works.

Rob
