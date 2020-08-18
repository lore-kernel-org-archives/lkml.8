Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB89C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463342063A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cUDFwKwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHRFcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:32:55 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:42049 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRFcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:32:53 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200818053249epoutp039dad7c13e75fb8fe49fad0db15e9d53a~sRdnLtiwF1275712757epoutp03K
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:32:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200818053249epoutp039dad7c13e75fb8fe49fad0db15e9d53a~sRdnLtiwF1275712757epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597728769;
        bh=66kQeZByB3VnREw6Hl+ROm5Q6QIF8sAgKa2bKNZTkAA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cUDFwKwD78cqc4T0gaKUCPTNk4lA9n9hCpBvbfClc2aSwPvLEgXuA4KUGYkiGewTh
         8R8ByA62rdHKMqsliMNZIpXs3OxPFXGCeezaHN2P5ZI0YC8iiyPt3PBKDPaavLvUki
         RKDniWBpK6XeIkMM/bcd2RVdWsal7c1H9kyyaJMY=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200818053248epcas5p250cd894b5acc7a515373a4b58710eff0~sRdmFd7i01864818648epcas5p2B;
        Tue, 18 Aug 2020 05:32:48 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.6D.09475.0086B3F5; Tue, 18 Aug 2020 14:32:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200818053247epcas5p262c5fd7e207dfa5145011c4329cf239d~sRdljwzDd1442114421epcas5p2g;
        Tue, 18 Aug 2020 05:32:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200818053247epsmtrp26dd0f18a837b9ad2fbaa36b241852e5f~sRdli_BPp2759627596epsmtrp2_;
        Tue, 18 Aug 2020 05:32:47 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-65-5f3b6800a4ca
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.36.08303.FF76B3F5; Tue, 18 Aug 2020 14:32:47 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200818053246epsmtip2a23b4ff878a27fde3da047c92e58bb70~sRdj_3rPM1985219852epsmtip2R;
        Tue, 18 Aug 2020 05:32:45 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     kbusch@kernel.org, hch@lst.de, Damien.LeMoal@wdc.com,
        axboe@kernel.dk, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        johannes.thumshirn@wdc.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 0/2] enable append-emulation for ZNS
