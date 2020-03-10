Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AEFC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E6624693
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845824;
	bh=dUpZZJ1pLzjB+74R7fnytlWCIkclNMrGtPyjibdV5Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GESMfVIkdUMUMaQLVJCi+iDVs5xhfZG7/pBLFH160r11V6fB5DFOp1FXQLzilLKOh
	 HRSz5dxGjrG7PrVOr9CzkwJdeLPx/3mbnmB3TvT/0LNDhBgbZ/uEz1bD4Ez4tWzuHB
	 VhbnRYsOW1mp9lGmG0spkBjiovi0k8GKJVKgvQ7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgCJNKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731316AbgCJNKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:10:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BA2E2468C;
        Tue, 10 Mar 2020 13:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845818;
        bh=dUpZZJ1pLzjB+74R7fnytlWCIkclNMrGtPyjibdV5Ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1lEGLxmeubvNzHbtNxw2H64AbElEp6xtBhEXb0qj4H8JwY022aNkQg1eV2OrRRD/
         bwTkgyifwRxAOgshJQxZKkKSv1bDQyykzT1tus9FVi03s52Qa8nHFXzthtXmcHqnKQ
         hukd/Kr4dFpZGDDfnTUhku4tzYzdq/h6ZmTXaPD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.14 094/126] usb: core: hub: fix unhandled return by employing a void function
Date:   Tue, 10 Mar 2020 13:41:55 +0100
Message-Id: <20200310124209.753686084@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniu Rosca <erosca@de.adit-jv.com>

commit 63d6d7ed475c53dc1cabdfedf63de1fd8dcd72ee upstream.

Address below Coverity complaint (Feb 25, 2020, 8:06 AM CET):

---
 drivers/usb/core/hub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1818,7 +1818,7 @@ static int hub_probe(struct usb_interfac
 
 	if (id->driver_info & HUB_QUIRK_DISABLE_AUTOSUSPEND) {
 		hub->quirk_disable_autosuspend = 1;
-		usb_autopm_get_interface(intf);
+		usb_autopm_get_interface_no_resume(intf);
 	}
 
 	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0)


