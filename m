Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEA5C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DFA217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608674;
	bh=/cBsV2+fZ3tqujiRAUL+RNTm5GPLITKuiZjrgCkDibY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YDuSKa3t/24wrPaUqiTTk300K3l1V8hVhtwbc06QI2XUFRCo1tq9tCQJ9cAOllyPk
	 qfPXOTLnE/1AvKlRQBVcDzSfdiAgp5x7c5MCr6tKqajhRj84M78iCRoDf/HzxQD8i5
	 fdKwYLM2msJnFKUAn6naXIybNfFpZK+/qAk7ALwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgBMPod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:44:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387703AbgBMP1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:41 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E039D218AC;
        Thu, 13 Feb 2020 15:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607660;
        bh=/cBsV2+fZ3tqujiRAUL+RNTm5GPLITKuiZjrgCkDibY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+LI80x7liCmpWwtPM1VYnBh6iGP9e7GSk/rqRX6E6YWQVDAlXbeLOwR/cMOILnLY
         ChqqfH60iBVK8WKp3FwQ/8d0bkYuZGHK1jU9sT+9wQmWWRKqGNs5xB8zx9M+baOA9o
         DYXGIN3/EhFBzMnhJi2pbHYICN7MQPeAq85BiyHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5.4 60/96] ARM: at91: pm: use SAM9X60 PMCs compatible
Date:   Thu, 13 Feb 2020 07:21:07 -0800
Message-Id: <20200213151902.191896192@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

commit 6b9dfd986a81a999a27b6ed9dbe91203089c62dd upstream.

SAM9X60 PMC's has a different PMC. It was not integrated at the moment
commit 01c7031cfa73 ("ARM: at91: pm: initial PM support for SAM9X60")
was published.

Fixes: 01c7031cfa73 ("ARM: at91: pm: initial PM support for SAM9X60")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/1576062248-18514-2-git-send-email-claudiu.beznea@microchip.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-at91/pm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -751,6 +751,7 @@ static const struct of_device_id atmel_p
 	{ .compatible = "atmel,sama5d3-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,sama5d4-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[1] },
 	{ /* sentinel */ },
 };
 


