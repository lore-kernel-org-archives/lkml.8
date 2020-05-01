Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C881BC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1682054F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341369;
	bh=zUCiPF1saQAniHcWkEVbc4jYJQ/5z6kvlySYJdaGaC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vt1EkFP8H8BXsE/8tUDA4+liAzLbFt7SGm4fTDPBrsZN/6Y5bgp91EEQ8eKIu6juW
	 BsrCJwydfEoM3jxxglY4x/MOG3IoG4t2TxJ/ONQXgUJbKpAgflxz7tFqDcnITqi0UE
	 RoB6M59NbEaYxi+Zwck3R1DjUV81UwXZxiUJbWV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgEANc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbgEANcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:32:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBBC208DB;
        Fri,  1 May 2020 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339967;
        bh=zUCiPF1saQAniHcWkEVbc4jYJQ/5z6kvlySYJdaGaC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qurfy/edyi9VPokida17Sjwb9+XTNNEkVq7TAKJOupOQcb2nwrfhYcq03lktNIIDm
         g0xZmlI/f9DJYge1WXXtv6capggZYUPzRujrI5Fz0O6J7bU/xXgzHRWibdc7mDghUx
         VnvY4jeEfbCSW0HR5z6NhwVs56ltdy95e32j1NM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 039/117] iio: xilinx-xadc: Fix ADC-B powerdown
Date:   Fri,  1 May 2020 15:21:15 +0200
Message-Id: <20200501131549.415119352@linuxfoundation.org>
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

commit e44ec7794d88f918805d700240211a9ec05ed89d upstream.

The check for shutting down the second ADC is inverted. This causes it to
be powered down when it should be enabled. As a result channels that are
supposed to be handled by the second ADC return invalid conversion results.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/xilinx-xadc-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -709,13 +709,14 @@ static int xadc_power_adc_b(struct xadc
 {
 	uint16_t val;
 
+	/* Powerdown the ADC-B when it is not needed. */
 	switch (seq_mode) {
 	case XADC_CONF1_SEQ_SIMULTANEOUS:
 	case XADC_CONF1_SEQ_INDEPENDENT:
-		val = XADC_CONF2_PD_ADC_B;
+		val = 0;
 		break;
 	default:
-		val = 0;
+		val = XADC_CONF2_PD_ADC_B;
 		break;
 	}
 


