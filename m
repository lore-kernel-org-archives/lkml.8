Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDF6C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186392074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K1me6Pav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgD3MuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:50:13 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:46608 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgD3MuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:50:12 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200430125009epoutp0427c7e873adaea214bcbf1b705604c0f9~KmeDMsxzi2110421104epoutp04G
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:50:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200430125009epoutp0427c7e873adaea214bcbf1b705604c0f9~KmeDMsxzi2110421104epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588251009;
        bh=UTRcVv35qACLhkjMCOdTBBaqODmCSl6ETevSqVnZMy8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=K1me6PavYWD4TjT84LvFSCp0EbvQNSpFmh26yE7ooWR7tU7DhETA+Nf8mMCrn+SjC
         WWzC41RjxeEANcjJrXeU1K+1/DsR0JTUjaerqJeKG4jkR6bjohyntDsX0bRWY53WJB
         lFNgZtUu+MkaTh/MYzIocSHtE26CZmdrGS6orxEM=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200430125008epcas5p20d01d37df71fb251c7b5cfd1ee4c8f97~KmeCcLSc40801308013epcas5p2c;
        Thu, 30 Apr 2020 12:50:08 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.33.10083.089CAAE5; Thu, 30 Apr 2020 21:50:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200430124952epcas5p28cd53b0aa452f43eed48ed9d58b4005b~KmdzU-ezD0801308013epcas5p2r;
        Thu, 30 Apr 2020 12:49:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200430124952epsmtrp18efbae9b68cedba6f3114884811a7f5f~KmdzUTmvI3007130071epsmtrp1R;
        Thu, 30 Apr 2020 12:49:52 +0000 (GMT)
X-AuditID: b6c32a4a-88dff70000002763-f9-5eaac980f564
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.11.25866.079CAAE5; Thu, 30 Apr 2020 21:49:52 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200430124951epsmtip27ebf3ad25d252763cc195b6e4dd4c949~KmdyGS4SW1701017010epsmtip2V;
        Thu, 30 Apr 2020 12:49:50 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     yamada.masahiro@socionext.com, george_davis@mentor.com
Cc:     linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 1/4] scripts/checkstack.pl: don't display $dre as different
 entity
Date:   Thu, 30 Apr 2020 18:19:29 +0530
Message-Id: <1588250972-8507-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCmlm7DyVVxBrM+yFlc3J1q8eT/d1aL
        y7vmsFkcnt/GYnHo5FxGi733PjM6sHns/trE6NG3ZRWjx4np31k8Pm+SC2CJ4rJJSc3JLEst
        0rdL4Mp4vvwEU8EPsYrDexpZGxjvCHYxcnJICJhIzG+7z9bFyMUhJLCbUWLa0XksEM4nRom5
        N04xQTifGSXer37ADtOy4vVMZhBbSGAXo8STRzoQRV8ZJX7tXMEKkmAT0JNYtWsPC4gtImAl
        8WxbB9gOZoEuRonVe7aDdQsLhEh8bbnHCGKzCKhKbL33ByzOK+Am8X/aUmaIbXISN891MoM0
        SwgsY5fYv2UjC0TCReLqxZtQJwlLvDq+BcqWknjZ38YO0dDMKPFp31pGCGcKo8TSix9ZIars
        JV43NwB9xwF0k6bE+l36EGFZiamn1jGB2MwCfBK9v58wQcR5JXbMg7FVJVpuboAaIy3x+eNH
        qIM8JO7eWcUOCZdYiQNLOhgnMMrOQtiwgJFxFaNkakFxbnpqsWmBUV5quV5xYm5xaV66XnJ+
        7iZGcKRree1gXHbO5xCjAAejEg8vx6ZVcUKsiWXFlbmHGCU4mJVEeB/GAoV4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzajGujBMSSE8sSc1OTS1ILYLJMnFwSjUwVr47ZWasPE3556tNG9vvnMx1
        LJefmni96Wzgj6ddYolSC5+w8O2+ZP1TQHjJe9tW6ZJt76dNjDR8/S43Mcvkwce5ly/0Wb53
        6xNSPJl05Yv/91UmcXLnk6U27v93+03JuZhJ/CKLGJo/WX94v/Gz3c2ahwYnblVyWDqZm/5K
        OfvpW1SZVb/xUSWW4oxEQy3mouJEAFdpxDLwAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJMWRmVeSWpSXmKPExsWy7bCSvG7ByVVxBi8XClpc3J1q8eT/d1aL
        y7vmsFkcnt/GYnHo5FxGi733PjM6sHns/trE6NG3ZRWjx4np31k8Pm+SC2CJ4rJJSc3JLEst
        0rdL4Mp4vvwEU8EPsYrDexpZGxjvCHYxcnJICJhIrHg9k7mLkYtDSGAHo8TXYz9ZIRLSEj//
        vWeBsIUlVv57zg5iCwl8ZpQ4vZYDxGYT0JNYtWsPWI2IgI3EiRMT2EEGMQv0MUos/DCRCSQh
        LBAk0Tn7MzOIzSKgKrH13h8wm1fATeL/tKXMEAvkJG6e62SewMizgJFhFaNkakFxbnpusWGB
        UV5quV5xYm5xaV66XnJ+7iZGcMBoae1g3LPqg94hRiYOxkOMEhzMSiK8D2NXxQnxpiRWVqUW
        5ccXleakFh9ilOZgURLn/TprYZyQQHpiSWp2ampBahFMlomDU6qBqWH9bs4T/7dN+b3pJ7v3
        Yr8bMnsS/IN5Rbk+dUzffHPDY6f3LxmzSj1WvGKbUfD750WBOeJn7vzX3x6rsnJdk8v9J8It
        7m2KUZuSGrZPuPnpwzSN6V+P7tkUq+K9UTZjz7FXB662s1sWT1c+/XbeVx6rlUs47V49fOqi
        PcOP5fnh372f3RNbptu++fXsT+JHja1/tNnOiQq0zF5s9zdTuvfDoWk7hGIfHQu6UqkU2vRo
        tqh23JsDU7vV/rX82pn49LjvFEeZhRkfPmRd22ygu8YrNvZrr75g6/HDvG0O3vY7LR+emHDQ
        +6zflHd8yke36yqb/e61uHEgpsf71HLLu78qxJ057gQXrn1wXOX6xGt/lFiKMxINtZiLihMB
        oPHCgIcCAAA=
