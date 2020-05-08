Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9691FC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACD024966
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942049;
	bh=imHllWF0IkqPyAJK3PIZEqSeIRDsQqcMz00EYhA95eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=czbHrTANZcjQ0Rfuwij4CsNufvYjKAZ15wj9v+ZOcYjj3FIkrGNdI2LYmqeV7BfCa
	 zYb9UEtyV+7htdZvL0sfsDRG3ZVWUZMx7m3ngF9u9bJb/dPky2ss5SE7XKGcSykhIb
	 vIYNZzBaafd9vlNVj/ap3v9e1sLR7hVWz6Jh3wAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgEHMr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729231AbgEHMrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:47:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526D121473;
        Fri,  8 May 2020 12:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942033;
        bh=imHllWF0IkqPyAJK3PIZEqSeIRDsQqcMz00EYhA95eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1vf/Up/QuOzNak28oi51q6ND44SJMFIt7Rr8y6DMeXEFLej8nSAbrUgSka4bQfnuH
         0uXP/DjF0EPOYUZ7IAzs+axZwn2XnJifr3Fa+nm/St9KC1S64YiZOi4C9jxwUcFX4r
         fkvbBYvUVy1C2/9lvgljVcfnKYpnQNUklBOdgNzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 268/312] net: ethernet: stmmac: dwmac-rk: fix probe error path
Date:   Fri,  8 May 2020 14:34:19 +0200
Message-Id: <20200508123143.283415866@linuxfoundation.org>
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

commit 2d222656db08b8eef3b53b56cf1ce4a90fe8cd78 upstream.

Make sure to disable runtime PM, power down the PHY, and disable clocks
before returning on late probe errors.

Fixes: 27ffefd2d109 ("stmmac: dwmac-rk: create a new probe function")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -600,7 +600,16 @@ static int rk_gmac_probe(struct platform
 	if (ret)
 		return ret;
 
-	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	if (ret)
+		goto err_gmac_exit;
+
+	return 0;
+
+err_gmac_exit:
+	rk_gmac_exit(pdev, plat_dat->bsp_priv);
+
+	return ret;
 }
 
 static const struct of_device_id rk_gmac_dwmac_match[] = {


