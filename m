Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F88C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C676E21744
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlVBEYtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgEEPLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:11:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52307 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729359AbgEEPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588691469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=QDdz0u1MDabvWLnuf8Me9gjoJIrk3ictomM8OSd7hgE=;
        b=OlVBEYtTN5ju6swVnEj8N3Mo0sNqYeeSjK3FbLpo99ZEGX5dSBbn4807ddMhtxBzB3DtCp
        NjOws0wnePq8QLplGLOutfJ5sZg1jo1GuxGwK1I520i/tyzKloCk51HeeH4qXlETMfCO5G
        BvDolbQy3t2NN9BnMrn61oL4BuQa1To=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-UqbHH1zxM6yBvkxPJMqzEA-1; Tue, 05 May 2020 11:11:05 -0400
X-MC-Unique: UqbHH1zxM6yBvkxPJMqzEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E690A872FEA;
        Tue,  5 May 2020 15:11:03 +0000 (UTC)
Received: from llong.com (ovpn-114-81.rdu2.redhat.com [10.10.114.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4D295D9D5;
        Tue,  5 May 2020 15:10:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
Cc:     linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] doc: Fix some typo errors in ras.rst
Date:   Tue,  5 May 2020 11:10:49 -0400
Message-Id: <20200505151049.11134-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo errors.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/ras.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
index 0310db624964..8b1803b2606f 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -156,10 +156,10 @@ the labels provided by the BIOS won't match the real ones.
 ECC memory
 ----------
 
-As mentioned on the previous section, ECC memory has extra bits to be
-used for error correction. So, on 64 bit systems, a memory module
-has 64 bits of *data width*, and 74 bits of *total width*. So, there are
-8 bits extra bits to be used for the error detection and correction
+As mentioned on the previous section, ECC memory has extra bits to
+be used for error correction. So, on 64 bit systems, a memory module
+has 64 bits of *data width*, and 72 bits of *total width*. So, there
+are 8 extra bits to be used for the error detection and correction
 mechanisms. Those extra bits are called *syndrome*\ [#f1]_\ [#f2]_.
 
 So, when the cpu requests the memory controller to write a word with
-- 
2.18.1

