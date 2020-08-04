Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0657C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF352067D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Riv8iutg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgHDMol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgHDMoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:44:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BDBC061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 05:44:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r4so34288132wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 05:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYDox3KQ1JETO7R6nCajEi5q9XM0wuEKwlQrdfldtzE=;
        b=Riv8iutgfQUgNDMN92DtQvb/ueHJ6AIreMGAIsPCtm4ILvbZOn+PBNFru/JxFRQn+a
         9TfiKx4DTAO1/mtV9wsMqag4ynofuu+qJ8KcnT0H01tQepbNaqDTZvqQvMuZtPQBOduf
         CxLDVXhPdqFLT0zbGguTGrJKZfH+S/lGnAzhvNTBi0FcUKC5HJp/+r/qZDgMqCN1u61M
         ZIBRfcVMUR48Uz0nrWv/JeBjsaFxjG5I/w8jfhHReJuMa+Pm25oX2mloao7+N1Yr/e42
         uovU2IyFUipCeXc7bYv0WjUNANHbOH3ka4foDQ5we7li93TpmE8H4yyBhs21Q8mbmEQA
         00PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYDox3KQ1JETO7R6nCajEi5q9XM0wuEKwlQrdfldtzE=;
        b=ZZLHpWiZHlxokTjOmhwFzqxUrMAqY7L93vNrv4xnYkR7/uJG21ylZ0PWJ4yG4oABig
         DUyitS1jFkP8MO+CQlEc9vEYjR6Lpem1IRnrIFfLi5L/Y83qMgOMLXVIiCLsQJ659bbA
         PHegsnQuV8xXWOZjuM/3lnt+/mP1kxlLNFmEMhBoXo+5rr1eolahCSb61hxEI+H4z/6W
         VVVg9VKe9Xf9AmP18NlfbphuGk54WFAUGdcTZxmstdjQ9yv0u7s3GR8c2qXkJ8OMHDEH
         tMDf4pX5vY6TuI9b1ADRnHmk4IIhsUu4Z3srWH5OdPOqmSTDHz8lpCCalLjdYsaLd6ob
         CCxA==
X-Gm-Message-State: AOAM532lRmgG7eL5yi9zpQEgux7nQwzyJySjQlUWbnqBDFkil3lK7EPU
        U7RoFwyR7SjAj6L7SQttyiWzPg==
X-Google-Smtp-Source: ABdhPJy369HvI22rb0UHPSZq9AsVjFavkg1pT+b1lsUC4Du192zTR5pC4Bv0+KzFRIkrLbZspUmmgg==
X-Received: by 2002:a5d:6a4a:: with SMTP id t10mr20525689wrw.360.1596545059657;
        Tue, 04 Aug 2020 05:44:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id z207sm4576048wmc.2.2020.08.04.05.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 05:44:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 9DC9E1FF8F;
        Tue,  4 Aug 2020 13:44:17 +0100 (BST)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        christoffer.dall@arm.com, maz@kernel.org,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH  v1 3/3] kernel/configs: don't include PCI_QUIRKS in KVM guest configs
Date:   Tue,  4 Aug 2020 13:44:17 +0100
Message-Id: <20200804124417.27102-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200804124417.27102-1-alex.bennee@linaro.org>
References: <20200804124417.27102-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIRTIO_PCI support is an idealised PCI bus, we don't need a bunch
of bloat for real world hardware for a VirtIO guest.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 kernel/configs/kvm_guest.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/configs/kvm_guest.config b/kernel/configs/kvm_guest.config
index 208481d91090..672863a2fdf1 100644
--- a/kernel/configs/kvm_guest.config
+++ b/kernel/configs/kvm_guest.config
@@ -13,6 +13,7 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_BINFMT_ELF=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
+CONFIG_PCI_QUIRKS=n
 CONFIG_DEBUG_KERNEL=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_HYPERVISOR_GUEST=y
-- 
2.20.1

