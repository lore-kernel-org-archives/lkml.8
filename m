Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0FFC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9802073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258841;
	bh=OR6SV+RZfA6Kg3yPJNOhpuudvHbA8yRXIsYbCOpjxIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PLGcLTMBSuLk/sxC7ULLGMcD9qqediOO+rncMSZG3dxdBhNSLnzkFS16dkXqDaBBc
	 j69FaLVEm9Zqu9wi1i5/N+t2Dv6Tm7+uPASWizAGS2LcFgHu6QvXkOowMw5k5H1h2i
	 iIvyqnpP48/uM0iLx6j2xesb5vpPivnkH35Z4IxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbgCCRzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732639AbgCCRzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:55:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A535F20CC7;
        Tue,  3 Mar 2020 17:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258106;
        bh=OR6SV+RZfA6Kg3yPJNOhpuudvHbA8yRXIsYbCOpjxIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMpp0IniCBW0EDd3E8T/cxkWhjGLepnMEV7l96Jxk7q+7lhweHH4Kww0w20TaHScq
         vn5cndSdLV8iqrXXFNYa3kmCNPPgDERQfi7PjRrw/bBhoznmTvFWj3A/Rh8kU/R8H5
         1yRrbs8A2qflXy120L6rHnTkXTGyFnW8Sv52ISNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 073/152] ACPICA: Introduce ACPI_ACCESS_BYTE_WIDTH() macro
Date:   Tue,  3 Mar 2020 18:42:51 +0100
Message-Id: <20200303174310.771620964@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 1dade3a7048ccfc675650cd2cf13d578b095e5fb upstream.

Sometimes it is useful to find the access_width field value in bytes and
not in bits so add a helper that can be used for this purpose.

Suggested-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Cc: 4.16+ <stable@vger.kernel.org> # 4.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/acpi/actypes.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -532,11 +532,12 @@ typedef u64 acpi_integer;
 	 strnlen (a, ACPI_NAMESEG_SIZE) == ACPI_NAMESEG_SIZE)
 
 /*
- * Algorithm to obtain access bit width.
+ * Algorithm to obtain access bit or byte width.
  * Can be used with access_width of struct acpi_generic_address and access_size of
  * struct acpi_resource_generic_register.
  */
 #define ACPI_ACCESS_BIT_WIDTH(size)     (1 << ((size) + 2))
+#define ACPI_ACCESS_BYTE_WIDTH(size)    (1 << ((size) - 1))
 
 /*******************************************************************************
  *


