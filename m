Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E924EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C284F206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hyGOJVtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389891AbgBNRnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:43:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:58423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389657AbgBNRn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581702189;
        bh=YD0nFl3vWsnaqqD55goqiNGiQpuyc+Q7p0W3ZhF8GAc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hyGOJVtYMdzUajW1BFxX5mCC+gi/I9kyRDiLz+4PsgtXaxY7bdZrxjbGG6gnF11+T
         NmrLVR14lphMFbFfyJFDclgC9hOb/OJwnjOuMiYtYICWaTuS19yXio6lsldMroG+3U
         CWscgUZXSlNjbakc7qc4IYKZxGg0cO/QeTWl0nMs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.12]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRQq-1iuuhN2GPk-00Tnwl; Fri, 14
 Feb 2020 18:43:09 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Harald Seiler <hws@denx.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] docs: admin-guide: edid: Clarify where to run "make"
Date:   Fri, 14 Feb 2020 18:41:35 +0100
Message-Id: <20200214174139.16101-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214174139.16101-1-j.neuschaefer@gmx.net>
References: <20200214174139.16101-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DKgAw2x+7Ddj6hriwqYIqBxjRCFrNpwXTt0CoC57L4vTp6HUO9o
 MIwJqXbuVjJFLBjzfZvQ1crfmQiDZyWAuXahgJkoRK2LCUcYjt+B9E7cwSXKHSnkI6rh5bJ
 /usDS4opbxeV25Ko3D6t8zFvLvec+VBZzN0pQuBC6xMYS9AwdAJlWCyyGIitZJOuH5n5Vtn
 qEcLyfAI+53Q9pp3bFlmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OAl7uKbfhaM=:kAu0UPlFuy368GjG4NK/qI
 T43/K/OWcc6Chj9+DynxGbxk+rc5YgAQQ9sPdhvlc/e0VdAe/RkNrzMLg0IwjVuWbmKXE0mef
 La2ntDv6ZVmKpfdk72FYQGz+RdSvDcJtpK2aO/cNqjN4YuS+wAK5ma1U57AEdU3/WsywuhGqs
 VAyDz5I3tRLYov8rVd/5SndvWN3AOfcPf8joWg0cwB5NHX+0QpqwyVUDP3ieq5+Jm0W/ceftu
 T/L3KXR3LjXVUdyeUo6nV6+i3Q4Q1dARquYtbvPSoABkt8cbAcp9bOdM0RKwHuN+nWU19b9Ry
 Wfy74bXsDR2TYM4gby8f/EqtTlik6lgaSgTc2PSFWgbVt/hCwpbzSrpvvU7ceqSUHmQgRZlEm
 v9OrZd07Xlcpg7fZPlSDX/pla1Eu4Cn46RpW14hIg3sSXKgjR7oyBjZE1Zbonx+9gS1i9qeJd
 WbIb3cntxTBb07vg+BbS2Hp8BlRLY2Dmlf54Orm+W35rFCCykBjVlfGVQ/ZQCwpO8KzBulkrq
 1PkF7pvzDLenKD8X+0TpKZ5PlhlrxpVXwM0h4htpAQZhdfF14ace0fHWDhRgWwzHo1p/aMozD
 0ofZ72k1rwJbwOpalH9OK7WD7ZT/EuZZSfQTPzVE+Uou2FgrLPg9X1odeCRPiRrdJjxNyjo6R
 yWMMyYTAfKBjQHoDqFG9K3RieTPHjgfHji7yuIBvsCPgBa7cAkDR+uxBoWC+1eVpAngQPPc19
 sgDn7RKy9usjeiZquxsDHlk86u4hnjk2b/ySz8JnxaPXvQVJAjjXXhe0LFNPHN8DBwFYAHuNi
 DHdvbWED5rkMQ0YwhDhajA6EdeC97dquz9m2BTnt9bOnnYFRTPkvJUOIYgOw5zszuPpCjLOpV
 wL8RRsMjG9/Plx5uU2yJeiG86RsOLuYlNcri+2q7kz2jJ7n48OiN+FblSQvvnYMBreUBK+lDw
 J9I9MDGT1/ZIvivYM+5M9Hquu/KxFpj/qj6mR/lAVe9S0YEN4Q/5yU/qwSRrw2ZUs/aDcqgxx
 mFXpghz6PZfLLttlSKUVfMIaGaqnRJTkISwKP2LLbwOOAeZphnU4gtWnTb5jbJ8FTeTHqZHsj
 AyGM0fGZc26dE35jCzmcn3w58bQZrKXVIxQWCkbBhFVMmstl+pcT2+ikpGckKp6aFzK7iWFYk
 UMKT5vIT1lNNH5sQPpLXktxKRWrUvgmX3sgS/juN7sOOTLvqpZgyubiLo/mjXDlxaH/VjoCBZ
 VBCyo8aZZ/J0NxMm/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both the documentation and the data files lived in
Documentation/EDID, this wasn't necessary, but both have
been moved to other directories in the meantime.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/admin-guide/edid.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/edid.rst b/Documentation/admin-guid=
e/edid.rst
index 7dc07942ceb2..80deeb21a265 100644
=2D-- a/Documentation/admin-guide/edid.rst
+++ b/Documentation/admin-guide/edid.rst
@@ -34,7 +34,7 @@ individual data for a specific misbehaving monitor, comm=
ented sources
 and a Makefile environment are given here.

 To create binary EDID and C source code files from the existing data
-material, simply type "make".
+material, simply type "make" in tools/edid/.

 If you want to create your own EDID file, copy the file 1024x768.S,
 replace the settings with your own data and add a new target to the
=2D-
2.20.1

