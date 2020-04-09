Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D88C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F5221D82
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kbnu945v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgDIJlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:41:12 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:37342 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgDIJlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:41:12 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200409094110epoutp02160d45ad30db9745c0dc7e5c8f0c7145~EHWDNLxky1435114351epoutp02I
        for <linux-kernel@vger.kernel.org>; Thu,  9 Apr 2020 09:41:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200409094110epoutp02160d45ad30db9745c0dc7e5c8f0c7145~EHWDNLxky1435114351epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586425270;
        bh=hYOGH5QzXR9eOJyz65hhkK+8y7rMO7Q72pB3emsDqBc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Kbnu945vdA1AlwdyCr75hNjp2ZPIoLgVYAQweZ/NpC2oZXShDic+4XtpA9hB0urit
         VD7ADAcWWImD3iNXmzSKwdItJVOL0VpVMbjFWEqE5iUzoNSd4+pr6s3PriM6jfhaVd
         CPaeQ/CoCYArgObageMhlWAZ4zPAhBjfEGqxSaa8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200409094109epcas1p463018479d21645ca68dadc15c6fd2c0e~EHWCrmu1f2551725517epcas1p48;
        Thu,  9 Apr 2020 09:41:09 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.163]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48ybkC2vnNzMqYls; Thu,  9 Apr
        2020 09:41:07 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.1E.04544.3BDEE8E5; Thu,  9 Apr 2020 18:41:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200409094106epcas1p4ab88dab9bddc5c2c40fca2bcbece3b17~EHV-9zi6u2865028650epcas1p4L;
        Thu,  9 Apr 2020 09:41:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200409094106epsmtrp1c525a99a6ad794aa28f9f1d7e9b2ea83~EHV-89LIx0118101181epsmtrp1F;
        Thu,  9 Apr 2020 09:41:06 +0000 (GMT)
X-AuditID: b6c32a36-7e7ff700000011c0-46-5e8eedb3f279
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.3C.04158.2BDEE8E5; Thu,  9 Apr 2020 18:41:06 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200409094106epsmtip18b9418a6856bcd27593376af15aa22c9~EHV-xcjo42924329243epsmtip12;
        Thu,  9 Apr 2020 09:41:06 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     willy@infradead.org, walken@google.com, bp@suse.de,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] mm: mmap: initialize align_offset explicitly for
 vm_unmapped_area
