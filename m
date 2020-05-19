Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0D9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28ADF204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgESIlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:41:39 -0400
Received: from smtp.asem.it ([151.1.184.197]:62107 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgESIlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:41:39 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000265424.MSG 
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 10:41:33 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Tue, 19
 May 2020 10:41:30 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1261.35 via Frontend
 Transport; Tue, 19 May 2020 10:41:30 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1 1/2] docs: filesystems: add info about efivars content
Date:   Tue, 19 May 2020 10:41:27 +0200
Message-ID: <20200519084128.12756-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515114054.2496c171@lwn.net>
References: <20200515114054.2496c171@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A090207.5EC39BBB.000B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
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

v1:  remove added backquotes from pathname strings

 Documentation/filesystems/efivarfs.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/filesystems/efivarfs.rst b/Documentation/filesystems/efivarfs.rst
index 90ac65683e7e..0551985821b8 100644
--- a/Documentation/filesystems/efivarfs.rst
+++ b/Documentation/filesystems/efivarfs.rst
@@ -24,3 +24,20 @@ files that are not well-known standardized variables are created
 as immutable files.  This doesn't prevent removal - "chattr -i" will work -
 but it does prevent this kind of failure from being accomplished
 accidentally.
+
+.. warning ::
+      When a content of an UEFI variable in /sys/firmware/efi/efivars is
+      displayed, for example using "hexdump", pay attention that the first
+      4 bytes of the output represent the UEFI variable attributes,
+      in little-endian format.
+
+      Practically the output of each efivar is composed of:
+
+          +-----------------------------------+
+          |4_bytes_of_attributes + efivar_data|
+          +-----------------------------------+
+
+*See also:*
+
+- Documentation/admin-guide/acpi/ssdt-overlays.rst
+- Documentation/ABI/stable/sysfs-firmware-efi-vars
-- 
2.17.1

