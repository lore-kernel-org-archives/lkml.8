Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41102C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A1A6208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XvgwCaMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgEHLKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:10:18 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:34791 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgEHLKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:10:14 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200508111012epoutp02294b809476abb99151de9c1d24f15ea7~NCREFp0U72624426244epoutp02t
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:10:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200508111012epoutp02294b809476abb99151de9c1d24f15ea7~NCREFp0U72624426244epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588936212;
        bh=gq9JiUyzyhiuoC74sreI4SkfqDkQ6n9DAdjln8txF00=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XvgwCaMdjjhShk/cN1M1Lhze7I+mZlr1XqH1Pr2NAFpEo/A9AAr2UF+jfWvv3wLrb
         rR3EUJYOgKm67AVl35dV2b4TZR7/Smsl76YHAL+pzPF9BSyNQ78MrLdBlFLSM3XpMt
         AHFT2EI6KfpTgv5jZZiVIxv4V14PwafoI59jZhew=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200508111011epcas5p2ec88c03b455c01d7f223937e114accf4~NCRDel_H32578125781epcas5p2C;
        Fri,  8 May 2020 11:10:11 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.35.10010.31E35BE5; Fri,  8 May 2020 20:10:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200508110343epcas5p1ae3398e56ee895572487d05b730bd466~NCLZyW91x0864608646epcas5p1d;
        Fri,  8 May 2020 11:03:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200508110343epsmtrp2dcedc2adf27eb34e3b37aae4b30b7153~NCLZxY4NZ3202332023epsmtrp2x;
        Fri,  8 May 2020 11:03:43 +0000 (GMT)
X-AuditID: b6c32a49-71fff7000000271a-82-5eb53e137bbc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.FA.25866.F8C35BE5; Fri,  8 May 2020 20:03:43 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200508110341epsmtip2130acd8c0a3ded2f927c629bcc113d97~NCLYNTrvP3194731947epsmtip2X;
        Fri,  8 May 2020 11:03:41 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     yamada.masahiro@socionext.com, george_davis@mentor.com
Cc:     linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        arnd@arndb.de, ak@linux.intel.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH v2 1/4] scripts/checkstack.pl: don't display $dre as
 different entity
