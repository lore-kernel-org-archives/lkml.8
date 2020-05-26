Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD1EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE32520849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521031;
	bh=dwPwdG0SK+kS1i7Rh+GeJcYZE0NSE+OYrDVqABO7+H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WfGKC4mI9YeLkrQU19mkxk962PH+QI4HvT2mqPEfziBTqulDesbgViNSy2KQqr8w7
	 Tif0lp6Ig3GkMumJ6PPHlr5Cjl5iTspfMbc37vyrFCFZxZ8vnz8IWh2K5ivahRc4Fh
	 W8QGtkCsXJ6D0nfHRaxqxOEDqp/FTGnQwfmlfQb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404526AbgEZTXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390612AbgEZTIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:08:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9493520873;
        Tue, 26 May 2020 19:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520120;
        bh=dwPwdG0SK+kS1i7Rh+GeJcYZE0NSE+OYrDVqABO7+H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yOHC1vWYajYDpy7cwOEmwlbDLub0Vfm9ovOywGboKbb7BSipU0qwLAT6NW0xEc1Hk
         5f0VlO0/Kw1hXPVl4ynTSYAnS7UbJnozgvWKCdP8s9itfKKso9rypKsDFhoi8kRlnJ
         GJb20WcqoWOLXrFTGYjZvfE0BCrQ3slLTdGKWdx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 5.4 065/111] drm/etnaviv: fix perfmon domain interation
Date:   Tue, 26 May 2020 20:53:23 +0200
Message-Id: <20200526183939.021178418@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Gmeiner <christian.gmeiner@gmail.com>

commit 40b697e256ccdb88aaff424b44b4d300eb8460e8 upstream.

The GC860 has one GPU device which has a 2d and 3d core. In this case
we want to expose perfmon information for both cores.

The driver has one array which contains all possible perfmon domains
with some meta data - doms_meta. Here we can see that for the GC860
two elements of that array are relevant:

  doms_3d: is at index 0 in the doms_meta array with 8 perfmon domains
  doms_2d: is at index 1 in the doms_meta array with 1 perfmon domain

The userspace driver wants to get a list of all perfmon domains and
their perfmon signals. This is done by iterating over all domains and
their signals. If the userspace driver wants to access the domain with
id 8 the kernel driver fails and returns invalid data from doms_3d with
and invalid offset.

This results in:
  Unable to handle kernel paging request at virtual address 00000000

On such a device it is not possible to use the userspace driver at all.

The fix for this off-by-one error is quite simple.

Reported-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Paul Cercueil <paul@crapouillou.net>
Fixes: ed1dd899baa3 ("drm/etnaviv: rework perfmon query infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -453,7 +453,7 @@ static const struct etnaviv_pm_domain *p
 		if (!(gpu->identity.features & meta->feature))
 			continue;
 
-		if (meta->nr_domains < (index - offset)) {
+		if (index - offset >= meta->nr_domains) {
 			offset += meta->nr_domains;
 			continue;
 		}


