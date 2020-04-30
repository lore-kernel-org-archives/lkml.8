Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B937DC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9462074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MYut6mhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgD3MuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:50:21 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:59769 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgD3MuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:50:20 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200430125017epoutp030f1fad99c111bd4afff4a7c349860c7e~KmeKV6_Wr1211512115epoutp03h
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:50:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200430125017epoutp030f1fad99c111bd4afff4a7c349860c7e~KmeKV6_Wr1211512115epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588251017;
        bh=wpu+3ukIInx2nRn1W8K27/+a9+Bp2v8EeAJ/0ijQ978=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYut6mhYSTFrLuh6+4nCt+Jx+sr+yyTxjm5IE4zW4D2fGoMFk940bvQd1T8rqwjCj
         9Vrv5z9ATxyX3eqEp+yCc7kudQqQ4PftsbbDCWZFXdpo40oNloJMnSpY0I4lCe5eyB
         JxngOimwzMOWY+Pe8ZK1RJVUQ1V9P2yU3aqdYXLw=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200430125016epcas5p1f778c34f1f64b95bf4984359c0f45ddb~KmeJqK6Jk0487204872epcas5p1V;
        Thu, 30 Apr 2020 12:50:16 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.33.10083.889CAAE5; Thu, 30 Apr 2020 21:50:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200430124958epcas5p15ecc8e744ed0f78837a6d58274a5baf0~Kmd5d3SgE2132721327epcas5p1g;
        Thu, 30 Apr 2020 12:49:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200430124958epsmtrp1d3b7a5294466a85355c7cf3e53f2b991~Kmd5dORWd3007130071epsmtrp1X;
        Thu, 30 Apr 2020 12:49:58 +0000 (GMT)
X-AuditID: b6c32a4a-88dff70000002763-1d-5eaac988817e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.11.25866.679CAAE5; Thu, 30 Apr 2020 21:49:58 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200430124957epsmtip283b16160a48e5d25742092b3826c9d69~Kmd4NOsIq1701017010epsmtip2X;
        Thu, 30 Apr 2020 12:49:57 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     yamada.masahiro@socionext.com, george_davis@mentor.com
Cc:     linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 3/4] scripts/checkstack.pl: add arm push handling for stack
 usage
Date:   Thu, 30 Apr 2020 18:19:31 +0530
Message-Id: <1588250972-8507-3-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588250972-8507-1-git-send-email-maninder1.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VRbUhTYRTu3b27u64WL1PpqCQyEnPYtCiYEeWPsCFJRj8ModnSm5pujl21
        tB8tHcsWbgqZMcoPUKE7TFtisjmhDSmlJhJBYhnR8qNJNcfwh4G5XaV/z3k+znnfc2hCukIm
        01W6Osag09TIKDE55svMONI6zalzIg6pcs7NKANbG0LlB9cTSunrMZNK7/RTpPQshlEepXJH
        mpHKOsoh1duuDVIVdqYWkSXiU+VMTVUDY8g+fVVc+cgbpPR/Em992co0oi5sQXE04OMw2r9K
        WpCYlmI3Am7Nj6KCFK8jMI4V80IYwexCSGRBdCzx2FrA8y4Evs5PIr6IIBjqWRNG0xRWAOea
        IKM4AZ+EpbFWKmoitoeCY+IVERXi8SUwTXljARKng2U5HAtIcD587loR8e9LhXn//Zg/Dp+D
        5d7ZWCPAkyIwd9op3nQWOhymHRwPP9+M7oSTYdVmFvGBFgTrk0OILx4iGJgLCXnXGQi2GAXR
        zxE4E4Zd2Tx9EDpnnguimMD7oW0zIOB5CYx37+J0MM2P7LRJgXAoRPJYBa99HiG/FzuCv30c
        1Y5S7f9H9CLEoSRGz2orGPaE/piOualgNVq2XlehKKvVOlHs/vKCcTToP+9FmEayfRLayaml
        Qk0D26j1IqAJWYLk25VtSlKuaWxiDLWlhvoahvWiFJqUHZDI0TO1FFdo6phqhtEzhl1VQMcl
        G1FjetKgIpJzOzhFZBQmrep68nqU4csLSzMX07qxLctmtMmb0zquB7PaA/0hT+m74hLZ3sW8
        PddSyvW5phueQsXv74fsdGKZI/+BlZ0TTBWlXdChe+8lLzdfFDu09Mfcr33D1dyPkdZfA3fM
        bc1qQyDkvJvod1v7NjYjh0VNMpKt1ByVEwZW8w+IDEC1+wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42LZdlhJXrfs5Ko4g1OXjCwu7k61ePL/O6vF
        5V1z2CwOz29jsTh0ci6jxd57nxkd2Dx2f21i9OjbsorR48T07ywenzfJBbBEcdmkpOZklqUW
        6dslcGVMO/SareCDaMXd/5oNjNMFuhg5OCQETCRm9Hl1MXJxCAnsYJRY+WEeYxcjJ1BcWuLn
        v/csELawxMp/z9khij4zSvTvfMEOkmAT0JNYtWsPWJGIgI3EiRMTwIqYBfoYJRZ+mMgEkhAW
        CJLYuuYKG4jNIqAq0fX8M1gDr4CbxJ3pEIMkBOQkbp7rZAaxOQXcJZ4vOA9WLwRU8296B8sE
        Rr4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCw0tLawfjnlUf9A4xMnEwHmKU
        4GBWEuF9GLsqTog3JbGyKrUoP76oNCe1+BCjNAeLkjjv11kL44QE0hNLUrNTUwtSi2CyTByc
        Ug1MBUZ1HYdd/4kvU/+UKr2m1v3evQcKTZt9Yq3iPT4LenycJrBxbuxTm9U7mazyFd4nVnTd
        X3Lfxn6NB8fGOX8KeBdplS4vT7tUmzXlek/ZtzfLLs1Nkbjfe9O045PDO4ObP18znK0S+vD7
        +YpVi1m3zE6Srw7hXHhn66Pf/BzZVZ8bdmx7qN2/f87JLRbX926e1nDq4rJJs9b3+BSc0whw
        NKlz4jSKD/uXoNQ8meuPgPDyKQn7msVkZ6woNPXYu/jZ/tOHF63YYya1jGGv0vw+rz0d9VZX
        PDkkbgit+zE/RMos5k519EF278m5SkF9fOtesF9Zqs68c/Ksf00a5969ubY4LY3JrqF1/6wJ
        0094miuxFGckGmoxFxUnAgATWqD6ngIAAA==
