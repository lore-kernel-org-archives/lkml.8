Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FD5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A57420724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947855;
	bh=YDuYgn1B+nMVAtTNBX7YH9v8OID+eAtMWJYetYwDfi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HE63dx3gYUW92+T/ciD12sqWSQe50EwIrvZbfHkAqLVLBR5gCa1uTUnqvWJ0Sdc7k
	 Ttydu8CEwVewKdaPA8i5YA8nXZCgfDGaFP00Y17CoSm1qq1c1W6vRSxfPO0tl6Eerq
	 skSFMuhfqBl9mC9LrUjB9xkflA6J2/vHIMobs0Dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393605AbgFWVax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388911AbgFWUO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:14:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B6E20707;
        Tue, 23 Jun 2020 20:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943268;
        bh=YDuYgn1B+nMVAtTNBX7YH9v8OID+eAtMWJYetYwDfi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vE8J8D0XlcbkEQQG8+W4l6xgG3CCSLgIYZdrKvLjHd0lTMbk6QNOcuV3lU9Sz2v6U
         KvStXaCLjPPAQy0JILMUfgn5JyROP/u/YV0yRMD26852jGMi2fHPkQFAByidy/mouS
         +43YUqKjO4FyF16LWn1Ia9oYgiO9E25o0hwkwXMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 325/477] pwm: Add missing "CONFIG_" prefix
Date:   Tue, 23 Jun 2020 21:55:22 +0200
Message-Id: <20200623195422.897634178@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit f5641d053d46a9a18fe13f2ecb4a7b4a66d9cdf7 ]

The IS_ENABLED() use was missing the CONFIG_ prefix which would have
lead to skipping this code.

Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9973c442b4555..6b3cbc0490c6e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -121,7 +121,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
 		trace_pwm_get(pwm, &pwm->state);
 
-		if (IS_ENABLED(PWM_DEBUG))
+		if (IS_ENABLED(CONFIG_PWM_DEBUG))
 			pwm->last = pwm->state;
 	}
 
-- 
2.25.1



