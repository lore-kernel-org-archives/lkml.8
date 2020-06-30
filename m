Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF86EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D07220748
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Il2wPhzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgF3DFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:05:53 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21850 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgF3DFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:05:52 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200630030549epoutp03a807b3d09df2a04257a1fc98fce5cf89~dM2RacP-L2578725787epoutp03T
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:05:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200630030549epoutp03a807b3d09df2a04257a1fc98fce5cf89~dM2RacP-L2578725787epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593486349;
        bh=RM12vg22eGvbT18YzAf+yBv6C+eGBEkx3HzCNW8KJIg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Il2wPhzBDJJ5ejFp2rru/+BnSt5pm0AVFrrPeuweNLiS9FAOd2oRstg+HhPmdbAPA
         Q7kUhS1btVFd1i5Vyd2743atYTG4FKNqlLwcxzjjsw6VVi0GuhW7XdnWvzAIjdKr+b
         bzgjrz4bGOYMAGzoR8TTWbWpV1EkWYIn+qXoZrfg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200630030548epcas1p350032852c7696ab940e7acd6dff2c094~dM2QzPeSP2881228812epcas1p30;
        Tue, 30 Jun 2020 03:05:48 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49wq4C3RQVzMqYkf; Tue, 30 Jun
        2020 03:05:47 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.70.18978.90CAAFE5; Tue, 30 Jun 2020 12:05:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200630030544epcas1p255f59b5d5e2c82219c37fc5b341b1e67~dM2NHjc1a2486824868epcas1p2Y;
        Tue, 30 Jun 2020 03:05:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200630030544epsmtrp26f0fd4c259802f1fd3bcebc298d0b6c6~dM2NHA1JN2260722607epsmtrp2E;
        Tue, 30 Jun 2020 03:05:44 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-d4-5efaac09d55b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.83.08382.80CAAFE5; Tue, 30 Jun 2020 12:05:44 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200630030544epsmtip2003bab8adc7523ab13d2d3041826a204~dM2M9nQ9k3271032710epsmtip2U;
        Tue, 30 Jun 2020 03:05:44 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] exfat fixes for 5.8-rc4