Date:   Thu,  9 Apr 2020 18:40:35 +0900
Message-Id: <20200409094035.19457-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmge7mt31xBvPOi1vMWb+GzWJiv6ZF
        9+aZjBa9718xWVzeNYfN4t6a/6wW/ybVWvz+MYfNgcNj56y77B4LNpV6bF6h5bHp0yR2jxMz
        frN49G1Zxeix+XS1x+dNcgEcUTk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
        eYm5qbZKLj4Bum6ZOUBXKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKDA0K9IoT
        c4tL89L1kvNzrQwNDIxMgSoTcjJO7gstmMZT8fVyJ2sD40quLkZODgkBE4l1L2YydjFycQgJ
        7GCUuH1rCTOE84lRYt7Kj1CZb4wSWzb+YIVpmdb6mA0isZdRovvERiYI5zujxKqJIMM4OdgE
        tCXeL5gE1MHBISIQLPF4JhtImFmgVOLtmxPMILawQIjE9KOLGUFKWARUJU7cUQYJ8wrYSvxt
        7gPrlBCQl1j4H+wgCYE5bBK3Xp1jg7jBRWLfvW1QtrDEq+Nb2CFsKYmX/W3sEA3NjBJvZ25m
        hHBaGCXubuplhKgylujtucAMsoFZQFNi/S59iLCixM7fcxkh7uSTePe1B+oIXomONiGIEjWJ
        lmdfoeEgI/H33zMo20Pi+OXvYG8JCcRKrDp1jXUCo+wshAULGBlXMYqlFhTnpqcWGxYYIcfR
        JkZwQtMy28G46JzPIUYBDkYlHt4De3rjhFgTy4orcw8xSnAwK4nwejcBhXhTEiurUovy44tK
        c1KLDzGaAgNvIrOUaHI+MNnmlcQbmhoZGxtbmJiZm5kaK4nzTr2eEyckkJ5YkpqdmlqQWgTT
        x8TBKdXAGBwq9eZ01gTbdQLnX8wVPruHSfnkXmuWe4fWfz8wo8TE7tzytwGa9Y9Odt7ftyKP
        pcH9xuZfjcahsx+scy6P1oqRFGw7KSo3Pe3jzI/Vz9yksyYtmvPJc8dhUQa2ZZcKnZ49nsqo
        Jf909+dExZsP9h+/+/Du2ievP8/M8ax5UC2+1s2Ik7Mi46ASS3FGoqEWc1FxIgDyX343fgMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSnO6mt31xBts/61jMWb+GzWJiv6ZF
        9+aZjBa9718xWVzeNYfN4t6a/6wW/ybVWvz+MYfNgcNj56y77B4LNpV6bF6h5bHp0yR2jxMz
        frN49G1Zxeix+XS1x+dNcgEcUVw2Kak5mWWpRfp2CVwZJ/eFFkzjqfh6uZO1gXElVxcjJ4eE
        gInEtNbHbF2MXBxCArsZJb5d3ccMkZCReHP+KUsXIweQLSxx+HAxRM1XRom5+34xgtSwCWhL
        vF8wiRWkRkQgXGLq9gqQMLNApcS/27dYQWxhgSCJvpl7GEFKWARUJU7cUQYJ8wrYSvxt7mOF
        mC4vsfA/8wRGngWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJDS0trB+OJE/GH
        GAU4GJV4eCX298YJsSaWFVfmHmKU4GBWEuH1bgIK8aYkVlalFuXHF5XmpBYfYpTmYFES55XP
        PxYpJJCeWJKanZpakFoEk2Xi4JRqYMxVWb3y6/pLt63cOx8wNa5bxlXlv95qbXbonT9rmBIb
        N/42DP5ULLD65v/zDzpO+ssz7yo0mnKk2zbppuG9WucZZ+brTuRx0WyQyE9T5dLnne3oG31w
        V6raD/lHc9dNN/Occvn7e7kbz9ovLJ48t/peV0DAP6Nb+5hPXzlzmbvgYI7juj+sOXVKLMUZ
        iYZazEXFiQBW7JP+KQIAAA==
X-CMS-MailID: 20200409094106epcas1p4ab88dab9bddc5c2c40fca2bcbece3b17
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200409094106epcas1p4ab88dab9bddc5c2c40fca2bcbece3b17
References: <CGME20200409094106epcas1p4ab88dab9bddc5c2c40fca2bcbece3b17@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On passing requirement to vm_unmapped_area, arch_get_unmapped_area and
arch_get_unmapped_area_topdown did not set align_offset. Internally on
both unmapped_area and unmapped_area_topdown, if info->align_mask is 0,
then info->align_offset was meaningless.

But commit df529cabb7a2 ("mm: mmap: add trace point of
vm_unmapped_area") always prints info->align_offset even though it is
uninitialized. Fix this uninitialized value issue by setting it to 0
explicitly.

Before
92.291104: vm_unmapped_area: addr=0x755b155000 err=0 total_vm=0x15aaf0 flags=0x1 len=0x109000 lo=0x8000 hi=0x75eed48000 mask=0x0 ofs=0x4022

After
68.584210: vm_unmapped_area: addr=0x74a4ca1000 err=0 total_vm=0x168ab1 flags=0x1 len=0x9000 lo=0x8000 hi=0x753d94b000 mask=0x0 ofs=0x0

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8d77dbbb80fe..de07bbc0e21f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2123,6 +2123,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.low_limit = mm->mmap_base;
 	info.high_limit = mmap_end;
 	info.align_mask = 0;
+	info.align_offset = 0;
 	return vm_unmapped_area(&info);
 }
 #endif
@@ -2164,6 +2165,7 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
 	info.align_mask = 0;
+	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.13.7

