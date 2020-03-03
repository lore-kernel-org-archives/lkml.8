Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF72EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E9B2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FBoRlyCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgCCTVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:21:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:35201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbgCCTVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583263278;
        bh=z5MdokEfnohRClHDpHvNTwSEsQsAEZU56XPFTiszgjQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FBoRlyCmC3WWcgtT3nbPmB3SkrAwUgVgkhxQabrxUhtoVAlJ5io97hAwd2Sq4tdw4
         xxzrXF73hE+Pb8oHR3Ap89aWjGMmdHn3KaJWaJ9XXiWVZO3kqpvSqk9um1cVxpZd0/
         L/leIqBK161YDttYGkrVDcoP3c0f0yegMjNfHxj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.177]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4QsY-1jXqki3JqQ-011RMb; Tue, 03
 Mar 2020 20:21:18 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: management-style: Fix formatting of emphsized word
Date:   Tue,  3 Mar 2020 20:21:12 +0100
Message-Id: <20200303192113.20761-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:asG4HO3fQkYF44OwjHkqrNtzg8cnJIwXuYEfJr8bzc74H5Tm4iW
 Itg01JLHuHBQr4bj3g75vJlPGFHTDuHToUuyStrii0XXY+i24phdtS5WVRisv18yHcTLJyO
 ZwxY/XOEdKNyjqOt+QKw66f9+9c7Te9zUUWNs5PadfgciunW9JBVLOnyfljX7wEkL+PQ83N
 Curd/Vxr2TkA/AZN+F5EA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pV+ZI0r+ksc=:vU9kIoEpyVXr0hx0sw8XSk
 XvZA15e5OcwyyfI5saPPbL6dqml6csbcWtTcOXWqHifV/UX9cQd5EhIw8qrT45GHnU2VqvM+N
 8yto4nKmQ6RkZ6OVxXNRXEsHz4+krgQydJLpUJfWnb7RY9/0107mUBKh2QHNfrhMq6W/jiPuM
 Vg0fQUAY49vnhm0e9KlOeUjSGWIeMDwUUx1G+ynv4hFbs9lCQw/3t6IrgcieFjwounOSxKop9
 TZOzSBPc007bdsCZeMiBUyxnbuIDXbye2lIVWs4DhIsVV05e0XZzbuP4jnTAwVbg1s7MpCT/c
 Hxkyy6UmEItzHt32LSbgktVkVY6hQknhjiTKa9JOHeGJT8syHR9bUBfHyDlQ90jl5hU2De+tp
 M/E5GMtiiFyhG0kXIXQJlyL3Oug/n4wzIYH6shYAJpiVaQFEXoHFjyeiUpkecmP/LZMZVBtdk
 5t/khNIObkQkfvimOAI3NDBLFncUltqUjc+IVgHH6gF8ieEx0E384E0EzNHUyHtRlBDhT0Zbl
 NCiuQvxU15JxGGGzexQhfCVUTgmzEsYJ5PWHcaRAkePuoFXIbmp2Pfw0b0a8wP/3WDwWv1x67
 LuDwWW5Yd43s8GKFHS/4qXb6CBZdmMM4FWmodKK1B1RJ5oAkY67BLD8o+JkmnrXcdirImJ3n6
 Z4hepjw66obHkmfA5KqqS+I5nM0Aum37gU1y3Jkvm4kCpgtonnh9cSl1W8U7LNIzq5HJZ7uoW
 I7UO1j5ibisTOOLZxtyYvD6skz95F2kOAFtkobobKBv0dbOoC0vC7uUskLbrXFm2rEJm7kPax
 72et1WwaizQBxrCWPa4Aneq9cOgZq/JkvuW2iykpkKzmJmzWetNvzEZqGErZnV4hpY2BglkdS
 Gb9QCrXVQ//QSQw+ZCMXjitG1MyI3ICJVdu/xoy//uKgln5R1pGwWFElEwhnsiGU7zH3tmyK7
 FbHzMVgOCjJas4SQ84qFHbohZii6FAnrgLGjOAZdag8rfhnO09QusQpMXlJxMdqrb1AEtFGYl
 BpfZkd7dNNA8a+5qai3eJWaFgUt98CzW3NOaAUKLcn3w3kXJHBPNqfTPYSNuN11ZsDuguhoL5
 iBFqkBRf+dq3Em/QXs5aDD8WIcEJRgsH4XxS3kT6npJlmdr9lwDlO35kR2GJW7ERUJhjX4KZ9
 vTwIsxxgLc+2Df8LMlE3V26J8BvmUk6COpD0h66zcYDWdZ0d4Bsu8ec2mTlRaInUkKRKTKzfL
 jH4cnoc/vmHja/tBx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7f2b3c65b9a1 ("Documentation/ManagementStyle: convert it to ReST
markup") converted _underlined_ to *emphasized* words, but forgot about
an underscore in this case.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/process/management-style.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/management-style.rst b/Documentation/pr=
ocess/management-style.rst
index 186753ff3d2d..dfbc69bf49d4 100644
=2D-- a/Documentation/process/management-style.rst
+++ b/Documentation/process/management-style.rst
@@ -227,7 +227,7 @@ incompetence will grudgingly admit that you at least d=
idn't try to weasel
 out of it.

 Then make the developer who really screwed up (if you can find them) know
-**in_private** that they screwed up.  Not just so they can avoid it in th=
e
+**in private** that they screwed up.  Not just so they can avoid it in th=
e
 future, but so that they know they owe you one.  And, perhaps even more
 importantly, they're also likely the person who can fix it.  Because, let=
's
 face it, it sure ain't you.
=2D-
2.20.1

