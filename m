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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE4BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B712F206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="izvS66sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390268AbgBNRnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:43:01 -0500
Received: from mout.gmx.net ([212.227.15.18]:34609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389575AbgBNRm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581702152;
        bh=RCA6UUkRvRQKX/W3+Nf4MvfQ3fR1SNVJKv9DdO0f6dE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=izvS66sz8Xk6x4rzvWbaiEWJvIDQqlIQlMZNE95EGq2eWsrc3UlvcGIH4UBWj1T12
         HRA/y/qMAwR5b42I1JwMIYwwvfI6ZV/vjlek6s4v1ufFTRzMGdqSMFhPzXVOzqISnm
         3dGAexbi1jYyj6CF4GR/V9V9fSnDQfabujgYdnnI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.12]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1jScEV1aUN-010ex1; Fri, 14
 Feb 2020 18:42:32 +0100
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
        linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 2/4] docs: admin-guide: Move edid.rst from driver-api
Date:   Fri, 14 Feb 2020 18:41:33 +0100
Message-Id: <20200214174139.16101-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214174139.16101-1-j.neuschaefer@gmx.net>
References: <20200214174139.16101-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s7MMSLzyHmYzrat2fYjH1Bs86acNt01IDnYncPmnMQxP6f1WPpX
 Ss21PQUDRcOX3U8Pxk36pA6fEdJ6qMmn84Biz1XCYX4bFG+bHZWSkx8ZEpYijf5r29Occ1q
 qdUMQ/0RxVLDNZOqOGB7j9cMN3cMRLUXD3zzBCCVA+f2mmDdiIxTzOkCFBGGmk/3rX2E5P/
 NkjxKWtSoy5Ep+4eO7tfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N/mhQWw0YIk=:aXBT2XuYWlMY1v6d64VYGe
 msMwy/cfKahE6MW2wokhnZObdO9P29nRaLopbUpys3pWv8xHQGxzQ28QShWtpsNrY9KQH2o4D
 QnHnLqV5VXPjG0YfdqsBL0Q5MX7ygjQlUzNnuwwXQ+hBWszOG3IHIMXHvpTOLuR47Fg8kkvUv
 f41fZkOuA34J1yE38KSbNC+E7kwv3h7MDliEhVOqOvweEIAyGuRCJGQdDsB7BOak4JiR4NuxO
 0x3sDWYU+/VZocMPj7X1aaz61D5rOT12nxvApdfngYNy67UgMb++V3yMDX3IeFLBvjvjyPrTP
 BKO2We+Ec1l8ixj/v2zFh1T9MwOJvUmnk9PdQV6RdEyuCNdKYaZGSuybzybcy6So/bYaZW/1K
 OEzfD6UDrskhhJJiVK9x5aH12HID3QelrtU7nNAT8LfJ+x4f0OuDQSrXUoV4F73bzfz4k5AIp
 MLMRjL/kRQ4K8s0MXsOewgcj4oNtvL4qYvlCpMORboLcLprtCp9WJr8ODN//0cAl8ip5crlc0
 ZphJxeK2rope3uo3hbZKdUCU9InLDucKr15Z6ORY3NR/reWhWyaKBtOdq+2yt9kj3bqwFNsjM
 2LMZ1R4Q9X66YKMTqZedjDjpUvnImARvGyjWwb9IaDi3udYXjqatUBZTsQUDX1mARTtWLy4Q2
 b5iRZob1qgseNueQAkCHkN91lrW2AbEZihOxDAxmC6XAvyiLGThgMFxggnflk01IbAZBT5eTW
 3GoTOkB1e42uKIVBD1xXzXkZ/u7F1OHN8dL0jG8Ao4J3QLhf5QONpxLww6ITvqYqiv6T7vzCi
 C2GY5xm5qm6sk/d9zE21aWuKulrcMT1lUfeAfr4cM/vzF+/BiK1CsEcJM++BEHRZNbtMobUa7
 kzzEO/nG2cjd2Ywz29vczo4J2i82W9993nkIB5UYfUKCvU2NNs8l4yr6jUKudoq1FB73z2wr6
 2GdzjqeE0b901a1cms5fP+U0vG15+jP+NoVqUKadwCF/STYCCMVhnTpDgdPHUjzDlHn4qeXwr
 XRJ/gzBeCovqmpJlJX+uvdOsztbwZsMSxK9C9Jpb5vIlunp9FuQlq//TmN8CL2XpbaJxtisG3
 6z8DqMhGjoizE4HinWWsJh0PJlZ+Ki279LAuDVDcy3M35W5geUywf/PVcNL3SIwO3KRbZ0fBl
 4PKquzbqaygvL1+LcyCRxvm0+N/lKfQv9r0M6GF1tyTEyf3Mso5me1ak1TEzVo5k8jmZ4LPb+
 UkudcAh2xQYeiDkgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document describes actions that an admin can do, rather than
interfaces available to driver developers, so admin-guide seems to
be a more appropriate place for it.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/{driver-api =3D> admin-guide}/edid.rst | 0
 Documentation/admin-guide/index.rst                | 1 +
 Documentation/driver-api/index.rst                 | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{driver-api =3D> admin-guide}/edid.rst (100%)

diff --git a/Documentation/driver-api/edid.rst b/Documentation/admin-guide=
/edid.rst
similarity index 100%
rename from Documentation/driver-api/edid.rst
rename to Documentation/admin-guide/edid.rst
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-gui=
de/index.rst
index f1d0ccffbe72..5a6269fb8593 100644
=2D-- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -75,6 +75,7 @@ configure specific aspects of kernel behavior to your li=
king.
    cputopology
    dell_rbu
    device-mapper/index
+   edid
    efi-stub
    ext4
    nfs/index
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api=
/index.rst
index 0ebe205efd0c..ea3003b3c5e5 100644
=2D-- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -74,7 +74,6 @@ available subsections can be seen below.
    connector
    console
    dcdbas
-   edid
    eisa
    ipmb
    isa
=2D-
2.20.1

