Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAB8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC10206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592896199;
	bh=bt2XIege4yj8u/sYLDroVzue0wsprC/fD/oatgGW5aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGIPmsQOJcShGh2AOmaIHDbLdqkKcu+KUNndoB+0L+5GVoZ5w1IS0Ajquqc2L3Zck
	 qZUSfDC+jHEqJHg0ARGGnDnjSUnh4H11lshcq9Na3ng4NsfRKhmawBPTaDcjyjdg3X
	 IGQxeZSY5n2y6wtnNYvL9bUI8DN5SA41e+XUhmKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbgFWHJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731301AbgFWHJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:09:17 -0400
Received: from mail.kernel.org (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 798AD207F9;
        Tue, 23 Jun 2020 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592896155;
        bh=bt2XIege4yj8u/sYLDroVzue0wsprC/fD/oatgGW5aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCP/O/beUcqU22Qw0CS3avZHL9bs86660ru/EiHjRGJ0g9g+mabEnj7P0BGgz2ioM
         2qLvq9sEolXNJ+ibifTE1gcSp6bHj8DVaiy+h1TroEXk08iWv1KhouqTzcP4iK6CpN
         RuA/fCHYmr9R+KEXTs9AWH7v7wgC8WfrWrIvJ0Mw=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnd3R-003qjR-Aq; Tue, 23 Jun 2020 09:09:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        Haren Myneni <haren@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/15] docs: powerpc: fix some issues at vas-api.rst
Date:   Tue, 23 Jun 2020 09:09:07 +0200
Message-Id: <fc1138e563bc3a41a9e59b5dd1fe2f6a4bfad253.1592895969.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592895969.git.mchehab+huawei@kernel.org>
References: <cover.1592895969.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few issues on this document, when built via the
building with ``make htmldocs``:

    Documentation/powerpc/vas-api.rst:116: WARNING: Unexpected indentation.
    Documentation/powerpc/vas-api.rst:116: WARNING: Inline emphasis start-string without end-string.
    Documentation/powerpc/vas-api.rst:117: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/powerpc/vas-api.rst:117: WARNING: Inline emphasis start-string without end-string.
    Documentation/powerpc/vas-api.rst:120: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/powerpc/vas-api.rst:124: WARNING: Unexpected indentation.
    Documentation/powerpc/vas-api.rst:133: WARNING: Unexpected indentation.
    Documentation/powerpc/vas-api.rst:135: WARNING: Unexpected indentation.
    Documentation/powerpc/vas-api.rst:150: WARNING: Unexpected indentation.
    Documentation/powerpc/vas-api.rst:151: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/powerpc/vas-api.rst:161: WARNING: Unexpected indentation.
    Documentation/powerpc/vas-api.rst:176: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/powerpc/vas-api.rst:253: WARNING: Unexpected indentation.
    Documentation/powerpc/vas-api.rst:253: WARNING: Inline emphasis start-string without end-string.
    Documentation/powerpc/vas-api.rst:259: WARNING: Unexpected indentation.
    Documentation/powerpc/vas-api.rst:261: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/powerpc/vas-api.rst:266: WARNING: Unexpected indentation.
    Documentation/powerpc/vas-api.rst:267: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/powerpc/vas-api.rst:270: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/powerpc/vas-api.rst:271: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/powerpc/vas-api.rst:273: WARNING: Unexpected indentation.
    Documentation/powerpc/vas-api.rst:274: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/powerpc/vas-api.rst:277: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/powerpc/vas-api.rst:278: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/powerpc/vas-api.rst:280: WARNING: Unexpected indentation.
    Documentation/powerpc/vas-api.rst:287: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/powerpc/vas-api.rst:289: WARNING: Block quote ends without a blank line; unexpected unindent.

Fixes: c12e38b1d52e ("Documentation/powerpc: VAS API")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/powerpc/vas-api.rst | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/powerpc/vas-api.rst b/Documentation/powerpc/vas-api.rst
index 1217c2f1595e..b7fdbe560010 100644
--- a/Documentation/powerpc/vas-api.rst
+++ b/Documentation/powerpc/vas-api.rst
@@ -87,6 +87,7 @@ Applications may chose a specific instance of the NX co-processor using
 the vas_id field in the VAS_TX_WIN_OPEN ioctl as detailed below.
 
 A userspace library libnxz is available here but still in development:
