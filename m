Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B2FC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806A520757
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341377;
	bh=Z/zPxkWe2fRUFC3yfV2DUN3dnKzbzDiP4hZZYzjw2t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E8psdaVGkc1SDngW4F/u/19qSBXy6Y5pZR/MhG/o33A69WJufgpoq/xUkdmpbM8Pc
	 ulOYBQWSKgjFxJCmS2jS39b62xmSZc+y4xM8vee7L6xMZXu2dUZtVIiEBZMk0az5B8
	 zqfH57/x5nkoqJcf8yGnWJzPBFTnQkA6V1WuBvPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbgEAN4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730351AbgEANcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:32:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 616702173E;
        Fri,  1 May 2020 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339969;
        bh=Z/zPxkWe2fRUFC3yfV2DUN3dnKzbzDiP4hZZYzjw2t0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T99wMS/qk5mimyAgPa9SAgWP3Fh5nC8HyiDfIc9gsF0T2GZNGrWzrd8j0y2ggkhPG
         qMTo8h0gB5qc6joGC0VBwfDtpBut/rhgifhRDBja5FoghyMtxPz003gI6yhjG2uqyI
         aZi92aaebovTxA4RvIXT90O8jZAiPYEqqhugnzh0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 040/117] iio: xilinx-xadc: Fix clearing interrupt when enabling trigger
Date:   Fri,  1 May 2020 15:21:16 +0200
Message-Id: <20200501131549.533545909@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

commit f954b098fbac4d183219ce5b42d76d6df2aed50a upstream.

When enabling the trigger and unmasking the end-of-sequence (EOS) interrupt
the EOS interrupt should be cleared from the status register. Otherwise it
is possible that it was still set from a previous capture. If that is the
case the interrupt would fire immediately even though no conversion has
been done yet and stale data is being read from the device.

The old code only clears the interrupt if the interrupt was previously
unmasked. Which does not make much sense since the interrupt is always
masked at this point and in addition masking the interrupt does not clear
the interrupt from the status register. So the clearing needs to be done
unconditionally.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/xilinx-xadc-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -660,7 +660,7 @@ static int xadc_trigger_set_state(struct
 
 	spin_lock_irqsave(&xadc->lock, flags);
 	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
-	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, val & XADC_AXI_INT_EOS);
+	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
 	if (state)
 		val |= XADC_AXI_INT_EOS;
 	else


