Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DB5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 01:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700732084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 01:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bkTPzQE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDIB7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 21:59:41 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:11305 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgDIB7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 21:59:41 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200409015939epoutp0274c4efa87f0e1a05391ef4fb1ec0a5b4~EBDGf1Twu0072500725epoutp02Y
        for <linux-kernel@vger.kernel.org>; Thu,  9 Apr 2020 01:59:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200409015939epoutp0274c4efa87f0e1a05391ef4fb1ec0a5b4~EBDGf1Twu0072500725epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586397579;
        bh=95fDoNRs5JGVEOP+Fb8hdUEyPdLEZ5sY0nUm6uPusfs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bkTPzQE9MBX4CKfb2bWoZtGNJhxUwXXbv5pN7wmBQyugDdT/cIQ/FD/ERHXqGhM1U
         fECF1duxtNJ35ZcK6EhEZWR5GLz2G0SOXzwMfysMf5/NUlIlvdjI5SuCzmHO3xX/74
         bOc0G0mIIzzbI/89nWKKTtfR+KmGOqXWERYcADCw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200409015939epcas1p4dfac266d53011d5d2f17b9064da575f7~EBDGBtdbC2227622276epcas1p4x;
        Thu,  9 Apr 2020 01:59:39 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48yPTk12JnzMqYks; Thu,  9 Apr
        2020 01:59:38 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.27.04648.7818E8E5; Thu,  9 Apr 2020 10:59:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200409015934epcas1p442d68b06ec7c5f3ca125c197687c2295~EBDBtQNiH2227622276epcas1p4o;
        Thu,  9 Apr 2020 01:59:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200409015934epsmtrp16beeb7cc40827301032330f40ba9ae1b~EBDBsI97R1062310623epsmtrp1c;
        Thu,  9 Apr 2020 01:59:34 +0000 (GMT)
X-AuditID: b6c32a37-1f3ff70000001228-ce-5e8e8187dd76
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.C9.04024.6818E8E5; Thu,  9 Apr 2020 10:59:34 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200409015934epsmtip28018da89fda1886b679f5d776316291a~EBDBihx-M1342013420epsmtip2l;
        Thu,  9 Apr 2020 01:59:34 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'Eric Sandeen'" <sandeen@sandeen.net>
Subject: [ANNOUNCE] exfat-utils-1.0.1 initial version released
Date:   Thu, 9 Apr 2020 10:59:34 +0900
Message-ID: <001201d60e12$8454abb0$8cfe0310$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdYODrN6wT2UdEovRMSz5jwENVzTyw==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTQLe9sS/O4OAcMYtr99+zW+zZe5LF
        4vKuOWwWrVe0HFg8ds66y+6xZfFDJo/Pm+QCmKNybDJSE1NSixRS85LzUzLz0m2VvIPjneNN
        zQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAlikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVS
        C1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEqE3Iypi+9wljQxFLR8msJawPjAuYuRk4OCQET
        ia3tDYxdjFwcQgI7GCWOPf7ODuF8YpR41byeFaRKSOAbo8TUFS4wHQsOToPq2MsocXvnTjaI
        opeMEj++uoPYbAK6Ev/+7AeLiwg4S+xqesHUxcjBwSwQJPH9iiSIKSxgJ7HxjzOIySKgItE6
        QxSkmFfAUmLhqi52CFtQ4uTMJywgNrOAvMT2t3OgblaQ+Pl0GSvEcD2Jh5d+MkLUiEjM7mxj
        BrlMQmAJm8Sb9rNMEA0uEr9fHmKHsIUlXh3fAmVLSbzsb2MHuUFCoFri436o+R2MEi++20LY
        xhI3129ghTheU2L9Ln2IsKLEzt9zodbySbz72sMKMYVXoqNNCKJEVaLv0mGoA6Qluto/QC31
        kFh0sJ19AqPiLCRPzkLy5Cwkz8xCWLyAkWUVo1hqQXFuemqxYYExcjxvYgSnQS3zHYwbzvkc
        YhTgYFTi4ZXY3xsnxJpYVlyZe4hRgoNZSYTXuwkoxJuSWFmVWpQfX1Sak1p8iNEUGAUTmaVE
        k/OBKTqvJN7Q1MjY2NjCxMzczNRYSZx36vWcOCGB9MSS1OzU1ILUIpg+Jg5OqQbG0scM63pX
        H4loYlP2lRT7x2zAU2f127w5pq420JhRfd6ft+Y35p3y60rNK5c/fOVyfQHTPs0lQuIiHcuK
        +Jbvbnr9inWHauTZ/LhE9y/TGvQe7cqueRYcNd2+XU4p/WRlTK7nLQO/Y2v7l64ue7bA7KJE
        z8Unte7iza9buK8fPPr9W/PJo/+VWIozEg21mIuKEwE5uGwlmQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSvG5bY1+cwc2lOhbX7r9nt9iz9ySL
        xeVdc9gsWq9oObB47Jx1l91jy+KHTB6fN8kFMEdx2aSk5mSWpRbp2yVwZUxfeoWxoImlouXX
        EtYGxgXMXYycHBICJhILDk5j7GLk4hAS2M0o8WfedSaIhLTEsRNngIo4gGxhicOHiyFqnjNK
        tF37wghSwyagK/Hvz342kBoRAVeJr+sCQUxmgSCJVTc0QUxhATuJjX+cQUwWARWJ1hmiIH28
        ApYSC1d1sUPYghInZz5hgWjUk2jbCDaaWUBeYvvbOVA3Kkj8fLqMFcQWASp5eOknVI2IxOzO
        NuYJjIKzkEyahTBpFpJJs5B0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERzc
        Wpo7GC8viT/EKMDBqMTDe2BPb5wQa2JZcWXuIUYJDmYlEV7vJqAQb0piZVVqUX58UWlOavEh
        RmkOFiVx3qd5xyKFBNITS1KzU1MLUotgskwcnFINjMq1sawRKzNMFD13r3faOYGtSoHxru65
        BoY77O+P21a8P63AvkfgU2n7gXsXr/Y42VbGuJ9ZxnKJc2a2GhdDvxF3Jn/W6uNis98umD6T
        YTrHGqclU2uCl8ik/3801Zh3qeHJ5HfVOoc8Djzs3BN7YXnt5XuWGemH5HIOnm5aMllglwgP
        G8/TYiWW4oxEQy3mouJEACTleBVqAgAA
X-CMS-MailID: 20200409015934epcas1p442d68b06ec7c5f3ca125c197687c2295
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200409015934epcas1p442d68b06ec7c5f3ca125c197687c2295
References: <CGME20200409015934epcas1p442d68b06ec7c5f3ca125c197687c2295@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial version(1.0.1) of exfat-utils is now available.
This is the official userspace utilities for exfat filesystem of
linux-kernel.

The major changes in this release:
  * mkfs.exfat: quick/full format support
  * mkfs.exfat: specify cluster size
  * mkfs.exfat: set volume label
  * fsck.exfat: consistency check support

The git tree is at:
      https://github.com/exfat-utils/exfat-utils

The tarballs can be found at
      https://github.com/exfat-utils/exfat-utils/releases/tag/1.0.1

