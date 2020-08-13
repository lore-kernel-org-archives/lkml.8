Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43637C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 01:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB5E20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 01:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="loqmWX2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMB2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:28:40 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:37991 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgHMB2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 21:28:40 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200813012838epoutp042fbeed82971fc49d6ff6a084ea7ef9a9~qr5_v_kGI0336503365epoutp04Y
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:28:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200813012838epoutp042fbeed82971fc49d6ff6a084ea7ef9a9~qr5_v_kGI0336503365epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597282118;
        bh=mcUxxV3dAIau4GRPJWDThSa0iYsiNlZ8SxzqqAUzmsE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=loqmWX2ELfddHT7GLK3rhejxS1K6Q/vfF80hpogKvkK2Y+rPwt64t4XDwO6BVoXB3
         J6NhIs3rHXsP+ItvcKCrQGNnPjhgtggZaTDcRMk2LTpTzBJHE93I/SbV+y4jESRHDr
         AozA3TAu310XrHQztFrp5SCMTFAOOy7cVkemWrGM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200813012837epcas1p15ea9d4a74ca0c3a777b0f3ba52197eac~qr5_SJn4-0053400534epcas1p1F;
        Thu, 13 Aug 2020 01:28:37 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BRpqm4p1GzMqYlv; Thu, 13 Aug
        2020 01:28:36 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.9E.28581.347943F5; Thu, 13 Aug 2020 10:28:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200813012834epcas1p2ca9a4e0f74353f7f3359a46b5acc5e39~qr57mj4XQ2480424804epcas1p2z;
        Thu, 13 Aug 2020 01:28:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200813012834epsmtrp191676a049a699546e880dea78a535ca4~qr57l7ugx0054900549epsmtrp1T;
        Thu, 13 Aug 2020 01:28:34 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-38-5f3497433cc5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.E0.08382.247943F5; Thu, 13 Aug 2020 10:28:34 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200813012834epsmtip14308fc1cbbe10feadbf539e1d98a7fb9~qr57cwEOb0753207532epsmtip1h;
        Thu, 13 Aug 2020 01:28:34 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] exfat update for 5.9-rc1
