Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ED9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDC72078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594405698;
	bh=znLxL7QxKrQnwkFsgsEFQvbCS0/u/STlDOmErC2vb38=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=GbtpI4JL0fJx/26rcGWYz70nVM0K1NqaFwmuoPpUECrWj14r2YmBRfXmovIjghtj0
	 oHFUxLXdEXL/cwLYMwZITRACKpSO79ZPWOYADH2HVSozp/+kyuTh98mZ3MRm3GiXZc
	 MLyr795TZbrUou5SpBX8CrbHOw8BraRdFIwZfMt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGJS2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJS2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:28:16 -0400
Received: from embeddedor (unknown [200.39.25.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D42D2075D;
        Fri, 10 Jul 2020 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594405696;
        bh=znLxL7QxKrQnwkFsgsEFQvbCS0/u/STlDOmErC2vb38=;
        h=Date:From:To:Cc:Subject:From;
        b=RrL4eFoQQU5pUrPGbbtbsYS48NPO24Wmkdm9W+LOygckMHyzZ2xx84sGlIc7t7ktP
         27miComXyAVgz2Dqt3gKhBOgMM9VoPrZdfnhac6dEeI2aES04WsYJBkkzBL469GyMr
         egg+AZ+92tD/5eRLJOP4URgfPIRyf8c+GH643QZk=
Date:   Fri, 10 Jul 2020 13:33:50 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] staging: rts5208: Assign array_size() to a variable
Message-ID: <20200710183350.GA8376@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign array_size() to variable _size_ and use it in multiple places.

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/rts5208/rtsx_chip.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_chip.c b/drivers/staging/rts5208/rtsx_chip.c
index c6f9375468eb..ee9ddc4eb94d 100644
--- a/drivers/staging/rts5208/rtsx_chip.c
+++ b/drivers/staging/rts5208/rtsx_chip.c
@@ -1440,6 +1440,7 @@ int rtsx_write_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 	u16 aligned_addr = addr - offset;
 	int dw_len, i, j;
 	int retval;
+	size_t size;
 
 	if (!buf)
 		return STATUS_NOMEM;
@@ -1451,11 +1452,12 @@ int rtsx_write_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 
 	dev_dbg(rtsx_dev(chip), "dw_len = %d\n", dw_len);
 
-	data = vzalloc(array_size(dw_len, 4));
+	size = array_size(dw_len, 4);
+	data = vzalloc(size);
 	if (!data)
 		return STATUS_NOMEM;
 
-	mask = vzalloc(array_size(dw_len, 4));
+	mask = vzalloc(size);
 	if (!mask) {
 		vfree(data);
 		return STATUS_NOMEM;
@@ -1471,10 +1473,8 @@ int rtsx_write_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 		}
 	}
 
-	print_hex_dump_bytes(KBUILD_MODNAME ": ", DUMP_PREFIX_NONE, mask,
-			     dw_len * 4);
-	print_hex_dump_bytes(KBUILD_MODNAME ": ", DUMP_PREFIX_NONE, data,
-			     dw_len * 4);
+	print_hex_dump_bytes(KBUILD_MODNAME ": ", DUMP_PREFIX_NONE, mask, size);
+	print_hex_dump_bytes(KBUILD_MODNAME ": ", DUMP_PREFIX_NONE, data, size);
 
 	for (i = 0; i < dw_len; i++) {
 		retval = rtsx_write_cfg_dw(chip, func, aligned_addr + i * 4,
-- 
2.27.0

