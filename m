Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C95C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F7321582
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U4m3dutz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgEHLKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:10:24 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:37548 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgEHLKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:10:21 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200508111018epoutp04e6ffc6125efee11d2724fff881e2a545~NCRJkc7EN1592815928epoutp04c
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:10:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200508111018epoutp04e6ffc6125efee11d2724fff881e2a545~NCRJkc7EN1592815928epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588936218;
        bh=QGIyb5U9k575+NBmIzoIJQV5aMjRbxZ9LUaHRWnh8IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4m3dutzwsC9P3F6MEaIUO7i2uGwqJzukbGtLKCkX5QVMLWeqs/9EaGS+sv3sQrLS
         +b9Wc6zw1RpcHS8hgpk0tKq5EgMs1+JY6odjDqan92rZ6ZE0EOBjo7yL3tEu6eekLI
         N1ry/FZvPdMERKbjn3lA4v4DDhpqZrIyb5az3/vw=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200508111016epcas5p1585c84ac5a58f3b2ab0941e143d40928~NCRIebM_i0784107841epcas5p1T;
        Fri,  8 May 2020 11:10:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.FD.23389.81E35BE5; Fri,  8 May 2020 20:10:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200508110351epcas5p32b6adff3dd1cb36dd4912c82bb291bbd~NCLhY-59N3167131671epcas5p3Y;
        Fri,  8 May 2020 11:03:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200508110351epsmtrp16fd18bb4f6aaa869668bbd7e61a87d00~NCLhYO6Yg2005420054epsmtrp15;
        Fri,  8 May 2020 11:03:51 +0000 (GMT)
X-AuditID: b6c32a4b-797ff70000005b5d-c0-5eb53e18eb4c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.CD.18461.79C35BE5; Fri,  8 May 2020 20:03:51 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200508110349epsmtip275b74a45e452e4c02888eb38e3342318~NCLf0ReM53194731947epsmtip2Z;
        Fri,  8 May 2020 11:03:49 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     yamada.masahiro@socionext.com, george_davis@mentor.com
Cc:     linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        arnd@arndb.de, ak@linux.intel.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH v2 2/4] scripts/checkstack.pl: Add argument to print stacks
 greather than value.
