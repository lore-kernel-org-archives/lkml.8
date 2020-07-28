Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65A9C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A8B20792
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3iAUbzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgG1Gdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgG1Gdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:33:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39F0C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:33:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so16179355wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+9ymQbKkfvO2y0f7evJNoJIbYaR/0FS5usSf9zZXVSk=;
        b=X3iAUbzcAVC2eGpCBvjCn4obAVo7l+i3+wwa7yIxH/WmhUWBjuFq7hGzz+fvnSyaAB
         quMvdv5Qi/JkmwdW4QFJllKbLYmPkiabffTbT1uJpqUBUcuN3ybpia01rAKe0pviFXV4
         pn9HVSNZVHlsv3vHcTlRyakcLbag1Lm0myAzUxLVBzeNtZXOhdUpyOnKf7eHu1lRJoRL
         2x+BoJIcXgKB2tderQzucrwj5kbuv3/SQl/n4jod67tA0T/Zb6UilZLrfdQyEbHMZpUm
         nOeYxCxqZKOGnK33Na20Pw/+zsJR0JnXZN5Ljy8cM6+CHnL24CTbRFcq1irhI+CCND/x
         J1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+9ymQbKkfvO2y0f7evJNoJIbYaR/0FS5usSf9zZXVSk=;
        b=cxZsR8LEqV05eprL/fgMnDPCT+w/OEOBBn5ot4yMFfhBjL70xQCiObVyrCIIceWKGF
         Vo5qgch45CNnBlnHydn/ELhlq8SSqDSKkID0C3E1MPNozgXxwl/pyR6mbL2YtKCF9vJP
         KxhatZ6AFlnsLtCu95OmSZ1z7DiB6ItEZ55RFc+j0gTz+mrzXFPYlir+ca4IiBepRR9C
         XqMfrRd1ShNucy5f669Aja0gn+qhHU09Q/H/Jf0pewTQLfaJ2bfJVsSJDgzMzST5kSfM
         AbsLGkCyRGOpwR0k2b8bF0kkZZCSDbyMMpAos36QO81AycwH6PXmBY+HhO1F7z9smJdZ
         9c5A==
X-Gm-Message-State: AOAM532S5PB6lNl3lx7hEa8MXQQ033KV9UQxU+8YKHRCEAE91OIX2UCZ
        7k7H/1fhoKaJdS+x0Bmof3CWfg==
X-Google-Smtp-Source: ABdhPJzjVOkrHdjavp13uvCll7m2KDhHn6VDGg3h7jEdKnRlL7BYK4WvIkBkSIt4th7SG9tF/xjpCw==
X-Received: by 2002:a7b:c921:: with SMTP id h1mr2351362wml.29.1595918020669;
        Mon, 27 Jul 2020 23:33:40 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id c10sm16074682wro.84.2020.07.27.23.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 23:33:40 -0700 (PDT)
Date:   Tue, 28 Jul 2020 07:33:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Subject: Re: [PATCH 2/8] dt-bindings: mfd: Add compatible for the MediaTek
 MT6359 PMIC
Message-ID: <20200728063338.GZ1850026@dell>
References: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1595509133-5358-3-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595509133-5358-3-git-send-email-hsin-hsiung.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020, Hsin-Hsiung Wang wrote:

> This adds compatible for the MediaTek MT6359 PMIC.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
