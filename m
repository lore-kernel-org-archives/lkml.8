Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAE3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0985B204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgESIll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:41:41 -0400
Received: from smtp.asem.it ([151.1.184.197]:62107 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbgESIlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:41:40 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000265425.MSG 
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
Subject: [PATCH v1 2/2] docs: acpi: fix old http link and improve document format
Date:   Tue, 19 May 2020 10:41:28 +0200
Message-ID: <20200519084128.12756-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519084128.12756-1-f.suligoi@asem.it>
References: <20200515114054.2496c171@lwn.net>
 <20200519084128.12756-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A090207.5EC39BBB.0020,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
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

v1:  remove added backquotes from pathname strings

 Documentation/admin-guide/acpi/ssdt-overlays.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/acpi/ssdt-overlays.rst b/Documentation/admin-guide/acpi/ssdt-overlays.rst
index da37455f96c9..5d7e25988085 100644
--- a/Documentation/admin-guide/acpi/ssdt-overlays.rst
+++ b/Documentation/admin-guide/acpi/ssdt-overlays.rst
@@ -63,7 +63,7 @@ which can then be compiled to AML binary format::
     ASL Input:     minnomax.asl - 30 lines, 614 bytes, 7 keywords
     AML Output:    minnowmax.aml - 165 bytes, 6 named objects, 1 executable opcodes
 
-[1] http://wiki.minnowboard.org/MinnowBoard_MAX#Low_Speed_Expansion_Connector_.28Top.29
+[1] https://www.elinux.org/Minnowboard:MinnowMax#Low_Speed_Expansion_.28Top.29
 
 The resulting AML code can then be loaded by the kernel using one of the methods
 below.
-- 
2.17.1

