Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68238C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49063204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689627;
	bh=Nl4sYPlqxnjuBaBPrJjt6ZfDR5qEtZmD5a/mIKpVQHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wHb4t1+tV+7v8q5Apyom+V8AnAnrJkJMDjsEW8WKAjDqflVI8F+GxasrNiu4tQJXf
	 E00HpbhANYf+i0vY7JYGSqFYWrYKyrMVzzqRYAFv2fzfnTP4mft+3/FDfnldlXyDw3
	 4JK12MDosxhXNjV2FlhX9hIXf7Jx5m8oftBi8mic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391378AbgHQSkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387933AbgHQP54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:57:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF89320760;
        Mon, 17 Aug 2020 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679876;
        bh=Nl4sYPlqxnjuBaBPrJjt6ZfDR5qEtZmD5a/mIKpVQHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eT3K4nFhpfKG7Y3dMEsCc4gusRGlI1pVkmWYgqRrZ8hiObG9UstQkNvZNqjSwcKQ9
         /pHwLu0fu4VRt0NZr4llzjK6uTrJDqiVfVVaeFAAnuN1JKzxkSEnx7KOfpRcD86ClY
         308wVZaa/TF2c8pW69PxsSJNDBNT+0LnadMPzp2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Eggers <ceggers@arri.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.7 365/393] spi: spidev: Align buffers for DMA
Date:   Mon, 17 Aug 2020 17:16:55 +0200
Message-Id: <20200817143837.307868815@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Eggers <ceggers@arri.de>

commit aa9e862d7d5bcecd4dca9f39e8b684b93dd84ee7 upstream.

Simply copying all xfers from userspace into one bounce buffer causes
alignment problems if the SPI controller uses DMA.

Ensure that all transfer data blocks within the rx and tx bounce buffers
are aligned for DMA (according to ARCH_KMALLOC_MINALIGN).

Alignment may increase the usage of the bounce buffers. In some cases,
the buffers may need to be increased using the "bufsiz" module
parameter.

Signed-off-by: Christian Eggers <ceggers@arri.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200728100832.24788-1-ceggers@arri.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spidev.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -223,6 +223,11 @@ static int spidev_message(struct spidev_
 	for (n = n_xfers, k_tmp = k_xfers, u_tmp = u_xfers;
 			n;
 			n--, k_tmp++, u_tmp++) {
+		/* Ensure that also following allocations from rx_buf/tx_buf will meet
+		 * DMA alignment requirements.
+		 */
+		unsigned int len_aligned = ALIGN(u_tmp->len, ARCH_KMALLOC_MINALIGN);
+
 		k_tmp->len = u_tmp->len;
 
 		total += k_tmp->len;
@@ -238,17 +243,17 @@ static int spidev_message(struct spidev_
 
 		if (u_tmp->rx_buf) {
 			/* this transfer needs space in RX bounce buffer */
-			rx_total += k_tmp->len;
+			rx_total += len_aligned;
 			if (rx_total > bufsiz) {
 				status = -EMSGSIZE;
 				goto done;
 			}
 			k_tmp->rx_buf = rx_buf;
-			rx_buf += k_tmp->len;
+			rx_buf += len_aligned;
 		}
 		if (u_tmp->tx_buf) {
 			/* this transfer needs space in TX bounce buffer */
-			tx_total += k_tmp->len;
+			tx_total += len_aligned;
 			if (tx_total > bufsiz) {
 				status = -EMSGSIZE;
 				goto done;
@@ -258,7 +263,7 @@ static int spidev_message(struct spidev_
 						(uintptr_t) u_tmp->tx_buf,
 					u_tmp->len))
 				goto done;
-			tx_buf += k_tmp->len;
+			tx_buf += len_aligned;
 		}
 
 		k_tmp->cs_change = !!u_tmp->cs_change;
@@ -292,16 +297,16 @@ static int spidev_message(struct spidev_
 		goto done;
 
 	/* copy any rx data out of bounce buffer */
-	rx_buf = spidev->rx_buffer;
-	for (n = n_xfers, u_tmp = u_xfers; n; n--, u_tmp++) {
+	for (n = n_xfers, k_tmp = k_xfers, u_tmp = u_xfers;
+			n;
+			n--, k_tmp++, u_tmp++) {
 		if (u_tmp->rx_buf) {
 			if (copy_to_user((u8 __user *)
-					(uintptr_t) u_tmp->rx_buf, rx_buf,
+					(uintptr_t) u_tmp->rx_buf, k_tmp->rx_buf,
 					u_tmp->len)) {
 				status = -EFAULT;
 				goto done;
 			}
-			rx_buf += u_tmp->len;
 		}
 	}
 	status = total;


