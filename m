Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E7EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B989206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rsf1N6yX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406211AbgFYQbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406191AbgFYQbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:31:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A16C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so6177664wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rS9j2rQNFBNuRqF+LXK8DlVraMrXmRrORbc3erknD/A=;
        b=Rsf1N6yX7IxQGRLHSgXSpJP/QPbCuo2R1yR5hRp/jiWLAjlOONAIfPujcEjKgSdHQq
         HCdTJkdvd5BFjh1Bf4cFe8BzerfwN1dBFhQUFxF2l/p1UxJkuvzb87JUP9Toy1Dy2axP
         a0LXFQn4VuxV6m0LMVFRM7zV0Uc8Z7kDndCgJbFlhEyRA0LwFTWA5a6HeDrPOr1yYDD0
         zLqv5Mi39CHmn58FiUh2XnxGJdysqcpFfOV7VH5Ll6rpkZHvKIPTXw3GtnCZ+KGLOvMG
         hjQBHX76GS7NR1yBcE561TiGBTocOaLGrfvZnmZqg7tfQe775ibW+ZCGKNSY7nrv4GFD
         KOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rS9j2rQNFBNuRqF+LXK8DlVraMrXmRrORbc3erknD/A=;
        b=gwMi/vTF45BOZikXtG25LdWzDvk56UwJ6DeDMKNV9M/xYEjRAifSyUhzqko5VWuCE/
         CMK7h1yG0uM5tztxalpz0INpa5b+L4xKOMxzVpoSIveMSHTh/6DT4JFs2Ea82heLYm/6
         Wzas90tXOe4E20ZwJYdZg/xDKtkVgrxmhdEiQui0Aa23ai1KmC2v82pyAu5Q5lO7lDjl
         vQvLmHwMNECxLQcGH6t9oTXl/ajmMkRxSucxry/tc2ltznqeMk1M3cSDy0/s7UK1Q4S9
         huml8NYGeDl+Rf3g4jFT8pCHGccuQXyPGvrKL07apooBlklKKHxZdABLnolPF0BOwnhc
         qvdA==
X-Gm-Message-State: AOAM532ow01sbJkMkmcEy3l6sg/RYgAQvIB+0QYlGlSaA4+dSCqZOY7T
        euPXdUFb21jKxo32208iQltpTw==
X-Google-Smtp-Source: ABdhPJzhQiFSSOZa69VFgcR0DY0GlXvIC6q9WGt36h5eMePZdVb++c5OYhmvra/vUdFSxkb68YaCJQ==
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr4312440wmk.16.1593102700156;
        Thu, 25 Jun 2020 09:31:40 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l8sm32090847wrq.15.2020.06.25.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:31:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 06/10] mfd: si476x-cmd: Repair wrongly described function argument 's/response/resp'
Date:   Thu, 25 Jun 2020 17:31:23 +0100
Message-Id: <20200625163127.4000462-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163127.4000462-1-lee.jones@linaro.org>
References: <20200625163127.4000462-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

si476x_core_send_command()'s 5th argument has never been called response.

This change must have occurred prior to the driver being Mainlined.

We're also taking the opportunity to bring the first description back
into line, making my OCD happy!

This fixes the following W=1 warning(s):

 drivers/mfd/si476x-cmd.c:264: warning: Function parameter or member 'resp' not described in 'si476x_core_send_command
 drivers/mfd/si476x-cmd.c:264: warning: Excess function parameter 'response' description in 'si476x_core_send_command'

Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/si476x-cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/si476x-cmd.c b/drivers/mfd/si476x-cmd.c
index 4a09ce9609c90..316d44c2edcd4 100644
--- a/drivers/mfd/si476x-cmd.c
+++ b/drivers/mfd/si476x-cmd.c
@@ -241,13 +241,13 @@ static int si476x_core_parse_and_nag_about_error(struct si476x_core *core)
 /**
  * si476x_core_send_command() - sends a command to si476x and waits its
  * response
- * @core:    si476x_device structure for the device we are
+ * @core:     si476x_device structure for the device we are
  *            communicating with
  * @command:  command id
  * @args:     command arguments we are sending
  * @argn:     actual size of @args
- * @response: buffer to place the expected response from the device
- * @respn:    actual size of @response
+ * @resp:     buffer to place the expected response from the device
+ * @respn:    actual size of @resp
  * @usecs:    amount of time to wait before reading the response (in
  *            usecs)
  *
-- 
2.25.1

