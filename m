Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A26C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E93B2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pBqZa7n0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgAPOJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:09:21 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50622 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgAPOJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:09:17 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200116140915euoutp01b6a61f5b94216753943790eef9243af7~qY0I5luMv0568405684euoutp01C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 14:09:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200116140915euoutp01b6a61f5b94216753943790eef9243af7~qY0I5luMv0568405684euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579183755;
        bh=69xJ+NJNadV7CrxpklCC1bU+SrtNBIUwyuB6JcFUzKg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pBqZa7n0P/QI7rrAVLr+/EWjSzc27JzUOOMAuzfHvNzUhvcYTTDcYrmt1zjmfDCTI
         ZlJ8oAf5MtUUOn7WV4siC27ZIGb8HP6gLYMCT2a96Coq9Gprgf4kof8JE9mODeNZju
         3rwpP0L75B+BsPifwQG9GIEzW0pnSy6i6DTmsLyw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200116140915eucas1p1ce402d249818a74e542d46edd3bbfc43~qY0Ioo23_0528405284eucas1p1q;
        Thu, 16 Jan 2020 14:09:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CD.ED.60698.B8E602E5; Thu, 16
        Jan 2020 14:09:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200116140914eucas1p1a62794ad40589e818614176ea8e817ff~qY0IXBpYY1316013160eucas1p1P;
        Thu, 16 Jan 2020 14:09:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200116140914eusmtrp230bddac5d1bb8bd58cccd32652088fb0~qY0IWbTYr0998609986eusmtrp2O;
        Thu, 16 Jan 2020 14:09:14 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-a6-5e206e8b58bb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 18.FF.08375.A8E602E5; Thu, 16
        Jan 2020 14:09:14 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200116140914eusmtip14959d6d6b1b6d26f0aaf3a5e0380de4a~qY0H-Aj3x0112701127eusmtip1D;
        Thu, 16 Jan 2020 14:09:14 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>, b.zolnierkie@samsung.com
Subject: [PATCH 0/6] video: fbdev: controlfb: small cleanup
Date:   Thu, 16 Jan 2020 15:08:54 +0100
Message-Id: <20200116140900.26363-1-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzned3uPIU4g0+L2CxurTvHarFxxnpW
        iytf37NZnOj7wGpxedccNgdWj/vdx5k8+rasYvT4vEkugDmKyyYlNSezLLVI3y6BK+N8yymm
        gldsFWfPdTE2MB5j7WLk4JAQMJHYPSWgi5GLQ0hgBaPEynMtbBDOF0aJozdXMEM4nxklPiy4
        wdjFyAnWMWPFZSaIxHJGibk/etnhWl5/ms0GUsUmYCUxsX0VWIeIQILEiukzGEH2MQs4SjT3
        84GEhQWsJR4fXwxWwiKgKjH5xRtmEJtXwFZi18d5TBDL5CW2fvvEChEXlDg58wkLiM0MFG/e
        OhvsOgmB22wSH7b8YoVocJFoarjKDmELS7w6vgXKlpH4v3M+E0TDOkaJvx0voLq3M0osn/yP
        DaLKWuLOuV9sEJdqSqzfpQ8JJEeJp0/CIUw+iRtvBSFu4JOYtG06M0SYV6KjTQhihprEhmUb
        2GC2du1cyQxhe0g8/vEH7BohgViJszu+M09gVJiF5LNZSD6bhXDCAkbmVYziqaXFuempxcZ5
        qeV6xYm5xaV56XrJ+bmbGIEJ5PS/4193MO77k3SIUYCDUYmH90OIQpwQa2JZcWXuIUYJDmYl
        Ed6TM2TjhHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamB0
        4V+d+ulvuLHz05ikyoy/HFt887+IN8/2uaz1x7c14f7EsoI1H8wnJ9uEL5V3+b3HzFPDqH7F
        2eIVuyxqPzy8/+7V6wDtvp6qlY+UJS4ecr2ttkEzarGtY5IhVx2L1PWvsx0X3pRSKVgdG5Jd
        lryTfanPm9fnL6wLCfSfsM907qS0g1XnQl2VWIozEg21mIuKEwFnnnATHAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsVy+t/xu7pdeQpxBg+/61ncWneO1WLjjPWs
        Fle+vmezONH3gdXi8q45bA6sHve7jzN59G1ZxejxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWR
        nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsb5llNMBa/YKs6e62JsYDzG2sXIySEh
        YCIxY8Vlpi5GLg4hgaWMEosv7WTuYuQASshIHF9fBlEjLPHnWhcbRM0nRonWaTcYQRJsAlYS
        E9tXgdkiAkkSnQ0nmUFsZgFniVm3HjGB2MIC1hKPjy8Gq2ERUJWY/OINWA2vgK3Ero/zmCAW
        yEts/faJFSIuKHFy5hMWiDnyEs1bZzNPYOSbhSQ1C0lqASPTKkaR1NLi3PTcYkO94sTc4tK8
        dL3k/NxNjMDQ3Xbs5+YdjJc2Bh9iFOBgVOLhnRGkECfEmlhWXJl7iFGCg1lJhPfkDNk4Id6U
        xMqq1KL8+KLSnNTiQ4ymQMdOZJYSTc4HxlVeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS
        1OzU1ILUIpg+Jg5OqQbGrit5Qld1X1jqP9P3+C9/ImDWnIyIEmWu0p2fF4rfeVGkH7996VXh
        wNRDy+zKt51r7m+6Z113I8f1euiSwONBTT+O/HzsV2HpeOz6tmliuos/6fnm8//sS/y37e2T
        8+5B/Hq812PCq+qkP4Xl3J2tMEnvz/G9abLTNI4wHuicPEXqXOdyg+kzlViKMxINtZiLihMB
        AQf//nMCAAA=
X-CMS-MailID: 20200116140914eucas1p1a62794ad40589e818614176ea8e817ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116140914eucas1p1a62794ad40589e818614176ea8e817ff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116140914eucas1p1a62794ad40589e818614176ea8e817ff
References: <CGME20200116140914eucas1p1a62794ad40589e818614176ea8e817ff@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Small cleanup for controlfb driver:

- fix sparse warnings
- remove not working module support
- add COMPILE_TEST support
- remove redundant function prototypes

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (6):
  video: fbdev: controlfb: fix sparse warning about using incorrect type
  video: fbdev: controlfb: remove obsolete module support
  video: fbdev: controlfb: add COMPILE_TEST support
  video: fbdev: controlfb: remove function prototypes part #1
  video: fbdev: controlfb: remove function prototypes part #2
  video: fbdev: controlfb: remove function prototypes part #3

 drivers/video/fbdev/Kconfig     |   2 +-
 drivers/video/fbdev/controlfb.c | 810 +++++++++++++++-----------------
 2 files changed, 383 insertions(+), 429 deletions(-)

-- 
2.24.1

