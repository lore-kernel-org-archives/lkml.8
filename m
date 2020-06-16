Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A23C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A067F206F7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLqq5y40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgFPIjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFPIju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:39:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5101C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:39:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so19861669wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=WS8mipaniJ0VihXzN7biSHCewF6l4wkB/rU4D5eGpes=;
        b=vLqq5y405sigBGrQHmEMZo110Jl57e7Dxtngm2jX97EBOiuzQdCaf4ZRJ3MLt7hd29
         WLl6Ykpb3FQDmRlAAQrsSm+edWp0cROnB7KbRYspkZK/R4Bu/WCGoPykFsqM/E1LoPA6
         M8iVzYAjxo+W6Kcv3AtuLbTZaYmqtKY/ronbtY1yOzXRJ7WXRENo2RJj4qXRTzjy1JeK
         i63O/a+w/iqr6w6z6CeHYd0jKRsYtr/Fa/Yz3Qd2USKtm20JfRXiVFrYw0oFXFskzvxw
         65jFPhcz3FwfadegSda7S9H+cudJoqvBlcCUMi2RXaOZCfRRxpHntEPs1mMRQ81a+vsJ
         SusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=WS8mipaniJ0VihXzN7biSHCewF6l4wkB/rU4D5eGpes=;
        b=Nz2Szqj30CJo11JOUVdPUjfMDjSCJL90SLplyBdJyspuYR/YvWNhTh+jVV+1AWKcBq
         m+0oZaCb0vnY/SXu0To8gnjx0uChxIj5AVvMLXHhVZOPfU6gtocYTUnAaZALIL45mFyt
         oU84hfXOOVMP8K3b4YV2Ypjea8MGf3+Lr3X0QSK0L6+v+z7H0IrHW0l5lV6gkBb/WErS
         1/stk/b6jFPoGUKyoG2yU4m27mX9WBqDvx3urzW7Td6WDca5jxX5MEMGTBmM4pSOMDcE
         agsr8obucwIdkiICD6ahVA+XK97kbLOgVALcU4RIZyje2S0XzivcD5C18YvwtndHCrl0
         yXPw==
X-Gm-Message-State: AOAM531Ek7aKS2b4SoA8Iyd0yQHbetpT4PrNXjRbr/1ipLGt/YoiApzb
        BT8wq/Pm35eY/W36h3+by4k7XQAsLOM=
X-Google-Smtp-Source: ABdhPJyyPaRA0Ek3ziBQKCIEOsyluTMuHOKbyL5EvEsZp8jwZxQARD1wTq9hR0tb+ZGVzXEVX9jylg==
X-Received: by 2002:adf:e4ce:: with SMTP id v14mr1062959wrm.64.1592296788565;
        Tue, 16 Jun 2020 01:39:48 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id j16sm33443330wre.21.2020.06.16.01.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:39:48 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:39:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD fixes for v5.8
Message-ID: <20200616083946.GN2608702@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.8

for you to fetch changes up to bf6b694a6a908a6fd8f23eada669d1e90b2772af:

  mfd: mt6360: Fix register driver NULL pointer by adding driver name (2020-06-16 09:32:43 +0100)

----------------------------------------------------------------
- Bug Fixes
  - NULL pointer dereference fix; mt6360-core

----------------------------------------------------------------
Gene Chen (1):
      mfd: mt6360: Fix register driver NULL pointer by adding driver name

 drivers/mfd/mt6360-core.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
