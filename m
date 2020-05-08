Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C9FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C30206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943656;
	bh=52sRnx/F4rTKmyY1npITnTBQxNE4Fpn1v2z+q26zue0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bkodnqhI8WaC+rCzxe3nRk+fJNbhpqK1cy8k0yj6EKBGq3cpLRPnaGi/Mv6JAQv6B
	 TetCMmT+EIe0h0plxSgglhD3tjdHsAWPpucQm7rvRsmbtzwaAFN1C7RkUEoe0BSo47
	 IZWcvDJc2WWC7e0bzdiRv3PMvW91ZJ7UaOhp9xa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgEHNOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbgEHMrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:47:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CE492495E;
        Fri,  8 May 2020 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942038;
        bh=52sRnx/F4rTKmyY1npITnTBQxNE4Fpn1v2z+q26zue0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVMZ2juUDV6zEG63DnZvra6Lyzss2nUXXS1zSJWQz3bfUsOthSKwXTmIcy+hKwkzv
         7reTkhCcg9JQeo7wBy+BOiKooUounjBVOZh9maxlXkjS/TvBRKpErQwwOHyHp1Ps3j
         3FeiRh1zMgUTEP+dewn4lyd1K4ns0ASJTDJ81zyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 270/312] net: ethernet: stmmac: dwmac-generic: fix probe error path
Date:   Fri,  8 May 2020 14:34:21 +0200
Message-Id: <20200508123143.425078077@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 939b20022765bc338b0f72cbf1eed60a907398d7 upstream.

Make sure to call any exit() callback to undo the effect of init()
before returning on late probe errors.

Fixes: cf3f047b9af4 ("stmmac: move hw init in the probe (v2)")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -53,7 +53,17 @@ static int dwmac_generic_probe(struct pl
 			return ret;
 	}
 
-	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	if (ret)
+		goto err_exit;
+
+	return 0;
+
+err_exit:
+	if (plat_dat->exit)
+		plat_dat->exit(pdev, plat_dat->bsp_priv);
+
+	return ret;
 }
 
 static const struct of_device_id dwmac_generic_match[] = {