X-CMS-MailID: 20200430124952epcas5p28cd53b0aa452f43eed48ed9d58b4005b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200430124952epcas5p28cd53b0aa452f43eed48ed9d58b4005b
References: <CGME20200430124952epcas5p28cd53b0aa452f43eed48ed9d58b4005b@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currnetly script prints stack usage for functions
in two ways:($re and $dre)

dre breaks sorting mechanism.
0xffffa00011f26f88 sunxi_mux_clk_setup.isra.0 [vmlinux]:Dynamic (0x140)
..
0xffffa00011f27210 sunxi_divs_clk_setup [vmlinux]:      Dynamic (0x1d0)

so we can print it in decimal only.

Also address before function name is changed to function
start address rather than stack consumption address.
Because in next patch, arm has two ways to use stack
which can be clubbed and printed in one function only.

All symbols whose stack by adding(re and dre) is greater than
100, will be printed.

0xffffa00011f2720c0 sunxi_divs_clk_setup [vmlinux]:     464
...
0xffffa00011f26f840 sunxi_mux_clk_setup.isra.0 [vmlinux]:320

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 scripts/checkstack.pl | 52 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 371bd17..412c459 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -109,11 +109,28 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
 #
 # main()
 #
-my ($func, $file, $lastslash);
+my ($func, $file, $lastslash, $total_size, $addr, $intro);
 
 while (my $line = <STDIN>) {
 	if ($line =~ m/$funcre/) {
+		if ($total_size > 100) {
+			push @stack, "$intro$total_size\n";
+		}
+
 		$func = $1;
+		next if $line !~ m/^($xs*)/;
+		$addr = $1;
+		$addr =~ s/ /0/g;
+		$addr = "0x$addr";
+
+		$intro = "$addr $func [$file]:";
+		my $padlen = 56 - length($intro);
+		while ($padlen > 0) {
+			$intro .= '	';
+			$padlen -= 8;
+		}
+
+		$total_size = 0;
 	}
 	elsif ($line =~ m/(.*):\s*file format/) {
 		$file = $1;
@@ -134,37 +151,18 @@ while (my $line = <STDIN>) {
 		}
 		next if ($size > 0x10000000);
 
-		next if $line !~ m/^($xs*)/;
-		my $addr = $1;
-		$addr =~ s/ /0/g;
-		$addr = "0x$addr";
-
-		my $intro = "$addr $func [$file]:";
-		my $padlen = 56 - length($intro);
-		while ($padlen > 0) {
-			$intro .= '	';
-			$padlen -= 8;
-		}
-		next if ($size < 100);
-		push @stack, "$intro$size\n";
+		$total_size = $total_size + $size
 	}
 	elsif (defined $dre && $line =~ m/$dre/) {
-		my $size = "Dynamic ($1)";
-
-		next if $line !~ m/^($xs*)/;
-		my $addr = $1;
-		$addr =~ s/ /0/g;
-		$addr = "0x$addr";
+		my $size = $1;
 
-		my $intro = "$addr $func [$file]:";
-		my $padlen = 56 - length($intro);
-		while ($padlen > 0) {
-			$intro .= '	';
-			$padlen -= 8;
-		}
-		push @stack, "$intro$size\n";
+		$size = hex($size) if ($size =~ /^0x/);
+		$total_size = $total_size + $size
 	}
 }
+if ($total_size > 100) {
+	push @stack, "$intro$total_size\n";
+}
 
 # Sort output by size (last field)
 print sort { ($b =~ /:\t*(\d+)$/)[0] <=> ($a =~ /:\t*(\d+)$/)[0] } @stack;
-- 
1.9.1

