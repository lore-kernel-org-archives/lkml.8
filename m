Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D25C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD5B2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699895;
	bh=LByY10wpkdMhOfDenUl7OS5TBtH4DUSUXN3WLEC0Sig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ROpkVcAABq2FJLEfxl+PadeleB2qoAP87Tn8xuXTzElaQ4nkVLwCCRuWYqgv0Mi1x
	 fhFUt7mYvlwLIBnG7AQ80tDiY5nJA9G586zTjZg4eeJ/LlZhDLsw8A17PFPKqiWEeT
	 ajAV2PHpNptIrijv7RbJqv+IYBbSV+ksmb2/2VkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAVNbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:31:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbgAVNTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:19:22 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 178742467E;
        Wed, 22 Jan 2020 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699161;
        bh=LByY10wpkdMhOfDenUl7OS5TBtH4DUSUXN3WLEC0Sig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9fui+BQRA9lMuBRBZnpCPtFDSytpEIq5Xm1p+Sgs1ihrufDdX9SzoFffzr5Ki2Uh
         LTmBXcoVWNBa+eZOZUVIgKOEL02MHcIkTuXWSg0vWgeIpGRgX2QFgxQiG/Id7s9k1C
         OAsubqotzWuDDYaaPGaC3DHq7ggNUpUMUHh6D9Co=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Esben Haabendal <esben@geanix.com>,
        Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.4 059/222] mtd: rawnand: gpmi: Restore nfc timing setup after suspend/resume
Date:   Wed, 22 Jan 2020 10:27:25 +0100
Message-Id: <20200122092837.940724471@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <esben@geanix.com>

commit d70486668cdf51b14a50425ab45fc18677a167b2 upstream.

As we reset the GPMI block at resume, the timing parameters setup by a
previous exec_op is lost.  Rewriting GPMI timing registers on first exec_op
after resume fixes the problem.

Fixes: ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
Acked-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -2727,6 +2727,10 @@ static int gpmi_pm_resume(struct device
 		return ret;
 	}
 
+	/* Set flag to get timing setup restored for next exec_op */
+	if (this->hw.clk_rate)
+		this->hw.must_apply_timings = true;
+
 	/* re-init the BCH registers */
 	ret = bch_set_geometry(this);
 	if (ret) {


