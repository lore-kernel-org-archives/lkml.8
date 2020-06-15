Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19656C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FCB207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JKnorHyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbgFOUkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:40:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:45953 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731104AbgFOUkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592253598;
        bh=O4SoFfD+P6gNu8VlZgxjAizLX6Qungt9AtyjgR3o4C4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JKnorHyqLmL3v+tdQHXfY/GtJZMnLcEFOiuuIxJyUy8v2lNVHTdwsp3k0eMjWJ81z
         b0UACGi8gpl+YQhp38uB3FrK1dOpwGmn5TqqDJd/QMbzDgYKrgzyN/IAFoOiT3Tw/T
         dB7MIeqt6Qv6NrzFS+iXmXC4uS/18estCPf7WUUw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([109.41.128.22]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MCbEp-1jbLWX0s9T-009jvX; Mon, 15 Jun 2020 22:39:58 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/libstub: Add libstub/random.c to the documentation tree
Date:   Mon, 15 Jun 2020 22:39:51 +0200
Message-Id: <20200615203951.11705-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gPYfHgUrMkKb/FxqSXAi2Gfz0T8iLx4le47mxNqH8s6ZSLv05Ex
 NhU4JZmGsp2NAGF+DGlMpEAEXm29ceoFdoYwqZVi1jesRyUb0Z8B5m31rQ0/MGNeYa7Hgv1
 Nvhc9sHuUh7ikx4acQylOqH1awyc2yU2vNm9VgmtFL1x8UKnsCiVe1H9xXG8UURWwF3sTRh
 ixz6FCkmYM9oCFSXjlc9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mc1KcC3e8ZA=:KBnwWp0Nmx9HCbgBpVScDw
 ZRCj3XpUTL9YQyZt/MwixoDb03ZA2QgAqbKBpy0MKRsYETqLo9lMcv1RBAIk4aDFl3nM3uzmA
 gRNJUsPPLZ1B9utb763w21VT4fp5wMC2db+1VjEJ76BaPnGrMU5RukcvrI1hOVnT08/r+tBQr
 byITsny3ryWp9F1sx6USB2PAVIweAVr7A+kk8RWFj0pRboh13/gHqgsq9SSEi24d7gNbKS792
 j6rsQXxvX6rFkbCvAqb4POYtTOyQaSle8xGSk4R9dD6YbBBFUM66NLT7AHW4nVjYAtCZG57zq
 FzUCURdnSgsHEfABS5BVdO+v4aqYn5mVnx5HelpQ7c1T0Vy4TUu/6MAvoH8A1J1px0fOYeBgG
 01HecLrZelP9ZTEQNXUbZstEUCt0YA9uoDm3Cjr+MyUPUSMTxejhKos3AGhN65jB1Kw6XELaa
 92IQo218x3tVPtV9Fd3VCp3y8fQORau6Jd70ZlxZdv12ZuRk1loXM0j3NdYFm+rXY4N4b6qd5
 RqpGNwssPGS6ao9DUppIU09B+DtQff2DlDsbSM1/mDYPeC+/nm3iuN/4VUV8j9tj5WWW3rTL7
 pKyXN4V6T3xfAsEK4ZxJy/oHFSkM9x7I/TAu+WZ33w/iOfG3RxvC3TwWKWsi9A9LTXaz/heJw
 Sbimu8PX4aPnN8zE5KmdMJqJAB3ddobeet0kUJc8FcnVLAb6SdEOocuz+q2GsKpwL1y2I3Ws4
 bHtrQUJsI1IzCY+rG+hV2ldTqBEtsXF1DY8V8Ng604DIEMX2HlW0ewBQJqrUtP9usq3uoxvEu
 J5pxNiVoJZrayDew+gjrf5AU56iA0v1NxdHLtsqD8PceoM1IwqKpXDFXOkeJFsdgNlNiPGAlv
 6XvfreRlh0tBTeEo+jn7g0aOf9S98EaJWjQdYvqe7aW7nJOdffDJjzKwQxdl0cSVWKa2LTuP/
 u+0FiqYvrF26R1GT602vo2RovnMjsptNyBcw6HFo6eQ/a7Z6s8ls6Lys9ASrpBLa0ZdzkGyiL
 6GG/zcMvenfJ1ntJe1dY0K4vN2TVV0yRsgTGYBJhnzUNntItunD+cSl1MznTdKv/Wf8C45kxQ
 Yy6nk7V2re3UVEI4jVKJUAJCcSfgS82MzXmdYrCriRlJh7BDmlb0nNvJZ/Bs92Mv7qEaMT6wN
 /Yvz3NxSOXR74bgQknKuH+WA7t+dx0PRx9wEL62QjRO35OyK8jjbmristZ4UM6xkC2A69V1gb
 XwO19laLDw6QQKn8L
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the description of the efi/libstub/random.c functions appear in the
kernel API documentation in the following chapters:

    The Linux driver implementer=E2=80=99s API guide
        Linux Firmware API
            UEFI Support
                UEFI stub library functions

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 Documentation/driver-api/firmware/efi/index.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/firmware/efi/index.rst b/Documentati=
on/driver-api/firmware/efi/index.rst
index 4fe8abba9fc6..08679962ae3b 100644
=2D-- a/Documentation/driver-api/firmware/efi/index.rst
+++ b/Documentation/driver-api/firmware/efi/index.rst
@@ -9,3 +9,7 @@ UEFI stub library functions

 .. kernel-doc:: drivers/firmware/efi/libstub/mem.c
    :internal:
+
+.. kernel-doc:: drivers/firmware/efi/libstub/random.c
+   :internal:
+
=2D-
2.27.0

