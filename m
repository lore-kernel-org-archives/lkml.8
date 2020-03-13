Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD45CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C691206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TDVxQbfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCMBOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:14:35 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:40520 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgCMBOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:14:34 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200313011432epoutp017746af518d3c2d15c5ca2b62c3f86f9d~7uA-4u2iU2318123181epoutp01e
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 01:14:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200313011432epoutp017746af518d3c2d15c5ca2b62c3f86f9d~7uA-4u2iU2318123181epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584062072;
        bh=/uwl5QYkVSHq8zDuzWq+Dxmu9/F2EF6FVR+WiMze73s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TDVxQbfraXD7y8ghKj8Dbfg/Q9mDP0iTgj0d57nYYYyEEhQvRwJ4y7H7EXaGvcKlt
         dE90aCdgRkbTvDstmeGUR3B99frQB+ZBAAK03z6kr4Yi26F31M9Kuec6DagJN03XEi
         hNbqCmrmw3Rbyhe7NsKw1kOc8qovw5IvUHwZLE/I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200313011431epcas1p48b23cca7c80f68a26bdce19f413b44f0~7uA-KawiY1492014920epcas1p4n;
        Fri, 13 Mar 2020 01:14:31 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48dnm72VqvzMqYkZ; Fri, 13 Mar
        2020 01:14:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.40.52419.77EDA6E5; Fri, 13 Mar 2020 10:14:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200313011430epcas1p423b939dea080fda77a2e0fe3f6531489~7uA90qoSq0946109461epcas1p4l;
        Fri, 13 Mar 2020 01:14:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200313011430epsmtrp20ed3e52337c04466f201a3d9a4384dd9~7uA9z8jKU2991729917epsmtrp2A;
        Fri, 13 Mar 2020 01:14:30 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-8e-5e6ade7729f6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.67.06963.67EDA6E5; Fri, 13 Mar 2020 10:14:30 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200313011430epsmtip2636097b44781ec64cceef7a3220452a4~7uA9pPI9I1861118611epsmtip2H;
        Fri, 13 Mar 2020 01:14:30 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     willy@infradead.org, walken@google.com, bp@suse.de,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v2 0/2] mm: mmap: add mmap trace point
Date:   Fri, 13 Mar 2020 10:14:18 +0900
Message-Id: <20200313011420.15995-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUhTcRTl59veXtbqsUov60N9Uaalbs3NVzgRlHhkkGEQCTkf+pjavtrb
        KotCSSRKbWpU5opV2IcZ2aai5iqMmhVEIEFkRpEt/JqkWYGkbb6k/jvncM793Xt/l8Bkw2I5
        UWyycVYTa6DwcFHHk7jEhMMfSvIUXVeX0c57LThdezaOPuNpQHT1xEgY3d/txOkPLXNierbu
        OD3zy4mnE0zXpUEJ43LbGc+teMY9WSdh+i7OiJiatmbEeF4eY6bca7OJXENqEccWctZozlRg
        Liw26bVUVo4uQ6fWKJQJyq10ChVtYo2clsrcmZ2wvdgQ7IqKPsQa7EEpm+V5Kikt1Wq227jo
        IjNv01KcpdBgUSosiTxr5O0mfWKB2bhNqVBsUQed+YYir3eVZUB05M7wM0kZGsBOI4IAMhlc
        j+A0CidkZCeCRl+PSCCTCEYfViOB/EAw+XEUX0j8vGkXdC+C8+MBiUB+IvA9bA/GFxE4uQkm
        XHXiUGAFmQOfG/CQjJF2GB/rw0J4OamB552t83YRuR5ufK4NC2EpqYWmsSYkvBUFV+ewUHkg
        nTiccbTMe4DMhOlz3//i5TDia5MIWA5TAS8uBE4iGG/wIIFUIBh0h8YJuVRQXfV6fn6MjIN7
        3UmCHANdM5eR0OhSCExXiYUmpHCqUiZYNkCFf1os4NXwe9b/18LA3V4yJMvI/VDe/l7kQGsu
        /avvQqgZRXAW3qjneKVF9f8PudH8mcWndKLWVzt7EUkgaolUEVGSJxOzh/hSYy8CAqNWSHVR
        +jyZtJAtPcpZzTqr3cDxvUgdXF4tJl9ZYA4ercmmU6q3qFQqOlmTolGrqEjpp31xeTJSz9q4
        Axxn4awLuTBikbwM7Riu2f20bc37PYN9WZor/l3ZkRn+elH/dH7u1/gp+kJV2LMH3T0b+gn1
        Oj7wriP26WZbpqts21DVifSAI+ZK8sbbt789fh57LfeF72Da/krsvnoipuzN0LcfSbgBM7a8
        VT/2yn3i8sXvJJNvrveoBiOavrTr/R/HHXsb6z0zA1wkJeKLWGU8ZuXZP8Jd4oV8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSvG7Zvaw4gyNtkhZz1q9hs5jYr2nR
        vXkmo0Xv+1dMFpd3zWGzuLfmP6vFv0m1Fr9/zGFz4PDYOesuu8eCTaUem1doeWz6NInd48SM
        3ywefVtWMXpsPl3t8XmTXABHFJdNSmpOZllqkb5dAlfG3r3SBbdZKla/PMbewHibuYuRg0NC
        wETi+/LSLkYuDiGB3YwS964fYOti5ASKy0i8Of+UBaJGWOLw4WKImq+MEp3dZ8Bq2AS0Jd4v
        mMQKUiMiEC4xdXsFSJhZoFLi3+1brCC2sICZxMkdG1hAbBYBVYlljycygdi8ArYSS98sZYQY
        Ly+x8D/zBEaeBYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgkNLS3MH4+Ul8YcY
        BTgYlXh4DcSy4oRYE8uKK3MPMUpwMCuJ8MbLp8cJ8aYkVlalFuXHF5XmpBYfYpTmYFES532a
        dyxSSCA9sSQ1OzW1ILUIJsvEwSnVwDjtgeeumvl8x99tCznaX3dSp2/7vLbV77us6oV+dlqk
        rGf7LKTkUDl7hqyburPEJC6pd7JGb5qKT5289qf5kUh4zdklcvMZmGybdq2uOn5quejzjDwX
        84/TT7ItuzKhovlohuDy2TvrU4WXXe7sr2Pc+Srucf1Ga2t9RXOZNwfm/gwrsjm37pESS3FG
        oqEWc1FxIgDrFCZ8KQIAAA==
X-CMS-MailID: 20200313011430epcas1p423b939dea080fda77a2e0fe3f6531489
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200313011430epcas1p423b939dea080fda77a2e0fe3f6531489
References: <CGME20200313011430epcas1p423b939dea080fda77a2e0fe3f6531489@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create mmap trace file and add trace point of vm_unmapped_area.

To include mmap trace, remove inline of vm_unmapped_area and move code
to mmap.c. There is no logical change.

Jaewon Kim (2):
  mmap: remove inline of vm_unmapped_area
  mm: mmap: add trace point of vm_unmapped_area

 include/linux/mm.h          | 21 +-----------------
 include/trace/events/mmap.h | 52 +++++++++++++++++++++++++++++++++++++++++++++
 mm/mmap.c                   | 24 +++++++++++++++++++++
 3 files changed, 77 insertions(+), 20 deletions(-)
 create mode 100644 include/trace/events/mmap.h

-- 
2.13.7