Date:   Thu, 13 Aug 2020 10:28:34 +0900
Message-ID: <000001d67111$0fc882f0$2f5988d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdZwbbLDTFjjj9dGQe2aT3FnLiDp/g==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmvq7zdJN4g45+bovLu+awWTzqe8vu
        wORxYsZvFo/Pm+QCmKJybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1Nt
        lVx8AnTdMnOAxisplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS
        9ZLzc60MDQyMTIEqE3IyZk4/yl7wmrdi+8J+lgbGFdxdjJwcEgImEk/2LWLtYuTiEBLYwShx
        8vUHZgjnE6PE+74pbBDON0aJH2cesMG0zDsxASqxl1Givf8NC4TzklHi7f8mZpAqNgFdiX9/
        9gNVcXCICJhJfFviCGIyCyhJXD0lB2IKC+hI7FolD2KyCKhKbG93AunjFbCUeDd/KjOELShx
        cuYTFhCbWUBeYvvbOcwQFyhI/Hy6jBVitp7EnWYNiBIRidmdbVAl+9glPj4Sh7BdJD7svMsC
        YQtLvDq+hR3ClpJ42d/GDjJGQqBa4uN+qNYORokX320hbGOJm+s3sEKcrimxfpc+RFhRYufv
        uYwQW/kk3n3tYYWYwivR0SYEUaIq0XfpMBOELS3R1f4BaqmHxJOtcxgnMCrOQvLiLCQvzkLy
        yyyExQsYWVYxiqUWFOempxYbFpggR/MmRnCi07LYwTj37Qe9Q4xMHIyHGCU4mJVEeJkvG8cL
        8aYkVlalFuXHF5XmpBYfYjQFhvlEZinR5Hxgqs0riTc0NTI2NrYwMTM3MzVWEud9eEshXkgg
        PbEkNTs1tSC1CKaPiYNTqoFJ8BrHZon093Mrzhlt6qz8UXVzSkbfEe1WMbbA7QFXWd/H+LB+
        Cpr3uMVTcyqj0l79a88j1hbJWN66XR/mun3q1tO8DV9EN/vahptFt0pkmTu3/pm3J0/c/tXD
        VlNO2SCpLXs1S/P5THawnis6vyfm+emD4ne3G5cYSP69sZM1IYTxxtQ3BY6pN35fObPdjf/3
        CX7GxTv4HuUe1gw1TP/+vvlF753zEvKnjPcs07nkGtC2Jr4lhWfVp48nC35wT93XLh7086Hv
        20XsjJdE0294PA5+78bKUc1wuN3f3zPg67yQI0ufdnNVnzqV9Oi3fZ+LbMsrA+eLSb7P1Gc+
        F/WX15qbxvtk5/Qe5prDV3WUWIozEg21mIuKEwEr3pL3/QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnK7TdJN4g5vP9S0u75rDZvGo7y27
        A5PHiRm/WTw+b5ILYIrisklJzcksSy3St0vgypg5/Sh7wWveiu0L+1kaGFdwdzFyckgImEjM
        OzGBrYuRi0NIYDejxPEz15kgEtISx06cYe5i5ACyhSUOHy6GqHnOKLF78UZGkBo2AV2Jf3/2
        s4HUiAiYSXxb4ghiMgsoSVw9JQdiCgvoSOxaJQ9isgioSmxvdwLp4xWwlHg3fyozhC0ocXLm
        ExaIRj2JNojRzALyEtvfzmGGOEVB4ufTZawQa/Qk7jRrQJSISMzubGOewCg4C8mgWQiDZiEZ
        NAtJxwJGllWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMHhq6W5g3H7qg96hxiZOBgP
        MUpwMCuJ8DJfNo4X4k1JrKxKLcqPLyrNSS0+xCjNwaIkznujcGGckEB6YklqdmpqQWoRTJaJ
        g1Oqgalnm5PTlRjTtxMKFbM6vxbIn9Ds59q81fKTN4OUHqPc5KTrxs+OfjkXU6X/2Fcjv3Oa
        j9kS/f4/xmJOe7Y4xlruSN/p3/szsSjys0bY3+Nesv3+y1i3NM4V7rD+bv5oc6rKPud9E/9d
        l7gcvaNFZ4PUk92Z/i/ck97I2HU3NR++b8MYH5JT4Hp/4f3U858rrbY4Tjsx55+exI9dO2U4
        1+SEta25MbG6nX++9KqnSx8mJR/7/i88XpND86JXmNWabiExN+u1X2ZJ5/tH3gk+/H7qCaWz
        0vpTr3i6HC27eKmB9xEv3/qVgjMlKxeprPykHRh9zKz5xHGrWtnpBq/Ut69QT9e6dPq88BKx
        cy83LFRiKc5INNRiLipOBAAc/roEzgIAAA==
X-CMS-MailID: 20200813012834epcas1p2ca9a4e0f74353f7f3359a46b5acc5e39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200813012834epcas1p2ca9a4e0f74353f7f3359a46b5acc5e39
References: <CGME20200813012834epcas1p2ca9a4e0f74353f7f3359a46b5acc5e39@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v5.9-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit bcf876870b95592b52519ed4aafcf9d95999bc9c:

  Linux 5.8 (2020-08-02 14:21:45 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.9-rc1

for you to fetch changes up to 7018ec68f08249de17cb131b324d5a48e89ed898:

  exfat: retain 'VolumeFlags' properly (2020-08-12 08:31:13 +0900)

----------------------------------------------------------------
Description for this pull request:
 - Don't clear MediaFailure and VolumeDirty bit in volume flags
   if these were already set before mounting.
 - Write multiple dirty buffers at once in sync mode.
 - Remove unneeded EXFAT_SB_DIRTY bit set.

----------------------------------------------------------------
Tetsuhiro Kohada (5):
      exfat: remove EXFAT_SB_DIRTY flag
      exfat: write multiple sectors at once
      exfat: add error check when updating dir-entries
      exfat: optimize exfat_zeroed_cluster()
      exfat: retain 'VolumeFlags' properly

 fs/exfat/balloc.c    |  4 ++--
 fs/exfat/dir.c       | 32 ++++++++++++++++-------------
 fs/exfat/exfat_fs.h  | 14 ++++++-------
 fs/exfat/exfat_raw.h |  5 ++---
 fs/exfat/fatent.c    | 58 ++++++++++------------------------------------------
 fs/exfat/file.c      |  9 +++++---
 fs/exfat/inode.c     | 13 ++++++------
 fs/exfat/misc.c      | 22 ++++++++++++++++++--
 fs/exfat/namei.c     | 32 ++++++++++++++---------------
 fs/exfat/super.c     | 48 ++++++++++++++++++++++++++++---------------
 10 files changed, 121 insertions(+), 116 deletions(-)