Date:   Fri,  8 May 2020 16:33:15 +0530
Message-Id: <1588935797-7283-2-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588935797-7283-1-git-send-email-maninder1.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7bCmlq6E3dY4gy8rjS0u7k61OD7B0uLv
        pGPsFk/+f2e1uLxrDpvF4fltLBaHTs5ltNh77zOjA4fH71+TGD3mnQz02P21idGjb8sqRo8T
        07+zeHzeJBfAFsVlk5Kak1mWWqRvl8CV0bX9GHNBP0/F3p6n7A2Mezm7GDk5JARMJHqOzWDp
        YuTiEBLYzShx++40RgjnE6PEqoZ5zBDON0aJyz8ussG0nNnexQqR2MsosevqTjYI5yujREP/
        WxaQKjYBPYlVu/aA2SICVhLPtnWAdTMLrGeUWLOZCcQWFkiSOLZ9PTuIzSKgKvHo4m6gdRwc
        vAJuEreuSUAsk5O4ea6TGcTmFHCXmL3+F9h5EgLX2CVuN52GushF4uPXW4wQtrDEq+Nb2CFs
        KYmX/W3sEA3NjBKf9q2F6p7CKLH04kdWiCp7idfNDUwgm5kFNCXW79KHCMtKTD21jgniaD6J
        3t9PmCDivBI75sHYqhItNzdAjZGW+PzxIwuE7SGxeM4GaEDOYpRYcuEl2wRGuVkIKxYwMq5i
        lEwtKM5NTy02LTDOSy3XK07MLS7NS9dLzs/dxAhOElreOxgfPfigd4iRiYPxEKMEB7OSCO/E
        ii1xQrwpiZVVqUX58UWlOanFhxilOViUxHkfNwKlBNITS1KzU1MLUotgskwcnFINTCxuTsHC
        OrldlmsLQySD2xniD1jKvxB+tqh8Rbj7V9nWP3Ntuz2zpz6csDJIdaFHvOKOw0/j/v5g/c99
        jPF7gNGvvOYsB6E+p6U3XPawno6Ytv3E0/V/fdSiMjOqHz9KXBnO2Jo+tzOq5rZlr+vFD59m
        vHUsX/hrb5N7wOHLaSo/vQJ+TGzKUGmNOhnMfj3ryInWky7zZMqL1jwOz5M/YT39hNDkJXMd
        EjclyQscDvmlPt2wz+SYsMVzX3G3+LbwGYdKRf/xdeirnTDRrJ+bmb63IPBaXQFjt5Xg7quR
        jxcdeTfbXnvWmUUfzRUYJacpcLP9Wa9ivKT5lyjzao6LMWEtQbc/RhyxfvjjyZyJSizFGYmG
        WsxFxYkAWBH8rIEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSvO50m61xBsdeCVtc3J1qcXyCpcXf
        ScfYLZ78/85qcXnXHDaLw/PbWCwOnZzLaLH33mdGBw6P378mMXrMOxnosftrE6NH35ZVjB4n
        pn9n8fi8SS6ALYrLJiU1J7MstUjfLoEro2v7MeaCfp6KvT1P2RsY93J2MXJySAiYSJzZ3sXa
        xcjFISSwm1Hi9ZLvTBAJaYmf/96zQNjCEiv/PWeHKPrMKHHwTzsjSIJNQE9i1a49YEUiAjYS
        J05MACtiFtjKKDFrXwsrSEJYIEFiwqKvYFNZBFQlHl3czdzFyMHBK+AmceuaBMQCOYmb5zqZ
        QWxOAXeJ2et/MYKUCAGVfFpUOoGRbwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxN
        jOAQ1NLcwbh91Qe9Q4xMHIyHGCU4mJVEeCdWbIkT4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuj
        cGGckEB6YklqdmpqQWoRTJaJg1OqgSlz7X3fO08Faxv5t/sYC9x2eZr7VP327Y+OmmJnAly2
        ZewPXfli6TmhOH9XKfWshXNlJvx87blxaV/85ci7RUFWFtzH1z0Xb+M2+fLq8qKcuH0tqvO0
        Ow5Z2FaJ+YidnL3e8cHJCE7ZsxUZiXpWXDyP1uYwntacOOVjpuqKzU0OR9Iu2P/ueV6y8c6d
        3vkZcYLcs6S9t/GV5z77y//9Ebus75YVuTVG2Qbm+45/vitgw9v7vmdOnqBnZobjz689nVc2
        +B1QOXK9YbuoXgzni8jD3y8F7S024t3zlNF3TcqN3xWlcl+KQ/Utbu3YNFH6lMwZja/2Td+O
        KQtu2VTxdxu71dzXvX87uyO3T9KojVJiKc5INNRiLipOBABcrxTKsAIAAA==
X-CMS-MailID: 20200508110351epcas5p32b6adff3dd1cb36dd4912c82bb291bbd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200508110351epcas5p32b6adff3dd1cb36dd4912c82bb291bbd
References: <1588935797-7283-1-git-send-email-maninder1.s@samsung.com>
        <CGME20200508110351epcas5p32b6adff3dd1cb36dd4912c82bb291bbd@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arguments support to print stacks which are greater than
argument value only.

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 scripts/checkstack.pl | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 6957108..bc23cc7 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -35,7 +35,7 @@ use strict;
 # $1 (first bracket) matches the dynamic amount of the stack growth
 #
 # use anything else and feel the pain ;)
-my (@stack, $re, $dre, $x, $xs, $funcre);
+my (@stack, $re, $dre, $x, $xs, $funcre, $min_stack);
 {
 	my $arch = shift;
 	if ($arch eq "") {
@@ -43,6 +43,11 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
 		chomp($arch);
 	}
 
+	$min_stack = shift;
+	if ($min_stack eq "" || $min_stack !~ /^\d+$/) {
+		$min_stack = 100;
+	}
+
 	$x	= "[0-9a-f]";	# hex character
 	$xs	= "[0-9a-f ]";	# hex character or space
 	$funcre = qr/^$x* <(.*)>:$/;
@@ -117,7 +122,7 @@ while (my $line = <STDIN>) {
 	if ($line =~ m/$funcre/) {
 		$func = $1;
 		next if $line !~ m/^($xs*)/;
-		if ($total_size > 100) {
+		if ($total_size > $min_stack) {
 			push @stack, "$intro$total_size\n";
 		}
 
@@ -162,7 +167,7 @@ while (my $line = <STDIN>) {
 		$total_size += $size;
 	}
 }
-if ($total_size > 100) {
+if ($total_size > $min_stack) {
 	push @stack, "$intro$total_size\n";
 }
 
-- 
1.9.1

