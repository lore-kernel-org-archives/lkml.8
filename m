Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F17C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570A020873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519962;
	bh=RuLq6l8ghx9Awz92TTEnXKdInMZwwPpwZ5Rs6CRv5QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NiEdgT2cJGofM0EHcj9Cw5261WUDRSAAxSDa2MVeezlNDDVNNpgYjtUasUvyhSbVA
	 8qaGX4fqqGUrV1Tys8Y9/johlFYD8Lw9CLJsgdvKPWLA/1d92TXU1g4CktoLjBPjUV
	 mXAqKJNWEHW6mHAqva8E+u7Ju5ljSt3ras3s6FsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391638AbgEZTGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391553AbgEZTFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:05:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 213F4208A7;
        Tue, 26 May 2020 19:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519953;
        bh=RuLq6l8ghx9Awz92TTEnXKdInMZwwPpwZ5Rs6CRv5QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnmV2ErpL6fWK3eDv2yX00Ue3P2PEh6f2nkmYqKbIu2KXt4K2G1OgNAxMCE5roCbv
         vQFwog9MSCyWH05oInrwFouTIsTv0/3dkjSaiJ22byCc+8EEHt/7ySZZkjqHMorqUq
         O1m1DvBlxXk65apZKdlZh+cUNEI8QCjI5iT0AkSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 56/81] media: fdp1: Fix R-Car M3-N naming in debug message
Date:   Tue, 26 May 2020 20:53:31 +0200
Message-Id: <20200526183933.346588333@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit c05b9d7b9f3ece2831e4e4829f10e904df296df8 ]

The official name is "R-Car M3-N", not "R-Car M3N".

Fixes: 4e8c120de9268fc2 ("media: fdp1: Support M3N and E3 platforms")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar_fdp1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/rcar_fdp1.c
+++ b/drivers/media/platform/rcar_fdp1.c
@@ -2368,7 +2368,7 @@ static int fdp1_probe(struct platform_de
 		dprintk(fdp1, "FDP1 Version R-Car H3\n");
 		break;
 	case FD1_IP_M3N:
-		dprintk(fdp1, "FDP1 Version R-Car M3N\n");
+		dprintk(fdp1, "FDP1 Version R-Car M3-N\n");
 		break;
 	case FD1_IP_E3:
 		dprintk(fdp1, "FDP1 Version R-Car E3\n");


