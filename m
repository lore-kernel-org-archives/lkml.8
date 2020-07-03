Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD994C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FA420884
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vvE61Ffi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgGCU5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 16:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgGCU5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:57:11 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628C2C061794;
        Fri,  3 Jul 2020 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=R+4UIuti3Yu59cS66T9z4T8p1dcbvO0NXfdkUzsABzc=; b=vvE61Ffi4Hwlw3EuRItCseBtlH
        yOUftxdUl5Hn7hu+Zj1EUKMId6MpcqaO9kqPc4JogUt5Zp5KZ+YZIXTYuXmJDdfDKPXtbWgfuq4FK
        IXlj8Z5eyZAMAmsyCSKhf78kVLf6NN4gnvbQ3WWe+fju55qoa8MxFhZaqXBo0VcVONfyoR5eVWY/M
        NFrH/06j8axeriq10rBKNn3J6c/cWdLmJoPl8P2WfbaWW3KAVXxZHRSxFl2P4PVTkPq/fjeBahfhp
        pNTzUHbbwUPyNDcWfcsYEsoEwUPM/G13DJLkWINjFKSlQkibDrT5mlvC7n1Co/h9kRkj+FlsacPbF
        csfrUUtg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrSk9-0003a5-3D; Fri, 03 Jul 2020 20:57:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 5/5] Documenation: hwmon/w83l786ng: drop duplicate words
Date:   Fri,  3 Jul 2020 13:56:49 -0700
Message-Id: <20200703205649.30125-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703205649.30125-1-rdunlap@infradead.org>
References: <20200703205649.30125-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "readings".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 Documentation/hwmon/w83l786ng.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/hwmon/w83l786ng.rst
+++ linux-next-20200701/Documentation/hwmon/w83l786ng.rst
@@ -36,7 +36,7 @@ Temperatures are measured in degrees Cel
 degC for temp1 and temp2.
 
 Fan rotation speeds are reported in RPM (rotations per minute). Fan readings
-readings can be divided by a programmable divider (1, 2, 4, 8, 16, 32, 64
+can be divided by a programmable divider (1, 2, 4, 8, 16, 32, 64
 or 128 for fan 1/2) to give the readings more range or accuracy.
 
 Voltage sensors (also known as IN sensors) report their values in millivolts.
