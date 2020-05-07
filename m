Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B405EC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8933824956
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877306;
	bh=4UwgB4pEdhhDwE0Vi3P7TXaWRto19eGF34jli3AKVNU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Dmm3N4+I1iSa1J3xsoP0oA3Nr4VJz/wjzTrhXRO/4LYIT4dwHVgEHriZ/Sh42Mzi1
	 lwQ7Hi95S32dTM2moK6pGD4AbNZy7J1/WOnx2aSSa1t/0wRj5eHvbjpH+Dh5CBM+j1
	 knnJShUZ6qwN3CwONVzYOoEvUk0fx46ehSGtBWK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgEGSsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgEGSsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:48:25 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3705121BE5;
        Thu,  7 May 2020 18:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877304;
        bh=4UwgB4pEdhhDwE0Vi3P7TXaWRto19eGF34jli3AKVNU=;
        h=Date:From:To:Cc:Subject:From;
        b=BFatDpXiYufb1iEB9KedA/kbpUg3ymmg4Z8Toa/K6ebGqNZQCYlUI0pm0zXDGt1UZ
         pIiVC0gj8ZUOLMfXY5ka9AfMdjP6+yxY44k+GMITgoDdHX2EzOvSVJi3FUoqlhaOsJ
         AFQVDBp4K88/MzM6HqsFckcb2xjq62RerQQpb72Q=
Date:   Thu, 7 May 2020 13:52:51 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: ohci: Replace zero-length array with flexible-array
Message-ID: <20200507185251.GA14293@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/firewire/core-cdev.c        |    2 +-
 drivers/firewire/core-transaction.c |    2 +-
 drivers/firewire/core.h             |    2 +-
 drivers/firewire/nosy.c             |    2 +-
 drivers/firewire/ohci.c             |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 6e291d8f3a27..e6fc20dff687 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -117,7 +117,7 @@ struct inbound_transaction_resource {
 struct descriptor_resource {
 	struct client_resource resource;
 	struct fw_descriptor descriptor;
-	u32 data[0];
+	u32 data[];
 };
 
 struct iso_resource {
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 404a035f104d..439d918bbaaf 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -620,7 +620,7 @@ struct fw_request {
 	u32 request_header[4];
 	int ack;
 	u32 length;
-	u32 data[0];
+	u32 data[];
 };
 
 static void free_response_callback(struct fw_packet *packet,
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 4b0e4ee655a1..71d5f16f311c 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -191,7 +191,7 @@ struct fw_node {
 	/* Upper layer specific data. */
 	void *data;
 
-	struct fw_node *ports[0];
+	struct fw_node *ports[];
 };
 
 static inline struct fw_node *fw_node_get(struct fw_node *node)
diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
index 6ca2f5ab6c57..5fd6a60b6741 100644
--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -52,7 +52,7 @@ struct pcl {
 
 struct packet {
 	unsigned int length;
-	char data[0];
+	char data[];
 };
 
 struct packet_buffer {
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 33269316f111..54fdc39cd0bc 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -111,7 +111,7 @@ struct descriptor_buffer {
 	dma_addr_t buffer_bus;
 	size_t buffer_size;
 	size_t used;
-	struct descriptor buffer[0];
+	struct descriptor buffer[];
 };
 
 struct context {

