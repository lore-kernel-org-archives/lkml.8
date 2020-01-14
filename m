Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BEDC33CB8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A0424672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g5wL/jH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgANTXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:23:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:52427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbgANTW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579029769;
        bh=lq30yIs/kC7cfrgLzXRHtUHGynXb89ZYgnwcKuYTLNE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=g5wL/jH6+URP2UNQCK5hFk7dGX2j5kexWIwUQsfx6t5neivSt0hgbU/bJpexlakRE
         2h/OskBvdMsgCksJcwKNSz9aySouLfrEKLbSiqDzFz3OZ/0PfSXJaZC+DaP2nBmAXq
         MZ8O5KxNwidsEHfwvu3/656EGF0NIWTW8vlFb/lU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.171.104]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnakX-1jYmom2w3J-00jdli; Tue, 14
 Jan 2020 20:22:49 +0100
Date:   Tue, 14 Jan 2020 20:22:47 +0100
From:   Helge Deller <deller@gmx.de>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ntb_tool: Fix printk format
Message-ID: <20200114192247.GA30840@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:cqTwOqVIQYt3IB2/nbO2/Luf1hWf6voFM2wcMONjNhcxwkzE5lC
 13ZcewEVHh+aQnf2xsKUYsyEgPjdxFHofbLhKgp+KOQ1nsIWZTE/ci9cSDjf6CHCZkRXkXT
 lC4kUszKHhrVK9J1sxM2naso06sxpHuqBcSKXcKc3sFSl27WoHM9BUFmbf9Z+aPyUrWJNVf
 Ho685sHT0PeWOquU6rHPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wyHYgapCZjo=:roclqpz9XbEmK9svrJhxpv
 L4UiUpakxKhuu8HIUITvo0Kak2YkvO5+b4hIZEHbnRqJZXYEe7EJc1pYLBx5+oDGZ2n7EOg0Y
 koZMOyb4UyhPYhCYM66dlfqsmJBSmCgJR/jwKWvS0gzjv5HVWhMzZOtnmQ+oIBeqWDkNuuhBK
 WCf5enuIwAjCEc5fcD2K64dPHh0brL3wmd9EIkdKbx/wAxrpU6PcwAuPYS1p3OyoEiwSs1/8y
 E5oDYZRDTYdOLdE7rqCXR070dVUutM9Bn8/qFw4/Z/vEEpMSCoUEMH7agVxaE8za0jb2PyLJk
 264IDe/57kFISEEpMJjehlgW7m+LU+kgg9uKBt7ml1RANiw2Vu3BuywAnGZRc6cEUiJ+1Xi+e
 e7ZgCsYUG34yvFHGV02chVWZCUIhAk7RizTYKz8EO61moM7m5RFCm5SLLA5sjz6IP4zZKfxZ9
 v2BxLjRofIIhLytEsBFSgIMpaiWGH0JTqjnxMIVbIDPAIp4zhyortTargGPK7tBhASCmK1UbC
 VnM0TVlHcRaQNV2h9ZWtsupuF4Ae7moIZVs62U/wuLqtODRAV8jv5fob7823ky6pRtTSHMmrE
 9TL8HMC0xYsBpUalEe5nmO+hOvUXxVHGex4MD+P/0Gz+jqGyRZ6GtnTuAY5F2bhgZqW7icg91
 EDoYUE84Wnp2VSLRoLLasu9J7hOoFvI+LpUm9SrGgpZTAHcOoom2iQgifBCQ1LqdD3h4fOHOU
 zz+tuxxbbeQAjG/LQHdj5SUrngEtXg+NI929vX9No5mLqA1pVC8Iezw8Y7ZI0rRCTxGqpdIoK
 ctWa1VjjrvyW1taHa5Z3lOUBp4hVA8oNSGQQta+FP7U5qJe0UXSTqRSGYUJFcEkUhyZBfBNAk
 zSmJRkeLhoGmiu4Uu7tG6u2GBI/6Sj9ymutc0y/E/OF10GJ3my18UMS6GgB5V89pXv/XdNj2m
 qIgW0tmJRproK0vlD6SF43ERKJiWI4/mSbLn7T47BuqVHChrPFxCeINLSXixPtZ7pkYlJSF5Z
 6ic5oI9wBGQC3wGWkhcPRoCpUGVZsQ+F0v8dFbzt9Gn4pYWkwkGZ1ZstkLlGDWmdcRSohB81Z
 YsWUgBcf/d37yqxfS2uCnRtJQZdaTT5/7hOJwKHNLykq8fjJ4ktXluIkIMbN/ixRJjX/guqar
 MFRT7cRYOPPGz+pamRhFs1Mb32UmUgK9E9GD74k49TiOvECBGn2k/qtJNPtL/3t4ebfcDAzMe
 Pcot8cSGsycwPG/6jEeRyHQi4XrbVGCz/K2Id7w==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct printk format is %pa or %pap, but not %pa[p].

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 7f46c8b3a5523 ("NTB: ntb_tool: Add full multi-port NTB API support"=
)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index d592c0ffbd19..69da758fe64c 100644
=2D-- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -678,19 +678,19 @@ static ssize_t tool_mw_trans_read(struct file *filep=
, char __user *ubuf,
 			 &inmw->dma_base);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Window Size    \t%pa[p]\n",
+			 "Window Size    \t%pap\n",
 			 &inmw->size);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Alignment      \t%pa[p]\n",
+			 "Alignment      \t%pap\n",
 			 &addr_align);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Size Alignment \t%pa[p]\n",
+			 "Size Alignment \t%pap\n",
 			 &size_align);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Size Max       \t%pa[p]\n",
+			 "Size Max       \t%pap\n",
 			 &size_max);

 	ret =3D simple_read_from_buffer(ubuf, size, offp, buf, off);
@@ -907,16 +907,16 @@ static ssize_t tool_peer_mw_trans_read(struct file *=
filep, char __user *ubuf,
 			 "Virtual address     \t0x%pK\n", outmw->io_base);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Phys Address        \t%pa[p]\n", &map_base);
+			 "Phys Address        \t%pap\n", &map_base);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Mapping Size        \t%pa[p]\n", &map_size);
+			 "Mapping Size        \t%pap\n", &map_size);

 	off +=3D scnprintf(buf + off, buf_size - off,
 			 "Translation Address \t0x%016llx\n", outmw->tr_base);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Window Size         \t%pa[p]\n", &outmw->size);
+			 "Window Size         \t%pap\n", &outmw->size);

 	ret =3D simple_read_from_buffer(ubuf, size, offp, buf, off);
 	kfree(buf);
