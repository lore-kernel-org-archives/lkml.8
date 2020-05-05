Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF64C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17C220675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=asem.it header.i=@asem.it header.b="d2Ch/eJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgEEKRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:17:39 -0400
Received: from smtp.asem.it ([151.1.184.197]:56537 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbgEEKRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:17:37 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000235779.MSG 
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 12:17:30 +0200S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
    s=s1024; d=asem.it;
    h=from:to:cc:subject:date:message-id:mime-version:content-type;
    bh=ZBqSxXgUivAUuVAsclHkHDsGUwkmsuduKBzLS0rYu9k=;
    b=d2Ch/eJK8f93bLolHFlz9MnrvlcW7aQarLA3anN5xYlq2Iw7xhbVE1tyY0pPmd
      cKwpDhnM3+b3modLyGgpvHgmcvRwyrwDsxAx3gYwqxBHXrdAiKPNuCQWubmSBP
      u5xrrT0hwxVK0A4qyALG1XAianu1YAKPcaQozGP7X7vwcOs=
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Tue, 5
 May 2020 12:17:29 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1261.35 via Frontend
 Transport; Tue, 5 May 2020 12:17:29 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 1/2] docs: filesystems: add info about efivars content
Date:   Tue, 5 May 2020 12:17:15 +0200
Message-ID: <1588673836-9954-1-git-send-email-f.suligoi@asem.it>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A09020E.5EB13D39.005C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an EFI variable is reading from:

/sys/firmware/efi/efivars

(for example using "hexdump"), the first 4 bytes of the
output are not the real EFI variable data, but the variable
attributes (in little-endian format).

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 Documentation/filesystems/efivarfs.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/filesystems/efivarfs.rst b/Documentation/filesystems/efivarfs.rst
index 90ac656..6380336 100644
--- a/Documentation/filesystems/efivarfs.rst
+++ b/Documentation/filesystems/efivarfs.rst
@@ -24,3 +24,20 @@ files that are not well-known standardized variables are created
 as immutable files.  This doesn't prevent removal - "chattr -i" will work -
 but it does prevent this kind of failure from being accomplished
 accidentally.
+
+.. warning ::
+      When a content of an UEFI variable in ``/sys/firmware/efi/efivars`` is
+      displayed, for example using ``hexdump``, pay attention that the first
+      4 bytes of the output represent the UEFI variable attributes,
+      in little-endian format.
+
+      Practically the output of each ``efivar`` is composed of:
+
+          +-----------------------------------+
+          |4_bytes_of_attributes + efivar_data|
+          +-----------------------------------+
+
+*See also:*
+
+- ``Documentation/admin-guide/acpi/ssdt-overlays.rst``
+- ``Documentation/ABI/stable/sysfs-firmware-efi-vars``
-- 
2.7.4

