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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41ACC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7494206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gvUIhLZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389608AbgBNRod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:44:33 -0500
Received: from mout.gmx.net ([212.227.15.19]:43989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387409AbgBNRoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581702236;
        bh=lGf0qyKg4mLkRKB3FW1N8BhdqnF6UEjDvbhUyHfJNb0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gvUIhLZMl6OGym334cDzWdjtf8jEQIkxgbvt56LvCJ4OONBxPZub7zdesrf3k+U5M
         uSNcUCGNukOF7qYBGaMHrB5hc3UtelGju/htzXsxpRPeTgI8kvVJ7G13kedpZnvqPr
         wnQftC9TssVZEbaHlqNPzAgb1w4vho4VQhg9mqDE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.12]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1j3TXU31TT-004Axw; Fri, 14
 Feb 2020 18:43:03 +0100
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
Subject: [PATCH 3/4] tools/edid: Move EDID data sets from Documentation/
Date:   Fri, 14 Feb 2020 18:41:34 +0100
Message-Id: <20200214174139.16101-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214174139.16101-1-j.neuschaefer@gmx.net>
References: <20200214174139.16101-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9u/8yfjqU+MPy0rTeFm8Na1uAqTaUDS8ZZ9aXgl6ZY2Eqe8wMvd
 3jsXEOKJVCzhPcv0dBgj9GmiwZcdyTPB1lqh15U+PCzzE83fCuAotIH595Q1lDMgBIBQdzl
 Gy1TKyjnwr3hMFv/E3vT0mLt08esmAR3VU01WvRrcG3ht4DPpYOFkO3P4s3noVPh69EaAS+
 Or6BypbZisYlfXt3IuwaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YOzTuLVAwZg=:hhaUO+WlkvrF46SojV4DzY
 4pLvOILkCwcqRJmTtyHjn2cGcJYuAWp8Fo99abkZJHKzIQT+mTkinMNQYpSZDbzfp7DAhUQb9
 Y2tlW0VIfiNvbR1MUxCeZVe42taID0I+ufnw4OMEkJA2TyVcThiipwcLRUdQnQ3/JAi8sgJ6l
 cxY9lXWI65qQH0ldWg2ynb9DdPQQMr2YlzUHk2yOwb6b4bF2j34mCG767UVIrsQiKwsVcLaWr
 608YME7NYRLFz4wn+i3pfyRvfaEMXvXpnAiCyM5Dn+pcaNE4KsmqygTfuPZ1+7/gGVttwf5K6
 StGsHHGVxWaSUsO4kA6362hFDZTknOmHLwv4PTkkaoeD5qqXeLqu9rl0nbMGFbq5cKHCTPIpb
 VUH9J/TO2/cJ4bSH1qCO4rnfhXJMZoqGd2i4gplIZ1NvBkg6KYWLZKvYMJMaKmSe0ZPGBGjBw
 rMyTBeMuwu+ACcJYYdcpCLTdvOA7MwR3qhw8XR4jOWjbGVSVxhNg3UHxlXkjfkXlmSUv4vouI
 UG0LEiuzt55mqzf6WhghhtQa7zmDftcr8WQB6sCHnj/Rcc/dfsiYLcDc4bVg2UJD3AGsonDMe
 7Z6o3HXPfNRTaxo1tyvQ5YyIXq5hRSreOgUXqPl7AUQWmlcYqj5UxGxGtOQt3cU8hzIN+7/yl
 ASuCX486EE4JD0s/smBPqIfmamzJGZOq7K2a1NSX6gLvbPMVR1jfgfWhG10KgEedEB4wIjxIP
 n3Hc9IRYJk6tsm9tQRDpkyKQMB/3dhp5NAs7DvlB1GDbJNGq2B+W+Nw155OjwUc6rY7sNo/om
 Ze+wFD78dncaYQHOesW5x7CCCKrZ4gc25aFxM3EcWGAsGyDpHFW16yHTB9sz8rBlCT92vVESS
 LpjNhuNsIzY882c1Grl7lRpS1DcawUImg5LctkD1aKOuONQtYQjaeZh7n46pTJlK5NMLd9OmY
 cwspTY/7WGG/HwNBJYScwW5riJWjPKAqGl92LORtjwJ/kb6aiFx8XmiFJBft3LfhJHEIWgq9Q
 vr2Mg1e8xgPVuHLBpjruy03U9ZlQxnL2CeZoqjAxJ5gXhAcClhAoPMwWwhHnEiFZAu1oUkuIK
 GgStn1U5aS1VGw9JK4rHi+tUNIkc4mRCueak7UCLcJ9Y0jId5rJ3CiiB5oTBvXyRlwVxpa2iR
 sal2DtVil87WvPfzyr+222GmNuyNxQbK5VLRCqjd3ULGtSDK1jHkIpu3fP/qeXWb8zaYDB77c
 Pwk3b6YjVGyl84d7m
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EDID files are not really documentation.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 {Documentation/EDID =3D> tools/edid}/1024x768.S  | 0
 {Documentation/EDID =3D> tools/edid}/1280x1024.S | 0
 {Documentation/EDID =3D> tools/edid}/1600x1200.S | 0
 {Documentation/EDID =3D> tools/edid}/1680x1050.S | 0
 {Documentation/EDID =3D> tools/edid}/1920x1080.S | 0
 {Documentation/EDID =3D> tools/edid}/800x600.S   | 0
 {Documentation/EDID =3D> tools/edid}/Makefile    | 0
 {Documentation/EDID =3D> tools/edid}/edid.S      | 0
 {Documentation/EDID =3D> tools/edid}/hex         | 0
 9 files changed, 0 insertions(+), 0 deletions(-)
 rename {Documentation/EDID =3D> tools/edid}/1024x768.S (100%)
 rename {Documentation/EDID =3D> tools/edid}/1280x1024.S (100%)
 rename {Documentation/EDID =3D> tools/edid}/1600x1200.S (100%)
 rename {Documentation/EDID =3D> tools/edid}/1680x1050.S (100%)
 rename {Documentation/EDID =3D> tools/edid}/1920x1080.S (100%)
 rename {Documentation/EDID =3D> tools/edid}/800x600.S (100%)
 rename {Documentation/EDID =3D> tools/edid}/Makefile (100%)
 rename {Documentation/EDID =3D> tools/edid}/edid.S (100%)
 rename {Documentation/EDID =3D> tools/edid}/hex (100%)

