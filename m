Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6ABC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E868B21835
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941390;
	bh=4461rff/8b/jph4vSDZqmbqZ71AQJeIrJYUJcwal6GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZlMMV+nkGedks7ueyNtNKmcvFwkt2blZcPlDqwV1Gu2OXDgPYYrwOG1uC+vKq7smn
	 OeKye27KxYf+HiLeLOib4k/xHDSgUWrQ93s+VILbwYR72mSRED6mhOCOA51dfrcre1
	 ysIf0x9o19+DzrQHsmUluh/BbM6V9ZwogPf6eb2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgEHMg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgEHMg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:36:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9607021974;
        Fri,  8 May 2020 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941387;
        bh=4461rff/8b/jph4vSDZqmbqZ71AQJeIrJYUJcwal6GM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9qxWbxl+AMW3Ep5DwYbzeQPoVCiOOBNglpdZfO2H9H+H9L68vLLJ5pLiDqoaHXuj
         DyaeYdIH83r7UazFja34TW0yX6Z0qtof53wPeBhtAUTltBArLJWwO4DfesohgT/NH9
         ApIvFxEPFPgw2DWUDcGUx2sp8LNx+eqObiOVWdBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 012/312] MIPS: smp-cps: Stop printing EJTAG exceptions to UART
Date:   Fri,  8 May 2020 14:30:03 +0200
Message-Id: <20200508123125.369792501@linuxfoundation.org>
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

From: Paul Burton <paul.burton@imgtec.com>

commit 6609ccdc852f7bfbfa54300dd5b3cd89eb4ced6f upstream.

When CONFIG_MIPS_CPS_NS16550 is enabled, some register state is dumped
to the UART when an exception is taken via the BEV on secondary cores.
EJTAG exceptions are architecturally expected to be handled by the BEV
even when Status.BEV is 0. This effectively means that if userland
executes an sdbbp instruction on a secondary core then the kernel dumps
register state to the UART even though the exception is perfectly normal
& expected. Prevent this by simply not dumping information to the UART
for EJTAG exceptions.

Fixes: 609cf6f2291a ("MIPS: CPS: Early debug using an ns16550-compatible UART")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/12341/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/cps-vec.S |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -245,7 +245,6 @@ LEAF(excep_intex)
 
 .org 0x480
 LEAF(excep_ejtag)
-	DUMP_EXCEP("EJTAG")
 	PTR_LA	k0, ejtag_debug_handler
 	jr	k0
 	 nop


