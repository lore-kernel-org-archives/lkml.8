Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E94C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49B1206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFOv6kzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgG0OEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgG0OEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:04:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192F1C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:04:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so4822940wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9Lfh/dGr1eOGcIybXH7oa9HItDyBtrEU0/0EZ2o/qHc=;
        b=OFOv6kzu0xGaUkx0Zhj3cgtN9Xl05UfmCqlBfS5JCnpeQooIIOZ9VwH91q6G4pva33
         NJXn5ZdwKRhLeyTt0TgrodqIRYE4yFOdTZzMjLyOpLCSb+FavWL8x1YCByZdPPVClIn+
         8+eO2QvuKHCFz19cXxmxg6rVghkfsYHem85c1mf/HbRCtluhX+Od/ciJIiPjGuWP8A9i
         KNim4WblEN+OqlUxCWuQNgTp5adswMDDZnryTMsuaWQj7FYBskYV4B+qSnbR6PuskuWu
         0Xb5iNUS30PIb2enoh3VU3BpIN+Gfk3L+m2EGm+OYuIPR5XncNksqA8zkSudQZKOtDDT
         tuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9Lfh/dGr1eOGcIybXH7oa9HItDyBtrEU0/0EZ2o/qHc=;
        b=QENfGj1ZkVjIfplLPn20A3tqHcIh3fp997/BPXYKpLZH5FrSlE79Fe+oARCyBtOuIn
         Wk0hwi8wWTrWdh/Ys0w212fW9HUyjktEmmN2xDrf/sQtXdoOsP9KwhaCIeQCt1vxLrXQ
         3aXNleN+D/dGH9AVRvP505oU41OQGSpvxO+l68+GXmM4KZSTBPOW/DnVHEXZFdRRZt7s
         e27TNEvIwH5P++NEJ93UvfC3JskiqZp+y8NhW6hU69ylWiSFv/UAOOwdE7bYEisu+Emn
         Epj2UYfyLS0/2/nNUNA6ulznrivziMpzLBtqHTvby/l0dvXBbl0/Jo4indFxxENpx0Ex
         5Lvw==
X-Gm-Message-State: AOAM531W3dLjkXzGmGzRyuuspDOdNCdgCXi9Oxs8tgNWTcKQvl9VrXzT
        dbmuzd19h0zpbmweqSwzhUc3/w==
X-Google-Smtp-Source: ABdhPJxcbEBwafQSECurn85RXLnqsVXFMO7fjGhYRTjczDgafsLd/CAtOzFi0D3zYgsIchyR84jd+w==
X-Received: by 2002:a05:600c:414f:: with SMTP id h15mr21854306wmm.82.1595858647770;
        Mon, 27 Jul 2020 07:04:07 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id s125sm12613185wmf.14.2020.07.27.07.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 07:04:07 -0700 (PDT)
Date:   Mon, 27 Jul 2020 15:04:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Microchip (AT91) SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/16] dt-bindings: atmel-tcb: convert bindings to
 json-schema
Message-ID: <20200727140405.GV1850026@dell>
References: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
 <20200723152639.639771-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723152639.639771-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020, Daniel Lezcano wrote:

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Convert Atmel Timer Counter Blocks bindings to DT schema format using
> json-schema.
> 
> Also move it out of mfd as it is not and has never been related to mfd.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Link: https://lore.kernel.org/r/20200710230813.1005150-2-alexandre.belloni@bootlin.com
> ---
>  .../devicetree/bindings/mfd/atmel-tcb.txt     |  56 --------

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 131 ++++++++++++++++++
>  2 files changed, 131 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
