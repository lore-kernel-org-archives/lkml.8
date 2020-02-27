Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EDBC3F34C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698BE222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811071;
	bh=2j9IIT2JYjYm4/5MWQQiDIMrm9oM+yuL54XZpkKfbyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fUCQUh6VAI2ZNT7EN2Y0hYs/VdnK1QFf4kY4tId9l5sIEqvsXA8X1Xiej39I49DEX
	 s70zSLW6unrJi/om73mARLYDmfDYtk6Qu4DPQH+UU+5nP4gpNfy8THAgjbOAwaGnKj
	 Cep9+3F4/nLKeL0UIORXmVe0yEWAaKNtsmkjPh3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgB0Noa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730218AbgB0No3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:44:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4600920578;
        Thu, 27 Feb 2020 13:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811068;
        bh=2j9IIT2JYjYm4/5MWQQiDIMrm9oM+yuL54XZpkKfbyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0c4saDxlxmpw5M1LDZBxqL1TwtqNVaj3d+lWPkvL1rgwJOWUWsQumGVHDh0n1ExoX
         kgY64kUsZDQhIsS9BGV3BsfkwYc97YaBqfKrRBdajDcd2IJ7HGBV4jMR1ZVmSEGcB7
         Y8YISYhXdTqt39HJPDVDQQeaVgDIagOjoB/rbp+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 097/113] VT_RESIZEX: get rid of field-by-field copyin
Date:   Thu, 27 Feb 2020 14:36:53 +0100
Message-Id: <20200227132227.248273302@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132211.791484803@linuxfoundation.org>
References: <20200227132211.791484803@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 1b3bce4d6bf839304a90951b4b25a5863533bf2a ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vt_ioctl.c | 68 ++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index a86bc7afb3b28..a1e5c408c931b 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -850,58 +850,44 @@ int vt_ioctl(struct tty_struct *tty,
 
 	case VT_RESIZEX:
 	{
-		struct vt_consize __user *vtconsize = up;
-		ushort ll,cc,vlin,clin,vcol,ccol;
+		struct vt_consize v;
 		if (!perm)
 			return -EPERM;
-		if (!access_ok(VERIFY_READ, vtconsize,
-				sizeof(struct vt_consize))) {
-			ret = -EFAULT;
-			break;
-		}
+		if (copy_from_user(&v, up, sizeof(struct vt_consize)))
+			return -EFAULT;
 		/* FIXME: Should check the copies properly */
-		__get_user(ll, &vtconsize->v_rows);
-		__get_user(cc, &vtconsize->v_cols);
-		__get_user(vlin, &vtconsize->v_vlin);
-		__get_user(clin, &vtconsize->v_clin);
-		__get_user(vcol, &vtconsize->v_vcol);
-		__get_user(ccol, &vtconsize->v_ccol);
-		vlin = vlin ? vlin : vc->vc_scan_lines;
-		if (clin) {
-			if (ll) {
-				if (ll != vlin/clin) {
-					/* Parameters don't add up */
-					ret = -EINVAL;
-					break;
-				}
-			} else 
-				ll = vlin/clin;
+		if (!v.v_vlin)
+			v.v_vlin = vc->vc_scan_lines;
+		if (v.v_clin) {
+			int rows = v.v_vlin/v.v_clin;
+			if (v.v_rows != rows) {
+				if (v.v_rows) /* Parameters don't add up */
+					return -EINVAL;
+				v.v_rows = rows;
+			}
 		}
-		if (vcol && ccol) {
-			if (cc) {
-				if (cc != vcol/ccol) {
-					ret = -EINVAL;
-					break;
-				}
-			} else
-				cc = vcol/ccol;
+		if (v.v_vcol && v.v_ccol) {
+			int cols = v.v_vcol/v.v_ccol;
+			if (v.v_cols != cols) {
+				if (v.v_cols)
+					return -EINVAL;
+				v.v_cols = cols;
+			}
 		}
 
-		if (clin > 32) {
-			ret =  -EINVAL;
-			break;
-		}
-		    
+		if (v.v_clin > 32)
+			return -EINVAL;
+
 		for (i = 0; i < MAX_NR_CONSOLES; i++) {
 			if (!vc_cons[i].d)
 				continue;
 			console_lock();
-			if (vlin)
-				vc_cons[i].d->vc_scan_lines = vlin;
-			if (clin)
-				vc_cons[i].d->vc_font.height = clin;
+			if (v.v_vlin)
+				vc_cons[i].d->vc_scan_lines = v.v_vlin;
+			if (v.v_clin)
+				vc_cons[i].d->vc_font.height = v.v_clin;
 			vc_cons[i].d->vc_resize_user = 1;
-			vc_resize(vc_cons[i].d, cc, ll);
+			vc_resize(vc_cons[i].d, v.v_cols, v.v_rows);
 			console_unlock();
 		}
 		break;
-- 
2.20.1



