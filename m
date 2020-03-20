Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C5BC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E16B2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="unUNJCRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCTF6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:58:44 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:24142 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgCTF6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 01:58:43 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200320055841epoutp0482df0bd591438f2fa446ca79d4a03dbc~97aF2oruK3063230632epoutp04Z
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 05:58:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200320055841epoutp0482df0bd591438f2fa446ca79d4a03dbc~97aF2oruK3063230632epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584683921;
        bh=WCXb5COBOSp7U5jTvqMISw1OOMK0iQ+UZw4Fd+B3gtg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=unUNJCRmFo25acYce4YgUSFW2XFHnHd7i06FtXD2oLpYmCk3/BO+YfjouLSrC9zxf
         43t98n6YuSq9R0xbF5dgmwWwohXuoMJSyBT1+se5ZqOx2fRu+6ABmFEuySdrS9LGem
         YM+yErweRXx5dJyGfJPy7yqzo+ZWP1tDxqJ9A8gY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200320055840epcas1p14ffd56d03fe6a15fc3a504cb64b4834a~97aEz0bAX3070730707epcas1p1P;
        Fri, 20 Mar 2020 05:58:40 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48kCkl6qbKzMqYkY; Fri, 20 Mar
        2020 05:58:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.32.04160.F8B547E5; Fri, 20 Mar 2020 14:58:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200320055839epcas1p26174a6a8e868127a78d24ebd95680b76~97aDhbeIo2353423534epcas1p2i;
        Fri, 20 Mar 2020 05:58:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200320055839epsmtrp12ab1a4f9b5b952f3f137fe182146bae7~97aDffy8Y2595725957epsmtrp1Y;
        Fri, 20 Mar 2020 05:58:39 +0000 (GMT)
X-AuditID: b6c32a38-297ff70000001040-3b-5e745b8ffea3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.06.04158.F8B547E5; Fri, 20 Mar 2020 14:58:39 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200320055838epsmtip10bfd4d8a9586235d6c7f8ec13b0a959c~97aDVKJfz1022510225epsmtip1O;
        Fri, 20 Mar 2020 05:58:38 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     willy@infradead.org, walken@google.com, bp@suse.de,
        akpm@linux-foundation.org, srostedt@vmware.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v3 0/2] mm: mmap: add mmap trace point
Date:   Fri, 20 Mar 2020 14:58:21 +0900
Message-Id: <20200320055823.27089-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUhTURzt7m1vb9LiMbUukmUvEmZtbs7NZ2gESj1IaFHaF7oe7rGJ+2Jv
        M/ukKFaZZi4MFUsNSZMs2IZMqX8MmVCEpVkgGkiKStvQ1peWte0V9d85557fPYd7fxgi+SJI
        wSosDsZuoU0EmsDveyaVy+qPO8oUoTY12fr4IUo21EvJ695mQNaFF3jk6EArSk49/CUgh5bn
        +eSq+xy58q0V3S2i+lsmhVS7x0l5uzMoz5JbSA03rfCpG74eQHmfn6E+eTZRobYgqhUdM+UZ
        GVrP2NMYS7lVX2Ex5BP7DuoKdGqNQilT5pI5RJqFNjP5RGGRVranwhTtR6RV0SZnVNLSLEtk
        7sqzW50OJs1oZR35BGPTm2xKhU3O0mbWaTHIy63mnUqFIksddZ4wGSMzYaFtml9dO7OCXgDT
        SA0QYRDPhg2TAbQGJGAS3A+g/+40nyNLAI7d/45w5AuAXa9fRU+w+Ig/coDTnwLo7V/kceQr
        gI0XG+P3ovh2GG53C2I4CTfCxuX3aAwjuBMGPw7HPYm4Bg7VdPJil/LxbfBpuCQmi/F82Dn1
        ncdlbYYdv+IdIN6NwtszLShXuxBGHo0LOJwIFwI+IYdT4Hy9S8gNXAIw2OwFHLkM4KSnDnAu
        FayrHUFiCQguhY8HMjl5C+xfuQO4nutg6HOtgCshhlddEs6SDi/Pfv6TuxH+XJ39gyk466vj
        xbAEL4UTvlb+TZDa8i+gHYAesJ6xsWYDwypt2f9/kgfEdy6D9IMnL4sGAY4BYq24ycWWSQR0
        FXvKPAgghhBJYpkhKon19KnTjN2qsztNDDsI1NHHa0BSksut0Q22OHRKdZZKpSKzNTkatYrY
        IG58ayqT4AbawVQyjI2x/53jYaKUC4B4kLurYCzpaDJ++Cy5vHWgJD05+I5Id9mP9f2YANfG
        V72a4mZ0UFrwouNo4PqE+7BW92b/xaw1rlCptit1jpzX+ajI3szTJwO1htG76BzWtW6xZFp9
        RJpbLXUvkoHShjb9LfOOPq+881515UjO6PlrH9S9xeSd3SdzCw9d6SX4rJFWZiB2lv4NQ4bH
        7IkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSnG5/dEmcwbsLzBZz1q9hs5jYr2nR
        vXkmo0Xv+1dMFpd3zWGzuLfmP6vF0V8vWSz+Taq1+P1jDpsDp8fOWXfZPRZsKvXYvELLY9On
        SeweJ2b8ZvHo27KK0WPz6WqPz5vkPN7Nf8sWwBnFZZOSmpNZllqkb5fAlfHl6Xv2gkcsFT1P
        f7M1MD5i7mLk4JAQMJHY8SWwi5GLQ0hgN6NE849tTF2MnEBxGYk355+yQNQISxw+XAxR85VR
        4tWtG6wgNWwC2hLvF0wCs0UE8iRaNj0Es5kFKiX+3b4FZgsLmEkc7VrCBDKHRUBVYu/7MJAw
        r4CtxJJ7P5kgxstLLPzPPIGRZwEjwypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOCA
        09LawXjiRPwhRgEORiUeXoeW4jgh1sSy4srcQ4wSHMxKIry66UAh3pTEyqrUovz4otKc1OJD
        jNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjJqlvxs/7dfq/VZjc7485Xzzkln7Z/2b
        U3uGx/XgwRVCpkqli469ZXzF/1N3k2nN2g7dnalSu9meqOW4BiVFiFz9+kOgznpp7ya3TTVM
        b7ZyvprRJ30+tFem93QtZ/PTV/OnW2Qv/Hfnxof7p5feUHTOOlhwe9eEbx1ydsWfKydz/9q4
        0iboarwSS3FGoqEWc1FxIgB80Pe2NAIAAA==
X-CMS-MailID: 20200320055839epcas1p26174a6a8e868127a78d24ebd95680b76
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200320055839epcas1p26174a6a8e868127a78d24ebd95680b76
References: <CGME20200320055839epcas1p26174a6a8e868127a78d24ebd95680b76@epcas1p2.samsung.com>
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

 include/linux/mm.h          | 21 +-------------------
 include/trace/events/mmap.h | 48 +++++++++++++++++++++++++++++++++++++++++++++
 mm/mmap.c                   | 28 ++++++++++++++++++++++++--
 3 files changed, 75 insertions(+), 22 deletions(-)
 create mode 100644 include/trace/events/mmap.h

-- 
2.13.7