Date:   Fri,  8 May 2020 16:33:14 +0530
Message-Id: <1588935797-7283-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7bCmpq6w3dY4gy1P5C0u7k61OD7B0uLv
        pGPsFk/+f2e1uLxrDpvF4fltLBaHTs5ltNh77zOjA4fH71+TGD3mnQz02P21idGjb8sqRo8T
        07+zeHzeJBfAFsVlk5Kak1mWWqRvl8CV8fzJTqaCXomKr+uOsTcw3hXqYuTkkBAwkVh0oIGx
        i5GLQ0hgN6PEyr/zmSCcT4wSrZc/skA4nxklLvR+ZIZpWfboPStEYhejREPLA3YI5yujxMcP
        b8Cq2AT0JFbt2sMCYosIWEk829bBBmIzC6xnlFizmQnEFhYIl7hx8CMjiM0ioCqxtKEFzOYV
        cJO4vPcgI8Q2OYmb5zqZQRZICOxil3h/9DYTRMJFYt3OHWwQtrDEq+Nb2CFsKYnP7/ayQTQ0
        M0p82reWEcKZwiix9OJHVogqe4nXzQ1AkziATtKUWL9LHyIsKzH11DomiEv5JHp/P4Faxiux
        Yx6MrSrRcnMD1Bhpic8fP7JA2B4SfyacA/teSCBWYv3iu4wTGGVnIWxYwMi4ilEytaA4Nz21
        2LTAMC+1XK84Mbe4NC9dLzk/dxMjOBloee5gvPvgg94hRiYOxkOMEhzMSiK8Eyu2xAnxpiRW
        VqUW5ccXleakFh9ilOZgURLnPZ0GlBJITyxJzU5NLUgtgskycXBKNTCVVxddi46yXcK08UXI
        cdaSrwEXtSdLSjjGh9vtqRIKXeMfUNx0u2jrfvO3bby3mI4ovJ9nEP584cXi+J1Cj8zCzfVr
        Sx+ITOv2tl7474Fnm8aRwjcGvL8vefbOY/55ZOlRlTz9/XObtxecuqC0+sSurrWtawpmBjkl
        8h3im+trNXFZmqRLmnwvW0PK/tLUh273fskoODoyPhDNPjh97qpN/BXM/95MWrN8w+f70nVZ
        F/MtdC9xNUlWs2e6Bp2/y64Rnda98ETgRdWoxR1+VtqXVvx8fcflnW/8Gf2GrW0TMxe0RVpn
        qkU8nbsji2W5YWdjb6S0jsVbA6WVe0XPrhL9JVe2VXTzRY4Fepwe4UosxRmJhlrMRcWJAEy7
        A1l1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplluLIzCtJLcpLzFFi42LZdlhJXrffZmucwZ4+TouLu1Mtjk+wtPg7
        6Ri7xZP/31ktLu+aw2ZxeH4bi8Whk3MZLfbe+8zowOHx+9ckRo95JwM9dn9tYvTo27KK0ePE
        9O8sHp83yQWwRXHZpKTmZJalFunbJXBlPH+yk6mgV6Li67pj7A2Md4W6GDk5JARMJJY9es/a
        xcjFISSwg1Hi0/SbjBAJaYmf/96zQNjCEiv/PWcHsYUEPjNKzHmTAGKzCehJrNq1B6xGRMBG
        4sSJCewgg5gFtjJKzNrXAjSVg0NYIFTi5r4KkBoWAVWJpQ0tYPN5BdwkLu89CLVLTuLmuU7m
        CYw8CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBIeUltYOxj2rPugdYmTiYDzE
        KMHBrCTCO7FiS5wQb0piZVVqUX58UWlOavEhRmkOFiVx3q+zFsYJCaQnlqRmp6YWpBbBZJk4
        OKUamDakf5tiv6r58zKvKBnVxKtVR5M9X4kFN159vvhW6ZQSkxPJx0rb3+20L+tZsDa54MSp
        picyYTv2uTfdLLyzydD5VabUOj7HHx1T/DStjri5iZn07Dm9QmjaD47zEduVJMRPneBeO5N9
        K4+YWG5SZ91v0dlNCze+1Jp/SiYvNvzTzObudREVq+wPJsydtaovYG9p8N233iFaZ+2D8yao
        avo9cFBItZ3K7u9SVZa1yIpD5c+dzPmTj26csWqHYLL0cxFjhnehucVXv0u2SAVn/tkZe9/d
        XKp6jkmf4cPoYhYd5Qu33NTy9c5bd5aWSBhsP8v/o/DHU36rKebvv3YHPH8XsvYs21ShYze4
        ufJ5lViKMxINtZiLihMBvDLjeJgCAAA=
X-CMS-MailID: 20200508110343epcas5p1ae3398e56ee895572487d05b730bd466
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200508110343epcas5p1ae3398e56ee895572487d05b730bd466
References: <CGME20200508110343epcas5p1ae3398e56ee895572487d05b730bd466@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently script prints stack usage for functions
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

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
v1: https://lkml.org/lkml/2020/4/30/530
v2: review comments by Masahiro Yamada incorporated

 scripts/checkstack.pl | 54 +++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 371bd17..6957108 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -109,11 +109,30 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
 #
 # main()
 #
-my ($func, $file, $lastslash);
+my ($func, $file, $lastslash, $total_size, $addr, $intro);
+
+$total_size = 0;
 
 while (my $line = <STDIN>) {
 	if ($line =~ m/$funcre/) {
 		$func = $1;
+		next if $line !~ m/^($xs*)/;
+		if ($total_size > 100) {
+			push @stack, "$intro$total_size\n";
+		}
+
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
@@ -134,37 +153,18 @@ while (my $line = <STDIN>) {
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
+		$total_size += $size;
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
+		$total_size += $size;
 	}
 }
+if ($total_size > 100) {
+	push @stack, "$intro$total_size\n";
+}
 
 # Sort output by size (last field)
 print sort { ($b =~ /:\t*(\d+)$/)[0] <=> ($a =~ /:\t*(\d+)$/)[0] } @stack;
-- 
1.9.1