Date:   Tue, 18 Aug 2020 10:59:34 +0530
Message-Id: <20200818052936.10995-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWy7bCmpi5DhnW8wa23/Ba/p09htVh9t5/N
        orX9G5PFytVHmSz+dt1jsjj6/y2bxaRD1xgtLu+aw2Yxf9lTdosrUxYxW6x7/Z7Fgdvj/L2N
        LB6Xz5Z6bFrVyeaxeUm9x+6bDWwefVtWMXp83iTn0X6gmymAI4rLJiU1J7MstUjfLoErY8Kc
        PraCGywVJ+/sY2lgfMPcxcjJISFgIvF59w62LkYuDiGB3YwS77fdZodwPjFKvH7eDJX5zCjR
        vnomC0zLnFVToap2MUosXXSZEcJpZZL4vKEHaDAHB5uApsSFyaUgDSICsRIzLnWzgNQwCzQz
        Stw5s4wVJCEMNOn4z4tsIDaLgKrEiutPgHrZOXgFLCTmpUHskpdYveEAM0irhMAjdonv188w
        QiRcJNbd2AZlC0u8Or6FHcKWkvj8bi8bhF0s8evOUajmDkaJ6w0wH9hLXNzzlwnkTmagO9fv
        0gcJMwvwSfT+fgIWlhDglehoE4KoVpS4N+kpK4QtLvFwxhIo20Ni5e1nYCcIAb248OVupgmM
        MrMQhi5gZFzFKJlaUJybnlpsWmCcl1quV5yYW1yal66XnJ+7iRGcILS8dzA+evBB7xAjEwfj
        IUYJDmYlEd6kE+bxQrwpiZVVqUX58UWlOanFhxilOViUxHmVfpyJExJITyxJzU5NLUgtgsky
        cXBKNTCdXhc6K2KKlavb7bufrEVnW0U6iG2b9FLrw8ltGfxh2R+m6rA2xn6VU+L/+XBy/Tbu
        OrP4a+rRvX1/Xbui8t/NO9NnZtb0xaqt9q55v7vkm4+5ZW8SJTkbNU88fnl5s+KHmx9KF7Ln
        2zhJXHJ1D1m0ak1AzrRNq79m6GRfn/Epr1dM72/38pLk/eeUNl+3/vRD6LH9hIPT3c7v5S6O
        9a7lnzU/dNtTiSkdx7r3yfXeaJjuKc4h1bouQfp41ETJB9Pc9+4Oehs2wyriXM8SecXqE1/Y
        MpPnux49nslQJdGlKpvVnbS4gilR9ZNfi/LbwxbtYvNkxXTuh/hIzS/Wtto4u+SfeRtjzaTa
        vmeND5VYijMSDbWYi4oTAVvfsRB/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSvO7/dOt4gzXnNSx+T5/CarH6bj+b
        RWv7NyaLlauPMln87brHZHH0/1s2i0mHrjFaXN41h81i/rKn7BZXpixitlj3+j2LA7fH+Xsb
        WTwuny312LSqk81j85J6j903G9g8+rasYvT4vEnOo/1AN1MARxSXTUpqTmZZapG+XQJXxoQ5
        fWwFN1gqTt7Zx9LA+Ia5i5GTQ0LARGLOqqnsXYxcHEICOxglbq3fww6REJdovvYDyhaWWPnv
        OVRRM5PE2/sr2boYOTjYBDQlLkwuBakREUiWaF20lwWkhlmgnVHi+cNfLCAJYaANx39eZAOx
        WQRUJVZcfwK0mZ2DV8BCYl4axHh5idUbDjBPYORZwMiwilEytaA4Nz232LDAKC+1XK84Mbe4
        NC9dLzk/dxMjOAi1tHYw7ln1Qe8QIxMH4yFGCQ5mJRHepBPm8UK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5v85aGCckkJ5YkpqdmlqQWgSTZeLglGpgmnfty4lzDx4l3773l0cqZloWm9zn0h/H
        u7OT3lhMvDjx3cOEQ34XF2zPOSjQcWdb2hWOt6EPF1UbrYhty9RgOPutqORHnke5yh5+xs/B
        0i+fXo5Kkjr2vkUzSVhi0utVbu+Fz37vOBO2w+Bf6c7ZCzQtr+7jeZf2P/LT1Me9hiwbf9Yu
        K2KfGsdfeKM8+nhV6Kb/vN4rNt69xft5/cad38OPbPpfo3thg2PA23/FPyzap1+Z3rClOjXA
        ZS3j1tVfa0y5lly553FxglGUjWz2OgNPdr6aCb/n77UOSJARf//9dtHxh1MLM+J40s6+qU7p
        COPZLPa3+NWLz8uOxnR2/lmuxKyVMlXccqI6K4tq4GolluKMREMt5qLiRADDMAgHsQIAAA==
X-CMS-MailID: 20200818053247epcas5p262c5fd7e207dfa5145011c4329cf239d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200818053247epcas5p262c5fd7e207dfa5145011c4329cf239d
References: <CGME20200818053247epcas5p262c5fd7e207dfa5145011c4329cf239d@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently NVMe driver rejects the ZNS device if zone-append is not
supported natively.
Make it accept the device and activate append-emulation instead. This
is mostly borrowed from SCSI emulation.
The other patch enforces a zone-friendly I/O scheduler for ZNS.

Kanchan Joshi (2):
  nvme: set io-scheduler requirement for ZNS
  nvme: add emulation for zone-append

 drivers/nvme/host/core.c |  41 +++++-
 drivers/nvme/host/nvme.h |  60 ++++++++
 drivers/nvme/host/zns.c  | 307 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 399 insertions(+), 9 deletions(-)

-- 
2.17.1

