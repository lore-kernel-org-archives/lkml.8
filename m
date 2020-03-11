Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EA1C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4014215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fs63vccb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgCKDpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:45:08 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41192 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgCKDpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:45:00 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200311034456epoutp01c220e8a09e63c477e0753a85d186ec8f~7IxvjIZRC1735217352epoutp01v
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 03:44:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200311034456epoutp01c220e8a09e63c477e0753a85d186ec8f~7IxvjIZRC1735217352epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583898296;
        bh=1oA52aVZG3c059yyJ7IvF/BZO+09kGIaHbRpZ+wX6ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fs63vccbJPnbH1VZM+on+DRbNmvx19xsrOLKWWw2ekpGsKN9y+6DdCjeYD+ZUakEZ
         LFsfJabpxDKPkhUv31EjSnrsxeWeeTczLKHtG8VCSsswpi9HTUeu+VBqI8eeeHr63n
         wnGE7J5SqxmAjW2Cp8ngYah3lVQH5qHGILzPc4Ho=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200311034456epcas1p2985c1929c0e75d9e48c650b0db07d96d~7IxvCpV3X2746527465epcas1p23;
        Wed, 11 Mar 2020 03:44:56 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.159]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48cdBZ710qzMqYls; Wed, 11 Mar
        2020 03:44:54 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.06.52419.6BE586E5; Wed, 11 Mar 2020 12:44:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200311034454epcas1p13f7806e51b19c7848148c20ce3841b1b~7IxtgFiST2430724307epcas1p1Q;
        Wed, 11 Mar 2020 03:44:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200311034454epsmtrp1140101c0c7cf1fc5a6192126a94d44aa~7IxtfXGtg3056530565epsmtrp1r;
        Wed, 11 Mar 2020 03:44:54 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-e0-5e685eb65295
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.9E.10238.6BE586E5; Wed, 11 Mar 2020 12:44:54 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200311034454epsmtip1c6fc620abd3ff4722880b4805b3e790f~7IxtQqSXg2352723527epsmtip1y;
        Wed, 11 Mar 2020 03:44:54 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RFC PATCH 2/3] mm: zsmalloc: include zs page size in proc/meminfo
