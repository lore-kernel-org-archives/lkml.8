Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8C8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8127820899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiK2yuMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgGBOrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730049AbgGBOq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2855AC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so27100069wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tk9qHYg/pg0juZNf3DyUaHaFVykgS42nSPkB38BS4VI=;
        b=GiK2yuMf9VW7Z19uG5zEvbRFhcxtXMkMeY4rPH9Zx9s8uYWAYCMypKVT6Y+yt/6rpf
         WAMPgaN9U6Wb1hOUUyF6qS2KpVrIESS0jlVC/cZiI8MECown7OC4GobHQPZTQbGyz8ZB
         7fvGBsjm6+LwOPTbQneEItoMZe1tX4XEGxdu0PNP4t+fYFBmNOEZ3xFE1sZrfX6U57so
         CsjeTWoXQxLX8Q7saQaBB7p8LTSLNTov4O5gqDMpRaYJstZKlvKa/a3L7R7Xz1KrFIR7
         8h0MKN445JU+sOn0Cy2a2snY9PgjV8i9RE4MkV55pirdqCbmMjSFkawux/M2RHJ4vmHm
         diuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tk9qHYg/pg0juZNf3DyUaHaFVykgS42nSPkB38BS4VI=;
        b=S0wiAKBS9bPbr7ye2lW3sHiuepn6/yUKb3TnN+jQCGCOa0yYao1Eu1o2ZUTF0AePht
         E4WUD3MGWDp1Ma7z3250aQVqxvTfNJVVstUjXbAfoikmXhzyMzT9GdcNU3qJUP8ktnx8
         jl54HlM/ziDwSq7IUPoBZU7rYj6Fw6c/9pZ0wwm4r/PY85mBq6K5ufYyLwtHvqXsADoL
         oxp3ZNO18MBSrr6hKWcP+yh8sVRzYntMqRtkw6J6e/0ZNlIQ7vjb5Piqje6nqr6bTuu4
         igman8KtLAi4A4eJFJiBsoVZyaQC+P4QGAev4tlJhRcY/NGxE2AHlkM6oOLe1YJaPBcX
         pDKg==
X-Gm-Message-State: AOAM532+EgSrcsqNRZNphuK15z3Fd0T/Qv/whhRwpYlJljUPlIb84ptz
        IcSOCQzjYl3uWPyDC79UuZZm8Q==
X-Google-Smtp-Source: ABdhPJwr5kCUGPxhCkk8QXKgz4YnAOyGhc74VvsL45wpZKCwBUEyj4mXBP6XM5Epl9ziHR3pE3GVuw==
X-Received: by 2002:a05:600c:2187:: with SMTP id e7mr31551586wme.171.1593701217878;
        Thu, 02 Jul 2020 07:46:57 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roman Weissgaerber <weissg@vienna.at>,
        David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 21/30] usb: host: ohci: Mark cc_to_error as __maybe_unused
Date:   Thu,  2 Jul 2020 15:46:16 +0100
Message-Id: <20200702144625.2533530-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/usb/host/ohci.h in included by a whole much of different
sourcefiles.  Not all of them make use of cc_to_error.  So mark
it as __maybe_used to convey that this behaviour is not only
acceptable it's expected.

Fixes the following kernel build warning(s):

 In file included from drivers/usb/host/ohci-pci.c:25:
 drivers/usb/host/ohci.h:165:18: warning: ‘cc_to_error’ defined but not used [-Wunused-const-variable=]
 165 | static const int cc_to_error 1 = {
 | ^~~~~~~~~~~
 In file included from drivers/usb/host/ohci-platform.c:32:
 drivers/usb/host/ohci.h:165:18: warning: ‘cc_to_error’ defined but not used [-Wunused-const-variable=]
 165 | static const int cc_to_error 1 = {
 | ^~~~~~~~~~~
 In file included from drivers/usb/host/ohci-exynos.c:20:
 drivers/usb/host/ohci.h:165:18: warning: ‘cc_to_error’ defined but not used [-Wunused-const-variable=]
 165 | static const int cc_to_error 1 = {
 | ^~~~~~~~~~~
 In file included from drivers/usb/host/ohci-spear.c:22:
 drivers/usb/host/ohci.h:165:18: warning: ‘cc_to_error’ defined but not used [-Wunused-const-variable=]
 165 | static const int cc_to_error 1 = {
 | ^~~~~~~~~~~
 In file included from drivers/usb/host/ohci-st.c:26:
 drivers/usb/host/ohci.h:165:18: warning: ‘cc_to_error’ defined but not used [-Wunused-const-variable=]
 165 | static const int cc_to_error 1 = {
 | ^~~~~~~~~~~
 In file included from drivers/usb/host/ohci-at91.c:31:
 drivers/usb/host/ohci.h:165:18: warning: ‘cc_to_error’ defined but not used [-Wunused-const-variable=]
 165 | static const int cc_to_error 1 = {
 | ^~~~~~~~~~~
 In file included from drivers/usb/host/ohci-s3c2410.c:32:
 drivers/usb/host/ohci.h:165:18: warning: ‘cc_to_error’ defined but not used [-Wunused-const-variable=]
 165 | static const int cc_to_error 1 = {
 | ^~~~~~~~~~~

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Roman Weissgaerber <weissg@vienna.at>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/ohci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index b85a39588f9d9..aac6285b37f80 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -162,7 +162,7 @@ struct td {
 
 
 /* map OHCI TD status codes (CC) to errno values */
-static const int cc_to_error [16] = {
+static const int __maybe_unused cc_to_error [16] = {
 	/* No  Error  */               0,
 	/* CRC Error  */               -EILSEQ,
 	/* Bit Stuff  */               -EPROTO,
-- 
2.25.1

