Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0169C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4130204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692007;
	bh=SrnGT9mFV8mx+n9fnp7oqTYm1Ykr9auihTd+1/BmR7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EV252/g80f/cE+OHQiuFrnueNohg9pp2Ce/Wbx+ObU691NKVGkiu6J7cakwGuZ4Ke
	 0UPeCNil1uIRbq7B4tlDAmWLZAUJzOp4Dff7wrLqaavOpm08MxaeHv96EXOYRwBHdr
	 b4VfQZ/mm2j+ZDf7hHIMZceB/ypEgpSn8sdGZ0H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbgHQTUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbgHQPhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:37:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B691022C9F;
        Mon, 17 Aug 2020 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678621;
        bh=SrnGT9mFV8mx+n9fnp7oqTYm1Ykr9auihTd+1/BmR7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKm1zAuDSHC5mZKsVLfttotiENKM9CwgONQUg940s8DYPbAa1uM0+J+udfiwp8oi9
         Dp8slGbntPp0vttCpJ6HbYHMcwKuYpF6Zfi6QowLZFvvmo1wjYo4LvU8b2xuKL5Ol6
         g8tfC+jKKg169oTrPprW8+AK84jKgy3cuBMJwekM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brant Merryman <brant.merryman@silabs.com>,
        Phu Luu <phu.luu@silabs.com>, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.8 398/464] USB: serial: cp210x: enable usb generic throttle/unthrottle
Date:   Mon, 17 Aug 2020 17:15:51 +0200
Message-Id: <20200817143852.844653645@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brant Merryman <brant.merryman@silabs.com>

commit 4387b3dbb079d482d3c2b43a703ceed4dd27ed28 upstream.

Assign the .throttle and .unthrottle functions to be generic function
in the driver structure to prevent data loss that can otherwise occur
if the host does not enable USB throttling.

Signed-off-by: Brant Merryman <brant.merryman@silabs.com>
Co-developed-by: Phu Luu <phu.luu@silabs.com>
Signed-off-by: Phu Luu <phu.luu@silabs.com>
Link: https://lore.kernel.org/r/57401AF3-9961-461F-95E1-F8AFC2105F5E@silabs.com
[ johan: fix up tags ]
Fixes: 39a66b8d22a3 ("[PATCH] USB: CP2101 Add support for flow control")
Cc: stable <stable@vger.kernel.org>     # 2.6.12
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -272,6 +272,8 @@ static struct usb_serial_driver cp210x_d
 	.break_ctl		= cp210x_break_ctl,
 	.set_termios		= cp210x_set_termios,
 	.tx_empty		= cp210x_tx_empty,
+	.throttle		= usb_serial_generic_throttle,
+	.unthrottle		= usb_serial_generic_unthrottle,
 	.tiocmget		= cp210x_tiocmget,
 	.tiocmset		= cp210x_tiocmset,
 	.attach			= cp210x_attach,


