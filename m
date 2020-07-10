Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9CDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6474920708
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ckgoHMtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGJAW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgGJAW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 20:22:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157E4C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 17:22:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x72so1734247pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 17:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckUCzQFimvD7NIA+QWWbpWCLSB8Zqmc22c9Qilpan44=;
        b=ckgoHMtuW/ok71oWR0jOY1AL7WiG2m/KZ0cSVRSnnNLRJGV4T3oyqnZe4i6+5CiH6T
         ZUv0jWl8XzBU6YDr5Zat6lHWAaAMqb4UBToJjBPAwJSzaOjfQww1OsjiKl3BAS9eiUKv
         iWhKmfG3dMoPDC0aGyfFjaEzw5XakcyXRvrLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckUCzQFimvD7NIA+QWWbpWCLSB8Zqmc22c9Qilpan44=;
        b=XEy9wyd9re5vrHEmgbnRz2M70WQ92PDTHr6qzn0+zhkUzocUwQIyp4ZeFHQDaPc+lg
         Djy4hfs3VMd/YOl8IyOus6pc9SjHF+o1+JK7IzTr02u2jRWBXeoqdF0lppqvEa+1h/wf
         1eWPK+80ASgbO1WW9lNrtFldcNqkUq2mPMA5sIMi+AGNFTtxi9elhlGJvxx4/kl0s7/f
         9I0QNeX8ifYDy4zQ7SGE9ZNhMkwx4ysmJG3GXbbnE1X1m+21nYC2RmYmD3VdwWAqmtdD
         yGwOiGgVDGltzAImy8CZfV3ze8w8hp+fQneIftsFxgnLMFZbVYDcRb1ImRCK5qWx9TKI
         DgJQ==
X-Gm-Message-State: AOAM5316wuKm1Glgz64mbOorumV7S/MtgOMhTzuJLc9OXEJiCAokM2KL
        woDp0u9/yRvarYhh53SqI+RJiw==
X-Google-Smtp-Source: ABdhPJyJ1Zl/XnIDYWubLFLNW5SV+UOx5qKUJXZPfzwDdsESHi5oJ223rZL0TXg/zVt4L12uoNyf4A==
X-Received: by 2002:a63:4c48:: with SMTP id m8mr57041634pgl.290.1594340546587;
        Thu, 09 Jul 2020 17:22:26 -0700 (PDT)
Received: from andrey-Z390.lan (c-67-164-102-32.hsd1.ca.comcast.net. [67.164.102.32])
        by smtp.gmail.com with ESMTPSA id i63sm3840181pfc.22.2020.07.09.17.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 17:22:26 -0700 (PDT)
From:   Andrey Pronin <apronin@chromium.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        Andrey Pronin <apronin@chromium.org>
Subject: [PATCH] tpm: avoid accessing cleared ops during shutdown
Date:   Thu,  9 Jul 2020 17:22:09 -0700
Message-Id: <20200710002209.6757-1-apronin@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prevents NULL dereferencing when using chip->ops while
sending TPM2_Shutdown command if both tpm_class_shutdown handler and
tpm_del_char_device are called during system shutdown.

Both these handlers set chip->ops to NULL but don't check if it's
already NULL when they are called before using it.

This issue was revealed in Chrome OS after a recent set of changes
to the unregister order for spi controllers, such as:
  b4c6230bb0ba spi: Fix controller unregister order
  f40913d2dca1 spi: pxa2xx: Fix controller unregister order
and similar for other controllers.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
---
 drivers/char/tpm/tpm-chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 8c77e88012e9..a410ca40a3c5 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -296,7 +296,7 @@ static int tpm_class_shutdown(struct device *dev)
 	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
 
 	down_write(&chip->ops_sem);
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+	if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
 		if (!tpm_chip_start(chip)) {
 			tpm2_shutdown(chip, TPM2_SU_CLEAR);
 			tpm_chip_stop(chip);
@@ -479,7 +479,7 @@ static void tpm_del_char_device(struct tpm_chip *chip)
 
 	/* Make the driver uncallable. */
 	down_write(&chip->ops_sem);
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+	if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
 		if (!tpm_chip_start(chip)) {
 			tpm2_shutdown(chip, TPM2_SU_CLEAR);
 			tpm_chip_stop(chip);
-- 
2.25.1

