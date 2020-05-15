Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E86C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B5F205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRA0I55P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgEOHvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726714AbgEOHvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:51:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CBCC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:51:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k13so249689wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hbVzyFGS1UmGEvVIj57oHLIBKMXLaE4t9FY/qY/HWM=;
        b=fRA0I55PCsxOBnUcYqMa2WZtI05hG6KwLouBvGq4PEw6YZmmrCap11xAqL4f+TFlci
         4jBAiBJtif+AK0o1ZKEX4SCHE9oBCddNuun2WN7VlS9TTt0GqBScoJN2u4fbLCehoFo5
         iDVxWOz/sqyy1Rn16DU485TpB3VlSwa6x/2svSQ+Ultn8YFz2a6IWrWdrKrGVlrkIuST
         9Cj3Vw9l6AOb44eeCondkvBsalwoY3Ek2ZvWaE6Kxc2ndAiYvOdbAm+a1RXTlLWFGauh
         9jkEokfw7pmXwygCvykKFjckA5tO6OGcQbPcduCGkH+SaEGR2LhBX5zl0pAa3tcQyQyx
         JauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hbVzyFGS1UmGEvVIj57oHLIBKMXLaE4t9FY/qY/HWM=;
        b=TGN7e09a6EqrYH7eB7u0dubrhtJt5e20FFSkc5MLNBv+VsRHvoiAfZShRBnDye8tyP
         TU6GX2WH8lcoFMvnLkxFGQPNm50jncHyKeN8szHLL3EL7+Jrv54PEOvyVa+sskItRer9
         qHA2v/ZpnzA1nN9Uu+6xvI1XpOxLrR1487dFUNwlWX+uzIu3+Er6U6IVPoQT4ZfOPt1t
         Xv8gU6ss9dB/gRJHmcWsSLeo8fThcwNGgvqK0trrlKWWrfS/r8vvnc+yCjITRQnQsQIt
         +11ELOUlFeolIGNjFgA2BM9IfH4cTdQwbQ5fQ+DvorZrKdO8xxY7sP14buzmVrne0Ul/
         IyfA==
X-Gm-Message-State: AOAM533k6O+nY9nIF6xofmdRfPOjD9/DihTat4eYOoq7iNhuuZcnIUpG
        Huyc0HyDo0xZGrFapQ943g4Rwg==
X-Google-Smtp-Source: ABdhPJzzgIqRYccdOCLaRm5r/FwnYo3XCP3xReZ1daSwHywCpusrhkeHpNhGtbsM39QclzulKTXiaQ==
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr2706089wrr.417.1589529078722;
        Fri, 15 May 2020 00:51:18 -0700 (PDT)
Received: from lmecxl0524.lme.st.com (2a01cb058702ff00bc4b798f4f30d41e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:bc4b:798f:4f30:d41e])
        by smtp.gmail.com with ESMTPSA id m3sm2246686wrn.96.2020.05.15.00.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 00:51:18 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     sudeep.holla@arm.com
Cc:     arnd@arndb.de, catalin.marinas@arm.com, harb@amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        steven.price@arm.com, will@kernel.org
Subject: RE: [PATCH v3 0/7] firmware: smccc: Add basic SMCCC v1.2 + ARCH_SOC_ID support
Date:   Fri, 15 May 2020 09:50:32 +0200
Message-Id: <20200515075032.5325-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506164411.3284-1-sudeep.holla@arm.com>
References: <20200506164411.3284-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Sudeep Holla <sudeep.holla@arm.com>
>
> Hi,
>
> This patch series adds support for SMCCCv1.2 ARCH_SOC_ID.
> This doesn't add other changes added in SMCCC v1.2 yet. They will
> follow these soon along with its first user SPCI/PSA-FF.
>
> This is tested using upstream TF-A + the patch[2] fixing the original
> implementation there.
>
>
> v1[0]->v2[1]:
> - Incorporated comments from Steven Price in patch 5/5
> - Fixed build for CONFIG_PSCI_FW=n on some arm32 platforms
> - Added Steven Price's review tags
>
> v2[1]->v3:
> - Incorporated additional comments from Steven Price in patch 5/5
>  and added his review tags
> - Refactored SMCCC code from PSCI and moved it under
>  drivers/firmware/smccc/smccc.c
> - Also moved soc_id.c under drivers/firmware/smccc
>
> Regards,
> Sudeep

Hello Sudeep,

In case it helps. I have successfully tested the 7 patches series
on some platforms, playing a bit with few configurations.
Qemu emulator for arm64/cortex-a57 with TF-A (v2.x) as secure firmware.
Qemu emulator for arm/cortex-a15. OP-TEE (v3.x) as secure firmware.
A stm32mp15 device (arm/cortex-a7), tested both TF-A (v2.x) and
OP-TEE (3.7.0, 3.9.0-rc) as runtime secure firmware.

Helper functions arm_smccc_1_1_get_conduit()/arm_smccc_1_1_invoke() 
works as expected AFAICT. No regression seen with older secure
firmwares.

For the patches 1 to 6, as I poorly tested [v3,7/7] soc ids,
based on tag next-20200505 [1]:
Tested-by: Etienne Carriere <etienne.carriere@st.com>
Reviewed-by: Etienne Carriere <etienne.carriere@st.com>

For [v3,7/7] firmware: smccc: Add ARCH_SOC_ID support
Acked-by: Etienne Carriere <etienne.carriere@st.com>

[1] 7def1ef0f72c ("Add linux-next specific files for 20200505")

Regards,
Etienne
