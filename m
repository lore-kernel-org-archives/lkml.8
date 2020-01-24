Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138BCC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CD9214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858484;
	bh=Ta146iI2SIxBhV5hZPxG8zR46iQgzhWqleg75MWH4vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+WMMYxnqAaSWz/N/8ZNOaShRxBTF6ZFo9Qkpuj+qM1mqJCqscOKQJAoEklDGrLbf
	 JEu2JWeJukH3TVtScVoNrdJvNyO79YMXmNhkQJmDk1snBUSMSA0JoSUykfO4x6Y6s3
	 FT8GCoa0ULmkexM9IuX/T+AyqRwxLeQNm8Cnv2Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgAXJen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:34:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730919AbgAXJek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:34:40 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1814E214AF;
        Fri, 24 Jan 2020 09:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858479;
        bh=Ta146iI2SIxBhV5hZPxG8zR46iQgzhWqleg75MWH4vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOEe16pkFJLGHq4+G/f+nlPtkKdBb+6+0UdzmZhqZfneM1dlCR7+mFs93ZPghHztc
         ThuE8uzv+GIbK7bWZ2fU8iHWs49RODbOtSw8sW4Q7mdoKUjzuoLy2u/AOlzn69/bTF
         eHznDqStTQuxmsCHx7DUG+l93XRRIkQUYqkVj43s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5.4 029/102] phy: lantiq: vrx200-pcie: fix error return code in ltq_vrx200_pcie_phy_power_on()
Date:   Fri, 24 Jan 2020 10:30:30 +0100
Message-Id: <20200124092810.579889897@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 82b5d164415549e74cfa1f9156ffd4463d0a76e2 upstream.

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: e52a632195bf ("phy: lantiq: vrx200-pcie: add a driver for the Lantiq VRX200 PCIe PHY")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
+++ b/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
@@ -323,7 +323,8 @@ static int ltq_vrx200_pcie_phy_power_on(
 		goto err_disable_pdi_clk;
 
 	/* Check if we are in "startup ready" status */
-	if (ltq_vrx200_pcie_phy_wait_for_pll(phy) != 0)
+	ret = ltq_vrx200_pcie_phy_wait_for_pll(phy);
+	if (ret)
 		goto err_disable_phy_clk;
 
 	ltq_vrx200_pcie_phy_apply_workarounds(phy);


