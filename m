Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8C1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECA02072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtAxFjFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgETEgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgETEge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:36:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B47C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:36:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i62so706595ybc.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=e5FkQX0hqXPwtmuVi/mPOXIImVD+5LE0Q+GlPxmL3Pk=;
        b=rtAxFjFXV3814BoP15yfVrUr8n8lCx4bVdnb1JuGCEaQ12FTW3houE0z8K6gheZl4I
         WhwvC6LyK8HIjNZWDUZcg7DadvOF1GbRBMGG9xraVURZ2m4OsBd+Elh1gMYyUF4URPmm
         7q5FCzulqn+YHhavRqKGRlzeANp3KftrKlUkcUVfRCnkt4GL4A+Cr+MZ5XQ4SYlQt/XR
         0Y2Uv6dlv9qDDbaGYTynFO94cZtbQPB++NQfK8ciGLX5pcs9oNKn5CxOCyWKbJ/2HV1i
         n7rYlEsxwVnpzeEoUve0hKu5GM9TUgfvtjc9jaNdwmHwQicf+PxcV/JZAx/axeVQrAgJ
         2+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=e5FkQX0hqXPwtmuVi/mPOXIImVD+5LE0Q+GlPxmL3Pk=;
        b=k1xW+Ox2t4UVCmmdJc711cZ1fAQ2CL8tLsafNpv1w0fUL+PGmz6iNQYiX6rgvGriWp
         RUQ0KTsduicE3pam/80I8hxI5T0K447lCPniP24MOzKg9xCU9cxA1mfwIWJ+yPJesnbJ
         MFCoxRmb+j1OzcGZIM5JkwGVl8uKeiz62a41om4jGWA07ucezbikk0lCVtSGI916HCvs
         x5RrOwpiUhxEbG4hLGNfigjyS8FnSSNsx5SWegjrPBH2e/IZT764z1kPvcA0BMJqzrA9
         +LxkABUJCRIyq0HRG+p/s3ZfWjohvcxRp0qIChnsljz5gXkN584+Zx0ySmoKtfkAFOGu
         Vhpg==
X-Gm-Message-State: AOAM530aYW6V2vxa/DQI769J/0g10iuFFfYOLic+uDxO5gJjbCrME0ih
        NneXDuGg0em95xRiejZpa6qGik5QtyGVK6c=
X-Google-Smtp-Source: ABdhPJw9heR6jKgjPLq3w01G+O3G0CkpM+fWQcg/NH2AUEED1dmphVKNO3erXOVNgIFhB2E9Wp1NTxJvysp+Rbg=
X-Received: by 2002:a25:d181:: with SMTP id i123mr4316128ybg.316.1589949393316;
 Tue, 19 May 2020 21:36:33 -0700 (PDT)
Date:   Tue, 19 May 2020 21:36:26 -0700
Message-Id: <20200520043626.181820-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v1] driver core: Fix handling of SYNC_STATE_ONLY + STATELESS
 device links
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link
implementation") didn't completely fix STATELESS + SYNC_STATE_ONLY
handling.

What looks like an optimization in that commit is actually a bug that
causes an if condition to always take the else path. This prevents
reordering of devices in the dpm_list when a DL_FLAG_STATELESS device
link is create on top of an existing DL_FLAG_SYNC_STATE_ONLY device
link.

Fixes: 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link implementation")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Sigh... device links are tricky and hard! Sorry about the endless fixes :(
Also, how was this not caught by the compiler as a warning?

-Saravana

 drivers/base/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 83a3e0b62ce3..dfd4e94ef790 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -543,12 +543,14 @@ struct device_link *device_link_add(struct device *consumer,
 
 		if (flags & DL_FLAG_STATELESS) {
 			kref_get(&link->kref);
-			link->flags |= DL_FLAG_STATELESS;
 			if (link->flags & DL_FLAG_SYNC_STATE_ONLY &&
-			    !(link->flags & DL_FLAG_STATELESS))
+			    !(link->flags & DL_FLAG_STATELESS)) {
+				link->flags |= DL_FLAG_STATELESS;
 				goto reorder;
-			else
+			} else {
+				link->flags |= DL_FLAG_STATELESS;
 				goto out;
+			}
 		}
 
 		/*
-- 
2.26.2.761.g0e0b3e54be-goog

