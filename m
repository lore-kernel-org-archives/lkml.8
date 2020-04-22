Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7395AC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4364820774
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549999;
	bh=e0BLSrIFRbPvC47jx0c234YbzrAFTYQdeTkVFHy1MJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HgMptl7QTcntNb+bfvgnsxGyiZ17Jz2aBKSCINbcCO1/7F5Wq14ELobCNW7eg9d/8
	 GGlAiy3Q5e5fmfgFhCIrMizGXtaOVPDGRG/mwkOTW3NJLurLoAP61CSZKrlE2CUlfJ
	 kisZ8xqLN8xk+CJWcK9zbmDtm+jbvj9zy2fcqTZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgDVKGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbgDVKGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:06:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8908420774;
        Wed, 22 Apr 2020 10:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549994;
        bh=e0BLSrIFRbPvC47jx0c234YbzrAFTYQdeTkVFHy1MJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/WFXit/83hu98Nkc7HbVTXsL20l9ucnEAfn+wMPRgHBZhwE9s27mcFHwCQ5BxZPu
         ztoovFTmhasQaUE0/55/qiKFxv50rexAIrOBKQl6KWgUOfx4e/1LBrzBRrZN7OBGV5
         T+uo3fPxleL48blwA88aV3XRcGwLi1wHya5r5Rf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Moriarty <joe.moriarty@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.9 090/125] drm: NULL pointer dereference [null-pointer-deref] (CWE 476) problem
Date:   Wed, 22 Apr 2020 11:56:47 +0200
Message-Id: <20200422095047.524731877@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Moriarty <joe.moriarty@oracle.com>

commit 22a07038c0eaf4d1315a493ce66dcd255accba19 upstream.

The Parfait (version 2.1.0) static code analysis tool found the
following NULL pointer derefernce problem.

- drivers/gpu/drm/drm_dp_mst_topology.c
The call to drm_dp_calculate_rad() in function drm_dp_port_setup_pdt()
could result in a NULL pointer being returned to port->mstb due to a
failure to allocate memory for port->mstb.

Signed-off-by: Joe Moriarty <joe.moriarty@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20180212195144.98323-3-joe.moriarty@oracle.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_dp_mst_topology.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1041,10 +1041,12 @@ static bool drm_dp_port_setup_pdt(struct
 		lct = drm_dp_calculate_rad(port, rad);
 
 		port->mstb = drm_dp_add_mst_branch_device(lct, rad);
-		port->mstb->mgr = port->mgr;
-		port->mstb->port_parent = port;
+		if (port->mstb) {
+			port->mstb->mgr = port->mgr;
+			port->mstb->port_parent = port;
 
-		send_link = true;
+			send_link = true;
+		}
 		break;
 	}
 	return send_link;


