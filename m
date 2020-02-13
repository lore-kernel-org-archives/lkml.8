Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8BBC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A07620675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608749;
	bh=vF3vpiJfV5jRF2elPwqFz17RlyJWH7ft1gujGBsgYYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qdw73pfG5/ZUT+I0PC28m8MMWze4gu7595RFBUI25vzhJFtyLQR8ccq99tCtF62mP
	 9nqMnWExi5Gru0vGN29rtFMjnzJBAVxNuYBkL84fjE/hWuENP/+snvN+fv3y+8iuN3
	 rs6QaAnuBNiLWt8NU7CmruphdJC84v/iru++z2sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgBMPpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:45:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbgBMP10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:26 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4692465D;
        Thu, 13 Feb 2020 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607646;
        bh=vF3vpiJfV5jRF2elPwqFz17RlyJWH7ft1gujGBsgYYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFbqLfw8ya/9qz6NOA037cwKVFCAJeTDpky+6S3P8EZibrd8tXMYfqbjc001FbOoq
         ilmnvV2lDg/+bXazIdY8qdq13I/OJJrOvOmag1ESj3hf7ao1YuSgU1Yr9/GCFC+m7G
         /uslvqefVE3UQjjXVbgEyOYD3hXhPSi46PFinxg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH 5.4 38/96] watchdog: qcom: Use platform_get_irq_optional() for bark irq
Date:   Thu, 13 Feb 2020 07:20:45 -0800
Message-Id: <20200213151854.039679791@linuxfoundation.org>
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

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

commit e0b4f4e0cf7fa9d62628d4249c765ec18dffd143 upstream.

platform_get_irq() prints an error message when the interrupt
is not available. So on platforms where bark interrupt is
not specified, following error message is observed on SDM845.

[    2.975888] qcom_wdt 17980000.watchdog: IRQ index 0 not found

This is also seen on SC7180, SM8150 SoCs as well.
Fix this by using platform_get_irq_optional() instead.

Fixes: 36375491a4395654 ("watchdog: qcom: support pre-timeout when the bark irq is available")
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20191213064934.4112-1-saiprakash.ranjan@codeaurora.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/qcom-wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -246,7 +246,7 @@ static int qcom_wdt_probe(struct platfor
 	}
 
 	/* check if there is pretimeout support */
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq > 0) {
 		ret = devm_request_irq(dev, irq, qcom_wdt_isr,
 				       IRQF_TRIGGER_RISING,


