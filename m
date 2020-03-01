Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69437C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AF2214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YNfHlNzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCAL2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 06:28:04 -0500
Received: from mout.gmx.net ([212.227.15.18]:37991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCAL2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 06:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583062077;
        bh=V9x9/p4WG/rpKs5F6o0VBgzej0iOeoMBXQKJZLNIEZo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=YNfHlNzJqwlDO4gtQCByWENu6ln//dfNmwZKULYsz81QA9Mb2djvtPu42sM3MwHgL
         OykMm6e3LIa5bIHCHvE+EUeuEI8nfzwW1i7ZX+tJkMbquY/98X5e8MPH8qH7F6vu6t
         VVQZLSlbJqMWse9QUV098Pu1mc+Iw4UNTXtdiC8Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MhlKs-1jd0g91cGW-00dmcJ; Sun, 01 Mar 2020 12:27:57 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Declare a few variables as __read_mostly
Date:   Sun,  1 Mar 2020 12:26:20 +0100
Message-Id: <20200301112620.7892-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6zcR7mN64S3xMLCbw+qN3jYVCShMX++6wg11VIG/bxYpBsi0lBJ
 CpRu5JBo9VkU6u6WIZifE3HJAPY9Sw7f1jd3KbnUcFPZVxHkb8u8RCyN0gq+JpwUyPKa8R/
 q6hoYIEc+zI8NlYjRXjFiuqgAh+CA/eH1BqCAgBJ0DQYoNIjIy7pgWwXp3ZJyFGRCcN6sAe
 cBBYTv0g/rFV0bGBgpF/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:be5gT6ui9+A=:XF3Vb+ywqgWTD6t6G+DTrn
 XJ7O1AkjNXAAEAotCiONIMKDdK+t3Fq8oSZJAcPfbGRmdaMVPFmIPtj0+M+m4t49h20rtBu8K
 GY2BG70bDOq/RKuNnmypziUN9rDS2jQxEtvL8Xzek5BmtBcC3eqM4PZ4raIGi/ce9Xwt2erE1
 iKkXWfcXjx/+nVLltIr4Eiv7mqYBpAJyQx2qnK1F0qoY9Vi5aLScsZg+Dd4TVlf2BtxP/c+D5
 Qq0rf486n6l9IxbSsHvfhMxTg3Mjmd42wGMPit64HLPRt6ShqYM/VR88tvIFOMPOlIEtEFl3H
 eiC1ilAvuV1KwyHGIT22BLJNZW49JqkjI5eyi2odJPZR/wSk+G/ICwrzGfqcoC7ULp5droYM9
 9oWKBaH3TgClNMVvgpylvI9/6efY/zyqj0XUymAjPB7FKQp3bhaLTF5yV5N5h91A3crkcM/xg
 DvtGjyK5nFOILJySTZA7v76aZs+FcfNYGATfVbJM22MjSw0gpd1tokpHmla7lXxMIp3kqRyjw
 qHiNAV+e2SxEY1JFAAb+h4hLqvOX6aVQeBugsSUmjDzS0B5OHUGeOWjKSkbunjJRUC1xNj8xz
 LNiz5nVoIjcdSra4YVc/iKzFBYwwzMsum8ujHViwiFjbN0eaL95xOkxh2WCDkHXTgwWeA08DG
 CM4KjUJEIiNCBupRQya++lUVlSLh/8KJQp1LPG/82DhbhAIMN98x1QvVygsfM5FEBMnDYi0Jo
 iFNacHKq92n/7RKAjbQ7WGE9LdZrxyZ029uQ4pI4X8X/Et2Joefhvx6sxOJ/CAs9TwmmyQeGg
 vNKxxyS+ecMA5HYBfl8G+2LyiGGLAVGHG37XQj2y1FvOFURllM5IUNY+xUx7xdBBLrjrl9aeS
 piOTpK2i6onKAQZGc2NjPBP+77eBDz2gvfK1gLyJ8jcHTIv2jevYBUIsxI0cBXoGMB7N7BnMs
 Wd/DafTbjZJM8auFPdeDHt9duBdBHQLozUZxKqCjWEDNr01Lu9ISYDXwVRzHrpQ7icT5wjbsR
 cyrZNq94YZ3qmCQmK9vG3LZifxfAjDTcQ8Yh4ARaXHVU+6q+Bl3bfkjGHig5I84tOZWDgbjaq
 C4rnHjEnpNSwbl0lT/XDbygQB9VA3igrJIBmbcjcafUBk12fpTGzwLWmj3U2yGuC9awz3NlJ/
 ojeaPylbZ+MU4+4aE6T9BMAY1eJ2B1o/mtPNkMxuQwRRXJBzVnosdmXQeTRzND8D8yzi73o0b
 cXKpGja6mYP7hcHDq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These include module parameters.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/main_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/ma=
in_usb.c
index 5e48b3ddb94c..701300202b21 100644
=2D-- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -49,12 +49,12 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION(DEVICE_FULL_DRV_NAM);

 #define RX_DESC_DEF0 64
-static int vnt_rx_buffers =3D RX_DESC_DEF0;
+static int __read_mostly vnt_rx_buffers =3D RX_DESC_DEF0;
 module_param_named(rx_buffers, vnt_rx_buffers, int, 0644);
 MODULE_PARM_DESC(rx_buffers, "Number of receive usb rx buffers");

 #define TX_DESC_DEF0 64
-static int vnt_tx_buffers =3D TX_DESC_DEF0;
+static int __read_mostly vnt_tx_buffers =3D TX_DESC_DEF0;
 module_param_named(tx_buffers, vnt_tx_buffers, int, 0644);
 MODULE_PARM_DESC(tx_buffers, "Number of receive usb tx buffers");

=2D-
2.20.1