Date:   Wed, 11 Mar 2020 12:44:40 +0900
Message-Id: <20200311034441.23243-3-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200311034441.23243-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN67QzU7RmLKgvaLSO0QSF0lpKx6VEo9FR/ECNKCZQJnRs0S6T
        TovCh1EpREFckCg0kuASEotaKciW4gcaBFeiURMUiQtEjdCERYyK2HYw+nfuuee8u7yLI/Jz
        aCyea3OyDhtjIdEocdPdOGVCU5Y5SzVap6MuHN1KXfRdR6nShipAlQW/iKhrge8i6nnbRZR6
        e31KQtWOBzHqltuDUe/PlIuoB32j2LoZdKunD6P93hMo7R8px+g3LwMo3VX5U0wH77xA6VON
        XkC3jjRI6FH/wjTpXstaM8sYWYeCteXYjbk2k55M3WnYYNAmq9QJ6lWUjlTYGCurJzduS0vY
        lGsJdUsq8hiLK0SlMTxPJqasddhdTlZhtvNOPclyRgunVnFKnrHyLptJmWO3rlarVCu1IWW2
        xfyt6grCuaMO1XU/lhwBp/ASIMUhkQTrOyexEhCFy4kWAM//+oAKwQiAnc1jIiH4BmDp5Smk
        BOARS+NRlcC3A1h43jttnwDwU8UxLPwuSqyAwZpySTgRQ9wAcPLYVXE4gRAuOPS1CwnjaCIV
        vp4ojBjExFI4MDYsCmMZoYe9H5swodoieGkqIpcSKXD0TS8IvwmJfhR29j9FhCE2wkfublTA
        0fDL/UZMwLHw8+liTDAUAjhU1TDtdgPY5y8DgkoDy072RGZDiDjoa0sU6MWw9Wc1EJqeBYfH
        T0qEhmTweLFckCyD7sFxiYAXwMnfg9OYhq+aJ4CwlbMAvvW1YGfAQs+/CjUAeMFcluOtJpZX
        c5r//8wPIge5XNcCbj3Z1gEIHJAzZZ8Om7LkEiaPz7d2AIgjZIzMsChEyYxMfgHrsBscLgvL
        dwBtaJVnkdg5OfbQeducBrV2pUajoZKSdclaDTlP9i4jLktOmBgne4BlOdbx1yfCpbFHwL6U
        jObte8YDAwPDXA+e2VM7siZvfkXhqrj0wO3ZnrIAa3Re/fFh/Zb24MMJqTIt4N2k+Zz7JKVi
        QS3aXfosM7V/5/PEKvNpFWXIz1vvmFvQfvweSOfqN/v274r39CbpFQeLltRVVy6eeVNapGvL
        HN4s6SmPL8h+NLhbzO1oy2wlxbyZUS9HHDzzB3rK2D6mAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSnO62uIw4g78fhSymN3pZzFm/hs2i
        e/NMRove96+YLFbu+cFkcXnXHDaLe2v+s1os+/qe3WJDyyx2i0cTJjFZnLr7md2B22PnrLvs
        HptWdbJ5bPo0id3jzrU9bB4nZvxm8Xi/7yqbR9+WVYweOz9tZvX4vEkugDOKyyYlNSezLLVI
        3y6BK+PbzMXMBS1cFatPnmVtYOzj6GLk4JAQMJHY0mjQxcjJISSwm1Hi77kEEFtCQEbizfmn
        LBAlwhKHDxd3MXIBlXxllPj97g0LSA2bgLbE+wWTWEESIgJbGSU+/FkPlmAWqJT4d/sWK4gt
        LOAtcft7MzuIzSKgKvH0yzsmEJtXwFbi1pNt7BAL5CUW/mcGCXMK2El8vnOLESQsBFSy4YHl
        BEa+BYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgoNXS3MH4+Ul8YcYBTgYlXh4
        X9SlxwmxJpYVV+YeYpTgYFYS4Y2XBwrxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2x
        JDU7NbUgtQgmy8TBKdXAuOLNJZuot18r7CYUznaY5J/5nK3rwvusmtknL4eerLEP3mizPOze
        sXXJk2eVXj528glTyL1Jzz8VfD4z66njmpJDjs4GMzJk5UPqp696/sGR02H6RvN1Yoybmtqd
        NjHlrfjxIfV66snt899ax3GbToy3spXedsPvp5dBtuwsGbvVi16tqbn06KsSS3FGoqEWc1Fx
        IgBoRCGDWgIAAA==
X-CMS-MailID: 20200311034454epcas1p13f7806e51b19c7848148c20ce3841b1b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200311034454epcas1p13f7806e51b19c7848148c20ce3841b1b
References: <20200311034441.23243-1-jaewon31.kim@samsung.com>
        <CGME20200311034454epcas1p13f7806e51b19c7848148c20ce3841b1b@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On most of recent Android device use DRAM memory based compressed swap
to save free memory. And the swap device size is also big enough.

The zsmalloc page size is alread shown on vmstat by commit 91537fee0013
("mm: add NR_ZSMALLOC to vmstat"). If the size is also shown in
/proc/meminfo, it will be better to see system wide memory usage at a
glance.

To include heap size, use register_extra_meminfo introduced in previous
patch.

i.e) cat /proc/meminfo | grep ZsPages
IonSystemHeap:    242620 kB
ZsPages:          203860 kB

i.e.) show_mem on oom
<6>[  420.856428]  Mem-Info:
<6>[  420.856433]  ZsPages:44114kB

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/zsmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 22d17ecfe7df..9e45d7e0cd69 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2566,6 +2566,7 @@ static int __init zs_init(void)
 
 	zs_stat_init();
 
+	register_extra_meminfo(&vm_zone_stat[NR_ZSPAGES], 0, "ZsPages");
 	return 0;
 
 hp_setup_fail:
@@ -2583,6 +2584,7 @@ static void __exit zs_exit(void)
 	cpuhp_remove_state(CPUHP_MM_ZS_PREPARE);
 
 	zs_stat_exit();
+	unregister_extra_meminfo(&vm_zone_stat[NR_ZSPAGES]);
 }
 
 module_init(zs_init);
-- 
2.13.7