+
 	 https://github.com/abalib/power-gzip
 
 Applications that use inflate / deflate calls can link with libnxz
@@ -110,6 +111,7 @@ Applications should use the VAS_TX_WIN_OPEN ioctl as follows to establish
 a connection with NX co-processor engine:
 
 	::
+
 		struct vas_tx_win_open_attr {
 			__u32   version;
 			__s16   vas_id; /* specific instance of vas or -1
@@ -119,8 +121,10 @@ a connection with NX co-processor engine:
 			__u64   reserved2[6];
 		};
 
-	version: The version field must be currently set to 1.
-	vas_id: If '-1' is passed, kernel will make a best-effort attempt
+	version:
+		The version field must be currently set to 1.
+	vas_id:
+		If '-1' is passed, kernel will make a best-effort attempt
 		to assign an optimal instance of NX for the process. To
 		select the specific VAS instance, refer
 		"Discovery of available VAS engines" section below.
@@ -129,7 +133,8 @@ a connection with NX co-processor engine:
 	and must be set to 0.
 
 	The attributes attr for the VAS_TX_WIN_OPEN ioctl are defined as
-	follows:
+	follows::
+
 		#define VAS_MAGIC 'v'
 		#define VAS_TX_WIN_OPEN _IOW(VAS_MAGIC, 1,
 						struct vas_tx_win_open_attr)
@@ -141,6 +146,8 @@ a connection with NX co-processor engine:
 	returns -1 and sets the errno variable to indicate the error.
 
 	Error conditions:
+
+		======	================================================
 		EINVAL	fd does not refer to a valid VAS device.
 		EINVAL	Invalid vas ID
 		EINVAL	version is not set with proper value
@@ -149,6 +156,7 @@ a connection with NX co-processor engine:
 		ENOSPC	System has too many active windows (connections)
 			opened
 		EINVAL	reserved fields are not set to 0.
+		======	================================================
 
 	See the ioctl(2) man page for more details, error codes and
 	restrictions.
@@ -158,11 +166,13 @@ mmap() NX-GZIP device
 
 The mmap() system call for a NX-GZIP device fd returns a paste_address
 that the application can use to copy/paste its CRB to the hardware engines.
+
 	::
 
 		paste_addr = mmap(addr, size, prot, flags, fd, offset);
 
 	Only restrictions on mmap for a NX-GZIP device fd are:
+
 		* size should be PAGE_SIZE
 		* offset parameter should be 0ULL
 
@@ -170,10 +180,12 @@ that the application can use to copy/paste its CRB to the hardware engines.
 	In addition to the error conditions listed on the mmap(2) man
 	page, can also fail with one of the following error codes:
 
+		======	=============================================
 		EINVAL	fd is not associated with an open window
 			(i.e mmap() does not follow a successful call
 			to the VAS_TX_WIN_OPEN ioctl).
 		EINVAL	offset field is not 0ULL.
+		======	=============================================
 
 Discovery of available VAS engines
 ==================================
@@ -210,7 +222,7 @@ In case if NX encounters translation error (called NX page fault) on CSB
 address or any request buffer, raises an interrupt on the CPU to handle the
 fault. Page fault can happen if an application passes invalid addresses or
 request buffers are not in memory. The operating system handles the fault by
-updating CSB with the following data:
+updating CSB with the following data::
 
 	csb.flags = CSB_V;
 	csb.cc = CSB_CC_TRANSLATION;
@@ -223,7 +235,7 @@ the application can resend this request to NX.
 
 If the OS can not update CSB due to invalid CSB address, sends SEGV signal
 to the process who opened the send window on which the original request was
-issued. This signal returns with the following siginfo struct:
+issued. This signal returns with the following siginfo struct::
 
 	siginfo.si_signo = SIGSEGV;
 	siginfo.si_errno = EFAULT;
@@ -248,6 +260,7 @@ Simple example
 ==============
 
 	::
+
 		int use_nx_gzip()
 		{
 			int rc, fd;
-- 
2.26.2

