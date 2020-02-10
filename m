Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B703C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFECB20708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339328;
	bh=b5E0seDSw/2qSo6zYqvtGmYLu55ZAeyA2xmwOUaLTtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lXoso1vtRqP5qz8mmob/dKDEoDRWFYTgFeeteZnVfU2coc4EPKAQwm0SlJojg3xC3
	 yFnkbhwN7+ljPszythb4hpaiTWy0zpNsGJEVxTEJ5gGhtugDoHETLyZRs3mdguG6Ls
	 PJcz6GX5a86QzVNNJGrDNHWvxewvBEIGmxL3/rV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgBJMz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:55:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbgBJMls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:48 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377C12085B;
        Mon, 10 Feb 2020 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338508;
        bh=b5E0seDSw/2qSo6zYqvtGmYLu55ZAeyA2xmwOUaLTtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHqinQ4AenhOt/sHIWLrwU9OVcYzBNUYlcd89ypzBs1OFsDJ0Pdp8i7Vywqpq1lDp
         5UKEZIr3Qvk33oiBMGKbnnop+TKOIAr6cBzVZz51UbgOFt46z53FYOOBI7ZckbGjYK
         GOYl00nF0iDBLfmSlSxS+hDrlUqF5bZkBS/YZptk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5.5 310/367] mfd: rn5t618: Mark ADC control register volatile
Date:   Mon, 10 Feb 2020 04:33:43 -0800
Message-Id: <20200210122451.946735221@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
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
@@ -26,6 +26,7 @@ static bool rn5t618_volatile_reg(struct
 	case RN5T618_WATCHDOGCNT:
 	case RN5T618_DCIRQ:
 	case RN5T618_ILIMDATAH ... RN5T618_AIN0DATAL:
+	case RN5T618_ADCCNT3:
 	case RN5T618_IR_ADC1 ... RN5T618_IR_ADC3:
 	case RN5T618_IR_GPR:
 	case RN5T618_IR_GPF:


