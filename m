Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101E7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1AE2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yJoNljIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbgIHUGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbgIHPVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:21:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD3AC0612F6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:58:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so17082340wmm.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nLn7MBojIPZBX1Cc0fte6bJy2zYPGF+0OvSOSKZTZQk=;
        b=yJoNljIa9qlqXWuxKL1etUoPBbX1rvf2LnGB7dKBJ9r9JaiDrabh6nGL1BJ3LsQvqH
         30ELXTFAi7IW9qjR3oYAyzwHxFMURLTJuY/bsyInF9Ja3sIV9hQ98k2ul+IyUVYV9AcB
         hriqDEUIZxfsCVQXzh8HYZENCU+u3nykO1L232HxS6MQVmeG4jnL6BsnJNuW95FEI9+W
         VnNzWEwTQSp82wWUt+DvVzP0H9mCix905ZS7D4JffHFa0McetsJrX2l4WnM5ty4GFFgR
         tzhL8qo+FMnFFqBOCK8nJieJK7CyM2FzaO96jnHFpKPdNS28pxgac4yq8+FlXv4mY9lG
         NvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nLn7MBojIPZBX1Cc0fte6bJy2zYPGF+0OvSOSKZTZQk=;
        b=XbLp37lGboxKL29ond/sVTKJ5av/clDx4ysGtYwYhxt5Yg4wWysEmH4iOQiIdciwnU
         Re1jtkiqENGSVzAu2DDCMthyR8L+PmlCz3L9b6JCUn+2uj1H6Xqdg49j9WbVodagakaH
         jIT4hMztyU3VehceMdmfAnGikTmuw6MTzHkc4joHatUy6ReWEco73v7mZkiFQo74GZFz
         mL/6kYG9oxi9q38Q7xZoz+1UNgo+FnGR9Ir94QiFT/Zmc/DzN7Ecrf4lmoZDDJ/QTXJb
         wHOSoaBS74ot7LCxpiaMdPYiHtm2s8JR4DazMnSDhH+1U8T1X70OxzSGDYqkb02wcmH9
         QTnA==
X-Gm-Message-State: AOAM533L7BdDOvVqafueIZhxYj6s6X7s7qRABWsNbcLO0K8AQ/D/tBLx
        uHZX1CveGfb72mSay0tb66gduA==
X-Google-Smtp-Source: ABdhPJw2UX4DwJ8uomQdKlEKGp4dWXgNPdYavMGcv8xNO/e3jRahH6Mfzl+E80OqSzYNL6Ct55Zkqw==
X-Received: by 2002:a1c:7d0c:: with SMTP id y12mr4360474wmc.103.1599569906573;
        Tue, 08 Sep 2020 05:58:26 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y207sm34817875wmc.17.2020.09.08.05.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:58:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/3] device: property: add helpers to count items in string arrays
Date:   Tue,  8 Sep 2020 14:58:11 +0200
Message-Id: <20200908125813.8809-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200908125813.8809-1-brgl@bgdev.pl>
References: <20200908125813.8809-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Instead of doing the following:

    count = device_property_read_string_array(dev, propname, NULL, 0);

Let's provide inline helpers with hardcoded arguments for counting
strings in property arrays.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/property.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 9f805c442819..1fa5e250a8ea 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -170,6 +170,12 @@ static inline int device_property_count_u64(struct device *dev, const char *prop
 	return device_property_read_u64_array(dev, propname, NULL, 0);
 }
 
+static inline int device_property_count_strings(struct device *dev,
+						const char *propname)
+{
+	return device_property_read_string_array(dev, propname, NULL, 0);
+}
+
 static inline bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
 					     const char *propname)
 {
@@ -224,6 +230,13 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
 	return fwnode_property_read_u64_array(fwnode, propname, NULL, 0);
 }
 
+static inline int
+fwnode_property_count_strings(const struct fwnode_handle *fwnode,
+			      const char *propname)
+{
+	return fwnode_property_read_string_array(fwnode, propname, NULL, 0);
+}
+
 struct software_node;
 
 /**
-- 
2.26.1

