Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F25C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2B220884
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0gKR8A3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGCU5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 16:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCU5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:57:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9B9C061794;
        Fri,  3 Jul 2020 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZjyioTRalYimLAboXrEmUQ+/b3I3ysLUSM2O0IlJMro=; b=0gKR8A3EosJlI5VVzkfpxpHf0A
        5Zq3E3uMn2iqMrI9SQgehDGM3lkecXQ9LZO9EQH3FyzqqZ/JNHKp88imrhjOossZR3xlzAz6Z0607
        UTB/MJtqvPCHpcYZ0rDFaKYJdPC3K3c73aux/aRAYfjZAp8oy8Mon97/VVDxSrwj7ZjI/VpGC+XS3
        kODRl8QYBKqUMlu0WvIgpRtaBxYEzz1cdt7Co/dg33h0F7TUUnK25PyAWHMSlVZ30anktLP6oSauF
        GpknJDxbC5vV+ZTJ2oOpuWxwbd2686Cs8gFtOxs3FbVjuZyfrLsb8fQZu1ykr86bsO9/avqCB/x10
        aWejyRag==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrSk0-0003a5-Tp; Fri, 03 Jul 2020 20:57:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 2/5] Documenation: hwmon/lm93: drop duplicate words
Date:   Fri,  3 Jul 2020 13:56:46 -0700
Message-Id: <20200703205649.30125-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703205649.30125-1-rdunlap@infradead.org>
References: <20200703205649.30125-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 Documentation/hwmon/lm93.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/hwmon/lm93.rst
+++ linux-next-20200701/Documentation/hwmon/lm93.rst
@@ -133,7 +133,7 @@ Smart Tach Mode (from the datasheet)::
 	four signals are measured within 4 seconds.
 
 Smart tach mode is enabled by the driver by writing 1 or 2 (associating the
-the fan tachometer with a pwm) to the sysfs file fan<n>_smart_tach.  A zero
+fan tachometer with a pwm) to the sysfs file fan<n>_smart_tach.  A zero
 will disable the function for that fan.  Note that Smart tach mode cannot be
 enabled if the PWM output frequency is 22500 Hz (see below).
 
