Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FB1C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391152222C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587044575;
	bh=UrwSOr4h2UrF7KC5Oh4oX+BltuND9X9C5BW/wnK2KGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FTosQFzZyoChFtiUtSFpKu9sYbJre6ujZlVvlhmFWhpYxO2lF6ZyBwBNWDMgBiTtz
	 05fqmF2iPwgAAgIEzZMJqRr9gYHEqPHLApCB67SPXlKloJC3kEmMLsKMKfDWkEVsqX
	 oXgbb+2UC/mRVU7MU542enlZekXBYROp5hJJ+TGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441578AbgDPNmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896687AbgDPNdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:33:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC71722201;
        Thu, 16 Apr 2020 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043991;
        bh=UrwSOr4h2UrF7KC5Oh4oX+BltuND9X9C5BW/wnK2KGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkPjcAYnM7agpiwmdlv0PDVFvQdJ0ocHzw6AORfV0ZPenSoRtck/wxGhRB5PLANKL
         ii04yOT6MvUbNSoN7De91h7OB1a+pjcpN2WiVvyiSkNG5287cfYlyfMszUu2SLKjKN
         mNwC618uvfehBD0h1zmPE6Lfrr9lE17GM8sE3utw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@suse.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 029/257] EDAC/mc: Report "unknown memory" on too many DIMM labels found
Date:   Thu, 16 Apr 2020 15:21:20 +0200
Message-Id: <20200416131329.582557948@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@marvell.com>

[ Upstream commit 65bb4d1af92cf007adc0a0c59dadcc393c5cada6 ]

There is a limitation to report only EDAC_MAX_LABELS in e->label of
the error descriptor. This is to prevent a potential string overflow.

The current implementation falls back to "any memory" in this case and
also stops all further processing to find a unique row and channel of
the possible error location.

Reporting "any memory" is wrong as the memory controller reported an
error location for one of the layers. Instead, report "unknown memory"
and also do not break early in the loop to further check row and channel
for uniqueness.

 [ bp: Massage commit message. ]

Signed-off-by: Robert Richter <rrichter@marvell.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Aristeu Rozanski <aris@redhat.com>
Link: https://lkml.kernel.org/r/20200123090210.26933-7-rrichter@marvell.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/edac_mc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 69e0d90460e6c..2349f2ad946bb 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1180,20 +1180,21 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
 		 * channel/memory controller/...  may be affected.
 		 * Also, don't show errors for empty DIMM slots.
 		 */
-		if (!e->enable_per_layer_report || !dimm->nr_pages)
+		if (!dimm->nr_pages)
 			continue;
 
-		if (n_labels >= EDAC_MAX_LABELS) {
-			e->enable_per_layer_report = false;
-			break;
-		}
 		n_labels++;
-		if (p != e->label) {
-			strcpy(p, OTHER_LABEL);
-			p += strlen(OTHER_LABEL);
+		if (n_labels > EDAC_MAX_LABELS) {
+			p = e->label;
+			*p = '\0';
+		} else {
+			if (p != e->label) {
+				strcpy(p, OTHER_LABEL);
+				p += strlen(OTHER_LABEL);
+			}
+			strcpy(p, dimm->label);
+			p += strlen(p);
 		}
-		strcpy(p, dimm->label);
-		p += strlen(p);
 
 		/*
 		 * get csrow/channel of the DIMM, in order to allow
-- 
2.20.1



