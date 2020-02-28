Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B9BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CA924699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgB1PNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:13:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:29073 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgB1PNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:13:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 07:13:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="385520271"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2020 07:13:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3719D24D; Fri, 28 Feb 2020 17:13:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mei: Don't encourage to use kernel internal types in user code
Date:   Fri, 28 Feb 2020 17:13:28 +0200
Message-Id: <20200228151328.45062-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uuid_le is internal kernel type which shall not be exposed to the user
in the first place. In order to mitigate the (wrong) distribution of
the use of that type, switch MEI AMT sample to plain unsigned char array.

Note, there is no ABI change involved.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 samples/mei/mei-amt-version.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/samples/mei/mei-amt-version.c b/samples/mei/mei-amt-version.c
index 32234481ad7d..458cb6db57c6 100644
--- a/samples/mei/mei-amt-version.c
+++ b/samples/mei/mei-amt-version.c
@@ -90,7 +90,7 @@
 } while (0)
 
 struct mei {
-	uuid_le guid;
+	unsigned char guid[16];
 	bool initialized;
 	bool verbose;
 	unsigned int buf_size;
@@ -108,7 +108,7 @@ static void mei_deinit(struct mei *cl)
 	cl->initialized = false;
 }
 
-static bool mei_init(struct mei *me, const uuid_le *guid,
+static bool mei_init(struct mei *me, const unsigned char *guid,
 		unsigned char req_protocol_version, bool verbose)
 {
 	int result;
@@ -126,7 +126,7 @@ static bool mei_init(struct mei *me, const uuid_le *guid,
 	memset(&data, 0, sizeof(data));
 	me->initialized = true;
 
-	memcpy(&data.in_client_uuid, &me->guid, sizeof(me->guid));
+	memcpy(&data.in_client_uuid, me->guid, sizeof(me->guid));
 	result = ioctl(me->fd, IOCTL_MEI_CONNECT_CLIENT, &data);
 	if (result) {
 		mei_err(me, "IOCTL_MEI_CONNECT_CLIENT receive message. err=%d\n", result);
@@ -270,8 +270,11 @@ struct amt_host_if_resp_header {
 	unsigned char data[0];
 } __attribute__((packed));
 
-const uuid_le MEI_IAMTHIF = UUID_LE(0x12f80028, 0xb4b7, 0x4b2d,  \
-				0xac, 0xa8, 0x46, 0xe0, 0xff, 0x65, 0x81, 0x4c);
+/* MEI AMT Interface GUID: 12f80028-b4b7-4b2d-aca8-46e0ff65814c */
+const unsigned char mei_iamthif[16] = {
+	0x28, 0x00, 0xf8, 0x12, 0xb7, 0xb4, 0x2d, 0x4b,
+	0xac, 0xa8, 0x46, 0xe0, 0xff, 0x65, 0x81, 0x4c,
+};
 
 #define AMT_HOST_IF_CODE_VERSIONS_REQUEST  0x0400001A
 #define AMT_HOST_IF_CODE_VERSIONS_RESPONSE 0x0480001A
@@ -295,7 +298,7 @@ static bool amt_host_if_init(struct amt_host_if *acmd,
 		      unsigned long send_timeout, bool verbose)
 {
 	acmd->send_timeout = (send_timeout) ? send_timeout : 20000;
-	acmd->initialized = mei_init(&acmd->mei_cl, &MEI_IAMTHIF, 0, verbose);
+	acmd->initialized = mei_init(&acmd->mei_cl, mei_iamthif, 0, verbose);
 	return acmd->initialized;
 }
 
-- 
2.25.0

