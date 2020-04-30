Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDBEC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51452070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mmww+RJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgD3QcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:32:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56135 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgD3QcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:32:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200430163217euoutp01fe1904a0e5dc1de6a6afd8396179233a~Kpf-mLfyf2727927279euoutp01o
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 16:32:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200430163217euoutp01fe1904a0e5dc1de6a6afd8396179233a~Kpf-mLfyf2727927279euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588264337;
        bh=k0wq6ZpDeeLk6QQH6CUaGaPwWrl1xqroWz3K7qcWkqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mmww+RJV37qDDgw29CeBIvEIJnOlE/ZDm9QB1pBIHej/18pcBg+5ZHDQqR6O04F0i
         ggJfEWVurW+zyg5tto24TBR67vvCCbK85UcCT6SCmWb6JvgV2WdOJahmiVoCiO/ATZ
         Vw50WVo7Q49FxH+4FXY6gPazUcsode3QzdwGSZpQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200430163216eucas1p2f9d4d1904b2021701a358b81c68ab634~Kpf-RNYMx1928719287eucas1p2F;
        Thu, 30 Apr 2020 16:32:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4E.E8.61286.09DFAAE5; Thu, 30
        Apr 2020 17:32:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200430163216eucas1p14e1529fdfbdd3663a5fdf3c9998e060b~Kpf_8hz6A3218332183eucas1p1i;
        Thu, 30 Apr 2020 16:32:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200430163216eusmtrp154ab2438088e1fce38831cb8111b940f~Kpf_5aP0t2557325573eusmtrp1b;
        Thu, 30 Apr 2020 16:32:16 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-a2-5eaafd90db74
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BF.FE.08375.09DFAAE5; Thu, 30
        Apr 2020 17:32:16 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200430163216eusmtip180f320c6ce70e7a7286911527d5a2c53~Kpf_t4NKT1208212082eusmtip1R;
        Thu, 30 Apr 2020 16:32:16 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 1/2] arm64: kexec_file: print appropriate variable