X-CMS-MailID: 20200430124958epcas5p15ecc8e744ed0f78837a6d58274a5baf0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200430124958epcas5p15ecc8e744ed0f78837a6d58274a5baf0
References: <1588250972-8507-1-git-send-email-maninder1.s@samsung.com>
        <CGME20200430124958epcas5p15ecc8e744ed0f78837a6d58274a5baf0@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To count stack usage of push {*, fp, ip, lr, pc} instruction in ARM,
if FRAME POINTER is enabled.
e.g. c01f0d48: e92ddff0 push {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}

c01f0d50 <Y>:
c01f0d44:       e1a0c00d        mov     ip, sp
c01f0d48:       e92ddff0        push    {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
c01f0d4c:       e24cb004        sub     fp, ip, #4
c01f0d50:       e24dd094        sub     sp, sp, #448    ; 0x1C0 

$ cat dump | scripts/checkstack.pl arm
0xc01f0d50 Y []:                                        448

added subroutine frame work for this.
After change:
0xc01f0d500 Y []:                                       492

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 scripts/checkstack.pl | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 8e5ef98..b292ef4 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -34,8 +34,10 @@ use strict;
 # $& (whole re) matches the complete objdump line with the stack growth
 # $1 (first bracket) matches the dynamic amount of the stack growth
 #
+# $sub: subroutine for special handling to check stack usage.
+#
 # use anything else and feel the pain ;)
-my (@stack, $re, $dre, $x, $xs, $funcre, $min_stack);
+my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
 {
 	my $arch = shift;
 	if ($arch eq "") {
@@ -59,6 +61,7 @@ my (@stack, $re, $dre, $x, $xs, $funcre, $min_stack);
 	} elsif ($arch eq 'arm') {
 		#c0008ffc:	e24dd064	sub	sp, sp, #100	; 0x64
 		$re = qr/.*sub.*sp, sp, #(([0-9]{2}|[3-9])[0-9]{2})/o;
+		$sub = \&arm_push_handling;
 	} elsif ($arch =~ /^x86(_64)?$/ || $arch =~ /^i[3456]86$/) {
 		#c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
 		# or
@@ -112,6 +115,24 @@ my (@stack, $re, $dre, $x, $xs, $funcre, $min_stack);
 }
 
 #
+# To count stack usage of push {*, fp, ip, lr, pc} instruction in ARM,
+# if FRAME POINTER is enabled.
+# e.g. c01f0d48: e92ddff0 push {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
+#
+sub arm_push_handling {
+	my $regex = qr/.*push.*fp, ip, lr, pc}/o;
+	my $size = 0;
+	my $line_arg = shift;
+
+	if ($line_arg =~ m/$regex/) {
+		$size = $line_arg =~ tr/,//;
+		$size = ($size + 1) * 4;
+	}
+
+	return $size;
+}
+
+#
 # main()
 #
 my ($func, $file, $lastslash, $total_size, $addr, $intro);
@@ -163,6 +184,10 @@ while (my $line = <STDIN>) {
 		$size = hex($size) if ($size =~ /^0x/);
 		$total_size = $total_size + $size
 	}
+	elsif (defined $sub) {
+		my $size = &$sub($line);
+		$total_size = $total_size + $size;
+	}
 }
 if ($total_size > $min_stack) {
 	push @stack, "$intro$total_size\n";
-- 
1.9.1

