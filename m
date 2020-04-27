Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83661C5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E9C206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vE6GKG3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgD0Hss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:48:48 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47667 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgD0Hsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:48:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200427074842euoutp0259426b936c2eaabb368da9a02493f21d~Jna-9_rFF3072330723euoutp02u
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:48:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200427074842euoutp0259426b936c2eaabb368da9a02493f21d~Jna-9_rFF3072330723euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587973722;
        bh=mknZsA/0FDTdTGPjnvNOmRPe3XSulv69+2PLJFu+0Xg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vE6GKG3WvE0AYOo8F6W+BKangggSShoOal0b6UOJTflcwvNk6g20TeGyoBq6VYaA/
         Mib9Oqvx00qbimuyRQzpBLTpJpTTazyDmwVV4srRpC3LVOVV+BNd+YY/AcKQDLnTBC
         SZkehxK31A7O/5pYHrwt8GvnXPCDGPk19GiG+T8Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200427074842eucas1p264ba5ffe000219575f29b012c99818d7~Jna-j0Aih0177601776eucas1p2Q;
        Mon, 27 Apr 2020 07:48:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 23.B1.60698.A5E86AE5; Mon, 27
        Apr 2020 08:48:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200427074841eucas1p10523e8e342a8fa2d7cdfb2bc4e25d485~Jna-Kc8Sv0342003420eucas1p1f;
        Mon, 27 Apr 2020 07:48:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200427074841eusmtrp1340ac1bc2bbe77ccbd6c6bebeb292812~Jna-J0pBE0061900619eusmtrp1M;
        Mon, 27 Apr 2020 07:48:41 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-fc-5ea68e5a9506
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CB.7D.08375.95E86AE5; Mon, 27
        Apr 2020 08:48:41 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200427074841eusmtip2aac658b2ba3ff637c086e8909101443f~Jna_qYR-f0786807868eusmtip2Q;
        Mon, 27 Apr 2020 07:48:41 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH RESEND 0/4] Minor WM8994 MFD/codec fixes
Date:   Mon, 27 Apr 2020 09:48:28 +0200
Message-Id: <20200427074832.22134-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTURzGOXu5uxvduG6CBwurQUJCvqDFhTIMyu4XQeiLGM6mXl9oL7ar
        lmJlSqZDpSwzzMCXdGqYa5mWmuk2NVCGbiMNZ6Zk6tAMl6JLq92u6bffOc//Oc/Dn4Nyxbf5
        vmiaKoPSqOQKKSLidQxuWo7HljXKglfnJIR9zMghKma+IoT9jgEQ02sDgFi3F3EIW1c1QrSa
        pwSEa+U9nzAt3eVHCEm9Kx8h31ZNCUhDSzFCOj72IGRl9R9AlrW3ANJl8IsWxIpOJ1GKtCxK
        E3TmsijVtGDmplcg1zsnvgnyQCFfC4QoxMOgY2Ud0QIRKsabABzvKweMIMZ/Avj0RyQruAAs
        mO3YdUxsdwNW0AFYXty55+h2qxhG8BCoXdYiDHvjMqirr+EwBi7uBtC1auAwggQn4KfJNh7D
        PPwoXBt59Y8xPByamvp5bNoh+Fzfx2XZhcBCfQDL56B1vHlnRgKdQ+0Clg/C4QclPCYM4gUA
        zlhaBeyhBEBb/mPATp2CDovbUw/1VDoG27qCGIT4WXh/0ovF/XBi2YsZ5nqwvKOSy15jsKhQ
        zL7hD6uGXuym9o9ad1qScHzDvLOSOPjrpQ7cA35Ve1E1ALQAHyqTVqZQdKiKuhZIy5V0piol
        MFGtNADPxxj+PbT2BvRuJRgBjgLpPgztbJCJ+fIsOltpBBDlSr2x2dRGmRhLkmfnUBp1vCZT
        QdFGcADlSX2w0LrFODGeIs+grlBUOqX5r3JQoW8eyLGprILauSz7Ahn1OVypJmNuOUYu5oZN
        H5mcn8LM2WPBj/RfkueSByLieWrL4MMTH+puPFEtG+u35k3DkSs6H9w9uq2wOoorp2OQ720b
        zgvqxKv5wqgloWgRnJS8Tri52Zv77B04X1p7WNDjvGS2qZ1Lzbh/KeaWOKIjGqQ8OlUeEsDV
        0PK/TznsmRQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xe7qRfcviDLadM7W4cvEQk8XUh0/Y
        LK60bmK0uP/1KKPFtysdTBaXd81hs1h75C67xef3+1ktDr9pZ3Xg9NjwuYnNY+esu+wem1Z1
        snncubaHzWP6nP+MHn1bVjF6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hs
        HmtlZKqkb2eTkpqTWZZapG+XoJdx+MUR5oKpbBXbbzxjb2BsY+1i5OSQEDCRuPF3N2MXIxeH
        kMBSRokDp34wQiRkJE5Oa4AqEpb4c62LDaLoE6PEm6/fmUESbAKGEl1vQRKcHCICCRKHlrcw
        gxQxC/xjlHj36CZYkbCAhcTN2+tZQGwWAVWJr2c2g9m8ArYSh1ccZIHYIC+xesMB5gmMPAsY
        GVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIEhuu2Yz8372C8tDH4EKMAB6MSDy/H9qVxQqyJ
        ZcWVuYcYJTiYlUR4H2UsixPiTUmsrEotyo8vKs1JLT7EaAq0fCKzlGhyPjCW8kriDU0NzS0s
        Dc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MDoVVoW+ZWhqqt9y0etl1hG+zNDp
        j22eKX0Rc7wUbRt059RMdm2BFwpKSUf3bBWfVOe90dTA6mfemTtVwUrOX0wPH+Ars3Szm26f
        vu/6pFMeRv5WhilafDv3P18isW3rIoOnqbbFSs8ClleJvezWuLBY3+uJ5cxlFVOvrO3WOdOp
        ebBFMaZUT4mlOCPRUIu5qDgRALprxGJtAgAA
X-CMS-MailID: 20200427074841eucas1p10523e8e342a8fa2d7cdfb2bc4e25d485
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200427074841eucas1p10523e8e342a8fa2d7cdfb2bc4e25d485
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200427074841eucas1p10523e8e342a8fa2d7cdfb2bc4e25d485
References: <CGME20200427074841eucas1p10523e8e342a8fa2d7cdfb2bc4e25d485@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is a resend of the minor WM8994 MFD/codec driver fixes posted in
last days of the February 2020:

https://lore.kernel.org/patchwork/project/lkml/list/?series=431296
https://lore.kernel.org/patchwork/project/lkml/list/?series=431721

I hope this time the patches will find their way to mainline.

Best regards,
Marek Szyprowski


Patch summary:

Marek Szyprowski (4):
  mfd: wm8994: Fix driver operation if loaded as modules
  mfd: wm8994: Fix unbalanced calls to regulator_bulk_disable()
  mfd: wm8994: Silence warning about supplies during deferred probe
  ASoC: wm8994: Silence warnings during deferred probe

 drivers/mfd/wm8994-core.c | 8 +++++++-
 sound/soc/codecs/wm8994.c | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.17.1