Date:   Thu, 30 Apr 2020 18:31:41 +0200
Message-Id: <20200430163142.27282-2-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200430163142.27282-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUYRTte5tPbexzMrzYIk36I6NFKnlgKxU8qCALCiKtqR62uMQ8l0xy
        qYwyc8QxLTfGQXOYNG3GxMQmmyhNQx0jbcKw0gwtldRSs83XM+rfueeee+75Pi5LKntpL/Z4
        RJSgiVCHqRgXqvrJZOvyjB+mkFUNRX5cQ2cNzRV9aqK50cqfDDd8Mw1x2Xc8uW5rKcE5bEbE
        mXs6aO55bT7DlXTaCa69Xk9w3x9MUpzFfI3kOl5ZGa7/cyPFTVT20JswP56STvFlhWWIN5su
        M3xXRx3DD7W0OPFvbBaKtxQn8sPWFwyfXmVC/Kh5Ed94YYze5brfZd1RIex4jKBZueGQy7GU
        tiHyVKnitKPvHpWEsl1TkTMLeA1cKih3SkUurBIbETQP19NyMYZAO2idKUYRJNt10zL2z0jJ
        FVeZL0XQVp7LyMUHBD1NU06SL4M3g7akkZawB3YQcF2/ScIkziTAqPOR8Fy8Dd48/PpHT2Ff
        6NdOkdICBQ6E1soAOZ435CU3MxJ2xuug5JadlLACu8PTG72UhOdgPyg710nJ9t5w/m4eKeUB
        XMBCSpadkENvhdbPguw5FwYaqpxkvACadWmULEkEXWaAPJqGoDp/gpI1gdDV8o2RNCReChW1
        K2V6M9T3Ppn5Ejd4OeguJ3CDzOocUqYVcOmiUlb7wG1t3YyhF1wdMKIMpMr97y25/+XP/bdL
        j0gT8hSixfBQQfSPEGJXiOpwMToidMWRyHAzmr695p8NIzXoS/thG8IsUs1WsGZTiJJWx4hx
        4TYELKnyULwNnqYUR9VxZwRN5EFNdJgg2tB8llJ5KlYb+oOVOFQdJZwUhFOC5m+XYJ29ps9E
        DLQ4JxkresPqDHFxCeke5fvKdhDjHx31J5ZttKyejAoZ2bJ74p0+LWFeZ8xFHZFkNeZ5eO+Z
        v3jhkV9r/fueac/ef+Q5K+hxpD641o0urhpz31ZXGLz3vf3TEtW7AwexwxCURfnuXL89/rVh
        rGmNISP+1vO2op6c2Dkfu82HAnxUlHhM7e9HakT1b+KP+SB3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsVy+t/xu7oT/q6KM9j1T8Di+PUdrBYL35xi
        tfi84R+bxftlPYwW0zaKW9zft5zJ4uahFYwWmx5fY7W4vGsOm8XS6xeZLC4dWMBk8Wf/TxaL
        zZumMltcu7WPzeLlxxMsFj82PGZ1EPD43trH4rFm3hpGj02rOtk87lzbw+bx7tw5do8Hhzaz
        eGxeUu/xft9VNo++LasYPT5vkvM40fKFNYA7Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRS
        z9DYPNbKyFRJ384mJTUnsyy1SN8uQS+j9cI75oLlvBU3n+1kaWCcxt3FyMEhIWAisbQbyOTi
        EBJYyiix995vZoi4lMTKueldjJxAprDEn2tdbBA1Txklbj7tYwdJsAk4SvQvPcEKkhAReMwk
        sfTTbjCHWWAak8ThaWuZQaqEBVwlHhz8BtbBIqAq8bIfYgOvgLXE+Q1mEBvkJWY3nmYDsTkF
        bCSWrr4I1iokkCsxac80MJtXQFDi5MwnLCCtzALqEuvnCYGE+QW0JNY0XWcBsZmBxjRvnc08
        gVFoFpKOWQgds5BULWBkXsUoklpanJueW2yoV5yYW1yal66XnJ+7iREY6duO/dy8g/HSxuBD
        jAIcjEo8vBybVsUJsSaWFVfmHmKU4GBWEuF9GAsU4k1JrKxKLcqPLyrNSS0+xGgK9OVEZinR
        5HxgEsoriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cC4cLvflpsZ
        Zysyur9t6f7Ms/Z+iVg+95uwHs8tiieq+DQsy4uNBE5uNDrJFezI/e/4PKXYX05PZn88ERkZ
        1XHONd3FLOnmUd9pK47drJ21OMLmhuiJk0u3Rm0tDdZ7VK70wXXZclWulBuZLstb+jYfqxAK
        UmL2PzRv3cVs9dg5j7c+nWLIFH1CiaU4I9FQi7moOBEAruFe6woDAAA=
X-CMS-MailID: 20200430163216eucas1p14e1529fdfbdd3663a5fdf3c9998e060b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200430163216eucas1p14e1529fdfbdd3663a5fdf3c9998e060b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200430163216eucas1p14e1529fdfbdd3663a5fdf3c9998e060b
References: <20200430105034.17513-1-l.stelmach@samsung.com>
        <20200430163142.27282-1-l.stelmach@samsung.com>
        <CGME20200430163216eucas1p14e1529fdfbdd3663a5fdf3c9998e060b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of kbuf->memsz may be different than kbuf->bufsz after calling
kexec_add_buffer(). Hence both values should be logged.

Fixes: 52b2a8af74360 ("arm64: kexec_file: load initrd and device-tree")
Fixes: 3751e728cef29 ("arm64: kexec_file: add crash dump support")
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: James Morse <james.morse@arm.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index b40c3b0def92..5ebb21b859b4 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -284,7 +284,7 @@ int load_other_segments(struct kimage *image,
 		image->arch.elf_headers_sz = headers_sz;
 
 		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			 image->arch.elf_headers_mem, headers_sz, headers_sz);
+			 image->arch.elf_headers_mem, kbuf.bufsz, kbuf.memsz);
 	}
 
 	/* load initrd */
@@ -305,7 +305,7 @@ int load_other_segments(struct kimage *image,
 		initrd_load_addr = kbuf.mem;
 
 		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-				initrd_load_addr, initrd_len, initrd_len);
+				initrd_load_addr, kbuf.bufsz, kbuf.memsz);
 	}
 
 	/* load dtb */
@@ -332,7 +332,7 @@ int load_other_segments(struct kimage *image,
 	image->arch.dtb_mem = kbuf.mem;
 
 	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			kbuf.mem, dtb_len, dtb_len);
+			kbuf.mem, kbuf.bufsz, kbuf.memsz);
 
 	return 0;
 
-- 
2.25.0

