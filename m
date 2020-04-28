Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422B9C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203E82085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098846;
	bh=lu+rWn0DuPCOc6t/Q8s2CXZu/8GtE0gGQvraLXW4+mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CG67eB1I1YrtiDG8U3+Xip0OdKQgAOIQkJuKa36FwfYZvXOclQskR2pytncmKQvUE
	 4ks3uf4cqAZf3BGu5zdIVcnFNJ0lLOiY87YwnpKXkVDViCZ4SVKDmO6oDYvaCJsftn
	 4Lc6aSrJP87+sWedz1+I+0vLgdalx1KHR73F3lRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgD1SeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbgD1SeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:34:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67EEC2085B;
        Tue, 28 Apr 2020 18:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098841;
        bh=lu+rWn0DuPCOc6t/Q8s2CXZu/8GtE0gGQvraLXW4+mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eobwr+Eui/IJTbttVNwjbKWC2kjW2GpgFNNLgC7Hc9og/JIVtnsnfnEOiC70YSTlo
         j5bsD4/Km6bcoz1UoX9XwB0pMMcLhp9QHctv4u9//0ThJc801FqJ9wv41NNKF0nnhy
         Jfh4id444wrd5OjYTaalb8PY97AfwdlIQLwCD+Ss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikita Lipski <mikita.lipski@amd.com>,
        Lyude Paul <lyude@redhat.com>
Subject: [PATCH 5.6 119/167] drm/dp_mst: Zero assigned PBN when releasing VCPI slots
Date:   Tue, 28 Apr 2020 20:24:55 +0200
Message-Id: <20200428182240.281525612@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikita Lipski <mikita.lipski@amd.com>

commit 7bfc1fec1af3e2f0194843855b0d49054fa42fd2 upstream.

Zero Port's PBN together with VCPI slots when releasing
allocated VCPI slots. That way when disabling the connector
it will not cause issues in drm_dp_mst_atomic_check verifying
branch bw limit.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: cd82d82cbc04 ("drm/dp_mst: Add branch bandwidth validation to MST atomic check")
Cc: <stable@vger.kernel.org> # v5.6+
Link: https://patchwork.freedesktop.org/patch/msgid/20200407160717.27976-1-mikita.lipski@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_dp_mst_topology.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4290,6 +4290,7 @@ int drm_dp_atomic_release_vcpi_slots(str
 	if (pos->vcpi) {
 		drm_dp_mst_put_port_malloc(port);
 		pos->vcpi = 0;
+		pos->pbn = 0;
 	}
 
 	return 0;


