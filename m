Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71AAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1CEB20771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580016;
	bh=r2ZD/z74CHUpWNLziOf1yJLE0NiqYpuEhktxmoHnFwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1WmF9wuAP6v2IAdcyU8di7Jz3/sY5huFBvcF2QAQ1qOBR1+nF/QP/kI2FCmSfrCjA
	 RRj69V2K2tI+l/Rjp0c8NWcFeaydKpvwmqu5xNsi99plpFVJUByhrWIlCEpQHqwuXi
	 2XzE+dk2ijVXd2xUcaN/xjMTIo+KNPBhePfcqtLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391720AbgFSPUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392584AbgFSPSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:18:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50A092158C;
        Fri, 19 Jun 2020 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579897;
        bh=r2ZD/z74CHUpWNLziOf1yJLE0NiqYpuEhktxmoHnFwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pChlHCVbfeMpM7Jos/zL4FhCM+YiNWUOD68zmzpyFLtPMz4Dhdc/z+lgBSanBGclB
         4v76b79AIjPoFSp+tjbqZmpCSUiLXPo1QnQ4gPGQruAzH83WnZhrc5Smf3FPs4qw+j
         4LxeHWGOl+g54qLS9Vo7g/T19TRcDOBM1N7kvNOc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 044/376] ixgbe: Fix XDP redirect on archs with PAGE_SIZE above 4K
Date:   Fri, 19 Jun 2020 16:29:22 +0200
Message-Id: <20200619141712.443793335@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 88eb0ee17b2ece64fcf6689a4557a5c2e7a89c4b ]

The ixgbe driver have another memory model when compiled on archs with
PAGE_SIZE above 4096 bytes. In this mode it doesn't split the page in
two halves, but instead increment rx_buffer->page_offset by truesize of
packet (which include headroom and tailroom for skb_shared_info).

This is done correctly in ixgbe_build_skb(), but in ixgbe_rx_buffer_flip
which is currently only called on XDP_TX and XDP_REDIRECT, it forgets
to add the tailroom for skb_shared_info. This breaks XDP_REDIRECT, for
veth and cpumap.  Fix by adding size of skb_shared_info tailroom.

Maintainers notice: This fix have been queued to Jeff.

Fixes: 6453073987ba ("ixgbe: add initial support for xdp redirect")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Link: https://lore.kernel.org/bpf/158945344946.97035.17031588499266605743.stgit@firesoul
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 718931d951bc..ea6834bae04c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2254,7 +2254,8 @@ static void ixgbe_rx_buffer_flip(struct ixgbe_ring *rx_ring,
 	rx_buffer->page_offset ^= truesize;
 #else
 	unsigned int truesize = ring_uses_build_skb(rx_ring) ?
-				SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) :
+				SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) +
+				SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
 				SKB_DATA_ALIGN(size);
 
 	rx_buffer->page_offset += truesize;
-- 
2.25.1



