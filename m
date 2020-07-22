Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB560C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B2120729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XD0eZDpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbgGVKWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:22:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28283 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726153AbgGVKWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595413369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GxCgvuoK8NuxbGBXVCCusTbGlNPSfTrnO2P7BCm4FhQ=;
        b=XD0eZDpmXcfIfAehSLZoRtxAToBdS7mvnkGemvrrR316qtRrSRRwAY7XcEYYyoc0DiQjDe
        r4P0XcjSbo1h4/XgSIn3rm9H47PccTsELtLOKgTdc0H5O7dlTn2+dBf1JygOzWGuk3jboG
        vpJ16/cUZdpnVCp/B+fPn5LoryXkJpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-spEUJSSAPy2OXuvs2fPvJQ-1; Wed, 22 Jul 2020 06:22:44 -0400
X-MC-Unique: spEUJSSAPy2OXuvs2fPvJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F246758;
        Wed, 22 Jul 2020 10:22:43 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-242.ams2.redhat.com [10.36.113.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0CDB5D9D3;
        Wed, 22 Jul 2020 10:22:41 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Subject: [PATCH] scripts/gdb: fix lx-symbols 'gdb.error' while loading modules
Date:   Wed, 22 Jul 2020 12:22:39 +0200
Message-Id: <20200722102239.313231-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ed66f991bb19 ("module: Refactor section attr into bin
attribute") removed the 'name' field from 'struct module_sect_attr'
triggering the following error when invoking lx-symbols:

  (gdb) lx-symbols
  loading vmlinux
  scanning for modules in linux/build
  loading @0xffffffffc014f000: linux/build/drivers/net/tun.ko
  Python Exception <class 'gdb.error'> There is no member named name.:
  Error occurred in Python: There is no member named name.

This patch fixes the issue taking the module name from the 'struct
attribute'.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 scripts/gdb/linux/symbols.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index be984aa29b75..1be9763cf8bb 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -96,7 +96,7 @@ lx-symbols command."""
             return ""
         attrs = sect_attrs['attrs']
         section_name_to_address = {
-            attrs[n]['name'].string(): attrs[n]['address']
+            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
             for n in range(int(sect_attrs['nsections']))}
         args = []
         for section_name in [".data", ".data..read_mostly", ".rodata", ".bss",
-- 
2.26.2

