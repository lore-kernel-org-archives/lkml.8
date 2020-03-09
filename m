Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44119C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FF120863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCIHbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:31:41 -0400
Received: from m177134.mail.qiye.163.com ([123.58.177.134]:21392 "EHLO
        m177134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgCIHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:31:41 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 03:31:40 EDT
Received: from SZ11061793 (unknown [58.251.74.226])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 72DD0261311;
        Mon,  9 Mar 2020 15:21:42 +0800 (CST)
From:   =?gb2312?B?zfWzzLjV?= <wangchenggang@vivo.com>
To:     "'Catalin Marinas'" <catalin.marinas@arm.com>,
        "'Will Deacon'" <will@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Marc Zyngier'" <maz@kernel.org>,
        "'Allison Randal'" <allison@lohutok.net>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Chenggang Wang'" <wangchenggang@vivo.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <trivial@kernel.org>, <wenhu.wang@vivo.com>
Subject: [PATCH] arch/arm64: fix typo in a comment
Date:   Mon, 9 Mar 2020 15:21:42 +0800
Message-ID: <000401d5f5e3$622aefa0$2680cee0$@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdX14qokbDT0UdHeTo+lZgDpTUZRnA==
Content-Language: zh-cn
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVJT09CQkJDQ05OTkJLQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6HRw4OjgrHj0jTQ0RTUk5
        CCEwCjVVSlVKTkNITEhDTktISUtLVTMWGhIXVQwaFRwYEx4VHBwaFRw7DRINFFUYFBZFWVdZEgtZ
        QVlOQ1VJTkpVTE9VSUlNWVdZCAFZQUlPSE43Bg++
X-HM-Tid: 0a70be2bbf969375kuws72dd0261311
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in a comment in arch/arm64/include/asm/esr.h

"Unallocted" -> "Unallocated"

Signed-off-by: Chenggang Wang <wangchenggang@vivo.com>
---
 arch/arm64/include/asm/esr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index cb29253ae86b..6a395a7e6707 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -60,7 +60,7 @@
 #define ESR_ELx_EC_BKPT32	(0x38)
 /* Unallocated EC: 0x39 */
 #define ESR_ELx_EC_VECTOR32	(0x3A)	/* EL2 only */
-/* Unallocted EC: 0x3B */
+/* Unallocated EC: 0x3B */
 #define ESR_ELx_EC_BRK64	(0x3C)
 /* Unallocated EC: 0x3D - 0x3F */
 #define ESR_ELx_EC_MAX		(0x3F)
--
2.20.1

