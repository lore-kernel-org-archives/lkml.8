Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B536BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F09A24649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="agqCWkLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404021AbgBNRKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:10:50 -0500
Received: from mout.gmx.net ([212.227.17.22]:60863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392184AbgBNRKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581700214;
        bh=QfMZZZE8iLkRO6Le7/kgk0wJeDUjLtxhHfOGmKp7fCw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=agqCWkLb1dEAG66G+kGI2CqpcZG4HBlJEzVK6IcHnJJWuIk1qKVe2W8rPteYdsY83
         nv7GPYEIdOmSOlJx5gqlR5wZgXrh6BxClx3yaTvQy8y2L+JDeE5SlOv3neeAABh8zO
         y9eYWfcOOVRr5puSLzhN0KS/nTeSD2L4jRr/9MO4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.12]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QFB-1j1p8F0485-001NGO; Fri, 14
 Feb 2020 18:10:14 +0100
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 1/4] MAINTAINERS: Add ubifs-authentication.rst to UBIFS
Date:   Fri, 14 Feb 2020 18:08:04 +0100
Message-Id: <20200214170833.25803-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4MCcuiTA+4OPSM3Khcu3EL2aDxPAp3zTVupIPjC90X9RQGUkVOs
 uMI+525Oc9Wtnd4Y7RZqaPb3me46yb5oYGh92ughm/Ef0GzNXL9mslena/+M5vp++nMqu0n
 yOb8j4bdQ5BeKrXbUsV5nz2n+ptNfGMleCVTiRLWw9nTSapl8gA03Q6FQUo5MzxyGYv2TEF
 l0jVAUdvAXkq7LEraBCOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3MsNYlqPH8I=:IlWg6t7ydMVoc840+QnQk+
 lx/V9JCMLQnGkjg/lldasehdjtn6/4ZJHE5kweFmd3qhJM54o19eDjEn3xFB4nAg3/OAHfsfb
 QuuqD3YuL8xXlyey1Huhulkor98HIiS2Bf/4q8rE4nUndc3kEDiMhfAk7iSdmj3GOO1gdFZ/t
 qiDRoNusmmPHTZkB7oqtelDINg6x0sY5b22YVte39ZWjM0t1MbkIZzKA+8r/VsFCRZLKyIhoI
 k56F3oOjse18f55Op8q9oLHrfH7VHODqOnvlVMfoJOQoCuc4maBRBrHEFLgcCyrz5m4cHUycC
 f3jh6TZPI1r5l/XpEr64sVi5yrHeMaLTYvJW29E2OO3OTbWvtvhY1DS369m/ZAvH6/8A6DkNU
 +52zRX2SSpM64CdFUn2lMr/wpog5xlJb/rLz3yYiF5jJVcG2U/ysPa/pryVYWPjJibl3c2HpW
 3csgZ4VANY7YJxHrviVCw54qNDrkWYUjIuz4/drVcl1fgB17fd8sxBK/ORLyBb4q8mOFLHLQe
 AHBFzCg5qdm/gf1FHrk18RuQxlcgZjuHrDbSGEoAB9BsQ46eoiBUzMWif1OtROJ83MKHATPcb
 OBaoUlp+0yrH7L8xOdmgpH5Bb8MWCVehFZXLfxZ0Mivdt2NoeWS4o9JxeO5EbsqB2FOdNOHOR
 x0KE37ANBy0m+vIvZtspCo8ZDxLfzWJFWnHfsNx11JXlMB4HjN9Uj4cxzWiUpexBSNhnO/UQy
 zLHRYQ6Z99SaWud4gqK2K0tv/mEIwF9KTnq9597IXXkJT4zuB9k2MwIkIjWN6i6uy33ohR0ph
 qWkyKw0WktL2OnySMiWBtqCg6cIQIg4is/C/TlMwnWzApvGHXnNMsL4OYLUPLoW1Br3jeo2Q4
 xi4tddyopzJnkylLqHXNqIkqFJhdznpioeZQmi4mY6EuLLyyasf4vK6QPMKAteJ3wuk7i3/i5
 bFavD4D/9rgqmbTayhfzWDq/UAgPx6qXlwppkXu2szRo42AzWThiOL54IiSlFxzRzp4feIm1i
 9RXLSFZnHnMshDRvFfvsMRIgwUDeD4axfPya5SNs6TBdCOnZ8McUKXt/no4tYi5aWzYVnxQDz
 h0netnFFqnCeTCNwWDGqTU+/PZeqEdIT99LePdxK0LIWZtZx+ODrHqloF09nCJhWKknAZ/dOz
 GWK49YVh9CbhHvxREHneX2H7r/uSXNWUWZams4848oFrfVFN5tj2OQQnVG+/1jfBsyPr6QUCZ
 TKjaaORLz+ayZWEmB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..6a5365f10aa5 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17047,6 +17047,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/g=
it/rw/ubifs.git fixes
 W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
 S:	Supported
 F:	Documentation/filesystems/ubifs.txt
+F:	Documentation/filesystems/ubifs-authentication.rst
 F:	fs/ubifs/

 UCLINUX (M68KNOMMU AND COLDFIRE)
=2D-
2.20.1

