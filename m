Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA2FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528F620848
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fft/uxRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCHVQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 17:16:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:53755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgCHVQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 17:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583702129;
        bh=SrPI560zXDJrijeCSQccL1i1TJ/uBy66UrOAoyMNzDk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fft/uxRHwKOK1a4EnkbWRlZE6qOmhleRC9l9PTqjC1H1vJh0hHqGElDJmQqr3UMnj
         hlNl4I4GcnE7ocMbviYhHTPts661BvaQKMFVBQnL0kAB05oFuNW5CT+PYlat2FNSPb
         alwfJ6w2rgxGPfq1Jwij0a+gp781W2JLUa9fGhss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.212]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8mb-1jnR1I0bGX-00f7zp; Sun, 08
 Mar 2020 22:15:29 +0100
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
Subject: [PATCH v2] docs: Move Intel Many Integrated Core documentation (mic) under misc-devices
Date:   Sun,  8 Mar 2020 22:14:43 +0100
Message-Id: <20200308211519.8414-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fcNz+DMw1U/mDTIGdliK2zAZhiqkrw0Ns0FKBI5DZWuD5lAixbi
 oB2SXPdNFn7BbiKOelhgt/CLf/FqJnBErFgFr20DjOsY2C5By1VRsJK+abYPL62WJ3tYRA2
 7z80o6fEuHdTBmO7hBCIpc4NDuAUMYcbZHgruP2uKsB2j4B7cyXRtxUZQjym0vZtyw/03i7
 Jbh+pnoHYl6TPW7qkrNfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/DlWjcr07/k=:RhM0/yynJdy15UBqpKuaO3
 YhaU6Y3Fqh9xpSCx49biXCLwbeZKhbO50RpKyKPlmjoLRFZiAmeFdt1xMMdh6b7ZBqzaRJdAk
 21CH7BoZMECGWWjIZrEW59sReMqmjfBZKXtHg0TvjKFoD4Q+uf6xm4Oudz9d233YKH8gVMhzk
 7uYtRfRVSLRlF8BqUzqxnUmwYhjGX2OJfm0L88gbv+SWbx6tPUOtvly0K18VvSFOdRArCg9pV
 EP0Bt+BKBVzN9plZvpLq6FNhZ74E2rccmAgEshQ3438g4wQL2uhnx1Hxbyj6N1BrOBboBvZR0
 0UGf6WbZIWdGNBFOYJgM8frg3hI26vfbEDUl+0lAPMMkUyhgUVl9ZNDu9Rdmy+QqWwoF5vsER
 GqIt5ZLBSeFv+RCBMQ7g/pCSpEb+2WuntSZu2qG6dvz1/3zyH8zDRKpFknY6FGcxEPTQQ3rur
 rzQJQdrigHbpM1E0rH/yIdGa1uAE5oZWiDC5mBp9sO2T/69wUpOwPm6DYWu7Lb98SaZfwdOzj
 lTVBf+YHa9kVWUgh+VwR3kjwrqkNI6ec1g/i1lMLzQdKgVbg5fUFbtRMOKypikJzve7AcMrQG
 uVZlIWf0BsiLd1cwt4eO8biF8rkNqWIQf5iScUOlQgtsFZqU6U9R4Sla7GpclD+Gohb8tH2BI
 zw9uqL8ZJ6X3DlAzQjA5oAutd9+q+4bt1Bs62swdk1NbmL3cneNSyYQrZHVKkWp08XHdP/p/v
 juH6ghJL8IaN+irszQlKXD/L1dbNY+m7tfgRFWogKtu97MSkoY684CeuJlvtuyqh/eH7q/+1w
 gCy6sQ3pq1FmuvyDIJB7BhFIbq0meCfQFctbgbMs3rM7u7AA0PJUrtE6qjRAETl5o5q12NxJH
 nm/xYosZY3oIc5j6TnhD2lESskgv/lvAnGsHLZxAU/U0WWIMWzVfLIMKwXDgXaqUfiGtNw110
 cMAlZ3jTmga6JDnAdglL9I2NA28iPtPm6fOLAha3ZJT7EqG2Qz4ucQTOBPvzMjP184Z9Nrg2f
 rCF5hA88v57V8qSW3fZKoc2xrKe2NTjPzTJ9LU/R7rSd6bt1twup8wdstZfNH73YkG4KyvFSQ
 3h1xj9h3rUzKukM5b/y2iirOqA6pH6wIptRBYbi2F3QLFfoa/EQqOfE1kpmWz1E0zPVUQIGYD
 OCGVRVTN4DfdSkR+Okdw61VqJ4xhUefkW0ksYpsFCvpNisGtJivOgEgn0a45Ld/fW1t2HAc8B
 wikSBq+xLD2+/faNa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't need to be a top-level chapter.

This patch also updates MAINTAINERS and makes sure the F: lines are
properly sorted.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- Run scripts/parse-maintainers.pl to sort the lines in the MAINTAINERS
  entry, as suggested by Andy Shevchenko

v1:
- https://lore.kernel.org/lkml/20200305214747.20908-1-j.neuschaefer@gmx.ne=
t/
=2D--
 Documentation/index.rst                                | 1 -
 Documentation/misc-devices/index.rst                   | 1 +
 Documentation/{ =3D> misc-devices}/mic/index.rst         | 0
 Documentation/{ =3D> misc-devices}/mic/mic_overview.rst  | 0
 Documentation/{ =3D> misc-devices}/mic/scif_overview.rst | 0
 MAINTAINERS                                            | 8 ++++----
 6 files changed, 5 insertions(+), 5 deletions(-)
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
index 5b229788d425..722b2e5d495b 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8570,15 +8570,15 @@ M:	Ashutosh Dixit <ashutosh.dixit@intel.com>
 S:	Supported
 W:	https://github.com/sudeepdutt/mic
 W:	http://software.intel.com/en-us/mic-developer
+F:	Documentation/misc-devices/mic/
+F:	drivers/dma/mic_x100_dma.c
+F:	drivers/dma/mic_x100_dma.h
+F:	drivers/misc/mic/
 F:	include/linux/mic_bus.h
 F:	include/linux/scif.h
 F:	include/uapi/linux/mic_common.h
 F:	include/uapi/linux/mic_ioctl.h
 F:	include/uapi/linux/scif_ioctl.h
-F:	drivers/misc/mic/
-F:	drivers/dma/mic_x100_dma.c
-F:	drivers/dma/mic_x100_dma.h
-F:	Documentation/mic/

 INTEL PMC CORE DRIVER
 M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
=2D-
2.20.1

