Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4CCC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB26206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCLTcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:32:31 -0400
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:60798 "EHLO
        6.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgCLTca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:32:30 -0400
X-Greylist: delayed 2399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 15:32:30 EDT
Received: from player728.ha.ovh.net (unknown [10.108.57.178])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id BD5BE158796
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 19:13:49 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 7C8D11047C29C;
        Thu, 12 Mar 2020 18:13:36 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <t-kristo@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: driver-api/dma.../provider.rst: fix indents
Date:   Thu, 12 Mar 2020 19:13:18 +0100
Message-Id: <20200312181318.1368421-1-steve@sk2.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8925290037935820104
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some block indentations, formatting them as definitions
(which seems appropriate given the content), and addressing these
warnings:

	Documentation/driver-api/dmaengine/provider.rst:270: WARNING: Unexpected indentation.
	Documentation/driver-api/dmaengine/provider.rst:273: WARNING: Block quote ends without a blank line; unexpected unindent.
	Documentation/driver-api/dmaengine/provider.rst:288: WARNING: Unexpected indentation.
	Documentation/driver-api/dmaengine/provider.rst:290: WARNING: Block quote ends without a blank line; unexpected unindent.

Fixes: 7d083ae98357 ("dmaengine: doc: Add sections for per descriptor metadata support")
Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/driver-api/dmaengine/provider.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 790a15089f1f..6367a79de47d 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -260,34 +260,35 @@ descriptors. Depending on the architecture the DMA driver can implement either
 or both of the methods and it is up to the client driver to choose which one
 to use.
 
-- DESC_METADATA_CLIENT
-
+DESC_METADATA_CLIENT
   The metadata buffer is allocated/provided by the client driver and it is
   attached (via the dmaengine_desc_attach_metadata() helper to the descriptor.
 
   From the DMA driver the following is expected for this mode:
-  - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM
+
+  DMA_MEM_TO_DEV / DEV_MEM_TO_MEM
     The data from the provided metadata buffer should be prepared for the DMA
     controller to be sent alongside of the payload data. Either by copying to a
     hardware descriptor, or highly coupled packet.
-  - DMA_DEV_TO_MEM
+  DMA_DEV_TO_MEM
     On transfer completion the DMA driver must copy the metadata to the client
     provided metadata buffer before notifying the client about the completion.
     After the transfer completion, DMA drivers must not touch the metadata
     buffer provided by the client.
 
-- DESC_METADATA_ENGINE
-
+DESC_METADATA_ENGINE
   The metadata buffer is allocated/managed by the DMA driver. The client driver
   can ask for the pointer, maximum size and the currently used size of the
   metadata and can directly update or read it. dmaengine_desc_get_metadata_ptr()
   and dmaengine_desc_set_metadata_len() is provided as helper functions.
 
   From the DMA driver the following is expected for this mode:
-  - get_metadata_ptr
+
+  get_metadata_ptr
     Should return a pointer for the metadata buffer, the maximum size of the
     metadata buffer and the currently used / valid (if any) bytes in the buffer.
-  - set_metadata_len
+
+  set_metadata_len
     It is called by the clients after it have placed the metadata to the buffer
     to let the DMA driver know the number of valid bytes provided.
 

base-commit: 7d3d3254adaa61cba896f71497f56901deb618e5
-- 
2.24.1

