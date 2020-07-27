Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334BFC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C72D2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nUrbMSi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgG0MX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgG0MX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:23:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C297CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:23:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so13967992wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nW+s+24CRruE/ETffG6i/goItz6RdfmROI5j5D2mpGI=;
        b=nUrbMSi32qTnlizWj2ed73CYqqL2UEIRJSfBhC4w27rQzgnIReWP0XOPaUNo+JWctz
         frlCiEsSZmA2hyZQ5HpVKCFnGZYl+lPl+Qx0BHIt+hQUzMtodGL/o7JeXl/UC7JKezPc
         txWueak5g8ZwzNABvcTREcfAoueC4TLeZUkyJ/U5FWeFkgPObCSuBXpefp2nb2eCAJef
         JjpYq3U+0UgHR6+LG8Flnx/xpdsiiSRYBtJltNr8aCS18xBcVE3tqe0LauWTA6dr9VEN
         C/O2aLSvawlGtMe3krHLPZQs+44hcJx4tHK9HYD+NrPS0d43pTUJlA6NYD7Mia8Pbh5h
         ZGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nW+s+24CRruE/ETffG6i/goItz6RdfmROI5j5D2mpGI=;
        b=cchtRWDhLBKnSdgKgO+T4A9A4gtz4Nh5wE9VK3lU1iUgO/j13AmP+hchrSiEjhAc1c
         jby8ZraZ7Hr0lFpT/Gz5PIN4SIv0BnWOoJ4yKMHaDnhQoxxwupsu3hEApJS+RDi/7tdN
         lqcOcGOO62eps/y8+jXHqe2GdB5VjrmRDRvgZ5SpqNCRg/d/XrUtzy9p0sQsyOP7fD6L
         HHqytrcmar/2XfOjgM/zKVPighMNO1EI/tMtFyRK9VFDKrD82dnwL4JtmQlKuIatI28z
         ERBsufcggxpHMmKyU0ETgY973nfzwdKMwU+/JzxqryPRwJn4W7mDT5u+2aT3EhCGjJb5
         MYcw==
X-Gm-Message-State: AOAM531TOGQualuvHf8lFHnT+psvxseSKNkBQE5F4xnruy3MgRPqFHO7
        /dxBgu4JofLkJ/uapdXlvew9dQ==
X-Google-Smtp-Source: ABdhPJyTzJWxSGenCrXIkNyl8yCaqkpB/ibu0t6p38KrhUVRO3DjN06ogmK5+zlRlA9Ho1syWq7VUA==
X-Received: by 2002:a1c:7313:: with SMTP id d19mr19092272wmb.147.1595852635575;
        Mon, 27 Jul 2020 05:23:55 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id o30sm12516196wra.67.2020.07.27.05.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 05:23:54 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:23:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 7/9] mfd: mt6360: Remove handle_post_irq callback
 function
Message-ID: <20200727122353.GN1850026@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-8-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594983811-25908-8-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Remove handle_post_irq which is used to retrigger irq.

s/irq/IRQ/

> Set irq level low trigger in dtsi to keep irq always be handled.

s/irq/IRQ/g

s/dtsi/Device Tree/

> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c  | 16 +++-------------
>  include/linux/mfd/mt6360.h |  2 +-
>  2 files changed, 4 insertions(+), 14 deletions(-)

Once the above is fixed, please apply my:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
