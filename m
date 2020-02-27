Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD28C52D46
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D648D20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812176;
	bh=ZznlblGTBFbuds+Sph5WVVJsc6irhIrrzO9HTsUYnug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2XnyO9nlyK6sDcBjf8yaMUAX0lsLpPtahrD0Rn369VPVmnIwqcIauEmg45b1hnWsY
	 qQEJ6ZkpS3xHORNM8UqOaiks+myu7cQGDbYQ2/5GeuOCLTbzVeF7b3foIBANe8BBgz
	 M9AJIDtWle7dQHNhbpOUpYUi2hkaLhtpUvLbwMdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbgB0OCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:02:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733221AbgB0OCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:02:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC0E24656;
        Thu, 27 Feb 2020 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812172;
        bh=ZznlblGTBFbuds+Sph5WVVJsc6irhIrrzO9HTsUYnug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqSE5O+w5PE3lMJTnWYGOsyqlWq3MCyawoRs4k3ay4OhAmYVOU1RGnaTyvIEX1/Tr
         BcdSpmykivnY0jo0ltQYCBCGMnCEnkUu4x0ItIzWWS79IiaWB3AgJdfyUQEK8ukU4f
         tbl6jDp+zxNcCerrZsoV4UCmqcZubdto59rtOAoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.19 13/97] vt: fix scrollback flushing on background consoles
Date:   Thu, 27 Feb 2020 14:36:21 +0100
Message-Id: <20200227132216.796677344@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Pitre <nico@fluxnic.net>

commit 3f4ef485be9d54040b695f32ec76d0f1ea50bbf3 upstream.

Commit a6dbe4427559 ("vt: perform safe console erase in the right
order") provided fixes to an earlier commit by gathering all console
scrollback flushing operations in a function of its own. This includes
the invocation of vc_sw->con_switch() as previously done through a
update_screen() call. That commit failed to carry over the
con_is_visible() conditional though, as well as cursor handling, which
caused problems when "\e[3J" was written to a background console.

One could argue for preserving the call to update_screen(). However
this does far more than we need, and it is best to remove scrollback
assumptions from it. Instead let's gather the minimum needed to actually
perform scrollback flushing properly in that one place.

While at it, let's document the vc_sw->con_switch() side effect being
relied upon.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
Reported-and-tested-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/nycvar.YSQ.7.76.2001281205560.1655@knanqh.ubzr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -936,10 +936,21 @@ static void flush_scrollback(struct vc_d
 	WARN_CONSOLE_UNLOCKED();
 
 	set_origin(vc);
-	if (vc->vc_sw->con_flush_scrollback)
+	if (vc->vc_sw->con_flush_scrollback) {
 		vc->vc_sw->con_flush_scrollback(vc);
-	else
+	} else if (con_is_visible(vc)) {
+		/*
+		 * When no con_flush_scrollback method is provided then the
+		 * legacy way for flushing the scrollback buffer is to use
+		 * a side effect of the con_switch method. We do it only on
+		 * the foreground console as background consoles have no
+		 * scrollback buffers in that case and we obviously don't
+		 * want to switch to them.
+		 */
+		hide_cursor(vc);
 		vc->vc_sw->con_switch(vc);
+		set_cursor(vc);
+	}
 }
 
 /*


