Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE13C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FF724685
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579011428;
	bh=q26RMnhv4e6vnyl7On3dw2ZS7Ofbxt7I4hTv9fYgiXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XrxDBAM1m4jf7QGeIdTWn8awH5/v84vt1dMd8Wfbk0KiMG1IDfehU7UeG2glvZFHE
	 RbotzaCaCuCMMVqJwnHURUMJG8cPC6yV7bEhQBqrH73bxMHLxNX256r1d6C/7azzs1
	 b6yLoyzj0UPXgaE0qC55+AfEL6+hrRbFDP3x0Qw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgANORI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:17:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgANORG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:17:06 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-206.w90-88.abo.wanadoo.fr [90.88.129.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B84424689;
        Tue, 14 Jan 2020 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579011425;
        bh=q26RMnhv4e6vnyl7On3dw2ZS7Ofbxt7I4hTv9fYgiXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A94Kv+FoH+qqPpiPSMm1lXCHjuH7DksvFWPXDH3mvBvxh8jbUn0C4UZ/hK58kJKRU
         gbYNtafpJMfiWdsxLHYQ5vONategLeQZB0BUI8pvdqdfBXz06rbNkH1BKvmjtpkZof
         ryTwyh2PAuBcDDd7YHn6b/HZc7KTWAIUOhn5vCcc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, masahisa.kojima@linaro.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: tpm-tis-mmio: add compatible string for SynQuacer TPM
Date:   Tue, 14 Jan 2020 15:16:46 +0100
Message-Id: <20200114141647.109347-2-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114141647.109347-1-ardb@kernel.org>
References: <20200114141647.109347-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the SynQuacer TPM to the binding for a
TPM exposed via a memory mapped TIS frame. The MMIO window behaves
slightly differently on this hardware, so it requires its own
identifier.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt b/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
index 7c6304426da1..b604c8688dc8 100644
--- a/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
+++ b/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
@@ -12,6 +12,7 @@ Required properties:
 - compatible: should contain a string below for the chip, followed by
               "tcg,tpm-tis-mmio". Valid chip strings are:
 	          * "atmel,at97sc3204"
+		  * "socionext,synquacer-tpm-mmio"
 - reg: The location of the MMIO registers, should be at least 0x5000 bytes
 - interrupts: An optional interrupt indicating command completion.
 
-- 
2.20.1

