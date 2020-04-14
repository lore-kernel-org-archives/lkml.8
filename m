Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E69CC3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0480C20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AXMojgi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440710AbgDNPlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:41:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:34727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440647AbgDNPkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586878786;
        bh=nDJVD3AZSdIriWbccSTLZqEVGQm3QecfPNGiBjWsz6o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AXMojgi8mai/xDVdpSdtmJqNbS/L8S8/dYfL9R2K1CSIvxfWNch3jWyFx5da69mZz
         RJnloac4OCKwq9asLbDLvneU0bDVR6hJY6zxfH6gwyNbxnwMnDY/o7Xk2JkIxrz2yb
         yM4BN/W+RRvttKuwqFCyJiilXVnv74qtHckXBEtw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M26vL-1jQIPI3EC1-002aT7; Tue, 14 Apr 2020 17:39:45 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: vt6656: Remove duplicate code for the phy->service assignment
Date:   Tue, 14 Apr 2020 17:38:49 +0200
Message-Id: <20200414153849.5785-6-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414153849.5785-1-oscar.carter@gmx.com>
References: <20200414153849.5785-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DqvcGdhV5y8Y8s39nWF+VzmtqcxktmEh47LOIttz1c+qLCQDQg1
 cfV8jiNw7uEusUe9pgroliSQiI3xubV7UhjX3MTpQbFSgnytyWA5c4kLJgZVY/GLnHcKlnD
 ZfL4zDNVpqKomHGKssznseGBLiDvg2+iwXUu5BPb5WaBHXYB4wIKZjV3hZPdSdVu9YW0vR7
 yzQR0vWNSzHpi02IFC5nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3+DymnGzQ14=:9SoIDgt6GCJphG8jmZ2IuV
 Lo7xl13oKDZiPO7+dD0zspU6mBrEsODfbvDNRY70d+rAAO8AXDKRIW+Ru/tXrKboBNnKvr9ap
 fgG5R2CyzvUIWTHB1IPOpHhFl7MJw34RE2yiBNIaMDDL3DLJ2FLT74fOpkt0ubaG4c+4Jdcax
 wBOsUTZMBELSVdwieFVBVP/wMvPMkYinwU7eBpcMaNRoTSdeIkAqKmQMNUEdnDaM5Dq8ecduW
 Ax8AS9ZTM4PCdsdPdah/ssgZiKVuoVDTOdzvA2rGCotWDfU3f28n3hNFS5rYhU+0oMzrn6tM/
 yonV5imk5jEV56QMtsyEMxYUVyieDriK8DJ+qeYeZKX85fHwt5c/ijphBl2Otu7eObysxOkuI
 Nuatj0KwxxF/4ggsq5Ep1ov2+bJurf9NLNM+dgZze3Og0FGYQ1+O4TYd36SwRr7v8mvxBhvTa
 vkRAEOgm2sn5e5gcxxQ/PvXeVXcAB/mLRZRnXOP8iNWWwshTFH38AqWznfNktBac7TokW1PKc
 abP4A2/anBPJphl+qmtL6DZa8C7jGKaN41p+rM9YhrkfP3SV0HNuF5v4VvbmTiQIC02iIiXq3
 uhA87J72jju9NIh5dyB7zqncgbkKL3tSL8fvCFOiCCfmVmXdjZQVTbwFWMN4DcMzMpdKm7K6W
 9yo/9qeELCjVclsLNJwkWPHi/6vgA++l7IAPxf3ITFnRWXApCVfoR4c5//0szF6JfBkeiqOUF
 tBAlwaJJs6uZzCKVRpRtf/2ke7Sr37aNnZ31JWfxoy4dCx1JZyMeN6uIaBi2MxNA2esK5RP8b
 Bx3aw+pspX1gTqJRYBgo7UhHhay3U3EE+u5+k/U1DbSwFoWI83LLZmWlu31WJihfiREQfebWi
 DeF86WW8S4mF5uqtWc9a7qQfW2ldfwbY8UWy87kvrI9HQcJyYSRJjriuNqP5a1euyQkqa63jQ
 g9wCmIQ+92+ggNA2/3G8kJ4EY6qFUOpwj0oNKdlbBPmIGJ0RrIKp6innp0LHgL+bus3qGiTXx
 CNUS/EllOKAl2ONZ9TYzTk2BxZA6I2MAsnSlqhUV1cHuSDsBUtc8rUaY6p3eu6gk3hcScOvh9
 iPrWNB978kLaCl5yljTJoJoTKErjK3PHIF5c8BIASyy671c6ZWfbXU+GJMYHOyeJ1IKj6R0J7
 i09sq3IrPq+HehLQboWS/WgUsamFUvOF8rcauCM8W0tdhCUzUZCGd0wOj5EVBZaOafeelFvzO
 TALSnEw8QxN4GXPPF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take out the "phy->service" assignment from the if-else statement due to
it's the same for the two branches.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index 3b6f2bcf91a7..13b91d7fc6db 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -320,14 +320,13 @@ void vnt_get_phy_field(struct vnt_private *priv, u32=
 frame_length,

 	i =3D tx_rate > RATE_54M ? RATE_54M : tx_rate;
 	phy->signal =3D vnt_phy_signal[i] | mask;
+	phy->service =3D 0x00;

 	if (pkt_type =3D=3D PK_TYPE_11B) {
-		phy->service =3D 0x00;
 		if (ext_bit)
 			phy->service |=3D 0x80;
 		phy->len =3D cpu_to_le16((u16)count);
 	} else {
-		phy->service =3D 0x00;
 		phy->len =3D cpu_to_le16((u16)frame_length);
 	}
 }
=2D-
2.20.1

