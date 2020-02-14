Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B2C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B63020637
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="O0QPNcYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404093AbgBNRKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:10:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:33787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403969AbgBNRKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581700221;
        bh=CB/jvaWBo96vvElchO6vbMU7pp5SiakOX2WgI/elrxk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=O0QPNcYMf9/jcYQiUS409ypfz/BZ+HF0rILIl+sIkBkCfminnZtP7Hn40wYthVPRX
         d63D93syYuoWotMpUTtHopYEbBLdveoFFyYPt5ivOapbJZADVjQ8XZViUoNKOdBeIn
         DCHuhHcFM0itwQeSAOlvU5+wtzkD1BQJuG06/OmA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.12]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLQxX-1ikiDu22Lr-00IVH5; Fri, 14
 Feb 2020 18:10:21 +0100
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 3/4] docs: filesystems: link ubifs-authentication.rst
Date:   Fri, 14 Feb 2020 18:08:06 +0100
Message-Id: <20200214170833.25803-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214170833.25803-1-j.neuschaefer@gmx.net>
References: <20200214170833.25803-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d1I+0xGCOx6MEU/g2PFkawbvdBMkXnvhQ+wTl+mYXvNW3XQ9N2T
 ieKNrz4Uw0FUXq5zE+W2x6h/Y1BF9oJiL8cXw4Zxm5MCR+r91juS7OPfLGOV9wIm/0ue+L9
 uOVC148/lbb2CTSIqbOExKZgvQNtNKsmkGShJcSP/IGxR4FCLu+F9ZoqRaHmt1wSZWOZe/K
 pvc+JAfttZsxsFE0CeDNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hbJyRwaE8dU=:iz6hKUflA5q8GHIHUyAt8R
 DusWTtnjhdhTYEsuoQl7gMREyyS3I284UGK54dICTtMA16hD0av37Shw15NrVjigw10wbEKR5
 Sw5JKfImwlDk/F4Jz9iat3YKZwfsN/HW4AkTapSxlkA+jsy25FeLupoUwKZ2UjVGelFQKQjes
 GO7h/cFGji1nH91dbvjbJ1SAyDyodQHy3r9pqXFXF4AQG6sxXKmtEHVKb74qJzv1fRvJFvoT8
 trM6pU1eiCM/l4GFh+qu+B8TECWSshUnCrIMvR38EtxE6r8TuqfYFL3rlNGh9bay+spy144sF
 NsDzM4aLEB1oj6wExmH+0feZ/a/qMLbgtk4TYJY+21DEz0YhIypocvm0emB1/6oqfMaScgrbJ
 eMFN8zLanMjGZtDxLI4/i+z4ngwMRuyDVebiyAT5nmqI//L73VVxzXV2SRqdGP0wSLmjxt6NE
 giCI1ArkOy9RwQvT8zaEYCoiAzzSDnk55abyHIqEz/ekXW4uldC4MomZ5wLx3XvZWTJbfPajY
 TeMsmIwmnA3aJYUdIx78C5feBof1HG3OKRpym5X4ecCJ5TDeeDBM4np1ceO8MFPwyDSSmhfxX
 et4pEh0MehKvNRrcTTOeO90ER1ApjP3Twqawrjw5PX4l1Cs8oEH5oqtnFSkFOi5BMh47qt7NX
 oq0j9Mvxfqf7yBwGe6pq79bqf/jQTWlCmTCRBzF6CJpDCJo1NQt5aiXyQvrPcV9x3/VavNF1F
 8q2/4pIzdseTM2MROC4WzX18PXvK3yO8wS2ykIxgE52L3jtWOlbsbih52SmDdkJo+PMSrIFKN
 0foloOYtYHiblho49yKSdliMQBphu1KUUUA7EC0P3PnOq+7gruqBHsG1M7+p1eDEdoZ7BYFCr
 tMLCbUihroJ+0STQRlYeC51etmm9mBk+6ZKplBz7hCaUwMKBAi0GB88EkMCoWntY8thk191Wp
 Ai64T9TQKOFh1hb+TyGcWetfkuVFhTC3dp/BosR89HuVitbe0Jmf0jROA179+wAaq7g/ByX2N
 ItOwr5OI0D6p27ReuYRnylk4l936sU7idsoJZr16+CLOThjYKRFHpugpQzDd7N25wxYsczgOt
 I9C8/Tdqe264eE7ekaHsNxfaAHCT3t2LCqYsSdbrLrw6G2FjLzEpzhGODVmMK/yciGvM4/N2Z
 26OHOFOrVTz0I3syGlRxPUIHre/vSxyLNiwxaRI7VQNpXpcjTWv0k6C8X2Cj/fYAQOrRWnR87
 Lnl9F6oIge3C31nFP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/filesystems/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesyste=
ms/index.rst
index 386eaad008b2..ac574d521f11 100644
=2D-- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -49,5 +49,6 @@ Documentation for filesystem implementations.
    autofs
    fuse
    overlayfs
+   ubifs-authentication
    virtiofs
    vfat
=2D-
2.20.1

