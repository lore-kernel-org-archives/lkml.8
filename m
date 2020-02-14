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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E469CC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2672187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bqDWKVI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393846AbgBNQie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:38:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:43427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393832AbgBNQib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581698305;
        bh=aljnTBBsgqVrEDd/gZAFSsxFP6sDswfp9xiGBdfL1cM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bqDWKVI/Vp3YAxe60eR6+WGucMg1H67N6O8r8ZLW0yRNqU143urojx8/60nnRRebe
         YXHkLM9nXvblGEL649ohvDF9PjBn9Iowm4fZW59mdhKgOJdt++r/WATx7Rd5tU4QFw
         r+N4obr7fkme+oFpoNvlJ5ivK9VnijHrdQTP7dKM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.12]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzuH-1jcWAY0P8x-00dVlW; Fri, 14
 Feb 2020 17:38:25 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] drm/mcde: Fix Sphinx formatting
Date:   Fri, 14 Feb 2020 17:38:15 +0100
Message-Id: <20200214163815.25442-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vZ9nWg5BWeKK1PKzyMUn6ldpagxahM+XpFuW53lIDolnke9gr2c
 RQUC5gkxbZz06w9tIB974S2dxOP+wJyl/79mFZdPo53zqFruF4o5j7rhFhLZMmmxH+84llB
 ER3FYu+hDSOh0QulSLYKQ4gv47VrGK5uvKalLABt6Jo90zAp8Sc0xK7qFy2cKFEK8dPzcls
 7bFG99gh7lgzU6Gl/hufQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KIrrjmF1rqM=:ZfVoE6CxftqLKTNVFw+DBU
 xxz+xlB5M8SyPHZ5JiBz6sFQkWwVJNtjCZvh4EKOvQMKcOoeT3cArZfbsniXkdpGZC0wA4V+j
 FH5YNtoofAJny+FanImwgUZWRPigBIk8k+Jl2FVPiu7gsMUaNCt+ouS9vKazLK4n9tn8//fqe
 /g0YwCrHezTjvq89mfbPtr7dEkyxTO7CNAowKicHLwmvPeEXazEVTXij6rSkzeblitTxyGpl8
 A7H7QWXtskfX6dxGM6AFh4trMzDalDA+7iIQmcmhHcQA+FDrgSzcxJutRROJwHBXzwesYIDjM
 pjDSEfRMwYlmdQ139qZJGs3oIQd9W9OGWzj95MPA/0z8h3XAxZ2mcWBDzYSwEGIxlsn/LzwUD
 TbVWfPOv9++PRETtt+zmoIjdSLrQE85gNSepi0dI5VcaoVwcw1IpQNha7Egc8odcmoYqzLdOo
 23AOiLN6frx1mFeLYu/THm/doCFEgI+DMxBUdbIihwabvrRzojqflzHwLHHLBuSYt30ObrpW3
 7nj+L1sbKCevzQqI9CsFNcaswseH6eblVWBYNQLJm0DkScn4lBUpzezkpkGUwrsW7/+bJkdv7
 T5MFJzV/X8QUBUcZ90nWtIh6XCkdZjFo6kbu6DNmrRKaR8NaFwkqEbeKCM//8Q5ymgx8h9Wg4
 PDGyRDlCfMYYtQBNV4ObwzWs+ebTH2WIoavKLQ9l5Ld7BBPM3XEBgjvvFfQ4+NhM/EjJ6my+K
 sqmuLNp6F1yP9tE0dOLPbf/tOejYjOGvM0sm8yOPBhvhchzQ7WGC+ccbBEDhb8Y9dMj5u0GIf
 aZF2qUyQZ2GfkrnCJYQmzExhWOjlUi4Ubz29ajvHdY00W5WEsMLQbDMu1rEs62CcxpkxdfyCE
 amTSV25I0hEBFVtgkAGsakRCI5hDBBv0Ve+NlAOvUwHM7003uhyjhWc4Ya4un1WzkBSksUMLN
 ZdvYUoER/4Exl7UZCVnL/dyt5NUXJxxsZIDcqDWUVOxq7GreLQrVUDWoRedOr+SpGlwrS/Pcl
 0QkC//3zXqLKjU+ZDO8odU9+A435N5GFTZUkB5+7ZIc2IbLz8YDvaBbkMAuXqQzsjLGb/TFa3
 xpZx6+XXMJJcqMOjKe1/xX0h3mbGGG1zU8EHSFlSbZ/ehGilzBuMtEZPOFUe33fGTPWDyAADP
 I3qjgN/TL5v5DQppmNQ/Ka8YJ/4MtXjTbImesOL3T7qkBf5LW6hHLC8cVd/wtLMMeEBoKUAaD
 VaAHYEDD+dx1aegof
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Format the pipe diagram as a monospace block.
- Fix formatting of the list. Without the empty line, the first dash is
  not parsed as a bullet point.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
Previous copy: https://lore.kernel.org/lkml/20191002153827.23026-2-j.neusc=
haefer@gmx.net/

It seems that this patch got lost, somehow.
=2D--
 drivers/gpu/drm/mcde/mcde_drv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_d=
rv.c
index 9a09eba53182..c535abed4765 100644
=2D-- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -20,11 +20,11 @@
  * input formats including most variants of RGB and YUV.
  *
  * The hardware has four display pipes, and the layout is a little
- * bit like this:
+ * bit like this::
  *
- * Memory     -> Overlay -> Channel -> FIFO -> 5 formatters -> DSI/DPI
- * External      0..5       0..3       A,B,    3 x DSI         bridge
- * source 0..9                         C0,C1   2 x DPI
+ *   Memory     -> Overlay -> Channel -> FIFO -> 5 formatters -> DSI/DPI
+ *   External      0..5       0..3       A,B,    3 x DSI         bridge
+ *   source 0..9                         C0,C1   2 x DPI
  *
  * FIFOs A and B are for LCD and HDMI while FIFO CO/C1 are for
  * panels with embedded buffer.
@@ -43,6 +43,7 @@
  * to change as we exploit more of the hardware capabilities.
  *
  * TODO:
+ *
  * - Enabled damaged rectangles using drm_plane_enable_fb_damage_clips()
  *   so we can selectively just transmit the damaged area to a
  *   command-only display.
=2D-
2.20.1

