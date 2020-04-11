Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59873C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3001D2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QMamHu5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgDKMvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:51:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:38889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgDKMvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586609492;
        bh=P+/BvTIcjH35iVjfgxMJNRM/IZEW2+XYyu9OfnCgY5g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=QMamHu5fxDtFfF3z/9dcjn/pHbSeAk0+WkTZZqwMnrEHZ6Xed42AKKkXAmavB46K6
         zEUs9ES7+4twBXIbzNdXXGOu8yE2ssxe8TyQmNiMaWPlxTy1is/XpRlverGWr3qtXW
         J8GjJ6hnWHecb2ySghhValLNVl/MjSk6jPGWmXqg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M26vL-1jPALq3pxB-002aPT; Sat, 11 Apr 2020 14:51:32 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: vt6656: Refactor the vnt_vt3184_init function
Date:   Sat, 11 Apr 2020 14:51:02 +0200
Message-Id: <20200411125104.9625-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UuQ0UtGMGBD59o4VJV5Zs3yYW9zRx6GV7q+pOX0p7VMKaXmWZMI
 l9z5FRQ6UezFd8tsg/CS0lwNBZW+yGUu8PMR3TeDBNKTAt9AI4/SZm2SEJKtIjDSBS23K2I
 oJHE63boNIiud9XMuisxKVlvjY7DUZvZOtEX7C/27+BnIfmg+bJaC2wtZjZ27KtQlFbte8b
 BB3Ke5zfXKM7u5aiMlUrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DDDFHtDXciw=:BJsLz2FqPiuICJT1vgj3rL
 xXU0RwJtrN+om0sb4WMKh0ACrkGPgVwJo9k37Z/pSwH5aJrs1Up0Kn1RednwsxAuOEmsJKsFu
 c7TaoNzH2sNyevGF66pjQFaT0vZ6nxh7xxe0cxGn+0EKdM01/23xVtj580UxDLFDsj+PsrHAv
 x4EQ6xmNwKUGAHyzl230mMksz4LEycTPI9vNc+TXSLm4G9uYe2EmHdjaHDUgw4odCYGYbvyM4
 oebpKt8baYxThMPRbMywpYqkflRa7Qmxb6TOcL1MxxVumQW78Vb0T1ddcUw6DwrCYSCR/ezqF
 m2yqrekRIxWvGdKzXFt3Ka+RHKUdmCtQRAG2BnmFHgQGbNbgzVGu+X/0W67RKhX6lhzG0/yuo
 uTnFgLrOFQTvAkzsLKPD0n+TCpR3qRRcWp+zOYCdheP3W131/7gJstfPfIklRVti6xX22rLVO
 Av1oq8OQWur61fcYXcy3Rg3+TB7oP+P+m2u1oh+llCcL70IteZGRf57LEUcv8gWPDfeLt4+J8
 kgKqWQNd2ytYwfI4iVVcWBIC+R1sSHBArmsG45SzynQdClKllOj0snswGjhNfdcHhRwukWRGK
 EGtfZBZp7EKDwKFCTNCowWz8a1TZV/4W1crTCpnn/TOMzVp5vhNfhjtQ6BeF+/QdJNDaOCRBX
 cZoJ4mQFg3d7uHwmeFQRvk7Com2blusni6hQsV+yMuFWxE1VtmpVS1tU4IPSNzXbR4tGBYMfk
 OSk67N/uLO4ExWRefO9KUi1bSMC1X9Sm/G6VpsT+qDJyELvx0AiFX0Iy1RTPR2FdhYJ3Gqlr1
 P13Sj4+98QGreOfTcG1pON2W5IjPKOlb7Lq6AmL0jwlwsuXCWK9OrT9nxnDIgHJKGMMcY9L8b
 cT14i4amGN046JjOD5GyHQYfHISj9IouINwdpj8OPpXhAcNR71KevIgfZyZuGKNdsasdKLqzW
 cvSDAJEIjPH1U6XEEgV6Ob1FjBPqpSiWiL0QW2jp5Aoa92j0tNRY/P7a/IOrRXuTVt7yvvBUZ
 xK0IFq6zM3nu9jizpFd75DRMp2hyQye5PSrpacBWeJcYYEz5m2WxIlAB1123TCNev2oNk224q
 IndIxAjeKrMHRkvZDZaGu5mYdihKTQYP6sLiYyYWIOU7irFq8adoYbYum6d3I85bhh+Qr4fQS
 k/Bn+1CvHMOOjsJYrML9GlGJxpZyjEoMCozGY93mzoNnD8r2iyjFRdRqFSGAXi4kstyU7bTZF
 hQ2oRbFh3hFdcXHf4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series makes a refactor of the vnt_vt3184_init function through
two patches.

The first one removes duplicate code in the if statements because
different branches are almost the same.

The second patch remove unnecessary local variable initialization.

Oscar Carter (2):
  staging: vt6656: Remove duplicate code in vnt_vt3184_init function
  staging: vt6656: Remove unnecessary local variable initialization

 drivers/staging/vt6656/baseband.c | 54 ++++++++-----------------------
 1 file changed, 13 insertions(+), 41 deletions(-)

=2D-
2.20.1

