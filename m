Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FE3C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E9B20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=asem.it header.i=@asem.it header.b="SG9Nmx0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgEEKRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:17:41 -0400
Received: from smtp.asem.it ([151.1.184.197]:56537 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbgEEKRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:17:39 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000235780.MSG 
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 12:17:30 +0200S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
    s=s1024; d=asem.it;
    h=from:to:cc:subject:date:message-id:in-reply-to:mime-version:
      content-type;
    bh=KNWTREnx6gdyIGMCjc8N04D/sn/FYso+cwDCKrUO1J0=;
    b=SG9Nmx0cntNtmIx+3RnCkroCiWgJ7ZyP80OYDqiE8lssJMSEHZ3wzg4upyZAk9
      mZvE6P0GAWDQX9NsTfkjYyPowCv0JaP04bav0JQFSsCQISViihzlyxF7rWA4W5
      WVrSZvRG7AyaK7gMfPGb0jVAY6tTEHPYQAjgj+RnWeX+3Is=
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
Subject: [PATCH 2/2] docs: acpi: fix old http link and improve document format
Date:   Tue, 5 May 2020 12:17:16 +0200
Message-ID: <1588673836-9954-2-git-send-email-f.suligoi@asem.it>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588673836-9954-1-git-send-email-f.suligoi@asem.it>
References: <1588673836-9954-1-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A09020E.5EB13D3A.0003,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The website:

    http://wiki.minnowboard.org

doesn't exist anymore. The same pages are moved to:

    https://www.elinux.org/Minnowboard

Other improvements concern the introduction of some rst
semantic markup in the document.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 Documentation/admin-guide/acpi/ssdt-overlays.rst | 40 ++++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/acpi/ssdt-overlays.rst b/Documentation/admin-guide/acpi/ssdt-overlays.rst
index da37455..5c090da 100644
--- a/Documentation/admin-guide/acpi/ssdt-overlays.rst
+++ b/Documentation/admin-guide/acpi/ssdt-overlays.rst
@@ -63,7 +63,7 @@ which can then be compiled to AML binary format::
     ASL Input:     minnomax.asl - 30 lines, 614 bytes, 7 keywords
     AML Output:    minnowmax.aml - 165 bytes, 6 named objects, 1 executable opcodes
 
-[1] http://wiki.minnowboard.org/MinnowBoard_MAX#Low_Speed_Expansion_Connector_.28Top.29
+[1] https://www.elinux.org/Minnowboard:MinnowMax#Low_Speed_Expansion_.28Top.29
 
 The resulting AML code can then be loaded by the kernel using one of the methods
 below.
@@ -76,9 +76,9 @@ when the system does not support EFI or when there is not enough EFI storage.
 
 It works in a similar way with initrd based ACPI tables override/upgrade: SSDT
 aml code must be placed in the first, uncompressed, initrd under the
-"kernel/firmware/acpi" path. Multiple files can be used and this will translate
-in loading multiple tables. Only SSDT and OEM tables are allowed. See
-initrd_table_override.txt for more details.
+``kernel/firmware/acpi`` path. Multiple files can be used and this will
+translate in loading multiple tables. Only SSDT and OEM tables are allowed. See
+``Documentation/admin-guide/acpi/initrd_table_override.rst`` for more details.
 
 Here is an example::
 
@@ -105,21 +105,21 @@ is also work underway to implement EFI support for loading user defined SSDTs
 and using this method will make it easier to convert to the EFI loading
 mechanism when that will arrive.
 
-In order to load SSDTs from an EFI variable the efivar_ssdt kernel command line
-parameter can be used. The argument for the option is the variable name to
+In order to load SSDTs from an EFI variable the ``efivar_ssdt`` kernel command
+line parameter can be used. The argument for the option is the variable name to
 use. If there are multiple variables with the same name but with different
 vendor GUIDs, all of them will be loaded.
 
 In order to store the AML code in an EFI variable the efivarfs filesystem can be
-used. It is enabled and mounted by default in /sys/firmware/efi/efivars in all
-recent distribution.
-
-Creating a new file in /sys/firmware/efi/efivars will automatically create a new
-EFI variable. Updating a file in /sys/firmware/efi/efivars will update the EFI
-variable. Please note that the file name needs to be specially formatted as
-"Name-GUID" and that the first 4 bytes in the file (little-endian format)
-represent the attributes of the EFI variable (see EFI_VARIABLE_MASK in
-include/linux/efi.h). Writing to the file must also be done with one write
+used. It is enabled and mounted by default in ``/sys/firmware/efi/efivars``
+in all recent distribution.
+
+Creating a new file in ``/sys/firmware/efi/efivars`` will automatically create
+a new EFI variable. Updating a file in ``/sys/firmware/efi/efivars`` will update
+the EFI variable. Please note that the file name needs to be specially formatted
+as "Name-GUID" and that the first 4 bytes in the file (little-endian format)
+represent the attributes of the EFI variable (see ``EFI_VARIABLE_MASK`` in
+``include/linux/efi.h``). Writing to the file must also be done with one write
 operation.
 
 For example, you can use the following bash script to create/update an EFI
@@ -168,12 +168,12 @@ Loading ACPI SSDTs from configfs
 ================================
 
 This option allows loading of user defined SSDTs from userspace via the configfs
-interface. The CONFIG_ACPI_CONFIGFS option must be select and configfs must be
-mounted. In the following examples, we assume that configfs has been mounted in
-/config.
+interface. The ``CONFIG_ACPI_CONFIGFS`` option must be select and configfs must
+be mounted. In the following examples, we assume that configfs has been mounted
+in ``/config``.
 
-New tables can be loading by creating new directories in /config/acpi/table/ and
-writing the SSDT aml code in the aml attribute::
+New tables can be loading by creating new directories in ``/config/acpi/table/``
+and writing the SSDT aml code in the aml attribute::
 
     cd /config/acpi/table
     mkdir my_ssdt
-- 
2.7.4

