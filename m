Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88295C35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629B7206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="k/yU59rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBWRro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 12:47:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:47001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgBWRrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582480046;
        bh=rzvgOcQ5qsBRQn91ALWmbWqAn4sF6ZW7d7cETnZtxY0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=k/yU59rq8mCTnr14YJ+71QQvsmH9KJdHK/aSFWFCoYmDv3NuUX54kasrIYoTPNKhH
         mb7qoVcUO3pzK8HK5LBl8/awgHD3fXdb8VSQKJAeodKi5tsmdQ/hwDKRMFDFy6sRDq
         CnhVl+KJUJFmkULvHn8hxpbt0AphYDCdDrJhPrkE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.223]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1inY5T0hNV-00PdiW; Sun, 23
 Feb 2020 18:47:26 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: networking: phy: Rephrase paragraph for clarity
Date:   Sun, 23 Feb 2020 18:46:31 +0100
Message-Id: <20200223174631.4734-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zKGK2C4bwOlG1AfpOUpdnFSsLzAbUDIGN7XHeFEQ/dZIHv4Hd2T
 STwbnvhRna+pbqvdYoqPInOdD469y2sn8qfVoqj0tqTe0pPqd1cdB94DbybbVL45HnHs73W
 z2PfdYnLYTDusTOB+5XXC4WvGMRRH5oy5P8ZA/CBmsqNctK+JyI6Sj2Tro/P11HztThsfn3
 IG1YrZ2iZ7wvR2RNS0UCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:phgZWfuZyVM=:/s3HgYUXn8IgKwbq0wtiej
 Pl2VZKY3UrAbor0vyxJ7PEkxZWml7WYIAywxeNxobAfwjCsilj2f2h3/sph3kFeEgEkj7lqm8
 RnODVXEBHk4w+3MTRAnA6iuaduhW3v/rA5jlv9t/MEUscpeCcRJ/KQBTPTDpoQNz9jo6q/mip
 BuMjsS19ceZajXKmh/xz8XtAWvigR5O/oHGyBR5FXFAwYSNvsqDl94iYejxYcBIQ2h5l7Y5dn
 n7nfs2WKXHMbCXq/6oVwbp6aj9xrgKfbH3+PhlIagQ8YPEaGXD0O+ZD0qxG6J9Vv3E1GeK6Ah
 50aIzxMTuEu3gw6VrYZdZT5iTrumrGz+GocQwDfRGH4YLmut1SO8EJiu9/Vt9/ud68CAD1BK3
 uCoPA8ONRlnBTa/VdsgaL4PMlckl82MGz25laG39RBf/xmkbfWjEs80HsjAWaIzPXGqkIM30n
 zVTeRyvICe1m64tI1gxBGiCPH2JnTJx6vOFTcClmUx3xV94TYAu89YaV3otJEoT0jt4O6Nj/K
 Kwi12CzMOqxoQg/gs9OTlyMjJGa6QEBBDZHwSQdyNz4F/d5F7ea5PNyXhzd8YQVxwe+wPgHR3
 5mTO7W1wqjFUA47VNoUUJ4nLuF6TOSDxBLpFeUwslRoTimqH49KG2to4rx2yMLKNIC+CGzCwM
 vdXU1GR60RS7vmv2PvDNWohRGeEJuH8j0UmIswBdj8iU5b8O0+k+XahF9gx2ht/BHjItrC9gN
 erulHxREemx2vtV4h36H+KgPb3MS9RjfITitklNVNiIwbQyjWwfK+qygPg/knroZVqVIzYnam
 asalzCU6NkFLjnVknLOuE/BJk+EvagR1Y+0gp6kBbcwlwmAtqxcFT1mKmwBRehzUM2wyZm4ND
 tdrCrlRvf+QzAXTNAUyX7C3LcTEWaRNheRsgzCObWn2Hanop/b/3bU1uJK2P9I/b8Eo9MTPzA
 OuZ+BOwrw25x0WEdtJYYOVfgjRKZoQQBtKvgd3zMgfmFnAOETzDwb43BYebBC6MauC8w60Cbc
 8lKi4Q3JK/P5FFpE79QnlaC1tVPvp9wx3ACrTHEh0F3Hr96d017wHuJIbl77DfRyu2TxsMEB+
 eMhB0GyJFORP8kcs8LUpBl0LT9MSxLhS+IFoltNAHMvQ9SVzP/g4vbBQ4wzSl0E6R/SwS6NFc
 lF3gqLh7tYVmJZj1JLqMG3zCuc9DKKHr9guDhcpEMJ1ZhtppN3ooogfbn2QXUirv/QmP/0Hys
 9KmKPiWpsPChVFntD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make it a little easier to read.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/networking/phy.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/phy.rst b/Documentation/networking/p=
hy.rst
index 1e4735cc0553..256106054c8c 100644
=2D-- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -487,8 +487,9 @@ phy_register_fixup_for_id()::
 The stubs set one of the two matching criteria, and set the other one to
 match anything.

-When phy_register_fixup() or \*_for_uid()/\*_for_id() is called at module=
,
-unregister fixup and free allocate memory are required.
+When phy_register_fixup() or \*_for_uid()/\*_for_id() is called at module=
 load
+time, the module needs to unregister the fixup and free allocated memory =
when
+it's unloaded.

 Call one of following function before unloading module::

=2D-
2.20.1

