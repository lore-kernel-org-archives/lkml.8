Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC42C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2668E20706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgHRMK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:10:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:58750 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgHRMK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:10:29 -0400
IronPort-SDR: PpUKk64O8VP4ulg75Aj3Rq+UjTBe8ogrdWjLNlUoPd2HY+q5W2yj5nBDarRW95+R/n2F3XO9x3
 /BRiTukV3cvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219200414"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="219200414"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:10:29 -0700
IronPort-SDR: X7ZBJ7bw4crp0cPJWmIkCio/vmUKSgiHhD5hfknXvffrccQdJzqdTchS7OecRodRBv8O98UeWJ
 G92PX9oYfViA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326713084"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 05:10:26 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 12/13] mei: docs: add vtag ioctl documentation
Date:   Tue, 18 Aug 2020 14:51:46 +0300
Message-Id: <20200818115147.2567012-13-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200818115147.2567012-1-tomas.winkler@intel.com>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add structured documenation for the new vtag ioctl

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/driver-api/mei/mei.rst | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/driver-api/mei/mei.rst b/Documentation/driver-api/mei/mei.rst
index c800d8e5f422..cea0b69ec216 100644
--- a/Documentation/driver-api/mei/mei.rst
+++ b/Documentation/driver-api/mei/mei.rst
@@ -42,6 +42,11 @@ The session is terminated calling :c:func:`close(int fd)`.
 
 A code snippet for an application communicating with Intel AMTHI client:
 
+In order to support virtualization or sandboxing a trusted supervisor
+can use :c:macro:`MEI_CONNECT_CLIENT_IOCTL_VTAG` to create
+virtual channels with an Intel ME feature. Not all features support
+virtual channels such client with answer EOPNOTSUPP.
+
 .. code-block:: C
 
 	struct mei_connect_client_data data;
@@ -110,6 +115,38 @@ Connect to firmware Feature/Client.
         data that can be sent or received. (e.g. if MTU=2K, can send
         requests up to bytes 2k and received responses up to 2k bytes).
 
+IOCTL_MEI_CONNECT_CLIENT_VTAG:
+------------------------------
+
+.. code-block:: none
+
+        Usage:
+
+        struct mei_connect_client_data_vtag client_data_vtag;
+
+        ioctl(fd, IOCTL_MEI_CONNECT_CLIENT_VTAG, &client_data_vtag);
+
+        Inputs:
+
+        struct mei_connect_client_data_vtag - contain the following
+        Input field:
+
+                in_client_uuid -  GUID of the FW Feature that needs
+                                  to connect to.
+                vtag - virtual tag [1, 255]
+
+         Outputs:
+                out_client_properties - Client Properties: MTU and Protocol Version.
+
+         Error returns:
+
+                ENOTTY No such client (i.e. wrong GUID) or connection is not allowed.
+                EINVAL Wrong IOCTL Number or tag == 0
+                ENODEV Device or Connection is not initialized or ready.
+                ENOMEM Unable to allocate memory to client internal data.
+                EFAULT Fatal Error (e.g. Unable to access user input data)
+                EBUSY  Connection Already Open
+                EOPNOTSUPP Vtag is not supported
 
 IOCTL_MEI_NOTIFY_SET
 ---------------------
-- 
2.25.4

