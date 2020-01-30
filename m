Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB3C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0196C20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LQQDXpQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgA3MnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:43:06 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56355 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbgA3MnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:43:06 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130124304euoutp02d78f6676bca660602ea3f5c38da57657~uqq5VFkHp0709607096euoutp02P
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:43:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130124304euoutp02d78f6676bca660602ea3f5c38da57657~uqq5VFkHp0709607096euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580388185;
        bh=+P8a2fdMyzXk8luowUxelFub/dwbU2MtPQ3w1czBqRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQQDXpQLxlZeHlKlKIUQOfpnitWnFxtv4FuQhRs4yOKat8O1xCJkULrYrnKEgXVNF
         gGMFhQ7nHsnjf0O+084c6Avp42JkkFgQb2TEPCgSap9IwkqHCBOosZH112WsdTHMKb
         iiR1w+whOMaHQERr8TPLu+X3qJmslcmTDi0GFyNE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130124304eucas1p2a579180e27d6d0ad2f7e0fbb5bb06c92~uqq5FRhGh2611426114eucas1p28;
        Thu, 30 Jan 2020 12:43:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 83.D9.61286.85FC23E5; Thu, 30
        Jan 2020 12:43:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200130124304eucas1p2f3381b1009cd71cd292169d5f10265c1~uqq4krDLU1246012460eucas1p2L;
        Thu, 30 Jan 2020 12:43:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130124304eusmtrp155ca62ca38ac1f64a26c76184b2bd44c~uqq4kIDIS2256122561eusmtrp1l;
        Thu, 30 Jan 2020 12:43:04 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-93-5e32cf581f1b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A4.3E.08375.85FC23E5; Thu, 30
        Jan 2020 12:43:04 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200130124303eusmtip2548f372b63f47f071fa7db90415c7968~uqq4Wy6ve1492314923eusmtip2V;
        Thu, 30 Jan 2020 12:43:03 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [RFC PATCH 2/4] scripts: add get_console_base.pl
Date:   Thu, 30 Jan 2020 13:42:31 +0100
Message-Id: <20200130124233.4006-2-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130124233.4006-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduzned2I80ZxBusmqlvcPLSC0WLT42us
        Fpd3zWGzmHF+H5MDi8fmJfUefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlbF3TnDBbY6KqxMu
        sTUwrmDvYuTkkBAwkdj2+wNjFyMXh5DACkaJZWs6mSGcL4wSv9+egHI+M0r8P9/KAtPStKuZ
        DSKxnFHi5vwWVgjnOVD/jh9sIFVsAo4S/UtPsILYIgLZEpM/fmECsZkF7CUmzvoPViMsYClx
        5uxXoEM4OFgEVCV+nSsFCfMKWEkcPr4S6j55ifO968BsTgFriY+rf7NC1AhKnJz5BOwgfgEt
        iTVN11kgxstLNG+dzQzR284usW1KLoTtInGs5y4rhC0s8er4Fqj5MhKnJ/ewgJwgIVAvMXmS
        GcgrEgI9jBLb5vyAetha4s65X2wgNcwCmhLrd+lDlDtKTP6ZD2HySdx4KwhxAJ/EpG3TmSHC
        vBIdbUIQM1Qk1vXvgZonJdH7agXjBEalWUhemYXk/FkIqxYwMq9iFE8tLc5NTy02zEst1ytO
        zC0uzUvXS87P3cQITBen/x3/tIPx66WkQ4wCHIxKPLweZ4zihFgTy4orcw8xSnAwK4nwiroa
        xgnxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAyFevmWf3
        zPimtp2CsP7E/uKJHHx8ch9ZZ54q8XC+bDxRRqxsu8Lt4I7fV1Wm7T1lV2PP5rya8dWh30ze
        kQ0v+PcGHvsoMc88cW9U8syXF55MP3n8WGL/7L/ZthNliqT+NbivZHbbKWDIVv/zyV/WPc/9
        deNu2b13npulkmC19WSS2MoTTxS8lFiKMxINtZiLihMBUXfpNhMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xe7oR543iDG4tYba4eWgFo8Wmx9dY
        LS7vmsNmMeP8PiYHFo/NS+o9+rasYvT4vEkugDlKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/I
        xFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PvnOCC2xwVVydcYmtgXMHexcjJISFgItG0q5mt
        i5GLQ0hgKaPEorWvgBIcQAkpiZVz0yFqhCX+XOuCqnnKKPFyVjcbSIJNwFGif+kJVhBbRCBX
        4tqho2BDmQXsJSbO+g9WIyxgKXHm7FewmSwCqhK/zpWChHkFrCQOH18JdYO8xPnedWA2p4C1
        xMfVv8FGCglkS3TtecUIUS8ocXLmExaQMcwC6hLr5wmBhPkFtCTWNF1ngdgqL9G8dTbzBEah
        WUg6ZiF0zEJStYCReRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgfGw79nPzDsZLG4MPMQpw
        MCrx8HqcMYoTYk0sK67MPcQowcGsJMIr6moYJ8SbklhZlVqUH19UmpNafIjRFOjLicxSosn5
        wNjNK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAGMt35pJD+7Kc
        5clR+zm2Ldz3UudD0+ruya5ss353pX9Z83btg323lsadClk8v/kK46HJjYL+iZ7q15bJrxao
        elP/xyni66+/XRdO/f8S2Mli+cR2/arodnnjmTeaHki9WfC+p2NSQ9ru798mBC1bHcUzUbz5
        ll7rrzUr8lVFX/NlNq2IP++8RE+JpTgj0VCLuag4EQAXSO14pQIAAA==
X-CMS-MailID: 20200130124304eucas1p2f3381b1009cd71cd292169d5f10265c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200130124304eucas1p2f3381b1009cd71cd292169d5f10265c1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200130124304eucas1p2f3381b1009cd71cd292169d5f10265c1
References: <20200130123934.3900-1-l.stelmach@samsung.com>
        <20200130124233.4006-1-l.stelmach@samsung.com>
        <CGME20200130124304eucas1p2f3381b1009cd71cd292169d5f10265c1@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read UART base address from dtb for compile time configuration.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 scripts/get_console_base.pl | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 scripts/get_console_base.pl

diff --git scripts/get_console_base.pl scripts/get_console_base.pl
new file mode 100755
index 000000000000..c707ee37a19f
--- /dev/null
+++ scripts/get_console_base.pl
@@ -0,0 +1,26 @@
+#!/usr/bin/perl -w
+
+use strict;
+use File::Basename;
+use File::Spec::Functions;
+
+my $DTB=$ARGV[0];
+die "$0: DTB file not found: $DTB" unless (-f $DTB);
+
+my $scripts_dir=dirname($0);
+my $fdtget=catfile($scripts_dir, 'dtc', 'fdtget');
+
+my $stdout_path=`$fdtget  -ts "$DTB" /chosen stdout-path`;
+chomp $stdout_path;
+
+if ($stdout_path =~ m#([^/][^:]*)(?::.*)#) {
+	$stdout_path=`$fdtget -ts "$DTB" /aliases $1`;
+	chomp $stdout_path;
+}
+
+my $reg = `$fdtget -tx "$DTB" $stdout_path reg`;
+unless ($reg =~ m/^([[:xdigit:]]+)/) {
+	die "Base address not found";
+}
+$reg = $1;
+print "0x$reg\n";
-- 
2.20.1

