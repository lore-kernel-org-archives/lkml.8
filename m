Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1001C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8715320784
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A8RjApn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgD3Kux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:50:53 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60132 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgD3Kux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:50:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200430105048euoutp010950c48122f94e5c6549ba28100f97b4~Kk12Wydc-0688606886euoutp01j
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 10:50:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200430105048euoutp010950c48122f94e5c6549ba28100f97b4~Kk12Wydc-0688606886euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588243848;
        bh=veBGnH7xgInKo9nRc/IuDX3Fs+zFRVjRLtRoRyzy6II=;
        h=From:To:Cc:Subject:Date:References:From;
        b=A8RjApn9R7em9FqaWPbaMMP3dF0E3xVyI2rQpIIO8BfBrQia0y4v8raXjeS1dijPD
         ZbLKaf5/t52POrvVplGh5cCLc5pBhN9Ka1lyfQ0unx40VH/Li+xuzr0fQrGl3C3O7N
         zyOX0NqbAm3NMJ5Sv03q6cRS3O84yhZrXZuWIpws=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200430105048eucas1p1daf75c97dab178dd9e3aa46b483783f0~Kk12JRnhf2501225012eucas1p14;
        Thu, 30 Apr 2020 10:50:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8C.D9.60698.88DAAAE5; Thu, 30
        Apr 2020 11:50:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200430105048eucas1p129975fe3fd84c4fd2b14117e3474b203~Kk110v5C80536305363eucas1p1s;
        Thu, 30 Apr 2020 10:50:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200430105048eusmtrp21306ce46205c837f07da8a3b9b5f96e6~Kk110Ld3e2294322943eusmtrp28;
        Thu, 30 Apr 2020 10:50:48 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-01-5eaaad8864d0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F7.D0.08375.88DAAAE5; Thu, 30
        Apr 2020 11:50:48 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200430105048eusmtip1b55b2459d9da86b9448bfb269235bd91~Kk11q5cyB0912709127eusmtip1D;
        Thu, 30 Apr 2020 10:50:48 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] arm64: kexec_file: print appropriate variable
Date:   Thu, 30 Apr 2020 12:50:34 +0200
Message-Id: <20200430105034.17513-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduznOd2OtaviDObvlLd4v6yH0eLmoRWM
        FpseX2O1uLxrDpvFy48nWBxYPdbMW8PosXlJvUffllWMHp83yQWwRHHZpKTmZJalFunbJXBl
        7Ljwmr3gDmtF27Q3jA2MH1m6GDk5JARMJOZe2wZkc3EICaxglDj/7QWU84VR4vHtG+wgVUIC
        nxklVm81g+nonXyPFaJoOaNE28VdzBDOc0aJrVNmMoFUsQk4SvQvPQFWJSIwg1Fi2sKJYKOY
        BewlJs76zwZiCwvYSezo7AOzWQRUJa6vfg7WzCtgLTH/xB1miHXyErMbT7NBxAUlTs58AnY4
        v4CWxJqm6ywQM+UlmrfOBrtCQuA3m8S1VbvZIJpdJLbMa2KEsIUlXh3fwg5hy0j83zkfaBkH
        kF0vMXmSGURvD6PEtjk/oCFjLXHn3C82kBpmAU2J9bv0IcKOEif71rNAtPJJ3HgrCHECn8Sk
        bdOZIcK8Eh1tQhDVKhLr+vdADZSS6H21ghGixEPi3NLqCYyKs5D8NQvJL7MQ1i5gZF7FKJ5a
        WpybnlpsnJdarlecmFtcmpeul5yfu4kRmEhO/zv+dQfjvj9JhxgFOBiVeHgnpK+ME2JNLCuu
        zD3EKMHBrCTC+zB2VZwQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotg
        skwcnFINjNP6H/EV8Tg2TYyZlJmk1qy0wGzJvIa5H6efv7g8NHX+jok1v0SNVdeIrHYvXv4g
        q2SG1UWLHvfSkuVbV4r4a+c4TGX9cvzXq/eB12on/1uVo6hupF5YMuVW1i/ZiyZ3PNl3FZ53
        3cxQtU0rbk/p3CUPlrY6xq111Itbtk4/+W8sk9pWvk62E0osxRmJhlrMRcWJAI+rcG0gAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e/4Xd2OtaviDBYv4rR4v6yH0eLmoRWM
        FpseX2O1uLxrDpvFy48nWBxYPdbMW8PosXlJvUffllWMHp83yQWwROnZFOWXlqQqZOQXl9gq
        RRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl7Ljwmr3gDmtF27Q3jA2MH1m6
        GDk5JARMJHon32PtYuTiEBJYyihxtGMyUIIDKCElsXJuOkSNsMSfa11sEDVPGSVuHFnFBpJg
        E3CU6F96AqxZRGAWo8ScnbeZQBLMAvYSE2f9BysSFrCT2NHZB2azCKhKXF/9HKyGV8BaYv6J
        O8wQG+QlZjeeZoOIC0qcnPkE7AhmAXWJ9fOEQML8AloSa5qus0CMl5do3jqbeQIj0FKEjlkI
        HbOQVC1gZF7FKJJaWpybnltsqFecmFtcmpeul5yfu4kRGAnbjv3cvIPx0sbgQ4wCHIxKPLwW
        qSvjhFgTy4orcw8xSnAwK4nwPoxdFSfEm5JYWZValB9fVJqTWnyI0RTonYnMUqLJ+cAozSuJ
        NzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwKii7fRjqdSlSbU/lUTU
        nVq5eWxevv2Z4XphgtnqfumUJcJ/Px9Pc9QSfr3SaWZhipoP648nm7q0Ir/pM9yfZWPg4L39
        /dzXO8QDSu+uyYow1xFybWCYrfnJ83uNdO7rY3FPTjo+iNvwNKWEOa9P/JD2x8UaWRe2CEab
        Ojjdeqyxfet/p9rvr5RYijMSDbWYi4oTAbUcTMiaAgAA
X-CMS-MailID: 20200430105048eucas1p129975fe3fd84c4fd2b14117e3474b203
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200430105048eucas1p129975fe3fd84c4fd2b14117e3474b203
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200430105048eucas1p129975fe3fd84c4fd2b14117e3474b203
References: <CGME20200430105048eucas1p129975fe3fd84c4fd2b14117e3474b203@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 4312057681929 ("arm64: kexec_file: load initrd and device-tree")
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index b40c3b0def92..2776bdaa83a5 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -332,7 +332,7 @@ int load_other_segments(struct kimage *image,
 	image->arch.dtb_mem = kbuf.mem;
 
 	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			kbuf.mem, dtb_len, dtb_len);
+			kbuf.mem, dtb_len, kbuf.memsz);
 
 	return 0;
 
-- 
2.25.0

