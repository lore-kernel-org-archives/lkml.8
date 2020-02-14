Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBFDC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB38120656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Bkddf+wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404295AbgBNRK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:10:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:50273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404029AbgBNRKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581700222;
        bh=C4bRvd+anZPjZdhrq0g5uP15WaxOlA4xkJx2cX/cwR8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Bkddf+wqkD25EPKMI3jhV0ainIMFqqsDml2mz5l4v2TAVBRTYFCnXRaD251FrPOSo
         gHNVJZ2+DAectQi8hPECL/cW8xwW3Z/ZmcA4Vya5NFli3g1x5i+E6p2odymuH9lSQN
         SX8wXWavo7p7IYIELTbhqHcqZZoZzSAiWjPmhNck=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.12]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSbx3-1iwInX26gr-00SzWk; Fri, 14
 Feb 2020 18:10:22 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-mtd@lists.infradead.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Richard Weinberger <richard@nod.at>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] docs: ubifs-authentication: fix Sphinx warning
Date:   Fri, 14 Feb 2020 18:08:07 +0100
Message-Id: <20200214170833.25803-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214170833.25803-1-j.neuschaefer@gmx.net>
References: <20200214170833.25803-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rdn58+GqlLmKn3Z54kUzJkfM2zd5RR9+vW93b7mKESA1LfJPTZm
 UahMD4MlDJVlqELtTQVqFi42/6MjWqE7NhhmYjTlzjwihF19LGkIRetM9hdAlBsO5xXYf7i
 DQTIcG44AQa6M+W8Fu0KdALWD8eiFvqimCqtgI7HGCni1yZWZ+PEYIAm9VbxhWDBz1d4/SD
 J/NEWI8jDpZa2TuF0ECTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5htk30vUBLw=:miuq7mT7OvoHijSqAWFP51
 YoAZYMQ0VM4NgA8Um6qsjCuB+aax1crdfkH0frkg0N5M2MHE0ih0HA+fIRk5b0YCjmCRnpWZ5
 WI2D/FH1gjHEfOHPOaTqhoUsgA9lbiu+ACqv4SRQYiR7zmwuvpotcojMuJ5EoEq6b1nef2kkT
 Q3QOUBBn5mltvfkxSiBsA7OFyne9gcfStfJ5ILtkAPTRnUWn3E2eE8iQac9nJHw0XhPeJzlkk
 d6pHB/d3w7kzuoahXZ4YQNTlsRVLFAJdtHg8FWDVnEBTfjm34wcmzRWCCVLZk55jjVgnFLQgV
 0n1e3gX1doV4EMozvOlEeKUod66AORDZboAEc1iGYb9Ih/0IdSOM4BvLX4j4f3OQLSs80O5R3
 z7m9c99kz9I+6EZ3U/YcFn9yg7YduEajiEn8U9veQwnLcmGkuUYPjFpMbhMgNqSB/VDS61FSW
 QkriSHoKjcuO8Bj4u1FjHCqQs1Bh9WsrAehjmtJ1PnVzDk9NwntSR8PBmZxbQUVuCUCbZS3Qz
 SzHaTFTyqGwLIkXCtGGVSlhMXMIlqFDEo+PGI/5JcQ27DZXQ2M70pyVtDGmrMMuex/hkBCk7x
 ZIL9LRVoSDqNB7CxNQBHjNzp6njkdovPOufPWcynBryWfPteuNhWldTOM0YExPa0ub9DDoARD
 //9PcDmHj3WcxrFr1LYvvLgp+MchiumvXSrKVo4yx1cHmdxi6IhsnBzMmCpb+Jdv9nmTOD2ZG
 zYEzNjetfQQdnZYslCuPvazepbhlVeEhNPolkKPVCIX5d5wYNLLA9d8/eOLxF0JeHqyKtHF6E
 yL08bcIqksW2uQOjgkCGB8P/Cjhip0+sP0JIDY5wuJ42YiV2wE10kq506menDlf65woATxxzm
 iWoqSZOK/Jc/W020devIHk3iVM9ZccYni6qH4QhvivCPCrAZvvOBRS7FEKiTRdQFuuOwHEHXX
 +SOZMF9q2VQhb5bV2gm/VWSWoBNEhOicH/NoMwSdE4Vpl8H3sSfmz9xue+tA0gYPq/onkfApr
 69SLdPOdU7p3Oeg/YtUfKO1YV+85jHZA03lAELbYyyL6qNVqfUDg2DGspNXCGs0IEDKc2TZP7
 gDkpcIWHdbR1h9CpQQ/8OKtAvWrb1Qasm4drGoGh2sh5UTti2Eg9vss1jXXXavQ5LbptRUg+h
 eslzLbtOWRZjYPP05Pga7EEwAqRPMULiKkD09eE10SsriYwhHID2VaJfz+zIr18epG8w/sGlc
 TeKe3xYWvKDltl82n
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following warning:

Documentation/filesystems/ubifs-authentication.rst:98: WARNING:
  Inline interpreted text or phrase reference start-string without end-str=
ing.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/filesystems/ubifs-authentication.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ubifs-authentication.rst b/Document=
ation/filesystems/ubifs-authentication.rst
index 12babb95a822..97f3780c2620 100644
=2D-- a/Documentation/filesystems/ubifs-authentication.rst
+++ b/Documentation/filesystems/ubifs-authentication.rst
@@ -100,7 +100,7 @@ of nodes. Eg. data nodes (`struct ubifs_data_node`) wh=
ich store chunks of file
 contents or inode nodes (`struct ubifs_ino_node`) which represent VFS ino=
des.
 Almost all types of nodes share a common header (`ubifs_ch`) containing b=
asic
 information like node type, node length, a sequence number, etc. (see
-`fs/ubifs/ubifs-media.h`in kernel source). Exceptions are entries of the =
LPT
+`fs/ubifs/ubifs-media.h` in kernel source). Exceptions are entries of the=
 LPT
 and some less important node types like padding nodes which are used to p=
ad
 unusable content at the end of LEBs.

=2D-
2.20.1

