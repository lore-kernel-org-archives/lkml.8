Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181B3C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA54C20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099327;
	bh=BHS3e/jKJugNA1/jaut3g7kvGJk+OFVAbUw+Z9klqcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MiQ3T/ap7Teq64VqBV0XiMOjiLyAYyiI4UTHheApezKxf5n5QbaK7NVBH3tdmm4CB
	 m4OLXypFDPC3+y0IPs8KuvltF02UhufcaHxi5vdCgjCxdqKTUXTq9anJ3Q3g6qMUM0
	 mpDSAQtidGIdMPLAfSdjKnuZE9Uha2wUYomzgVR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbgD1SmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731058AbgD1SmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:42:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8769420730;
        Tue, 28 Apr 2020 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099320;
        bh=BHS3e/jKJugNA1/jaut3g7kvGJk+OFVAbUw+Z9klqcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvHwQHdNrlVszqJ1uyHw8a9HfT6dd8XcRb8A5+TPT4oS3kaGf9xp+EUu8obInSJLG
         bpxbK5RY+1WyNe1+V32AvN6NYCgPlD+owSo+VhmOSKhwfkAC3D6a1JpKOOoS7xNqo1
         NLJM8lUHZlMvmRGgrV/t/SeAhNsisO9ad7jMRBNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Mendes <luis.p.mendes@gmail.com>
Subject: [PATCH 5.4 103/168] staging: gasket: Fix incongruency in handling of sysfs entries creation
Date:   Tue, 28 Apr 2020 20:24:37 +0200
Message-Id: <20200428182245.401671082@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Mendes <luis.p.mendes@gmail.com>

commit 9195d762042b0e5e4ded63606b4b30a93cba4400 upstream.

Fix incongruency in handling of sysfs entries creation.
This issue could cause invalid memory accesses, by not properly
detecting the end of the sysfs attributes array.

Fixes: 84c45d5f3bf1 ("staging: gasket: Replace macro __ATTR with __ATTR_NULL")
Signed-off-by: Luis Mendes <luis.p.mendes@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200403151534.20753-1-luis.p.mendes@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/gasket/gasket_sysfs.c |    3 +--
 drivers/staging/gasket/gasket_sysfs.h |    4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -228,8 +228,7 @@ int gasket_sysfs_create_entries(struct d
 	}
 
 	mutex_lock(&mapping->mutex);
-	for (i = 0; strcmp(attrs[i].attr.attr.name, GASKET_ARRAY_END_MARKER);
-		i++) {
+	for (i = 0; attrs[i].attr.attr.name != NULL; i++) {
 		if (mapping->attribute_count == GASKET_SYSFS_MAX_NODES) {
 			dev_err(device,
 				"Maximum number of sysfs nodes reached for device\n");
--- a/drivers/staging/gasket/gasket_sysfs.h
+++ b/drivers/staging/gasket/gasket_sysfs.h
@@ -30,10 +30,6 @@
  */
 #define GASKET_SYSFS_MAX_NODES 196
 
-/* End markers for sysfs struct arrays. */
-#define GASKET_ARRAY_END_TOKEN GASKET_RESERVED_ARRAY_END
-#define GASKET_ARRAY_END_MARKER __stringify(GASKET_ARRAY_END_TOKEN)
-
 /*
  * Terminator struct for a gasket_sysfs_attr array. Must be at the end of
  * all gasket_sysfs_attribute arrays.


