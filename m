Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65973C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337FD2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341403;
	bh=MrJiRdv9r/LUUwNsVWVmc/rZcoTAG34gs6aj4hF9sl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g+/T4PtZb42N51yrJ9v3IWA9fXKNmo+aWkqy+QLxrcJPqq+fdJezLSbvRkIdet1xf
	 SAR0lyNiqHSjVIGA7rBzpGXgk0mNj6UjiSpcAB+9f+99dSkCAHbB6Hz/HJUCEhFwYq
	 vZTzqP6NRvQXQPYeaFJA9+jf8pLai461CBTvmx7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbgBJNaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:30:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbgBJMgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:17 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2230620842;
        Mon, 10 Feb 2020 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338177;
        bh=MrJiRdv9r/LUUwNsVWVmc/rZcoTAG34gs6aj4hF9sl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RuPm3aB2M+hbH5Lg6BMMUCjyWHqgru5X57dOXs1kAEZdBalhNEf+iQm7iiecpU2n0
         buqkObMlTbcyEvkgCphl69BD02lNEKp4Aramxy1hLW+x7bU2TLdsd4Yo8K750boqcf
         YXz1MOMttokOu6ROFGraO5oLFgQCJ115E1NKP94E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 165/195] mfd: rn5t618: Mark ADC control register volatile
Date:   Mon, 10 Feb 2020 04:33:43 -0800
Message-Id: <20200210122321.372873407@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
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


