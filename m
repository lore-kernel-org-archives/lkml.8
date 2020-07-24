Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CD4C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A35E2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyNWaIcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGXHPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGXHPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:15:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A526C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:15:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so3966599plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m1cxk/yJDhQzHWxIfDtc4KRiJ6G7tfj5/p6X6jwH+Gc=;
        b=EyNWaIcz3awnLmOZp7ObOt7Sc266NbIAdgQeQz42bIDRybALnG0DkZd9IJfJbsYASP
         p2+lQXVYgL97v8R4jcb+tjCWP8s/1YqAQIyz/u6vWBQngBgVxxV0BKMH4dUg5fvS8tDI
         5SQOkT9YdaqbS5KM02tcIBdUXUweooesiLBZoFZEi08lz9UxGdvJVd5121n7LmyHLesi
         /lbbznze8b7ME2Dy6oz2q+0MXu6DtnZpJ3y+ISkkekhEOnNqG1puA9hb8JeggiGrZv49
         L0Ny2ks9r43wLbBZKAGSbYsrBCvDHrKm+0ZF2lRtoNhXy3pTzgjSNf3/cRB0T1HpBHIO
         qfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=m1cxk/yJDhQzHWxIfDtc4KRiJ6G7tfj5/p6X6jwH+Gc=;
        b=fwhY0dcL7zCekMY4HZii4SG8/2LkNQkifM/I0waIMyurdbXRHpu9oicJt7r7t7Bewu
         fDSmYmRwI5JE5BQKrv7zE5fDIToHGWgBszkKJGqOAQQWWKvjso4o8zsJXt4uWOtmu7kv
         0doNVXG4oHxIXLkl6JdZZcWRtwwq7rOFQEPG5L8vUqKHiU+CDcG8HLt1jg99p1gDmLOS
         I4fjNPWZwkYQs2Sjiu6nUd1eKG9GiTnVl77GnQ2EG2Lf55hA2xuP1OxQR0VN+5BPEqdt
         czUe1+XLXAoJzi1X9kKy3anpN76BJKfO4w3iqAOtNibCO+67rK5gLKFFNbZq4tvQ3WHn
         Xdeg==
X-Gm-Message-State: AOAM532NXyhlNmhqZ8qTfafWEgCIdfKXEyOH39KLuAh9x1jBw7XYRP3Y
        whcITzqK1E7L5h6EfFVirZI=
X-Google-Smtp-Source: ABdhPJxgvBNXWtqzgzBUzJ9ogczfeKoncBUHrg12gGEGNxjtq7ZC9euY9OtybQjhckPRtijdwo4UgA==
X-Received: by 2002:a17:90b:338d:: with SMTP id ke13mr4089518pjb.60.1595574953153;
        Fri, 24 Jul 2020 00:15:53 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id e20sm5206216pfl.212.2020.07.24.00.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 00:15:52 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     linux-fsi@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joachim Fenkes <FENKES@de.ibm.com>,
        linux-kernel@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/2] fsi/sbefifo: Clean up correct FIFO when receiving reset request from SBE
Date:   Fri, 24 Jul 2020 16:45:17 +0930
Message-Id: <20200724071518.430515-2-joel@jms.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724071518.430515-1-joel@jms.id.au>
References: <20200724071518.430515-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joachim Fenkes <FENKES@de.ibm.com>

When the SBE requests a reset via the down FIFO, that is also the
FIFO we should go and reset ;)

Fixes: 9f4a8a2d7f9d ("fsi/sbefifo: Add driver for the SBE FIFO")
Signed-off-by: Joachim Fenkes <FENKES@de.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-sbefifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index f54df9ebc8b3..655b45c1f6ba 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -400,7 +400,7 @@ static int sbefifo_cleanup_hw(struct sbefifo *sbefifo)
 	/* The FIFO already contains a reset request from the SBE ? */
 	if (down_status & SBEFIFO_STS_RESET_REQ) {
 		dev_info(dev, "Cleanup: FIFO reset request set, resetting\n");
-		rc = sbefifo_regw(sbefifo, SBEFIFO_UP, SBEFIFO_PERFORM_RESET);
+		rc = sbefifo_regw(sbefifo, SBEFIFO_DOWN, SBEFIFO_PERFORM_RESET);
 		if (rc) {
 			sbefifo->broken = true;
 			dev_err(dev, "Cleanup: Reset reg write failed, rc=%d\n", rc);
-- 
2.27.0

