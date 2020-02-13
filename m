Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC38C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E50D20661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608889;
	bh=I3F37xw90XR+ITkmYbUSU264wdX9jM9dM/02J2SyJLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SldU6NM1NnAWnXHnmqK1nJZHgZWefAUXtMMwGEheDVoOKYXTlBrES2JjdA/fsL9Vt
	 B/EHYuVF0TpUkkD80+0Z/UGmH6p6breoCsFD+HJCekZg1gI+W3Y+PfFJCR0ETq/ADU
	 zevc9TUugQbAgjngJjYq8S1KyF9iQVre9HQ72a5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgBMPry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbgBMP1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:00 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BAC32468D;
        Thu, 13 Feb 2020 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607620;
        bh=I3F37xw90XR+ITkmYbUSU264wdX9jM9dM/02J2SyJLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2TspjOcCQ9n9JadozBeoTf3IzjIA8SuLKl1kZC6omrVYLr34MxiN5wPa20cm0h0Q
         qmPlspNtkmKWYlWCEj/f57KNbERH89BnS/C7We6cuWOjhQO3RqMN8yVFHaQM8Po7w6
         z1H+8ckTyhZVm5Vpl1q7cqkOIaZFeugCNxIiMggQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.4 14/96] ath10k: pci: Only dump ATH10K_MEM_REGION_TYPE_IOREG when safe
Date:   Thu, 13 Feb 2020 07:20:21 -0800
Message-Id: <20200213151844.830408523@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

commit d239380196c4e27a26fa4bea73d2bf994c14ec2d upstream.

ath10k_pci_dump_memory_reg() will try to access memory of type
ATH10K_MEM_REGION_TYPE_IOREG however, if a hardware restart is in progress
this can crash a system.

Individual ioread32() time has been observed to jump from 15-20 ticks to >
80k ticks followed by a secure-watchdog bite and a system reset.

Work around this corner case by only issuing the read transaction when the
driver state is ATH10K_STATE_ON.

Tested-on: QCA9988 PCI 10.4-3.9.0.2-00044

Fixes: 219cc084c6706 ("ath10k: add memory dump support QCA9984")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/pci.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1604,11 +1604,22 @@ static int ath10k_pci_dump_memory_reg(st
 {
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
 	u32 i;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+	if (ar->state != ATH10K_STATE_ON) {
+		ath10k_warn(ar, "Skipping pci_dump_memory_reg invalid state\n");
+		ret = -EIO;
+		goto done;
+	}
 
 	for (i = 0; i < region->len; i += 4)
 		*(u32 *)(buf + i) = ioread32(ar_pci->mem + region->start + i);
 
-	return region->len;
+	ret = region->len;
+done:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
 }
 
 /* if an error happened returns < 0, otherwise the length */
@@ -1704,7 +1715,11 @@ static void ath10k_pci_dump_memory(struc
 			count = ath10k_pci_dump_memory_sram(ar, current_region, buf);
 			break;
 		case ATH10K_MEM_REGION_TYPE_IOREG:
-			count = ath10k_pci_dump_memory_reg(ar, current_region, buf);
+			ret = ath10k_pci_dump_memory_reg(ar, current_region, buf);
+			if (ret < 0)
+				break;
+
+			count = ret;
 			break;
 		default:
 			ret = ath10k_pci_dump_memory_generic(ar, current_region, buf);


