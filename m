Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88792C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5100224671
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607697;
	bh=MrJiRdv9r/LUUwNsVWVmc/rZcoTAG34gs6aj4hF9sl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cxe4zFWTkbq8Z5l8iyJQD5XAss6Q1y9F7sfH/aspcatQcR79izTovZWnKaLeruX+h
	 RexEwY4tZqmYdJhFaAPzGtsGL6FtoknkkIa4e7AAOpgyJ/TAgE4VJL8tyP22hcxH5f
	 TAx5Jyh7145/540bKahWLddOg/nFdn1E5dKtSMtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgBMP2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:28:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729077AbgBMPZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:48 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1904B246D5;
        Thu, 13 Feb 2020 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607548;
        bh=MrJiRdv9r/LUUwNsVWVmc/rZcoTAG34gs6aj4hF9sl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2UCZXQYz2oty2AX2W8pgnH8nKk0FttwzHY2OH6+leG15GBjtXi7QtNnEoQCCXVAM
         cCSUAFFYRE00x+jDmFfcdco2kRJovgqSZBR1t6ct/H0n2qibN307obZnKGTtBPvqow
         Yv/NcRTM/DIP7Swthd6s5Ef24SobimC69NI/6SEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.14 111/173] mfd: rn5t618: Mark ADC control register volatile
Date:   Thu, 13 Feb 2020 07:20:14 -0800
Message-Id: <20200213152000.546832829@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Kemnade <andreas@kemnade.info>

commit 2f3dc25c0118de03a00ddc88b61f7216854f534d upstream.

There is a bit which gets cleared after conversion.

Fixes: 9bb9e29c78f8 ("mfd: Add Ricoh RN5T618 PMIC core driver")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mfd/rn5t618.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -32,6 +32,7 @@ static bool rn5t618_volatile_reg(struct
 	case RN5T618_WATCHDOGCNT:
 	case RN5T618_DCIRQ:
 	case RN5T618_ILIMDATAH ... RN5T618_AIN0DATAL:
+	case RN5T618_ADCCNT3:
 	case RN5T618_IR_ADC1 ... RN5T618_IR_ADC3:
 	case RN5T618_IR_GPR:
 	case RN5T618_IR_GPF:


