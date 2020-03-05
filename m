Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FFBC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F342072A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KJ/F/Jno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgCEVsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:48:43 -0500
Received: from mout.gmx.net ([212.227.17.22]:40005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgCEVsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583444884;
        bh=2ZbX8iy2LPLmbuk32bi++QHMD8DqL6IlLA56q+HPJyg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KJ/F/Jno+u5rHjjgjYjFOBCoO9zBiJe6k6KhxuwtQu+Q43hO16ZaaffqOjclB01d5
         gtj9MPYgJn4hF/yV2ZRUgtQK6p0Kf+zi/kXNIH39Wo1rCvo0EJgQQfiufynbCS9dzv
         CrUgW6FSVd25zJRWXUupkqDWMwN6nVg5hRre2PUg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.153]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowGU-1jiiTa16Vi-00qVAp; Thu, 05
 Mar 2020 22:48:04 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: Move Intel Many Integrated Core documentation (mic) under misc-devices
Date:   Thu,  5 Mar 2020 22:47:12 +0100
Message-Id: <20200305214747.20908-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q6ZgU8kgD40IX+r1XgjbkvrRc8ACsBRBemccsnuY1/eiFZuKwbB
 HNF0l8btOQ3e3vktoTqJGWwjL6xY+LieM1eyf3fw0SG1PSYPfv/n70s6xfYYScXYlCWTM+M
 miDdPBc9BirWnyWnXWDTJrSJ23iPj/Qr2DiuIFArukjDpAsx7dSyV3Tkc71T7GB+SXPe7S6
 SUeytQi+bewEWh4l1uFnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hmzQnyJyZ6o=:rlmBulbCbuI6TlpXkawsr8
 gag9BjJW3cbuwOoFDatopR7f5m1ayt8QiPazTsX4v6Y+E48s6Zn15yDNVwsVsFB7Ezyc62L2R
 g83gifdAi3YVCru2Kh/x4P4jOihN70axGb5abyLY5RUmdwmMEC0p33q/YbnM7siqEOlS+383k
 s6G14ANXYn/DZ0iNWa/lobh770AsPtvcS7JpyXMwZCGqKQE6f+z5LdiVxkghtwGsoU0X991Xn
 xS5taUVIYw4voJcbkVrIQhnvZs5tAEolImvPVih3Yy8euA404c9d/NYGW+15ehu+Jjpl7iEgw
 +BNIwjxVx73tbuk0O0utowmVYG0h/VgvNiUja++ZW5qMdsCPnsMZ8ceDlDaW81SROP3vq/DYI
 kdjRGfY8yY8G8YGucaW45yBuLdrGFwsmnYF9N8Q+vsDj8WQ/OSGNmPncfK+JqO0mbfECfi9Lm
 WzwgzuGpEa+GiDQgwHqQ2wsuTFaqFnzEkmLEG8wJtQxIE30JvKBW382dfss3GeqxupbZWgX8u
 dloSppUbtqnBIDMc8qP4uOzFQqpyGswYJWYTdHJabP5xxctXtELM/yxNcvZWqVHcDd9OwULJK
 QN89Hz7KY7DfC0+b+PG6VGbv7688HrTq9jzZZY3qVSsTCIj3G2osizAtAZRHgjBcHNXEUb+9U
 apCeg87FIzkYLj6LQ+qSsi/fyemE+w+oyAL1JnTJqnWpd7nkFwm0eX4MJkjY8XtWepXcxPqlK
 /buMleDZSSUxcIlqZadIQ03YUeVkyEflGstKOm8tcsAQ04174Mf1HQVOTDiwmnhlZQGUj+EYy
 2cttxOGoSFKRFBwQSSVLFXTxiz0ycSloggRXGJhlOLFt+8tHxjpeg+jksVriBwPNho+r7SwrV
 KRBxPM5wGiymZT23Masc42fYw1KG/vpfqure4yOrqwFM+idCSZlzIA/Ef6lEO/ryWZcM0CHdG
 MPV8CvyIIZ1EnJ+ajdfCvA6HTJm2qr5AXOF7qAhoGTEq6Bp/T5PgzNnFTPxpdOlceHxYCcEQb
 1vWc5ECe6FcnA0fpWc2FTqrB80uWdQYjQo1hOqOxTzR7X3nfUqeOzk7wLfShtyxH3Pj81ZKS7
 HDUQHPFlAWmgFcGVO98S/ALrp4crCdx5Nh0GAmiirYQhJ7Ok5OAY4adEjF50LyaL5QIip1ZL2
 3gpd6PyCva1ImczuoEnv8kgGVUY1Rd+WhE6gojEhGI7TlyKS6c3xS3M1XC39nnpCJbTFlWRpK
 QMmrcmBxt/88StHF2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't need to be a top-level chapter.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/index.rst                                | 1 -
 Documentation/misc-devices/index.rst                   | 1 +
 Documentation/{ =3D> misc-devices}/mic/index.rst         | 0
 Documentation/{ =3D> misc-devices}/mic/mic_overview.rst  | 0
 Documentation/{ =3D> misc-devices}/mic/scif_overview.rst | 0
 MAINTAINERS                                            | 2 +-
 6 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/{ =3D> misc-devices}/mic/index.rst (100%)
 rename Documentation/{ =3D> misc-devices}/mic/mic_overview.rst (100%)
 rename Documentation/{ =3D> misc-devices}/mic/scif_overview.rst (100%)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index e99d0bd2589d..6fdad61ee443 100644
=2D-- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -131,7 +131,6 @@ needed).
    usb/index
    PCI/index
    misc-devices/index
-   mic/index
    scheduler/index

 Architecture-agnostic documentation
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-dev=
ices/index.rst
index f11c5daeada5..c1dcd2628911 100644
=2D-- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -20,4 +20,5 @@ fit into other categories.
    isl29003
    lis3lv02d
    max6875
+   mic/index
    xilinx_sdfec
diff --git a/Documentation/mic/index.rst b/Documentation/misc-devices/mic/=
index.rst
similarity index 100%
rename from Documentation/mic/index.rst
rename to Documentation/misc-devices/mic/index.rst
diff --git a/Documentation/mic/mic_overview.rst b/Documentation/misc-devic=
es/mic/mic_overview.rst
similarity index 100%
rename from Documentation/mic/mic_overview.rst
rename to Documentation/misc-devices/mic/mic_overview.rst
diff --git a/Documentation/mic/scif_overview.rst b/Documentation/misc-devi=
ces/mic/scif_overview.rst
similarity index 100%
rename from Documentation/mic/scif_overview.rst
rename to Documentation/misc-devices/mic/scif_overview.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index 5b229788d425..cb2f714b3191 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8578,7 +8578,7 @@ F:	include/uapi/linux/scif_ioctl.h
 F:	drivers/misc/mic/
 F:	drivers/dma/mic_x100_dma.c
 F:	drivers/dma/mic_x100_dma.h
-F:	Documentation/mic/
+F:	Documentation/misc-devices/mic/

 INTEL PMC CORE DRIVER
 M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
=2D-
2.20.1

