Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB424C8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1C72078D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rua34oGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgD3MuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:50:16 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:46620 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgD3MuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:50:16 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200430125012epoutp04fea4b4876d6e3b523d8600cfd89e6dd3~KmeGaEqw91933619336epoutp04k
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:50:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200430125012epoutp04fea4b4876d6e3b523d8600cfd89e6dd3~KmeGaEqw91933619336epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588251012;
        bh=jUPo0kpEwyRVUkoKBs06zck5gMd7jBCryiz6PHCIdqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rua34oGbSvnWJvoWM5CaB4DQ6pA9xnCJp+kaFszPmycwTylboUEHvWmwqtXj1LUD9
         MtQrZuAHwWdPslVBCw7n1W2Gcsc/5zbSO/sTHvsiTfmLIwcN2ncmrWR0Mj3d6WDg98
         Qy2NeTgWPKq3jVbc2PD9MMQUKfC1Z8QBHD+2ePNM=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200430125012epcas5p4d517585790291d1ceedbdbcfb39bd3a3~KmeGJZv-D0408004080epcas5p4f;
        Thu, 30 Apr 2020 12:50:12 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.4B.04736.489CAAE5; Thu, 30 Apr 2020 21:50:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200430124955epcas5p4b5c1dd7393a7b798d80206d071264df3~Kmd2ltiOA2023020230epcas5p4J;
        Thu, 30 Apr 2020 12:49:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200430124955epsmtrp1381920dd28dbf06769db52ebbfdd63b5~Kmd2lFJxs3007130071epsmtrp1V;
        Thu, 30 Apr 2020 12:49:55 +0000 (GMT)
X-AuditID: b6c32a4b-ae3ff70000001280-85-5eaac984f704
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.11.25866.379CAAE5; Thu, 30 Apr 2020 21:49:55 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200430124954epsmtip25e6b2adad45102d6574970c854d48d69~Kmd1YJeQn1751917519epsmtip2g;
        Thu, 30 Apr 2020 12:49:54 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     yamada.masahiro@socionext.com, george_davis@mentor.com
Cc:     linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 2/4] scripts/checkstack.pl: Add argument to print stacks
 greather than value.
