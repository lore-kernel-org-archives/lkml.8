Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA99C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D8220789
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cedTZliE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgHQOr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:47:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:57109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHQOr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597675629;
        bh=FnwjLb22HUjp4PiOi6cF+kfYG76GZvZBzJAczuehRww=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=cedTZliEc18ZJfFPybnXAsobtDOWTL3RDTuDbm+3oN97l3BcMo7qKpzaYfmW74yKf
         W8zCiRMevJlxWeJeU7aTxTzrjr9Rbh8IKKI4h8vufuBzU3ffGDKVngJ7k7H3UV9Zm/
         LwwjaMa5EVLsjzGiqOl0RIp47QijLhZu7Bi04WF8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.148.252] ([217.61.148.252]) by web-mail.gmx.net
 (3c-app-gmx-bs07.server.lan [172.19.170.56]) (via HTTP); Mon, 17 Aug 2020
 16:47:09 +0200
MIME-Version: 1.0
Message-ID: <trinity-e15639c2-d077-4b70-b351-a5888543688c-1597675629284@3c-app-gmx-bs07>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [BUG] 5.9-rc1 broken bootup on mt7622/mt7623
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Aug 2020 16:47:09 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:Uq7mLMyk43jr1rVK0kpxDBhpMc+pJWcLVpnPUgo3ueusQMCuuwclCv9XQzxpBR2pqI5HB
 85o+2UHPoMDBer/aPyhiiMaYCd4o0uMIpMLPmwNg/FMwlOUl/yHFUvofQN3oXQuCGaz3Q+dwtXiy
 m5OgIkfcjxEtc7Cqlv+hDWb/JMdY+XlUL5PWdFdqTxN7+y3crWpbSCOHXqbpfCHPe4StgMZ5mJlj
 7H5kXDeBFWvPuN99OyDNDVGBGDn9GjrB+oiyca+fZO6nvaLhh93p2uBdL2bYoDyrb5cewoz6BRjo
 Gk=
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Q3PhC+mkas=:eJvGHVPPOQUkGU1Vqi6V4r
 DG3rH+cA/7BbdW9QDP+BwchdiKhzJgUtXlCHJ6slvPG7rC9cnyz4BtQur8cPPgKc/+PeBRECp
 5KyJ1ne8KJWLxD/vj9dvzckcDqKoXY/Kk9yTXa5UWShpV69gaZ+QPMdfPPbbkbyI7O3BwzpiR
 Ge8IoGhvU4axT89aaPzoR2AVxtLDEG6La5muF8UTpVwHjJ39h3SZCOGwB6m74IUVW4SxSXnrJ
 oSsPTZ9V9mMgQjDpgp9fUS2CcyX3EW2CQyRgfci0tPHpgXtrb6TX4X6ttSxRO3dUFN150T2s4
 v9CgxY4k/fGAmxopec+uuJGJbfzg+VbIg5XWoN2l2Yd62OF6qCFpZxQT5lYYrr6GzXmu50QOb
 qDeHj/4vJ14Cij12WwlAgr8WF+odXunxU7/KHqzkAs3qZPCBgGq2v837X3Zabohfr1Yv7n8/m
 KRZ2QWpyBYxYgYO7p8blhusEIaZ+365ONUv1Xwzh5PAMYWWstd+BLIgINs4TEdekX+IQC+rtu
 res72sTc4qzG+0+rybcyV8fKYEHaUaEwdSuwbGI+XYDiMl3Rd1swA67ElMA+HvgoAEG9itiFu
 0LP8Cq4PLyLj4qmhYIbkPEjnw/gLAtEfDqZcNN6okB2KoQf2fKfr/LgIKiNA+T63vgl2JKTOR
 ZArgSsAopvil1uHpRP0CQ7hmW1Cq43U+dwf9P+cFAKFbDWZI77zqWulBPdqjpTpBSvAE=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

at least my Bananapi R2/R64 does not bootup (no output on serial console) =
with 5.9-rc1

made a bisect which points me to this commit:

commit f97dbf48ca43009e8b8bcdf07f47fc9f06149b36
Author: Saravana Kannan <saravanak@google.com>
Date:   Fri Jul 17 17:06:36 2020 -0700

    irqchip/mtk-sysirq: Convert to a platform driver

    This driver can work as a platform driver. So covert it to a platform
    driver.

    Signed-off-by: Saravana Kannan <saravanak@google.com>
    Signed-off-by: Marc Zyngier <maz@kernel.org>
    Reviewed-by: Hanks Chen <hanks.chen@mediatek.com>
    Link: https://lore.kernel.org/r/20200718000637.3632841-4-saravanak@goo=
