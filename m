Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7151EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3791220BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599733705;
	bh=uAmqZ5lhgQiIp+ZbTBM+IlrsfVig3NUg8EB06Ii3lck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wl+ZaO9hfs4hev1WwKDgm/k4xGxoG62dwzXoU0QZCWLgGCHQFB/X+jcxt/io7hA2I
	 MQg0//WAPSYbXHGp84UV5hErymqMugPuNOG6EX+vkKXCWfmQ8Pg80rjU167mDw0Qdf
	 +xT2tpZBw+maP+rlSA/Hj6/pqkc4oNDPJGeAMFUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIJK1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgIJKYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:11 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D42D21556;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=uAmqZ5lhgQiIp+ZbTBM+IlrsfVig3NUg8EB06Ii3lck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0FNGjU1gT0b0tH5ePOzeEjjqluZksqgnM2IYSFK0iTuPCj6skx7m1Qjy1Hi/tUcMn
         PbPjoGs1GUikqdAZ06iCvPeMUFE32rTBkItgyYwxYR1AadrS+GZBwhWqT4e8FwBmBD
         n5LOYEHzKsZjUmD0quThkBM2HvnXZ/1FeUDBvxOk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EINg-AH; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] usb: docs: document altmode register/unregister functions
Date:   Thu, 10 Sep 2020 12:23:55 +0200
Message-Id: <3a62f4520e8eedfbf701fc67ba8de49ac8e5b9ce.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typec_bus.rst asks for documentation of those two
functions, but they don't exist:

	./drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
	./drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found

Also, they're not declared on bus.c but, instead, at a header
file (typec_altmode.h).

So, add documentation for both functions at the header and
change the kernel-doc markup under typec_bus.rst to point
to the right place.

While here, also place the documentation for both structs
declared on typec_altmode.h at the rst file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/usb/typec_bus.rst |  8 +++++++-
 include/linux/usb/typec_altmode.h          | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/usb/typec_bus.rst b/Documentation/driver-api/usb/typec_bus.rst
index 03dfa9c018b7..21c890ae17e5 100644
--- a/Documentation/driver-api/usb/typec_bus.rst
+++ b/Documentation/driver-api/usb/typec_bus.rst
@@ -91,10 +91,16 @@ their control.
 Driver API
 ----------
 
+Alternate mode structs
+~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/linux/usb/typec_altmode.h
+   :functions: typec_altmode_driver typec_altmode_ops
+
 Alternate mode driver registering/unregistering
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. kernel-doc:: drivers/usb/typec/bus.c
+.. kernel-doc:: include/linux/usb/typec_altmode.h
    :functions: typec_altmode_register_driver typec_altmode_unregister_driver
 
 Alternate mode driver operations
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index a4b65eaa0f62..5e0a7b7647c3 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -152,10 +152,26 @@ struct typec_altmode_driver {
 #define to_altmode_driver(d) container_of(d, struct typec_altmode_driver, \
 					  driver)
 
+/**
+ * typec_altmode_register_driver - registers a USB Type-C alternate mode
+ * 				   device driver
+ * @drv: pointer to struct typec_altmode_driver
+ *
+ * These drivers will be bind to the partner alternate mode devices. They will
+ * handle all SVID specific communication.
+ */
 #define typec_altmode_register_driver(drv) \
 		__typec_altmode_register_driver(drv, THIS_MODULE)
 int __typec_altmode_register_driver(struct typec_altmode_driver *drv,
 				    struct module *module);
+/**
+ * typec_altmode_unregister_driver - unregisters a USB Type-C alternate mode
+ * 				     device driver
+ * @drv: pointer to struct typec_altmode_driver
+ *
+ * These drivers will be bind to the partner alternate mode devices. They will
+ * handle all SVID specific communication.
+ */
 void typec_altmode_unregister_driver(struct typec_altmode_driver *drv);
 
 #define module_typec_altmode_driver(__typec_altmode_driver) \
-- 
2.26.2

