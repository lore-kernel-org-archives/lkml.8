Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F60C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 18:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7DB206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 18:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="b9BK5zBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgBWSGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 13:06:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:47503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWSGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 13:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582481197;
        bh=2NFrMCPNd4HHmEBukow80ok3UEzrJ4vUNsvLNSAoUNM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=b9BK5zBOk9QKo4BvPu6JmRInBs22BMgKXNV2XKl/uXhy1uWgL4pWTLfK1egxlzI/6
         S61+oxSgdjK29Zfwa4Ncyj9Dj5BZboXMhxCAaUtToeh73115Ft5fSTjqJSTbdfO6FK
         rdaOtfMLRKOCXg4IWZY0h2vevwqdfEJXxG2hVTcM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.184]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD6W-1ja1LK3evy-00eKjS; Sun, 23
 Feb 2020 19:06:36 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-mtd@lists.infradead.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: Fix a typo ("manufecturer")
Date:   Sun, 23 Feb 2020 19:06:33 +0100
Message-Id: <20200223180634.8736-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Z5+5sy4KYL+oHikGgeU9ovylJ0mV0BYaJh75CE/JWMPWUANEEj
 1jyFlszYDOGhWnwjX2nrEbwwRsveVVgxzpVeS29DRbag5uUGww06+Nd5hY0QLC7zxIV/UlI
 xS3UUb7OI/SdmGCUjtjq7OY7CMNz8DSthUzsJkYJnMBtTDQ5v5CX5COlS2R0JyyQMWa/78T
 iLVkORXgBbDhdhZsMJ7zQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zOOz/ZTXQ5E=:/NBTSZZjrqCWLzcxrHbnve
 eBSHTRkRf9YoLh20gq/+Yi5NU8qlX+CtAHp9yYHxsTQ7H9v3KOnSm9KpUwzRPAwZOiBg8xHEP
 E9dflcIaprDZpKdbNw0V/ROw5CAhv421E54C+fxnM3K703HNttLBVnDtHKOE3zPqA71HWILgz
 2lHNFUexcP++IFB1d42La5kZo3yaOW9PztYqj4xm9gs7ztD5kqdTQUBkURiXmL8oQT7DK3iH0
 vJjFYesEkRVqLIC7CsY3J7q6ylxEngC40/+R+ccxvSogBh7tQkl91FoEYRw83Qf7NZ9FGOFq7
 D/LmpbmepaGCraGGlaM3lAE6p2vp/OL6shNgHXwQX3ekzvsfxzSGuY8ORwR7yGQpkIjg6KZmq
 l4bK+bbDv23aO6YL+shuEEOdXcK/gKYhQX68tW0iOc3MbuHhpej4SoAZr2j6Icr0OZeIBUTF8
 X681/PHyUUJk24BlU6UZRHd0Ql2hPyXkVIiVmpNIJsoFfT+vuAqnfymBJnxCXXoOkbgUAyO+F
 18K9n4IRmVXrD1FRKPBMedvvcFnbZRXVjr+/sHsQXsn+vkNUTFYD1SwMkR02JRXnYN7TD8/Nq
 XxZ/L6frz9ytC+nBapyLs7gUwmBJbc3tOLkxRtCZkSOQtgjQlrU8hQFIZMKQYAb+YcyT4H+tS
 IdKl5fZLZqUAAkvkxpdjV+QF00dmCvcjRfs6ddBFXjiJNkojUq0s5ulSiYfeztkrFB5oCn31/
 jluy9BwDYFIgkMQWOMAqKVFck87Bevde3QrUsCMb9jdJBzuW0rS6Z6/bxgZZQfiraLudK/Ntu
 bJN0rMPcDXRRCxCmJI3C/FgkeU4f7iE1MPglR5g1G5dQi2H/lCJzYnI2ZqE2I8J5XFn1DIV90
 +tRkkZkE7XrLOWL4m66/YqTXKKkluqWGpRIpk9u7DbsY5DAGVXT79o+/O8WjTjG7ovvSfwIod
 5d8a5CsCALDRcxkIzAyBCLVSxwbDqVXG/asJwAtO/RozbJLtdBFQII2pw9/gMZI3Vw58UihX2
 tf8mU/QVEWL0GQNveQALJFF8pIj4KN6s85ogQJQAfYdXdBkZfq8BWMVXHkbSi/Z5LtbnqelBb
 Fg5RZw/F6m7Hmox1rgiaaHZnGdNI58bc4NXTC+FDGdH2qt1yqzyUm6UzTqsXhquVN0qFrJjZW
 zdgD0JsrlEk/RF1LOAhHbAhZoP1jCy4wSxfDPzz73y2y3G7sW51l5WkDBrOrEt9rya0lQz61T
 GWoQLiXhUModPXlZg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/linux/mtd/rawnand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 4ab9bccfcde0..3c7c15aadcee 100644
=2D-- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1215,7 +1215,7 @@ static inline struct device_node *nand_get_flash_nod=
e(struct nand_chip *chip)
  * struct nand_flash_dev - NAND Flash Device ID Structure
  * @name: a human-readable name of the NAND chip
  * @dev_id: the device ID (the second byte of the full chip ID array)
- * @mfr_id: manufecturer ID part of the full chip ID array (refers the sa=
me
+ * @mfr_id: manufacturer ID part of the full chip ID array (refers the sa=
me
  *          memory address as ``id[0]``)
  * @dev_id: device ID part of the full chip ID array (refers the same mem=
ory
  *          address as ``id[1]``)
=2D-
2.20.1

