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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EBFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4A120637
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CSnRtHNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404220AbgBNRK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:10:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:47919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403969AbgBNRKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581700219;
        bh=eLMiagqOTLo0Fe/eUccWWaRAzlh3W3WBBNSVjdyDeUw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CSnRtHNYRCXuK+aBmFanayRkMjOeJZYH/9P92XEeHHVq1Y0cGMUpQ8Vfx+ZIL8F2H
         krlBCChypzqVYgyQjG0cSAjL6Gukxk6jEZYmbWmOrUXNe6OixPXomA/KMiHvxwza74
         NzGxB1i6m676axNAEoXCD1Q0LWqlkuOImqWJS/c8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.12]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1j6Cqd3y9F-005to1; Fri, 14
 Feb 2020 18:10:19 +0100
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
Subject: [PATCH 2/4] docs: ubifs-authentication: Add a top-level heading
Date:   Fri, 14 Feb 2020 18:08:05 +0100
Message-Id: <20200214170833.25803-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214170833.25803-1-j.neuschaefer@gmx.net>
References: <20200214170833.25803-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oxp8U1MKXiQ6HnjYqIf7xioUtO3cN711dKpnmsvNQm3K62qLzoR
 lUghIYWoTuZNFgwtwb98ByRUGrm5H75dKw5yhLeN5BbVaLqmLvGSxwHFva4gSpNuLRjXxny
 Qvnun5mHzJivOus+IShpvKvwbYVRC+R7GLZJIXSXNKDrqvw9iMbGv99qEU4GFaZbgr4V3aH
 FzGlBKMl8XK5EJfdXf/Fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tgBDfQi+c7k=:PKbXmSYEs/3x5wtfvmEl0Y
 eDBL06MIj6Hx8+nM3NxmrJiNM+Ipfy2skD46CenQimh9eety5c8l0D1z3Mbrh+kNkPQf7PJ1A
 wYoUlxJa9+4a6DNAWC9M7pl6eXAOW9/UcG1litBtbqRLfQ87tvDrBz/7uZLzVXN9XpxN2wGIQ
 FvwkPdhYYL/xGdHsh3rT80PlgpBg3MKfrwJi6+lD9925r6TneE8dlp4fQUTCU7Yh/xfR31g8x
 Gr9T9wFVyDq0qLzyUCVFYlrQj8dukZKlvU9ZlO5TyxSh3NUkQbx1JT2BFopekEtuyd8Bscs0p
 E4D43u4krmxLd9PEru/458K71Yl4y59CBUOqYFGN6LIsyBJr/aR0l6OG5ILzFeAejLBOcVOYm
 Q+2c3xbRrQ664v7q6vMWuljEXgrb7pq9Lx3HUfi8VgUHCvuHrhHzdIZ89tTznA3bVd2A3Q0Ev
 yy3sM46AwoV3eWl2HOHmaUqF/G2Q5LPq/4BROMSEj/F2cxz9Ks34TtgTlK9Fu1b/W2WPF+GCA
 bwSiiQv6ZqFKLakuwxcRV4XriHLiJUDCS46Vnt/a1ueTgWwlfM9hgNbtq5HIFCUFcwdhuBvVV
 cjNU3ZE6vt+vS7b5FMRRCPWZqeq1ShgbjzZ2XAn2UAFO4Mlw0l5xi7qXjMaHX8Nm/8IKurgJy
 j/Bjg3pvBZNtJEU2HLar1+bfO6bcHwo4mzp2T6mvcSsod1kg7FrK5ZBKt4b/aSsRA0ninHlKu
 xdttoNBWef/+hWtfyr00hiKUH/SsFOWMO0mcP7QanNrfntBCoArhwbjODW3H3a2uoWYdEl4gm
 jlO1uoZmxog84V8sP0VTMhUYQ+ukIhmEEG1OiZxPa97FHL4sxNEhznamtNwB4WLuTgYdvzdwH
 QungWdVjmW6S+dn9sexrRKy3g8BSCgElGVkUZ37+28iByuIjtz2sLHkNr+Fgyz0R57i2WwxKz
 2+t9hOKAsgWyUBjulFjfo3eVjwS/VowJwAD5QRljgOxCs7LLcZ7ZhbBubtWDrJKlibBs86bo7
 t+3LVw98XybPDRXpzyw4LFhPaEOAEw/fd/kt/0W8SddiOmkkghUPh+m0UmDGuBBWGyhU0mZxU
 LKqCJAgHovhZJp2HDU5ZqV82CSQF12mff+55tqbS+tqKHPWk5Hw/hK+BWhuCM2jWc+a/ArteX
 zvWpzpvVHkwWT3TvafyQvXYSXWW8h2VVWrgeG6kWcXRFuJ4z6YEPdhHliFCbNQmLC7ZsUkQ9X
 1tuOs5GTc25SAcUTB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two chapter headings, which otherwise both show up in the
table of contents in filesystems/index.html.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/filesystems/ubifs-authentication.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/filesystems/ubifs-authentication.rst b/Document=
ation/filesystems/ubifs-authentication.rst
index 6a9584f6ff46..12babb95a822 100644
=2D-- a/Documentation/filesystems/ubifs-authentication.rst
+++ b/Documentation/filesystems/ubifs-authentication.rst
@@ -4,6 +4,10 @@
 .. sigma star gmbh
 .. 2018

+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+UBIFS Authentication
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
 Introduction
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=2D-
2.20.1

