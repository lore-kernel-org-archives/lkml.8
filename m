Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74809C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400EE222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFjRi2lX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgBUIF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:05:27 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33256 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731809AbgBUIFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:05:23 -0500
Received: by mail-pg1-f201.google.com with SMTP id 37so774115pgq.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 00:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TmMGk/2HBR1UCtTSik3KGPjlUzxkj3b3kzWXZC6WT9Q=;
        b=iFjRi2lXT3xCMYDE9bXhtNTLTPvc/qH/k0oZFPXOxEmT77SupUGzWbQlxjIkYDvepJ
         J9m8yzaSxeNODkQo4SNsHB7r3mdbZphkPoMS8nwejEWyCm1o2Yi5799rE1NpThTna3G2
         OmBhe0RsQMPWgbObAglt1/23z6cPD70Hwh0LuccpHztgX4nyAsbugqpyb6VzLlsm/2r0
         O1um1spjp+JKFiTI5jmugktkX6EarXzwznHkso5Se6zh48jpoyM7P5rLyUKLy41HPvnQ
         7K/avBOyXpvJoulZfo/ANUTrpc7dfVv/OyVX/611NoYiOVEeSq5GpQBwA7CLcn29E+MC
         I4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TmMGk/2HBR1UCtTSik3KGPjlUzxkj3b3kzWXZC6WT9Q=;
        b=uhgfbOhQVJWVChQ3Fp32/OmlwTfuwyhNgpc9E+47DjmtwKdG3Sy1DkB0uUKv45rCXX
         Os5G1j/qPeJmOmi7DoNHxBKggeWBA7y4Vhyhubc9BJLrgbucvNgbCxCNFtQvGrnOs4Xo
         PQyYFwTJAHCEOmasIVT5+/tl2LBmhUsPUkQpkT+Uqu2BdRltfnWsxrAdpHpV4glQxI8v
         bkUe0KQFoomrYQ2hdlxUF10Ukeii+kfxjiYn0+Tl2dW9QKzr1YZZ2s8U5Cfns1JNA9F8
         YOI4xfiAin/QGAfRL+rA1c+gKpodu+P3xRNiqGsAsR07yK6SHoYWVwy11YkYd94V6GGT
         oMUg==
X-Gm-Message-State: APjAAAWn/Khw+BlBmCk23Meiyk76BQBq/aM526ZyUBPAKegidTJMxA3N
        3mRUGHBXMrsHht4giJKeVPqZtCOOtKhzEHg=
X-Google-Smtp-Source: APXvYqwwT8HrJMcRaQcjbMBtfXoB9pFj05Vh7NYFLdWIETzC1+E/D7owCTf4aiQ+/33i/qwrW6L5AmqEXOqk5Rc=
X-Received: by 2002:a63:d49:: with SMTP id 9mr36176560pgn.249.1582272322794;
 Fri, 21 Feb 2020 00:05:22 -0800 (PST)
Date:   Fri, 21 Feb 2020 00:05:09 -0800
In-Reply-To: <20200221080510.197337-1-saravanak@google.com>
Message-Id: <20200221080510.197337-3-saravanak@google.com>
Mime-Version: 1.0
References: <20200221080510.197337-1-saravanak@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 2/3] driver core: Add dev_has_sync_state()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an API to check if a device has sync_state support in its driver or
bus.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 include/linux/device.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0cd7c647c16c..fa04dfd22bbc 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -798,6 +798,17 @@ static inline struct device_node *dev_of_node(struct device *dev)
 	return dev->of_node;
 }
 
+static inline bool dev_has_sync_state(struct device *dev)
+{
+	if (!dev)
+		return false;
+	if (dev->driver && dev->driver->sync_state)
+		return true;
+	if (dev->bus && dev->bus->sync_state)
+		return true;
+	return false;
+}
+
 /*
  * High level routines for use by the bus drivers
  */
-- 
2.25.0.265.gbab2e86ba0-goog