Date:   Thu, 30 Apr 2020 18:19:30 +0530
Message-Id: <1588250972-8507-2-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588250972-8507-1-git-send-email-maninder1.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCmum7LyVVxBh9vSltc3J1q8eT/d1aL
        y7vmsFkcnt/GYnHo5FxGi733PjM6sHns/trE6NG3ZRWjx4np31k8Pm+SC2CJ4rJJSc3JLEst
        0rdL4MrYePMmU8ER3orlc2awNjDu4+pi5OSQEDCROPRtJTOILSSwm1Hi2nMgmwvI/sQosaRt
        IhuE85lRYun0t6wwHQfedrNCJHYxSmx8+gbK+coosWP6bxaQKjYBPYlVu/aA2SICVhLPtnWA
        jWIW6GKUWL1nO9hCYYF4iRk3H7GD2CwCqhIbHy0Bi/MKuEncefCECWKdnMTNc51gcU4Bd4nn
        C86DDZIQ2MUusXDrfhaIIheJu3cPMELYwhKvjm9hh7ClJF72t7FDNDQzSnzat5YRwpkC9NHF
        j1Af2Uu8bm4AWscBdJ+mxPpd+hBhWYmpp9aBXcEswCfR+xvmIl6JHfNgbFWJlpsboMZIS3z+
        +BHqIA+Jhq7bbJBgncUosXJxxgRGuVkIGxYwMq5ilEwtKM5NTy02LTDOSy3XK07MLS7NS9dL
        zs/dxAhOAFreOxg3nfM5xCjAwajEw8uxaVWcEGtiWXFl7iFGCQ5mJRHeh7FAId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rxajCvjhATSE0tSs1NTC1KLYLJMHJxSDYzl6+4dyjtasnBu/g9uH/PH
        JzdcK1rypveEh/VMYx4pt02+V6UFVjyRYeg60JTx//LLWTf388/8tfTwPE6mEBmV8EdvLdu4
        /nkt2cXWppReufOpu9h9p57FpfFvWpoP1X6/1PZNs8bszaq4rUuW82tOiFtprFDBbHa05p5y
        r9WuhRffzrH9oLxCiaU4I9FQi7moOBEANcip6vwCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LZdlhJXrf45Ko4gxcHDCwu7k61ePL/O6vF
        5V1z2CwOz29jsTh0ci6jxd57nxkd2Dx2f21i9OjbsorR48T07ywenzfJBbBEcdmkpOZklqUW
        6dslcGVsvHmTqeAIb8XyOTNYGxj3cXUxcnJICJhIHHjbzdrFyMUhJLCDUWLdkRWMEAlpiZ//
        3rNA2MISK/89Z4co+swoMetfOxtIgk1AT2LVrj1gRSICNhInTkwAK2IW6GOUWPhhIhNIQlgg
        VuLBvVOsIDaLgKrExkdLmEFsXgE3iTsPnjBBbJCTuHmuEyzOKeAu8XzBebAFQkA1/6Z3sExg
        5FvAyLCKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4xLS0djDuWfVB7xAjEwfjIUYJ
        DmYlEd6HsavihHhTEiurUovy44tKc1KLDzFKc7AoifN+nbUwTkggPbEkNTs1tSC1CCbLxMEp
        1cA0TWTqUuerTasWK97llHri+Vq4qZz7N/fl81WOKlpLElx2dl+fXlfO7Hj2nFzJLhNJqZJ9
        ni2f5m8/7nXF7w7br2XM+VEf782eFKQ5K6j0y7Y/Yh8ixVOeu37WWf/E4cqDgwcn5W/264jq
        iZrp/Iu5RvDttJ5HbfffuW/STPVh89XheZK+Vcer7XiYyYW1OhU7HIyWcFnNdZDU5iy/ZbfR
        rf9ZzJm3WQ0f/BcwcYlLx+258jzlm8etLzWGb4Xqrv5p3iTIseI1i2hbj+Z3lg3R9nydR9Ln
        GMlG/rL+a/718DHDlGkfOeL3XFmkwFfnZZ+iIvm4xr3A2PZG+UWm8g07zrEUVcU94V77yl6e
        xUmJpTgj0VCLuag4EQBXXjPhoAIAAA==
X-CMS-MailID: 20200430124955epcas5p4b5c1dd7393a7b798d80206d071264df3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200430124955epcas5p4b5c1dd7393a7b798d80206d071264df3
References: <1588250972-8507-1-git-send-email-maninder1.s@samsung.com>
        <CGME20200430124955epcas5p4b5c1dd7393a7b798d80206d071264df3@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arguments support to print stacks which are greater than
argument value only.

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 scripts/checkstack.pl | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 412c459..8e5ef98 100755
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
@@ -113,7 +118,7 @@ my ($func, $file, $lastslash, $total_size, $addr, $intro);
 
 while (my $line = <STDIN>) {
 	if ($line =~ m/$funcre/) {
-		if ($total_size > 100) {
+		if ($total_size > $min_stack) {
 			push @stack, "$intro$total_size\n";
 		}
 
@@ -150,7 +155,6 @@ while (my $line = <STDIN>) {
 			$size += 0x80000000;
 		}
 		next if ($size > 0x10000000);
-
 		$total_size = $total_size + $size
 	}
 	elsif (defined $dre && $line =~ m/$dre/) {
@@ -160,7 +164,7 @@ while (my $line = <STDIN>) {
 		$total_size = $total_size + $size
 	}
 }
-if ($total_size > 100) {
+if ($total_size > $min_stack) {
 	push @stack, "$intro$total_size\n";
 }
 
-- 
1.9.1

