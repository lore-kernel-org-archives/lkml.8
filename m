Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA76C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF8F20787
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623219;
	bh=ybMxabZn+LAHW5r0IG3LlRQP9yHidLzv795RMLLHfhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oh7sCDtcqPymsh7YV0hubCz/4e1nJJ2c55zeaAEPf/Y3BMCBXKL3dUQJhmf/ZDWAc
	 OHHkPekHroxpA/ZxCrL/hovNYxqZgJCfV4yLKXdevDLTd6ZBsfgkfajO9A5NpcDbaG
	 sNu3jTKYEBaYfCsc7cLggiPY2JuJcG+isa11wRNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgCSNGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbgCSNGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:06:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB8C20732;
        Thu, 19 Mar 2020 13:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623210;
        bh=ybMxabZn+LAHW5r0IG3LlRQP9yHidLzv795RMLLHfhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KeEY22qDnh/DdvSoqftFCFkoMbtpdmZwWlRgf3o29WN/TnF25oJF4DbaU7JkzPYjj
         OnGzRSU5maN7eY41HcfFzAXOjVLAJ+UoDZU2FwwHsbIyLLmyJr1+7b4xX8P0HgobER
         g2eq7JkctGlxBqWwWhJrXvrJ7X7leodKVCl/6ZgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Antonio Quartulli <a@unstable.cc>
Subject: [PATCH 4.4 45/93] batman-adv: Deactivate TO_BE_ACTIVATED hardif on shutdown
Date:   Thu, 19 Mar 2020 13:59:49 +0100
Message-Id: <20200319123939.275764946@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

commit f2d23861b818d08bcd15cc1612ae94aa33b3931c upstream.

The shutdown of an batman-adv interface can happen with one of its slave
interfaces still being in the BATADV_IF_TO_BE_ACTIVATED state. A possible
reason for it is that the routing algorithm BATMAN_V was selected and
batadv_schedule_bat_ogm was not yet called for this interface. This slave
interface still has to be set to BATADV_IF_INACTIVE or the batman-adv
interface will never reduce its usage counter and thus never gets shutdown.

This problem can be simulated via:

    $ modprobe dummy
    $ modprobe batman-adv routing_algo=BATMAN_V
    $ ip link add bat0 type batadv
    $ ip link set dummy0 master bat0
    $ ip link set dummy0 up
    $ ip link del bat0
    unregister_netdevice: waiting for bat0 to become free. Usage count = 3

Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/hard-interface.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -562,8 +562,7 @@ void batadv_hardif_disable_interface(str
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_hard_iface *primary_if = NULL;
 
-	if (hard_iface->if_status == BATADV_IF_ACTIVE)
-		batadv_hardif_deactivate_interface(hard_iface);
+	batadv_hardif_deactivate_interface(hard_iface);
 
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;