Date:   Tue, 30 Jun 2020 12:05:44 +0900
Message-ID: <002f01d64e8b$586fa220$094ee660$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdZOcLCU3DZik/kMTGioqDKJNkf5LQ==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmri7nml9xBo9XqFlc3jWHzeJR31t2
        ByaPEzN+s3h83iQXwBSVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtq
        q+TiE6DrlpkDNF5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqX
        rpecn2tlaGBgZApUmZCT8XP3CeaCU7wVF/beYWxg/M3VxcjJISFgInH03F0mEFtIYAejRMvX
        1C5GLiD7E6PEvumdrBDON0aJk+u72GE6nt7sZIdI7GWUOL75CJTzklFi9ssLYFVsAroS//7s
        Z+ti5OAQETCT+LbEEcRkFlCSuHpKDqRCWEBb4mtXOyuIzSKgKvFz5hY2EJtXwFKiuf8NC4Qt
        KHFy5hMwm1lAXmL72znMEDcoSPx8ugysV0RAT6Kh5S9UjYjE7M42ZpBzJAT2sUvcfP+JFaLB
        ReLg2jMsELawxKvjW6CekZL4/G4v2JkSAtUSH/dDze9glHjx3RbCNpa4uX4DK8T5mhLrd+lD
        hBUldv6eywixlk/i3dceVogpvBIdbUIQJaoSfZcOM0HY0hJd7R+glnpI/PjZzjaBUXEWkidn
        IXlyFpJnZiEsXsDIsopRLLWgODc9tdiwwBA5pjcxgtOdlukOxolvP+gdYmTiYDzEKMHBrCTC
        e9rgV5wQb0piZVVqUX58UWlOavEhRlNgsE9klhJNzgcm3LySeENTI2NjYwsTM3MzU2MlcV5x
        mQtxQgLpiSWp2ampBalFMH1MHJxSDUybCl8e+Xx2TZjT9g2XIi8+31rFwPnKOivpu7CE45Q5
        u4NP7du9yeyfwouzv7jVizOPePcWf8/gC8ri2S+vvEB3ju2PpXEhfts/h9fr3Hqw++v7zVVV
        F+VvafpP8fokPaVRTkCaO2ueTKheTWH5/R7Tr6b77rHKPOS9FLq+V++szeq03MX7VNofHdmn
        H6ajlKIhE5W63++ycUO51pfV4gd8stZE+5zvVlO5fyZN8F1bnqye567W45X8u2bOYdjDczjI
        sjdoxbl9Xvval/gez7N23PLvgN/i+98mPq9Irfz/8ICC40eneMeiY/2L9U1MNx875ric0+w8
        G+fxy++/XEsJWm0fx1C/ncnigO7ElTuUWIozEg21mIuKEwErD5SmAAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSvC7Hml9xBhdOKVlc3jWHzeJR31t2
        ByaPEzN+s3h83iQXwBTFZZOSmpNZllqkb5fAlfFz9wnmglO8FRf23mFsYPzN1cXIySEhYCLx
        9GYnexcjF4eQwG5GiYk9M5khEtISx06cAbI5gGxhicOHiyFqnjNKnN33khGkhk1AV+Lfn/1s
        IDUiAmYS35Y4gpjMAkoSV0/JgVQIC2hLfO1qZwWxWQRUJX7O3MIGYvMKWEo0979hgbAFJU7O
        fMIC0aon0bYRbDizgLzE9rdzoI5RkPj5dBnYGBGgkoaWvywQNSISszvbmCcwCs5CMmkWwqRZ
        SCbNQtKxgJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcBBrae5g3L7qg94hRiYO
        xkOMEhzMSiK8pw1+xQnxpiRWVqUW5ccXleakFh9ilOZgURLnvVG4ME5IID2xJDU7NbUgtQgm
        y8TBKdXA5Fy3prVsfk1Kq/FnBv0GniMmkslhJ4q4hW+0HXD69rG+/smtV4/+1kR8Or9COuHJ
        1a+7BKULmio5v9/meLvrgGHHFfeazsjMI77q52/er8v/qteV2bis3CWCf41NvYL8o5zutpMb
        WWV2Md2R36vgel5Z9oqLybqbbnU//xYvPP5z5b7FkrUOkSUlGvlRxztZJltO0MjX0Cq8dolz
        t3xAViGDqPDiq7v+lqrOjeFzt5DJO33l2kvGfKfvD2tb9Geucc0vFkgSLmjtY8zyMojL+yvy
        qGm3fv+F+9zTPl4/EZp68AqPxvTC9sUPrTXcbvcoMJmb1vY3Wz6836sW/7j3a7Z49kK3uxt/
        nuZ+IKnEUpyRaKjFXFScCAC3vZq20QIAAA==
X-CMS-MailID: 20200630030544epcas1p255f59b5d5e2c82219c37fc5b341b1e67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200630030544epcas1p255f59b5d5e2c82219c37fc5b341b1e67
References: <CGME20200630030544epcas1p255f59b5d5e2c82219c37fc5b341b1e67@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat fixes pull request for v5.8-rc4. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks!

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.8-rc4

for you to fetch changes up to 5267456e953fd8c5abd8e278b1cc6a9f9027ac0a:

  exfat: flush dirty metadata in fsync (2020-06-29 17:11:18 +0900)

----------------------------------------------------------------
Description for this pull request:
  - Zero out unused characters of FileName field to avoid a complaint from some fsck tool.
  - Fix memory leak on error paths.
  - Fix unnecessary VOL_DIRTY set when calling rmdir on non-empty directory.
  - Call sync_filesystem() for read-only remount(Fix generic/452 test in xfstests)
  - Add own fsync() to flush dirty metadata.

----------------------------------------------------------------
Dan Carpenter (1):
      exfat: add missing brelse() calls on error paths

Hyeongseok.Kim (1):
      exfat: Set the unused characters of FileName field to the value 0000h

Hyunchul Lee (1):
      exfat: call sync_filesystem for read-only remount

Namjae Jeon (1):
      exfat: move setting VOL_DIRTY over exfat_remove_entries()

Sungjong Seo (1):
      exfat: flush dirty metadata in fsync

 fs/exfat/dir.c      | 12 +++++++-----
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/file.c     | 19 ++++++++++++++++++-
 fs/exfat/namei.c    | 14 +++++++++++---
 fs/exfat/super.c    | 10 ++++++++++
 5 files changed, 47 insertions(+), 9 deletions(-)

