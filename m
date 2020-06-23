Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7E9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A2320724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592906029;
	bh=km1TTFWf9AKbBi+av9lc+XYXFzm3Utc9eo+duYioHqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TEkpSqd0hkMwek9U85MwJzppUUQW3izvDlarAlop6u75JGrMUAnwosHKM+eRf2rFD
	 yIMEBC3mPyAv8EgEGq8K2hN0a0PeNIgslXSALnEhJKsruJWro1La81XvINz/M/AQwY
	 zs3xUQQWb+IyNfu1r8QsHsbEv4nc+gpuCyZj3ihE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbgFWJxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731935AbgFWJxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:53:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36AE62078A;
        Tue, 23 Jun 2020 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592905986;
        bh=km1TTFWf9AKbBi+av9lc+XYXFzm3Utc9eo+duYioHqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Se/a/ghqd5cuEpRImWiqbsZkkz7IYuj0RupiUutWZwU26WdzR5CKXAjMqQXmHsC5o
         Rwua0DXhUQyy4grXn5bbIUihnYIo+3VfQrlxFCZNBzbuSXJwhRBl378haFRMmnyZ+f
         s+2s7Zq0ZimJtfkmgQ+TPy9I6G4RXdZvOMM0Wbos=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnfc0-004C3V-CM; Tue, 23 Jun 2020 11:53:04 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 6/9] docs: move mailbox.txt to driver-api and rename it
Date:   Tue, 23 Jun 2020 11:52:59 +0200
Message-Id: <c23f3238de954a0788053adca4fbbeab012a3fa2.1592905407.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592905407.git.mchehab+huawei@kernel.org>
References: <cover.1592905407.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is already at the ReST format. Move it to
driver-api and rename it.

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/index.rst                    | 1 +
 Documentation/{mailbox.txt => driver-api/mailbox.rst} | 0
 2 files changed, 1 insertion(+)
 rename Documentation/{mailbox.txt => driver-api/mailbox.rst} (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6567187e7687..3eb0085d5e42 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -48,6 +48,7 @@ available subsections can be seen below.
    scsi
    libata
    target
+   mailbox
    mtdnand
    miscellaneous
    mei/index
diff --git a/Documentation/mailbox.txt b/Documentation/driver-api/mailbox.rst
similarity index 100%
rename from Documentation/mailbox.txt
rename to Documentation/driver-api/mailbox.rst
-- 
2.26.2

