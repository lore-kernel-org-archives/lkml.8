Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD80EC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FF0218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1hogus41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgIIIz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgIIIyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:54:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC3CC061786
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:54:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so2050587wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjs3H1T57/OsvxujNGQGLBWexjTmuttV9nlq5vhVwiw=;
        b=1hogus410UbSTewZULq8XN8hOyyBaL3K5B6EOLPEBYnY2sGYGPLbPW3ExsJq4pq4+H
         GICD3jVw0enYx6Gprar6A5TRJmmt56br+sRooWOV1CwuhcTx+bsn//Px3L+pkoJCOh+m
         fYwbhRd6W8qaWAXI2rTd6jScVykNjvgR7bNmSjXEZ7TDiBxHT09dlxpG5Ezja1cg/s8A
         FOAyOQuANxMt5ChTXpvKigtNMY0VAmWUmnKt7iiXAycAGWMUovJrodozixh0MtVmJxen
         gXRZ4DATBIzKNBdBoi/e96MQ3hAxtrVB9feV6GsGHB4jQ8BKl5oVyhuQNjPFJ0zTIu28
         J8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjs3H1T57/OsvxujNGQGLBWexjTmuttV9nlq5vhVwiw=;
        b=AVvZ9q2PuBN2EBpOtDjDkRYUtTni3eCpNVNUzf2tLtCb6TIdsZJTCCyqPtt4RIV89r
         JISJftD5Sq0pYTH+PCXlX/QybWo8vjgXW8fOzGZ29+T9QrKZTRvn1cDT02esS3t+DivM
         zzYGKy/m3/isTASEJ3SxgprWPdoqfsVMoE6qHMSNaZXXSoZ97noktCH0B0lXMeHGmIrc
         P/8wOwXSazuaR873psWBMbNBNkbFgNqwoaA8Gr8ZUTXUCEJbs0LuIJtvvFplrOX8hn/u
         tsnjcZ4rjqXtneknssylsONCNI5WblEuB7phbwG9t250LYo/8S8Jcg3IESMCMEf/resE
         SNpQ==
X-Gm-Message-State: AOAM532VEIN/BzB75mosScExUkmKI2BYXaeeLw806RfOQt4NUqh0289C
        jL35SZIYopyJUA0DGNSvm9/GfQ==
X-Google-Smtp-Source: ABdhPJyfX1lAkYRdf3f086UINT2xngPSrOgIgkfFzYyUgZA0LaGJG7CLOAi3E9XKsLi6Ob8wB4E1zg==
X-Received: by 2002:a5d:46cd:: with SMTP id g13mr2988799wrs.153.1599641673479;
        Wed, 09 Sep 2020 01:54:33 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-657-1-17-60.w109-210.abo.wanadoo.fr. [109.210.64.60])
        by smtp.gmail.com with ESMTPSA id n17sm3418812wrw.0.2020.09.09.01.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:54:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/3] device: property: add helpers to count items in string arrays
Date:   Wed,  9 Sep 2020 10:54:24 +0200
Message-Id: <20200909085426.19862-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200909085426.19862-1-brgl@bgdev.pl>
References: <20200909085426.19862-1-brgl@bgdev.pl>
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
index 9f805c442819..75c178055bc9 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -170,6 +170,12 @@ static inline int device_property_count_u64(struct device *dev, const char *prop
 	return device_property_read_u64_array(dev, propname, NULL, 0);
 }
 
+static inline int device_property_string_array_count(struct device *dev,
+						     const char *propname)
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
+fwnode_property_string_array_count(const struct fwnode_handle *fwnode,
+				   const char *propname)
+{
+	return fwnode_property_read_string_array(fwnode, propname, NULL, 0);
+}
+
 struct software_node;
 
 /**
-- 
2.26.1

