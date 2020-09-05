Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61B2C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 20:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1CA20760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 20:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Q+F3ABzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgIEUpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 16:45:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:55085 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbgIEUoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 16:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599338649;
        bh=Be/pWWRCdG9k6oAZQXTcja1Tc2WaPrzbgsSdvaLxfZ4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Q+F3ABzxf6onrrkrNJBPuXNu0dHuu9JfTv44cr3smoCoqnowKl48cJP03RfzrOOgV
         W4NVpd2hjTXwrX9EEkoZAaocaQdV6foAoBm/Vx4baoGrLkHw1eoYcT5xjH8psHIz33
         gM07c/GiOEtF8MWNhGf6Ef9XereN855HQXghhVyE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof5H-1ktzCz3e93-00p6n5; Sat, 05
 Sep 2020 22:44:09 +0200
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
Subject: [PATCH v2 2/2] docs: ubifs-authentication: Add a top-level heading
Date:   Sat,  5 Sep 2020 22:43:26 +0200
Message-Id: <20200905204326.1378339-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905204326.1378339-1-j.neuschaefer@gmx.net>
References: <20200905204326.1378339-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JCZ9dogxu6N+RKhbMPfW1OC69oFNA7oU53WsieXUXkqlBdaEgxw
 hYf9C8XKUtNhM+adsNx2AyU1FWtSjEi+tJO0PI+5RcAUrSnXgUcPBfYmjkkpKs9VgnoA3kc
 CoWDSA6KjQrnwq8KD1aov7dV1gi3/NoD1xAKaeeI7z5nMBrZMP9rGI03q/b5ofl6UVzBVFF
 27/UcfcBJroX8S6wxPeHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/tKJFPdbk3k=:gQcm/T0WkZ6j+W/XpL/lxc
 wV5Wkmt829NuLGiAFrCJPtKya5IXazn/hlJWwEjxSrB7oSj+BGzBXeMeX0Kg2dVEU5ZRZa+DH
 46/B2zyQFsIDjC6mYTSVv+XbMStQE3/Ani/Swt4mSu1Q8ZdMre1L0GXgJZ5SIFB8FKXp7cHmE
 5tuR81mWAFCTaEuPFedO/H8h4LSWSohFfnrDlKsDh/cfoiKjWBD13111rWMDPOos98/ZI5aXC
 k9c4cD6pzaR2biKqpiLw34T0AieqQ6v7ubNC/rDuMn8gKgA3DhGNr3RJ/1MSsCR9p+DU0KN27
 pMKNgsK6QDuI2xUJ+FVwXbIi6sFNvf+gpNeeoeYkd0jLj5590EcvV20QYcu/Qo0hACnNE46gO
 HPC3hmjS/g9BEtDi8u4vI5d6GvcC/fqwkLYRCIHekx+Bq50hDpR8nIbzMRQIWOfia119NswpZ
 VtX4RmW2KWe3pgndT1BUNx6liyQyTz3tFHpVN7JxavtuW2kLKubc3LvXnp/5zvgkuH3BJKaHx
 iDcQNKix1kD9b8mrmrkodrFB0VLRAtwgs+gzcJgK5YC0W2CND38ZwJoSAzCWIKmakm68OzSLw
 fk8PwbMFkeiQh6G8eteFm0Kjbeo88GpEgjPYDTVHvb+3Bn3vpV6P0E7qfA9SXaQb4mqilLk9h
 z3hOu9w25HnAakxUivbJblwBirV+EnXft5scev6UKtFc6qfcX5wkrqEiuzXh5fZRfC1JVWikX
 +qaUemnQ8n6yY79YA3jQ6Po+awvTuELETQXBedzzqwruDfDDA+BgJ7O7xw3khq0YB8uxbVcVv
 RpbW/O0fNL66YyeuxW6Hm17+ubi7Xj+yQ456NNoDp82/8ngxNXj11HyylOIFY8UH9lPA9obqB
 Iu6G0yf8ypjB6HZaBcLksEcxZaFFHZhsDM7IG7qzi73qgBRvtLkB5CSAlD17J1weAjBImuEPO
 qal/sV5wFVkJbl7oFPlXqjKm3W0xgdx2vXcvLqTOWyNRcdr3F9tEZHTT0PBM/RYSepem9+Z1D
 iD0QHnkIvNRl8NHlKc4pUaM8Wj1YWRZC8VZfSx5dvwB9DSki+HPR83EJOOEXj8dmvOrDLK8DC
 QhPCvhpyLBzZ/hiPA58ih8/JsoromNyNTGg/EVT07WoBemWtiIOP2ixTR1G+qnM3EdaDIG/oT
 KoM8aXAkbdj9zmxOdXk5tmMEzcmKAEBDMXvh55D+H4WrM8j/NIHVEjiXt3NcccQuDs8lQqI8K
 kIdSIiTFQitcFOpHSs0AK3unodCkOrvKIeNTv5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prevents the chapter headings from showing up in the table of
contents in filesystems/index.html.

Note that I didn't pick "UBIFS Authentication" as the document title,
because there is a chapter of the same name, and Sphinx complains about
multiple headings with the same name:

  /.../Documentation/filesystems/ubifs-authentication.rst:207:
  WARNING: duplicate label filesystems/ubifs-authentication:ubifs
  authentication, other instance in
  /.../Documentation/filesystems/ubifs-authentication.rst

Remove the :orphan: tag, as the document has been included into the
toctree.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/filesystems/ubifs-authentication.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/ubifs-authentication.rst b/Document=
ation/filesystems/ubifs-authentication.rst
index 1f39c8cea7029..5210aed2afbc3 100644
=2D-- a/Documentation/filesystems/ubifs-authentication.rst
+++ b/Documentation/filesystems/ubifs-authentication.rst
@@ -1,11 +1,13 @@
 .. SPDX-License-Identifier: GPL-2.0

-:orphan:
-
 .. UBIFS Authentication
 .. sigma star gmbh
 .. 2018

+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+UBIFS Authentication Support
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
 Introduction
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=2D-
2.28.0

