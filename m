Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBC0CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60AF220740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363550;
	bh=ZuB+gw9ZoEOdoMX/3lgixjJvw6tsb6ZPvbabwUWcTlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B1KKI+hA818kOqRGWOfmwpezdYOgJaz5tPEq2T8Mpu+NRkaNCttNO4M2Lm4kHgwJP
	 LBRuVhnDEbVXlYWrVus73ozNqDZ+F7CXu3EVUZb+FThSlRiNliAviyKHAjZWZlU5NI
	 89EKGhBgIROUKWuXfwtzyPDYNz9A6sJAIu4ovYtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbgEMJw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732878AbgEMJwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:52:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0CF7206D6;
        Wed, 13 May 2020 09:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363543;
        bh=ZuB+gw9ZoEOdoMX/3lgixjJvw6tsb6ZPvbabwUWcTlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7D7sUhpKUUwa2Z4zFhU1Odgdyt6kwxbrgxOA2Ec9V5letwoxcyrsNIj3andppX9K
         6PU/sO3EtMnjsUCFARUNv2cHC8d+DzM3nbBmU5lV38LqTCqW1+ldqjdACQlg+TroPh
         5Pu8VXfDea431peFOViBEbXXZ8y7rAsUYOaRD6mk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
        syzbot+0bfda3ade1ee9288a1be@syzkaller.appspotmail.com,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 005/118] vt: fix unicode console freeing with a common interface
Date:   Wed, 13 May 2020 11:43:44 +0200
Message-Id: <20200513094418.099677638@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Pitre <nico@fluxnic.net>

[ Upstream commit 57d38f26d81e4275748b69372f31df545dcd9b71 ]

By directly using kfree() in different places we risk missing one if
it is switched to using vfree(), especially if the corresponding
vmalloc() is hidden away within a common abstraction.

Oh wait, that's exactly what happened here.

So let's fix this by creating a common abstraction for the free case
as well.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
Reported-by: syzbot+0bfda3ade1ee9288a1be@syzkaller.appspotmail.com
Fixes: 9a98e7a80f95 ("vt: don't use kmalloc() for the unicode screen buffer")
Cc: <stable@vger.kernel.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://lore.kernel.org/r/nycvar.YSQ.7.76.2005021043110.2671@knanqh.ubzr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index cc1a041913654..699d8b56cbe75 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -365,9 +365,14 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
 	return uniscr;
 }
 
+static void vc_uniscr_free(struct uni_screen *uniscr)
+{
+	vfree(uniscr);
+}
+
 static void vc_uniscr_set(struct vc_data *vc, struct uni_screen *new_uniscr)
 {
-	vfree(vc->vc_uni_screen);
+	vc_uniscr_free(vc->vc_uni_screen);
 	vc->vc_uni_screen = new_uniscr;
 }
 
@@ -1230,7 +1235,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	err = resize_screen(vc, new_cols, new_rows, user);
 	if (err) {
 		kfree(newscreen);
-		kfree(new_uniscr);
+		vc_uniscr_free(new_uniscr);
 		return err;
 	}
 
-- 
2.20.1



