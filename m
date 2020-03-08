Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5C7C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4528A2072A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bXv0HLMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCHVLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 17:11:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:52159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgCHVLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 17:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583701871;
        bh=LofpNAENv7DCIEUIacJYbrYEGFnYMDkwCF9jZ+0TADg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bXv0HLMGmYvHnssYw8WoDKKDCoiyt/m5nYPBA19B/U71ukiZofRP13ltq0OeK8tZ0
         hIHxecQCj84IALEyv43Lxz8Znsy7TArHopx6OdGRARp2Juth8V2KyZzy+AHtsYz96W
         3Z3A/+4BlQNwyu45D4jh2PP8fIzldepV+UeS4UfQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.212]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XU1-1jO3m21mHR-014Rfd; Sun, 08
 Mar 2020 22:11:11 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: admin-guide: binfmt-misc: Improve the title
Date:   Sun,  8 Mar 2020 22:09:34 +0100
Message-Id: <20200308210935.7273-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sqzG6iroUdTOIUoIyIhuycd5Z7WhHPrR4g5kfE58Wom1/Hjfvo6
 Qz+nkFPKrJ3K2SgcQ66ghLHvG/gDidTdxmoP3UDUhj/oovJwRey7R6B+JzwXy8tPOagvTKN
 +MOsixHjtsJzT+EnzHHH+/O3j/UqAzCqCo8ZGONogw/LbBSxBydU3kZP7Uqnau6S168kNSv
 IfrnuJyWs/7nz4lOXG7Yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iX5513HVTpU=:wd7WpNLLaFn3pg8g2cIt63
 /u4+MgFsQLPbjk8/DqGs3v6d5UkIqUmSVF9+5IoFw5HKw5BDqGXNgadxY2DgB14HxB4zDteZB
 mxRtjnNwwiRHMGDtDvVZb3TJtYE97AHv6wBAtLDnH9crvIJg4CKksLXXh2DRSDjW+3ubRuvJS
 q5rUSxA9hblnJB8pbFKE1cxLG0mJvFNW0/WbH7VjX+5zOSNDE0cKdQ/OvUjmMNToU46OLkufU
 m4kvQ2rZjFSKLM0c94LJD+IZtIzIhPHWuFWeVt9F+amkSUcQvt1cJH4Fz2BgIjnPB8RCiU6Qq
 WPPJ1sRHRRkKYchtV/6enCiiI0G4iG/sOkL/y5+gayRITxeJGCMH9hIFCk/Tv/c9qGU361eWP
 eSm05CUX44hsX6k52p0Xazpm61waXFUK3QG6OoWMn6rVr4YfM7q2QSdPHtsZLYfkTohx1a476
 S6H/Kksvuc0oAcXzv6t7Yy5YS0IKj5zNFmGdELj0RENP3H7fdkD1A6nOJ4/1dv95pIyHs13Xj
 l7zC/5T0jTuXO23pQqlP1wHQhxk2N4K0UlqrOkPK+ifIr5khFq4J7it8krDNP+ZT4XQEoz2Ee
 QwynrEdq8gZR7K024WbwOiOYR98AxqXM7rrvLP1NKBKEpxLVButadMFHlTbGpXkbnZsBCK2Aa
 ZYNf0BngLFJUcHJniZq4FfKvc5a7ZxnYr7LT2I/66n+4FtEwFAicwuP1L0onu3IGXMrOtG+g9
 hv90TVPnOQ0pvvTAx6h0rSU23l6fMrSlxm6jcrQtZOacQOtgr2XEp1AAABZc7zQzoVTAYLpp5
 0mhzeiKxxGWflqSyLbULuTOoQfbWhtwV/NxuSvvUksZA7WM02Ax5jycPe4GyUwrJltiaDWwkw
 LuZaZ3uY/w6gh0gr9KXY32wu9U8L4RKX5WAFcAnVanv3ix7Du+XT+n+klFqpKeorRYrHTm8vD
 ETHlWdvNTuR3hQzk0iYD9OOQ876aZKsQpshhBsHCKjIt38AlTAVE+IusuSIg18XGyT6IfyBgL
 Z03veKce0x+BcMceL/ovoOvd2p3f4CJbmDDZvAokgZYuyyp7MI3Imib8kKzz7wLAWIIgETTBl
 EFlK2eB5CWlUPxqTWQSZZsSOcOXzBVBUPWF9l+SuXxNpiybcgd9MtWzAcVH02wbngcp2x9uk/
 CNdDOaK1B3pvBhLvuXW7ouaZhBv7w/Kn9W9HQw4hgyIrx9jDBWg9vJyElwaeir1NTbvWoQ0Yq
 n7pMK81ZqWb1IF1BW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trim the title a bit, since it's relatively long. Add `binfmt_misc` to
make it easier to search for the feature by its common name.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/admin-guide/binfmt-misc.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/adm=
in-guide/binfmt-misc.rst
index bcdfbe39976e..82aab71ca783 100644
=2D-- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -1,5 +1,5 @@
-Kernel Support for miscellaneous (your favourite) Binary Formats v1.1
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Kernel Support for miscellaneous Binary Formats (binfmt_misc)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 This Kernel feature allows you to invoke almost (for restrictions see bel=
ow)
 every program by simply typing its name in the shell.
=2D-
2.20.1

