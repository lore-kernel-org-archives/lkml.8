Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE17C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EF1208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TA4dXVHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgEHLK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:10:28 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:52534 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgEHLKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:10:25 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200508111021epoutp03b8de4df5874bc85a556985ff3cc521e5~NCRMjCHGm1960919609epoutp03W
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:10:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200508111021epoutp03b8de4df5874bc85a556985ff3cc521e5~NCRMjCHGm1960919609epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588936221;
        bh=0DKTNWs7qWZKhCMxZ3+S89oIvDloO2Ni9RoH59/M5nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TA4dXVHUNZWi94gT9RNzqx3MmBgP4079kpdTJAj0qg55oo1BHLB8hR81jrXNSzA7S
         mQfGqeu+1IW6eVZvPx8ZuPV5maBpS8XAyDkyBgyuU5k1XSd5oJ/+urpi3VbiOTcJLZ
         OWR5GRzWpwZkKR1Tyn9kreTUE6E+w8VWu+ZdAxfk=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200508111020epcas5p2eeff7cce47bc7edb5fbd2d4af424bb3e~NCRMDylRd1358713587epcas5p2-;
        Fri,  8 May 2020 11:10:20 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.35.10010.C1E35BE5; Fri,  8 May 2020 20:10:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200508110354epcas5p3b80625f7ae03836a38547017b671268d~NCLkv_3Ih3167131671epcas5p3c;
        Fri,  8 May 2020 11:03:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200508110354epsmtrp2fc5c3126f1d939a22073790950d822bf~NCLkvNmSF3202332023epsmtrp26;
        Fri,  8 May 2020 11:03:54 +0000 (GMT)
X-AuditID: b6c32a49-735ff7000000271a-99-5eb53e1c0c97
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.CD.18461.A9C35BE5; Fri,  8 May 2020 20:03:54 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200508110353epsmtip2bb3a613496486fe0c3a3ecfeb5e4c4ad~NCLjJjS-60119301193epsmtip2C;
        Fri,  8 May 2020 11:03:53 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     yamada.masahiro@socionext.com, george_davis@mentor.com
Cc:     linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        arnd@arndb.de, ak@linux.intel.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH v2 3/4] scripts/checkstack.pl: add arm push handling for
 stack usage
