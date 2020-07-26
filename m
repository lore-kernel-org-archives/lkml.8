Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82134C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA6320714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2LBBl9NV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2db/pzQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGZKuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 06:50:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48422 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZKuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 06:50:39 -0400
Date:   Sun, 26 Jul 2020 10:50:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595760638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LvSzc0PrUE0g2EncjC2dXTyr1h5cdovmAIp2gWWHAHk=;
        b=2LBBl9NVTOEhuJIkYarmUaZ8G7X+w4JTyU85zx2Ght9b7ysCAwd8xUoDIEk44PuR5nZvGI
        VNbzOkXxIkCe+aIjMzAaZhOCw0Wn5xbqSs2YTaibZhLUufJPlTsyqzvbsnK0IX63AXSUcr
        cmWURlS9wXeB/WA8TqUcZePnpVJdfKn+vfn2NK1jXeCb5ZbNjtiOBOs2+Py0eV9SONJCgs
        l0fHMglz1xVLyUt7myH1lNVf1kOk4vk0IJuQ1M3WOmFCnmFaAYOUd7iFH11vvDGhs2ipDO
        YDMaJiDICtRbTNNZf4T6WEEiK/NJDzj3XBFjLpTAiBnf2W/Uvox+/efDbYAHsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595760638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LvSzc0PrUE0g2EncjC2dXTyr1h5cdovmAIp2gWWHAHk=;
        b=2db/pzQ7nAhoM0FW/3OypjJJZIdEbTdFLlGcI5W6hVbh7+nXRiNFhF1jkJf7CXnQ+8XWRs
        3D7CgDt5VUo7ZZDg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: bootparam.h: Delete duplicated word
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200726004124.20618-2-rdunlap@infradead.org>
References: <20200726004124.20618-2-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <159576063765.4006.16074832961217588429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ddeddd0811ffeb43937aca2d5479f323234f17cd
Gitweb:        https://git.kernel.org/tip/ddeddd0811ffeb43937aca2d5479f323234f17cd
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sat, 25 Jul 2020 17:41:22 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 26 Jul 2020 12:47:22 +02:00

x86: bootparam.h: Delete duplicated word

Delete the repeated word "for".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200726004124.20618-2-rdunlap@infradead.org
---
 arch/x86/include/uapi/asm/bootparam.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 8669c6b..600a141 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -255,7 +255,7 @@ struct boot_params {
  * 	currently supportd through this PV boot path.
  * @X86_SUBARCH_INTEL_MID: Used for Intel MID (Mobile Internet Device) platform
  *	systems which do not have the PCI legacy interfaces.
- * @X86_SUBARCH_CE4100: Used for Intel CE media processor (CE4100) SoC for
+ * @X86_SUBARCH_CE4100: Used for Intel CE media processor (CE4100) SoC
  * 	for settop boxes and media devices, the use of a subarch for CE4100
  * 	is more of a hack...
  */
