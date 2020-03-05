Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC3C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E2920732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kHLPFozq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCEUvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:51:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:59309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgCEUvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583441488;
        bh=7rYudHkLaPWYz1EG6XE2+tdiDV5EtkdgykUVDPUIQrg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kHLPFozql360H4pez2iNYogmkVoKmmhR73v2BUwAW8mFAtdGpvDS6rklh8MChW98P
         n06AAhtkHI+aPP/i+TjYKEik++5ULTY02Ngjdkr25D1j1qbT7yuESJKwfC1Fgv/55K
         OwIOT/AKHSIXaeVhbqnBoaLFEJtlvl4QR85Q5sX4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.153]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1jmK9l00lh-00d0g3; Thu, 05
 Mar 2020 21:51:28 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: it_IT: netdev-FAQ: Fix link to original document
Date:   Thu,  5 Mar 2020 21:51:21 +0100
Message-Id: <20200305205123.8569-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JAFLwR2jXa4Awfyyo2fmfzgSHQARdU0kgjH/ZvdO9cslYVRO+hg
 VgKzce52rnmt5tBni8r/O1NJK/P59Dfum7pGNL7+xYtyEkWmBG6HMoUncd1uVYi03YogENF
 gI1DbD6CE3AdH9Ro2uFXt88s0mQGyLbumGcC/gfcUURonUOMpa4sLwkge7np1lzLKgr48tN
 y/LnRzZipKS5KOfATUNmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T4YW+/QoZ6Y=:utr/OCfyZevLvoe7p6jTH2
 vXTS+33v/vtnwxWKqrZ8rcNltfHLHFQ8PC0x7y+MKRGBq9caEo0yJoAuTxiJWXf585jcohDBd
 O0aiREqDDSbx/L/GwMHnxZNKG/87yBjAo1ohBk6pqdseC2CJHRNKZ7arGWmCp6NQ/KgDJ9Jqg
 GBOVwgsOEeyNYxulNvuFhuQKFDkZJvZrRONSBfphmTPVVLiuVUqhlMCiZU/G8aHkTWIUqINcr
 QiAUlkT7PFWpyjCaCP6ZYWfudMgq2gpgCIkUkx4iTpQkYgWVUeSyPNHkWdBc7EZPK6euAs4U1
 egJwAbO6eVJiULLsFu7o4DXbxoI9+ryTt09I5J38GvoamhzfwmQ0OsP4EPhhxslDkBvlmDmHm
 hPrcvGaE2f67FSCTYpd7WsSjoiyBWrucJ8BpBlG9zW5T3iG8sPMX0rItAE7yx0rUYlZUJI7+K
 ga8YwXYRwyscmPa9DxsFDwsRFQ/HmRTmxmneeZDuU6CmhMkFlPRdcz8h5DchUsrxXQ25F+2FW
 v+iGQROrJjjF/zXLQLf1o24M51B0Op1T3OR7MoxY7LtVvahvnswK50/NWDQX+Tc85+z2F45tD
 SgyGPyry5HwL8fh8l0TzomSVz29gWZMShQebUW5aHKtRi8MEWSsBGFPwlqyvUy9NQaAA2Fnmf
 JO9rHVjd2E6YZw38KLRfn9PMSySGKndw6Qo11Zzi6Kg9+RjWvvozeCVqHNWTXvPqsd4/0/ZtH
 76h1twGdrksmf81aJ+gH5gAh1CJaSPjHKGOMyWqccX9gLj22E5fYFrrIh1fHfMXYi+Ln0G3EW
 3X0z0w1MOp/pGKFFxuPbDoU1320EGYp2USvRE40DbO3ZdQL/hGF0twjMbxiyGzEbOnIGwXiu2
 1foT7ee+8G6W1DFhHDgAuk83R2M89qBDLRfeoMrJ9C/RbPtsZjhdlPojIyCjLASgvdZrYwnqr
 4/2K0UQDE3+wOaKxB7+l96n5GuRTlafuKYLt7mcEk2m8HBHkWWXMfrS7lwlDPUHuVfaLTdJJG
 3xVA15OyNJCm71vfUmALAyf6lUurak9ctQiinDP1tyE0gSxryZ2B4Xd/dR7zFwP0eGxFcEuM4
 D4poEvjwl/fPVaQUAXtgGF7sqRUxaqsYN1pXQEzD7bPu8oftoYBA8593SgSmOlys8EJPb+KAi
 hNzVcbEEXXwcnKin7XlrVh6ahmuibCrKwF3FViucHRGMWFcK+l2jkg5XWplM4RGRGsEW8kS8k
 tGcStAq05ccRe7PnO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/translations/it_IT/networking/netdev-FAQ.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/it_IT/networking/netdev-FAQ.rst b/=
Documentation/translations/it_IT/networking/netdev-FAQ.rst
index 8489ead7cff1..7e2456bb7d92 100644
=2D-- a/Documentation/translations/it_IT/networking/netdev-FAQ.rst
+++ b/Documentation/translations/it_IT/networking/netdev-FAQ.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-ita.rst

-:Original: :ref:`Documentation/process/stable-kernel-rules.rst <stable_ke=
rnel_rules>`
+:Original: :ref:`Documentation/networking/netdev-FAQ.rst <netdev-FAQ>`

 .. _it_netdev-FAQ:

=2D-
2.20.1