Date:   Fri,  8 May 2020 16:33:16 +0530
Message-Id: <1588935797-7283-3-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588935797-7283-1-git-send-email-maninder1.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTcRTm7N5t18XqZmJHS62FyKy2rKzZwx72uAVmSUkIqatuas05dlvZ
        29RCg2pKpvgMyQTLDN9uuWiWZoHZA8FKW5AVFqLOR673vEr/fd93znfOd378KML1G+lJxWuP
        snqtWiMTSci6Zrl88dzg2qgluc0K1Qszq2o1Bql+ZbWIVR//jAlVr0wFIlVz8UVSZW0rBFVT
        jx3WU8wPRxYwRW27GPNICjBXasqBeZIzRjL2Ku+dokjJmoOsJv4Yq1cGx0jiSt/+Fusy3ZPG
        R3OEyVBHXwIXCunleOGajbgEEsqVNgMWNl8FngwBvh58J+DJKOD781+EU5bGi48nLU2AjrxU
        IU9GAEdMWWJnl4hWYLnpPunEbvQq/FSXLnJigq4EvFP9byxFzaIjMP3XZqdM0r7YeeHlhFVK
        b8Gez/0kv8wbu9ozCCd2obdifqUDeP2lGL/mePB4Ez5ovDnZPwv7WmvEPPZEe3+TyJkN6VTA
        IUsF8OQaYOmLwclz1uHX1OSJQAQtx0qTkpe9MPvpXQGfeTpe/vFRwOtSbCiawr6Y1nVvcswc
        tA8Oks4xSDNY+2gP/yZ5gO0dr8AI3nn/N9wAKAcPVsclxLJcoC5Ayx5XcOoEzqCNVRxITKiC
        iQ/hv60Bum0DCisIKLACUoTMTZqZVBPlKj2oPnGS1SdG6w0alrPCHIqUzZY+O/SvRMeqj7JH
        WFbH6qeqAsrFM1lQsDN8bk9QQkpMeFrFRmGZTDmecbosL3pm2NLdkQvqbW/XezQilBJRW25v
        6F0LodXGleSiCHG9seWun9/1+e865NQ8i8+3jCO5ErFhhBv4KTmmWf0hYHutvUCc+HDs0+Lg
        FfsC3Z9bPE5tjK/3msZc3/ulqfbBcNh3pQ2KDMrR/pRW5bkr37vOLnxc3JcW5N3r7mPxEQ7Z
        fPcbi4mk/JKYbKnjnvzN8zWNBv8qffpSbhwPW4bbu4sHTs3QadztIedDrG4yyy27K7W5Y9MO
        9edOc5iXNEJr7ki1DxtF7+NXHsp2hHYTZ5LLfKJ7VxNEekmbIbFlzLRuGRMSKDDrZSQXpw7w
        J/Sc+i8vgoI1fwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSvO4sm61xBv3PzCwu7k61OD7B0uLv
        pGPsFk/+f2e1uLxrDpvF4fltLBaHTs5ltNh77zOjA4fH71+TGD3mnQz02P21idGjb8sqRo8T
        07+zeHzeJBfAFsVlk5Kak1mWWqRvl8CVsfT2P/aCiWIVP79NZ21g3CbQxcjJISFgIrGz7Shz
        FyMXh5DAbkaJuwvb2CES0hI//71ngbCFJVb+e84OUfSZUeL7xetgRWwCehKrdu0BKxIRsJE4
        cWICWBGzwFZGiVn7WlhBEsICIRInF0xhBrFZBFQlrrVeAmvmFXCTuPf8HdQGOYmb5zrBajgF
        3CVmr//F2MXIAbTNTeLTotIJjHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIE
        B6GW5g7G7as+6B1iZOJgPMQowcGsJMI7sWJLnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeG4UL
        44QE0hNLUrNTUwtSi2CyTBycUg1MM6Qe7JQ1m5RqaJGcJhwbkP3xdk7i88RJpzOmX/eKrftV
        52H6i23ly6V1Z5msDGNOhh7KXb/+16u/U74Ul+/eENVzsWCO3Pu5EvNup2enr8w4bl0jnqez
        PGqr/Y7Fe+5vVn3w7L1lxF9h2fwo4f3KbV3Pov2CjiTrv/8o1PLMZDfLIoVr+TVzdrg3r0xZ
        I3dD4Z/Zycx8seuW053mqycVrVjuup7z7jz7BvUAjgoXN4flUaUzpzyvDFL6KcawVPD/mTuR
        uXUrjK15z5y6pPuqasMck+93ylhdu9g3i9lND2XYJ7PFaYngcdMfK7j332mNre2v+xnNvIxX
        bsn1b1+0dxxidOB17/+XbHrQtsZOiaU4I9FQi7moOBEA+zasJbECAAA=
X-CMS-MailID: 20200508110354epcas5p3b80625f7ae03836a38547017b671268d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200508110354epcas5p3b80625f7ae03836a38547017b671268d
References: <1588935797-7283-1-git-send-email-maninder1.s@samsung.com>
        <CGME20200508110354epcas5p3b80625f7ae03836a38547017b671268d@epcas5p3.samsung.com>
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

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 scripts/checkstack.pl | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index bc23cc7..bc07e19 100755
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
@@ -166,6 +187,11 @@ while (my $line = <STDIN>) {
 		$size = hex($size) if ($size =~ /^0x/);
 		$total_size += $size;
 	}
+	elsif (defined $sub) {
+		my $size = &$sub($line);
+
+		$total_size += $size;
+	}
 }
 if ($total_size > $min_stack) {
 	push @stack, "$intro$total_size\n";
-- 
1.9.1

