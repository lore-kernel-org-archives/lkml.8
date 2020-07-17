Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F6BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A521520737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JoPHqajg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgGQQ5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgGQQ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD97C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so11857324wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VxERIJkNFUQ5ozpJhehQBvzBnN2ugWiIznLPwHBPnFk=;
        b=JoPHqajgOW42YICPAe8k9IXDr8Oq0uyPpS778IQ3CfxvDtIbl5D8zR0Df+QDdALhPU
         por7Z1VCalQYriqoUWjMGqkkEBx9qImCE5FFvIaMi8hJpomwggTqQgOJ19UYPdPO8rBY
         I5PSktHvzMysiadqwkX2LWNDAzwUcNS7uAwz2NvAxFZ/Iy+S1Ud5WLrixqzfdLf/pbGg
         yxYjRYaAjHvYP+zH3MJwVQX8O0kle7SSULEcwJKMfkMqnqKsaCZyjvK/G3JNJRGNdFjx
         zJ/JJ2pXTBy6xWQXBvuRm3uIllaX05mGTqtnfXfw3uviQ82rG8NtpnmP3o0TmmXYzwHb
         XSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VxERIJkNFUQ5ozpJhehQBvzBnN2ugWiIznLPwHBPnFk=;
        b=AT6iaj80ZMAvf+Cah19A/kpqtaVy2SguprPxFF7k67KlierEWG50LXTa1BNmpGjCgQ
         5biPM+MPLFLlMfSwoAK06F+K9OS506F4TrT4oyxJm9U2NUTZWCYn7swYuDJm+O2k7Gkj
         QTTOE8o3rozd+wixjPoWK1QEVmhYgNqMKgvW1hvKmOv9xdydtC0uGJiie/jFE1KukIzw
         M0CC8x8Hc1PWtcnmrVjZ56b98XdUg8rKvvQG2c+gtpHsXayXMa9SCaUWjLwNlHk/1gFK
         uZhsQ2BhCO+yhY1Cg/SrfWHUuW7Fqq1vIqXOSe8PA+gDcLzQ+h/fte0RNRBwinLFf7lh
         RNng==
X-Gm-Message-State: AOAM53227sxsQ/eK70tEwk4Ii8JGplxmRnI62Z5m2tOV+wi29xeviPZC
        FhVBUUtOW8xImBSJDMz57FzXUA==
X-Google-Smtp-Source: ABdhPJyoyi3KXxofIeitDa3r5dXgzfyGk9VTWMvKp/iCGqvFymG0cwak1NwrvETpg7f4cCGxPyMThw==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr10668408wrn.94.1595004984144;
        Fri, 17 Jul 2020 09:56:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Pradeep Goudagunta <pgoudagunta@nvidia.com>
Subject: [PATCH 23/30] iio: adc: palmas_gpadc: Demote non-conforming kerneldoc header
Date:   Fri, 17 Jul 2020 17:55:31 +0100
Message-Id: <20200717165538.3275050-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very few of the struct attributes have been documented here.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'dev' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'palmas' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'irq' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'irq_auto_0' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'irq_auto_1' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'adc_info' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'conv_completion' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup1_data' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup2_data' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup1_enable' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup2_enable' not described in 'palmas_gpadc'

Cc: Pradeep Goudagunta <pgoudagunta@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/palmas_gpadc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 46e595eb889fa..81b0a76a767e8 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -76,7 +76,7 @@ static struct palmas_gpadc_info palmas_gpadc_info[] = {
 	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
 };
 
-/**
+/*
  * struct palmas_gpadc - the palmas_gpadc structure
  * @ch0_current:	channel 0 current source setting
  *			0: 0 uA
@@ -94,7 +94,6 @@ static struct palmas_gpadc_info palmas_gpadc_info[] = {
  * This is the palmas_gpadc structure to store run-time information
  * and pointers for this driver instance.
  */
-
 struct palmas_gpadc {
 	struct device			*dev;
 	struct palmas			*palmas;
-- 
2.25.1

