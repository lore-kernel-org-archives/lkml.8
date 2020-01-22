Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38821C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F4A24673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685463;
	bh=1sZwyDzsZStdE1HgfxdQMDQY0KfdLKvbmwsdZjONnM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=okPhVqtdaRnc4uWyxN40E6C9UrRvCviKzVXVMLNdeFYk+pvGXUJ7N6fcibcCdmgcW
	 MPsM4wPLlf6WNDw+OMCoBVJlEl5kYwIlPR3b/G97A6peGHxmy3rS5l0GHXLN2Oo19Q
	 syq/MzIDAtQPNDHMDcdUrgjZQ7+5ijmmV4JHicQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgAVJbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:31:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbgAVJa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:30:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2AFD2071E;
        Wed, 22 Jan 2020 09:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685456;
        bh=1sZwyDzsZStdE1HgfxdQMDQY0KfdLKvbmwsdZjONnM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0vbg6gL36Uwe3YfcXOEXWgy68g1d8fZZcIcSVXRxOqWpH7grdthjjKpgOAMD/oBTQ
         yro/HRvW8BMh1nZhdneKxtZAJ+CB7U1E54wUAyTB8cRlqDfr4RyG8fTS5ldXVWVLHB
         f1NcyeRaDrwz5LNgA/8Rv7D7FNQbGAsUwTASgBko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 21/76] hsr: reset network header when supervision frame is created
Date:   Wed, 22 Jan 2020 10:28:37 +0100
Message-Id: <20200122092753.778521511@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092751.587775548@linuxfoundation.org>
References: <20200122092751.587775548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

commit 3ed0a1d563903bdb4b4c36c58c4d9c1bcb23a6e6 upstream.

The supervision frame is L2 frame.
When supervision frame is created, hsr module doesn't set network header.
If tap routine is enabled, dev_queue_xmit_nit() is called and it checks
network_header. If network_header pointer wasn't set(or invalid),
it resets network_header and warns.
In order to avoid unnecessary warning message, resetting network_header
is needed.

Test commands:
    ip netns add nst
    ip link add veth0 type veth peer name veth1
    ip link add veth2 type veth peer name veth3
    ip link set veth1 netns nst
    ip link set veth3 netns nst
    ip link set veth0 up
    ip link set veth2 up
    ip link add hsr0 type hsr slave1 veth0 slave2 veth2
    ip a a 192.168.100.1/24 dev hsr0
    ip link set hsr0 up
    ip netns exec nst ip link set veth1 up
    ip netns exec nst ip link set veth3 up
    ip netns exec nst ip link add hsr1 type hsr slave1 veth1 slave2 veth3
    ip netns exec nst ip a a 192.168.100.2/24 dev hsr1
    ip netns exec nst ip link set hsr1 up
    tcpdump -nei veth0

Splat looks like:
[  175.852292][    C3] protocol 88fb is buggy, dev veth0

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/hsr/hsr_device.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -289,6 +289,8 @@ static void send_hsr_supervision_frame(s
 			    skb->dev->dev_addr, skb->len) <= 0)
 		goto out;
 	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
 
 	hsr_stag = (typeof(hsr_stag)) skb_put(skb, sizeof(*hsr_stag));
 


