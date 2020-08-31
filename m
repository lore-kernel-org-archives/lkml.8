Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147F8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E752D206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI4M2k2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgHaDXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgHaDXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:23:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06530C061573;
        Sun, 30 Aug 2020 20:23:41 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j11so2361162plk.9;
        Sun, 30 Aug 2020 20:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9daGc+bQBQhtyKnIGABCoe3Sraaytqyp+0NjDqFhrAU=;
        b=GI4M2k2DYgh1o0YqHKe3ieUJytW1r80zb5/Mh9HB97j9m6a/STR3/v6uvxaiYW/U/F
         N0fC4OS4+RbFSzBAsYahElHnDTD0WF2VeYfKz5HcY/N7bSzSEyJoMTDfMrgNMpjMvaDl
         sUhPWTlE/JaiGsMDv2EITvLvQfMMgef5ZiEf9wn9JkGbWqYhLPnfHMoIyoFLxNUtEfi6
         +onmiMlboctW/rBuEL1wr9XO5pxHmwW36iho4Vj5Kn/zc3TVlHLLXJl8N4i3zTMubK/6
         1/BIDWCHY2VH6SbKjUbNaR+h0hUqMp1tniZpY15ZGo3bkLP1nt5nr0q0ngYrszcwsnBZ
         CprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9daGc+bQBQhtyKnIGABCoe3Sraaytqyp+0NjDqFhrAU=;
        b=qCzwG/2tnioKEAMTbqUT44x3lPsDnSMcJZoZIMqTMCblqAHDDY0DdZLEihmNimENuz
         bGuHhCC8/GV8eX/GqgxXlVLzKfRUlmE5zhIKLh1XUwWyLOW1okomeNpYXMrYZOZoRHr5
         YZeArLMPDDhODLwEmwyf/VwLmdzDbejASLGrgt7TME4nbQTur+dUzHmag7xWkyK0zvDA
         ZXE8YhmAFt8WfMwlVGXPh5EJ9f/APxlMZdKCaIsH6GB6tEmNFr9/3S4AnZ7Kbwj/Wl2Z
         ExVdjBgogg88irxM3HcNOOPA8TsY7iqWV4Q6qiXrIGz/WPpXdAyvux9AI3cA3V7PChIx
         kTAg==
X-Gm-Message-State: AOAM530vZTvpj6qWh47Z935cjPRQmjDjH7Ha9otQ6n5HXubGcVcV2uIc
        qxKrOqHUsYeOl9C1Ef08nWZGpW3hy/Q=
X-Google-Smtp-Source: ABdhPJyqep3tHEMf+p8Yg1LkixPFUWcGsFy1Q+8cZDE0rgcsDg+5Up3If2K7m52K/mRcDLZA/Ld1NA==
X-Received: by 2002:a17:90b:a54:: with SMTP id gw20mr8585540pjb.183.1598844220186;
        Sun, 30 Aug 2020 20:23:40 -0700 (PDT)
Received: from sol.lan (106-69-184-100.dyn.iinet.net.au. [106.69.184.100])
        by smtp.gmail.com with ESMTPSA id z17sm6095733pfq.38.2020.08.30.20.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 20:23:39 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v6 13/20] gpio: uapi: document uAPI v1 as deprecated
Date:   Mon, 31 Aug 2020 11:19:59 +0800
Message-Id: <20200831032006.1019978-14-warthog618@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831032006.1019978-1-warthog618@gmail.com>
References: <20200831032006.1019978-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update uAPI documentation to deprecate v1 structs and ioctls.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 include/uapi/linux/gpio.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
index 0eb1f53b47e0..4af67415d73e 100644
--- a/include/uapi/linux/gpio.h
+++ b/include/uapi/linux/gpio.h
@@ -274,6 +274,9 @@ struct gpio_v2_line_event {
 
 /*
  *  ABI v1
+ *
+ * This version of the ABI is deprecated and will be removed in the future.
+ * Use the latest version of the ABI, defined above, instead.
  */
 
 /* Informational flags */
@@ -297,6 +300,9 @@ struct gpio_v2_line_event {
  * @consumer: a functional name for the consumer of this GPIO line as set by
  * whatever is using it, will be empty if there is no current user but may
  * also be empty if the consumer doesn't set this up
+ *
+ * This struct is part of ABI v1 and is deprecated.
+ * Use struct gpio_v2_line_info instead.
  */
 struct gpioline_info {
 	__u32 line_offset;
@@ -328,6 +334,9 @@ enum {
  * guarantee there are no implicit holes between it and subsequent members.
  * The 20-byte padding at the end makes sure we don't add any implicit padding
  * at the end of the structure on 64-bit architectures.
+ *
+ * This struct is part of ABI v1 and is deprecated.
+ * Use struct gpio_v2_line_info_changed instead.
  */
 struct gpioline_info_changed {
 	struct gpioline_info info;
@@ -367,6 +376,9 @@ struct gpioline_info_changed {
  * @fd: if successful this field will contain a valid anonymous file handle
  * after a GPIO_GET_LINEHANDLE_IOCTL operation, zero or negative value
  * means error
+ *
+ * This struct is part of ABI v1 and is deprecated.
+ * Use struct gpio_v2_line_request instead.
  */
 struct gpiohandle_request {
 	__u32 lineoffsets[GPIOHANDLES_MAX];
@@ -386,6 +398,9 @@ struct gpiohandle_request {
  * this specifies the default output value, should be 0 (low) or
  * 1 (high), anything else than 0 or 1 will be interpreted as 1 (high)
  * @padding: reserved for future use and should be zero filled
+ *
+ * This struct is part of ABI v1 and is deprecated.
+ * Use struct gpio_v2_line_config instead.
  */
 struct gpiohandle_config {
 	__u32 flags;
@@ -398,6 +413,9 @@ struct gpiohandle_config {
  * @values: when getting the state of lines this contains the current
  * state of a line, when setting the state of lines these should contain
  * the desired target state
+ *
+ * This struct is part of ABI v1 and is deprecated.
+ * Use struct gpio_v2_line_values instead.
  */
 struct gpiohandle_data {
 	__u8 values[GPIOHANDLES_MAX];
@@ -421,6 +439,9 @@ struct gpiohandle_data {
  * @fd: if successful this field will contain a valid anonymous file handle
  * after a GPIO_GET_LINEEVENT_IOCTL operation, zero or negative value
  * means error
+ *
+ * This struct is part of ABI v1 and is deprecated.
+ * Use struct gpio_v2_line_request instead.
  */
 struct gpioevent_request {
 	__u32 lineoffset;
@@ -440,6 +461,9 @@ struct gpioevent_request {
  * struct gpioevent_data - The actual event being pushed to userspace
  * @timestamp: best estimate of time of event occurrence, in nanoseconds
  * @id: event identifier
+ *
+ * This struct is part of ABI v1 and is deprecated.
+ * Use struct gpio_v2_line_event instead.
  */
 struct gpioevent_data {
 	__u64 timestamp;
@@ -464,6 +488,8 @@ struct gpioevent_data {
 
 /*
  * v1 ioctl()s
+ *
+ * These ioctl()s are deprecated.  Use the v2 equivalent instead.
  */
 #define GPIO_GET_LINEINFO_IOCTL _IOWR(0xB4, 0x02, struct gpioline_info)
 #define GPIO_GET_LINEHANDLE_IOCTL _IOWR(0xB4, 0x03, struct gpiohandle_request)
-- 
2.28.0