gle.com

 drivers/irqchip/irq-mtk-sysirq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

at least on my devices i got 5.9 working by reverting the commit, will sen=
d a revert-Patch

$ git bisect log
git bisect start
# bad: [d24b5abc4640b46bb356bb5371d244866a5fe0a3] gitignore: add from 5.8 =
+ itb/mod
git bisect bad d24b5abc4640b46bb356bb5371d244866a5fe0a3
# good: [bcf876870b95592b52519ed4aafcf9d95999bc9c] Linux 5.8
git bisect good bcf876870b95592b52519ed4aafcf9d95999bc9c
# bad: [8186749621ed6b8fc42644c399e8c755a2b6f630] Merge tag 'drm-next-2020=
-08-06' of git://anongit.freedesktop.org/drm/drm
git bisect bad 8186749621ed6b8fc42644c399e8c755a2b6f630
# bad: [2324d50d051ec0f14a548e78554fb02513d6dcef] Merge tag 'docs-5.9' of =
git://git.lwn.net/linux
git bisect bad 2324d50d051ec0f14a548e78554fb02513d6dcef
# good: [92c59e126b21fd212195358a0d296e787e444087] Merge tag 'arm-defconfi=
g-5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 92c59e126b21fd212195358a0d296e787e444087
# good: [d4db4e553249eda9016fab2e363c26e52c47926f] Merge tag 'arm-newsoc-5=
.9' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good d4db4e553249eda9016fab2e363c26e52c47926f
# good: [fd76a74d940ae3d6b8b2395cd12914630c7e1739] Merge tag 'audit-pr-202=
00803' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit
git bisect good fd76a74d940ae3d6b8b2395cd12914630c7e1739
# bad: [95ffa676583b23baed40861d30b65fe31397da00] Merge branch 'parisc-5.9=
-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
git bisect bad 95ffa676583b23baed40861d30b65fe31397da00
# bad: [f8b036a7fc231fe6e8297daddee5dffdbbf2581f] Merge tag 'irq-core-2020=
-08-04' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad f8b036a7fc231fe6e8297daddee5dffdbbf2581f
# good: [4f30a60aa78410496e5ffe632a371c00f0d83a8d] Merge tag 'close-range-=
v5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
git bisect good 4f30a60aa78410496e5ffe632a371c00f0d83a8d
# good: [8d16f5b979660c0fdcfa21a418cc03f1fde60cf7] genirq: Export irq_chip=
_retrigger_hierarchy and irq_chip_set_vcpu_affinity_parent
git bisect good 8d16f5b979660c0fdcfa21a418cc03f1fde60cf7
# bad: [c9c73a05413ea4a465cae1cb3593b01b190a233f] irqchip/loongson-liointc=
: Fix misuse of gc->mask_cache
git bisect bad c9c73a05413ea4a465cae1cb3593b01b190a233f
# bad: [f97dbf48ca43009e8b8bcdf07f47fc9f06149b36] irqchip/mtk-sysirq: Conv=
ert to a platform driver
git bisect bad f97dbf48ca43009e8b8bcdf07f47fc9f06149b36
# bad: [f97dbf48ca43009e8b8bcdf07f47fc9f06149b36] irqchip/mtk-sysirq: Conv=
ert to a platform driver
git bisect bad f97dbf48ca43009e8b8bcdf07f47fc9f06149b36 //needs change fro=
m 762a21fd45e0 as build-fix
# good: [3af9571cd585efafc2facbd8dbd407317ff898cf] irqchip/gic-v4.1: Ensur=
e accessing the correct RD when writing INVALLR
git bisect good 3af9571cd585efafc2facbd8dbd407317ff898cf
# good: [f8410e626569324cfe831aaecc0504cafc12b471] irqchip: Add IRQCHIP_PL=
ATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros
git bisect good f8410e626569324cfe831aaecc0504cafc12b471
# good: [5be57099d44550d2c4cf44a86c44df87edb79a57] irqchip/qcom-pdc: Switc=
h to using IRQCHIP_PLATFORM_DRIVER helper macros
git bisect good 5be57099d44550d2c4cf44a86c44df87edb79a57
# first bad commit: [f97dbf48ca43009e8b8bcdf07f47fc9f06149b36] irqchip/mtk=
-sysirq: Convert to a platform driver

regards Frank

