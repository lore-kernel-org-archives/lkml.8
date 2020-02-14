Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09E7C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8891D206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cVlFsWdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390365AbgBNRmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:42:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:58657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389707AbgBNRmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581702136;
        bh=Fr/aV/fvvp0r0zg9ZhAl6tEBlqL/IG+UHnFaZMP2xXA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=cVlFsWdKoSt6DNuU7j0/9SMkS/LfXVWu9Y5YxplA0E1j+GFiBiy/8KQ+7X8AcVt83
         z8r9GHkYkNryJlimtlKmXEhRUs14jRbUmBsF0TC/ahR+pCPczyob8gcuh7V8aVuarO
         9/rJJ/uKBGTQZm7fWnKEOhmrWwXsUOnFu3lHktWU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.12]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS9C-1jmBzm0bGs-00kvyP; Fri, 14
 Feb 2020 18:42:16 +0100
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
Subject: [PATCH 1/4] docs: driver-api: edid: Fix list formatting
Date:   Fri, 14 Feb 2020 18:41:32 +0100
Message-Id: <20200214174139.16101-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FJvoTyFdd0RiK48roKn8aMvVl1k9p/41HXgnAtAMRT2NE40/nyQ
 wDjPiwbkUtJQDugYSv9KVu1xKaKZSguMv5G2IDxWTTepwy7kG2f5JGlsyw8iOpfZqjTtu56
 9reNrw38kef/8044qU4pAqRcB815wsWNLeV7dUEVWs5OmgZOBhUIXwJEQ0t5CvgDjMVUJCY
 OB6UFo/MaD81TWxkhefuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XgJ0tGiKOuE=:+MYfgJk1i3iEep13DPweyr
 tZPEKqpXJZPh5xLewfAPk1IbB6HZ574i88oikL9mIC4nYbGXozqTxUVSA1+nENn65EEe6PKTH
 KddOGB0xUviOtO//sb9EiOSQ06GjXPBMxsFuyYCQqdqeXzd8a5OkNq0pSj02jXzXW0TYicqcH
 lp2mY9KRzprWP20SIQ9/TqiTAKxu7/vepGqk7zhSmzN7g+Vi8kBUslC9bSQBRxW59YX8xklBW
 oEjas1Zxq2zSDUPFqP0TIvMctN6ywS7eUsSjqaYdCR1qh4pqRoiYMk0GjxqUlmldpzD7sQhys
 oRGfaHNTgDv+SYG/BKX3H6s4V7VXvKCM4nHxIMZZ55rjP1+q1yuJhH2sCCklc3silfEh4GB7S
 tVW10YvafH8WOCqzfsF90O5Ba1OlsZBVxy/NlL194eb2PMOsRbQEIddpmx9LpBq3JS425iCSx
 5aRkAxkH8ljqT5++fncC4nSAO/dlKgdCs/xFQZ29u3FG5bTWmrFOZK3d7akbPNRRRD0B3R1/g
 /Ycb5xFUNr4yjP+BaYgGakNEODRtaypH0YLKhdvTmx1xSOq3ANiIyisOsA6j8lOcRL39N8nSR
 rrCrQCPerOXam7eek2PX2yVrkh99AedpETT5+xjag81hQapgPBelLxB3uPTLwAvEVSayAsa0n
 ZDCIdHqmy8Noji7bFB6fiTCfYx5J+s9hRNKEH1bIAuGDvk2Fq5tksl2zjz6oixLboljarwHoF
 8KyYowkKJKYh/d39PvAqrqYg8yTLbSgmd1VirJWyvGQFoz3diOWorhPKq7qq50b0WHqEBtH72
 d0gpG/bYNx2ktnZBfjx11snXOcKu2WsO5HR77+UwkbZ43P2lkg9ZEwjBpJ+xE7uaTymdJq8o4
 pAbb/efS/YfH51YnN/FBoYb64bE8xiy3aU3Wlm5wLPSgs5oXXI6pxc/d2pT5/0dQ3QVoUTRsL
 hzhj5TFkr7QpCzGm4ux7n0/4l58IV6WaY5j696+FkaZNB/DBwvKrsa88AvvkilzBOMyo5zGDn
 RTCCVPG7Z56QYIhApdErGuSTqnYsbwZiCrJTbK18Gxd1EE2NdsaNw4MVwX3OY5CZDsnA1rSlM
 8Jx98TnmqWus7yslKsR3SwqtRVMZspS8wQoCTbu9p7sseQ9whW1ANHdB7nfuYHNfFlro+NL/j
 PZJkowLKxsV2kPW/grVDsD7osJf9Lg2/W1M1x0tshVHNNkl5hY/4nSXzwOgYSd0eu5FyE2uZ/
 a03AzZ596g3oX4M8e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without the empty lines, Sphinx renders the list as part of the running
text.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/driver-api/edid.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/driver-api/edid.rst b/Documentation/driver-api/=
edid.rst
index b1b5acd501ed..7dc07942ceb2 100644
=2D-- a/Documentation/driver-api/edid.rst
+++ b/Documentation/driver-api/edid.rst
@@ -11,11 +11,13 @@ Today, with the advent of Kernel Mode Setting, a graph=
ics board is
 either correctly working because all components follow the standards -
 or the computer is unusable, because the screen remains dark after
 booting or it displays the wrong area. Cases when this happens are:
+
 - The graphics board does not recognize the monitor.
 - The graphics board is unable to detect any EDID data.
 - The graphics board incorrectly forwards EDID data to the driver.
 - The monitor sends no or bogus EDID data.
 - A KVM sends its own EDID data instead of querying the connected monitor=
.
+
 Adding the kernel parameter "nomodeset" helps in most cases, but causes
 restrictions later on.

=2D-
2.20.1