diff --git a/Documentation/EDID/1024x768.S b/tools/edid/1024x768.S
similarity index 100%
rename from Documentation/EDID/1024x768.S
rename to tools/edid/1024x768.S
diff --git a/Documentation/EDID/1280x1024.S b/tools/edid/1280x1024.S
similarity index 100%
rename from Documentation/EDID/1280x1024.S
rename to tools/edid/1280x1024.S
diff --git a/Documentation/EDID/1600x1200.S b/tools/edid/1600x1200.S
similarity index 100%
rename from Documentation/EDID/1600x1200.S
rename to tools/edid/1600x1200.S
diff --git a/Documentation/EDID/1680x1050.S b/tools/edid/1680x1050.S
similarity index 100%
rename from Documentation/EDID/1680x1050.S
rename to tools/edid/1680x1050.S
diff --git a/Documentation/EDID/1920x1080.S b/tools/edid/1920x1080.S
similarity index 100%
rename from Documentation/EDID/1920x1080.S
rename to tools/edid/1920x1080.S
diff --git a/Documentation/EDID/800x600.S b/tools/edid/800x600.S
similarity index 100%
rename from Documentation/EDID/800x600.S
rename to tools/edid/800x600.S
diff --git a/Documentation/EDID/Makefile b/tools/edid/Makefile
similarity index 100%
rename from Documentation/EDID/Makefile
rename to tools/edid/Makefile
diff --git a/Documentation/EDID/edid.S b/tools/edid/edid.S
similarity index 100%
rename from Documentation/EDID/edid.S
rename to tools/edid/edid.S
diff --git a/Documentation/EDID/hex b/tools/edid/hex
similarity index 100%
rename from Documentation/EDID/hex
rename to tools/edid/hex
=2D-
2.20.1

