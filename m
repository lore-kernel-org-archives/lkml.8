Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85FBC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5A321741
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFjF8NYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgGRQvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 12:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgGRQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 12:51:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC1C0619D2;
        Sat, 18 Jul 2020 09:51:33 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c139so11557758qkg.12;
        Sat, 18 Jul 2020 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hqR7nLeOqkrR3dVNUU/FhC4bdCZMzx2L+6QAslHtlsQ=;
        b=DFjF8NYGokKEuca5gVne/BU6ev+jAXmZC8vkvF40trG8KBCQj2IuitF8i2dKhnc4el
         8ebIO8K5+Io8YIMTM3QOH1Ty9pvqDyCR7PmZOjhx13RLl+SWZyxj7KXmryF79XcTpWqv
         Y3RIuMtMJz9cGZsgQwIsXjVLGEsb0pjPk6z9mdhDPmN0waF9DrOOwQHxhgCpQSyPkTSN
         j0oSSaStmJZRkPc1RXed+l1BUPjlFjO/6cHQbAXUZKTQOrT9R/MYY0STG1zX2qm3SAxT
         cu+OxqW5DcrKd9EjXurKLKAeO4XG8U8PbTW3WHIBQ/qatGnNK77Xz+IOU6QLWzzY2xGj
         SYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqR7nLeOqkrR3dVNUU/FhC4bdCZMzx2L+6QAslHtlsQ=;
        b=nwKjwf7uGjdeQ1Y2gKteg3G5wYomxvFnZgP25ll3M++sLtX8bR06gHBLNEKPudMnAM
         x1Czhgflvvam7pZrpxwjytL4wJm3e12jo2OPK0Pr11QN5I3C/Mxz7vNnELFGnYFzZNMA
         epAc5WhZVsq048fKuYioR2+KV1iCCDe2VV+Q+IpkJTXFuhb71hAtPzZswYqowewd2zDJ
         K3vwAzUHnxqH1ifYqzSjoERP5U6n/f9CXyU4X5i7LQrUhcEZ1ItaiqFlSmNLg4lqcNFL
         nu3+NKLUGJlcDYzoZw7zv/YM7KFVYuoy5RkxSNdx7Q7nCNRyoWxdxuX50Fx4zXto/ioz
         YTkA==
X-Gm-Message-State: AOAM532LluyBY/dZKJdD5/k3TZwU9GqE4oJWeG5Uo5b+G/zPqUVD+zwq
        Oeu5utVchAaHaqzrd4lgUZ16wk4IW7c=
X-Google-Smtp-Source: ABdhPJx4OBz50AX++OUHQwarmICKgScFdPYbfGjT3BFeP61zcQz8/KYLgD5oBuXSokDMzyM+ceEzeQ==
X-Received: by 2002:a37:9d82:: with SMTP id g124mr13978054qke.456.1595091092872;
        Sat, 18 Jul 2020 09:51:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:602d:16d:d038:1a92:190d:65d2])
        by smtp.gmail.com with ESMTPSA id q5sm15361801qtf.12.2020.07.18.09.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 09:51:32 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, jens.wiklander@linaro.org
Cc:     "Daniel W . S . Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Subject: [PATCH] docs: staging/tee.rst: convert into definition list
Date:   Sat, 18 Jul 2020 13:50:58 -0300
Message-Id: <20200718165107.625847-4-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718165107.625847-1-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Fix the following warnings:

tee.rst:65: WARNING: Unexpected indentation.

tee.rst:69: WARNING: Block quote ends without a
blank line; unexpected unindent.

By switching to the 'definition list' syntax.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/staging/tee.rst | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index 62e8ba64d04f9..4d4b5f8896032 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -61,13 +61,17 @@ represented as a device identified via Universally Unique Identifier (UUID) and
 client drivers register a table of supported device UUIDs.
 
 TEE bus infrastructure registers following APIs:
--  match(): iterates over the client driver UUID table to find a corresponding
-   match for device UUID. If a match is found, then this particular device is
-   probed via corresponding probe API registered by the client driver. This
-   process happens whenever a device or a client driver is registered with TEE
-   bus.
--  uevent(): notifies user-space (udev) whenever a new device is registered on
-   TEE bus for auto-loading of modularized client drivers.
+
+match():
+  iterates over the client driver UUID table to find a corresponding
+  match for device UUID. If a match is found, then this particular device is
+  probed via corresponding probe API registered by the client driver. This
+  process happens whenever a device or a client driver is registered with TEE
+  bus.
+
+uevent():
+  notifies user-space (udev) whenever a new device is registered on
+  TEE bus for auto-loading of modularized client drivers.
 
 TEE bus device enumeration is specific to underlying TEE implementation, so it
 is left open for TEE drivers to provide corresponding implementation.
-- 
2.27.0

