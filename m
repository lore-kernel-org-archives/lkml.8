Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A38BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE33207FB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2jt/IiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgFBI2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgFBI2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:28:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849CBC061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 01:28:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so2455708wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=THpbqsIqcsaX8JFjkYqBpTRk1wV1aSkOMzOPc76FV+E=;
        b=Z2jt/IiEH08fKBjSDJW/rFkEDpi1SROeqBKQwYrsMkbHq7Dk0FvTxMe18SCdyWn6DA
         cA7BkgouNeJ2A7P1omaDU8w8B91/5SCDKgmVGagtq0OQs8PrixL9xFUzs+pALxIKecSU
         vOHjiyh7QDf/XqPep7KcBc6jTB9OaU9RYAQ+HSgUTVGn4lLHChfpp4t1Tn9XktuWJbc1
         u9GwPRfQV65HNE4RYo03toMPhu9gqrAotSVEmwwNKMIGcE32PgYrdRKt6LGFszNh4OMG
         tZc6ajirZPPYUDTwyrN/iyIE3WKyotRCT6gJqNAfvU4tXgrLZfMg8HloFXERP7qv8th3
         rILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=THpbqsIqcsaX8JFjkYqBpTRk1wV1aSkOMzOPc76FV+E=;
        b=DVX0EN+3xTFcCoOqSnbVdf9xoPt0Aav2hlqdvMVBJpnsGoHQIwKfQSiWfWrjDCqP1z
         cXa9nzhsDK+wz8zKtIWOPEFzy9PahWJGztb20nxUbj32vObkPUjN3idFwu1E2Ftpa3EQ
         9g2c+R65UTIw2pP+yP1Hb+Gi3EWfvZUU8G9PT2dgv5mb/bd4LTncLfsN2NfnKDc/Mx0R
         UwQngT8sMZTiixPP3sD22kxPZIBeKzmtwWfwSiBDB9RDJhV7Kjk4gk3UUk8309CfXW4F
         /NzB9wV4p2JMu6tfUH8ZiUGyk5JWbq0bXKnPVSIDq0HwQpG75eTE6B2sDqehyPBEgVGB
         ujOw==
X-Gm-Message-State: AOAM530XkJIl3XLrr36Mc7Cwf2TJHgw4GnztPyttHydi6X6gA4ro8Fur
        8xczrDv+AcCfrg7ceYUC8wtx9oq5738=
X-Google-Smtp-Source: ABdhPJyfWM51ssitVrKZ+ILxEdr3bQxiA49aRTHpesRfUbEo6cvOqTynK9IKviDUA5E06Y92l1RKIg==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr26422025wrs.374.1591086498236;
        Tue, 02 Jun 2020 01:28:18 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id l2sm2480817wru.58.2020.06.02.01.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 01:28:17 -0700 (PDT)
Date:   Tue, 2 Jun 2020 09:28:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v10] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20200602082816.GC3714@dell>
References: <1591070142-7653-1-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1591070142-7653-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jun 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Add MFD driver for mt6360 pmic chip include Battery Charger/
> USB_PD/Flash, LED/RGB and LED/LDO/Buck
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I did not sign this off.

> ---
>  drivers/mfd/Kconfig        |  12 ++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/mt6360-core.c  | 424 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6360.h | 240 +++++++++++++++++++++++++
>  4 files changed, 677 insertions(+)
>  create mode 100644 drivers/mfd/mt6360-core.c
>  create mode 100644 include/linux/mfd/mt6360.h
> 
> changelogs between v1 & v2
> - include missing header file
> 
> changelogs between v2 & v3
> - add changelogs
> 
> changelogs between v3 & v4
> - fix Kconfig description
> - replace mt6360_pmu_info with mt6360_pmu_data
> - replace probe with probe_new
> - remove unnecessary irq_chip variable
> - remove annotation
> - replace MT6360_MFD_CELL with OF_MFD_CELL
> 
> changelogs between v4 & v5
> - remove unnecessary parse dt function
> - use devm_i2c_new_dummy_device
> - add base-commit message
> 
> changelogs between v5 & v6
> - review return value
> - remove i2c id_table
> - use GPL license v2
> 
> changelogs between v6 & v7
> - add author description
> - replace MT6360_REGMAP_IRQ_REG by REGMAP_IRQ_REG_LINE
> - remove mt6360-private.h
> 
> changelogs between v7 & v8
> - fix kbuild auto reboot by include interrupt header
> 
> changelogs between v8 & v9
> - fix GPL license out of date
> - add commit message about Acked-for-MFD-by
> 
> changelogs between v9 & v10

v9 of this patch is already applied.

You cannot send a v10.

> - fix duplicate define of kbuild test reboot initializer-overrides

I fixed this already.

https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=098c4adf249c198519a4abebe482b1e6b8c50e47

> - sync commit message format

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
