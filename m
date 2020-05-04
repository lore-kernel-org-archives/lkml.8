Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4CDC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4462420661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588616249;
	bh=6Cc5uK0xpSEhAULcKCqr2vRXb5oEtl0zXMdTVAfo6GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x0+7IKJ/QxcnzxkUUeGI/aFY7kAmbxwbmgctBJCRw1I6EgHxNQqufeO9pu3BCG4wB
	 BW0m/Tl9YNsiOKJCe3nn8VWZUXZS8c18ezEXezkFopvm4DjBvGnvbKN1ZxLUM/pN9O
	 FfUUzlGeAb4JeGQOWNCKW2rUvqn55hMW65xXHhPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbgEDSPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730753AbgEDR7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:59:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81558206B8;
        Mon,  4 May 2020 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615158;
        bh=6Cc5uK0xpSEhAULcKCqr2vRXb5oEtl0zXMdTVAfo6GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ybSohxwOGG2gtB7HD/n9DJe/GUpxuHbhsJVWeZI7zI/7yrBo/IozQJAx0QGQrVvu4
         WDNITtNVlSXL9r/neBrinuLW3/724eT/sMetfuSsRo6vXkEQt5ydUW94mgOCn354OA
         EggdMMEg6SVC/zQk81qDV0fHk5NS9CJJb/e2LFOc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.4 10/18] i2c: designware-pci: use IRQF_COND_SUSPEND flag
Date:   Mon,  4 May 2020 19:57:08 +0200
Message-Id: <20200504165443.749819807@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165441.533160703@linuxfoundation.org>
References: <20200504165441.533160703@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit 08c6e8cc66282a082484480c1a5641bc27d26c55 upstream.

This is effectively reapplies the commit b0898fdaffb2 ("i2c: designware-pci: use
IRQF_COND_SUSPEND flag") after the commit d80d134182ba ("i2c: designware: Move
common probe code into i2c_dw_probe()"). Original message as follows.

The mentioned flag fixes a warning on Intel Edison board since one of the I2C
controller shares IRQ line with watchdog timer.

Fixes: d80d134182ba (i2c: designware: Move common probe code into i2c_dw_probe())
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-designware-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -865,7 +865,8 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	i2c_set_adapdata(adap, dev);
 
 	i2c_dw_disable_int(dev);
-	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr, IRQF_SHARED,
+	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
+			     IRQF_SHARED | IRQF_COND_SUSPEND,
 			     dev_name(dev->dev), dev);
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i: %d\n",


