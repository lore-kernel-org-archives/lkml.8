Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CA6C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4502D2068F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TlraVXkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgGOFYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbgGOFYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:24:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8982C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WnynRIMfITaZMYZcNLabagyEgxDCBTufX2A0jcLZF0o=; b=TlraVXkm1rHpK1VF8Yo7dwSrUE
        WTobD94OaIOiMsU5X6a+VpyrWzgXlZCFdTeQHguytfv2zJbuPYCaFdDUN2L81O0cJiAJBB9BkpedU
        LqUcegPY78oIgAvN5fDa/L685DVMXpwgTFhcSJ9qLVRVvJ5aaWajsgWPFuBfvTyg2jSnIRMy0oZOE
        ZxoxopJ02m2prVxxGZDZ3JLV41XbeG+tD0wHoieon/IkZhOOmlq9EPOiEVhnQ+qiBvHmHGyxuvmiP
        PI3kl9vsAnZOM1aT9JA5dRA98UE9/vSAdxBFPKMbNVTbag+IW0rrXsm34eHy+DjOtk0DMrZaQfFQt
        OMBArcUw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvZtf-0006Vd-3V; Wed, 15 Jul 2020 05:23:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 5/7] drm: i915_drm.h: delete duplicated words in comments
Date:   Tue, 14 Jul 2020 22:23:47 -0700
Message-Id: <20200715052349.23319-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715052349.23319-1-rdunlap@infradead.org>
References: <20200715052349.23319-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop doubled words "the" and "be" in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 include/uapi/drm/i915_drm.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200714.orig/include/uapi/drm/i915_drm.h
+++ linux-next-20200714/include/uapi/drm/i915_drm.h
@@ -55,7 +55,7 @@ extern "C" {
  *	cause the related events to not be seen.
  *
  * I915_RESET_UEVENT - Event is generated just before an attempt to reset the
- *	the GPU. The value supplied with the event is always 1. NOTE: Disable
+ *	GPU. The value supplied with the event is always 1. NOTE: Disable
  *	reset via module parameter will cause this event to not be seen.
  */
 #define I915_L3_PARITY_UEVENT		"L3_PARITY_ERROR"
@@ -1934,7 +1934,7 @@ enum drm_i915_perf_property_id {
 
 	/**
 	 * The value specifies which set of OA unit metrics should be
-	 * be configured, defining the contents of any OA unit reports.
+	 * configured, defining the contents of any OA unit reports.
 	 *
 	 * This property is available in perf revision 1.
 	 */
