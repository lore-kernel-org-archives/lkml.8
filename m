Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73BDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B70D2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035058;
	bh=H7naidMd5Qa0u04rOXvuNj7VG6ToA776KEDM8xBVLYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vSf8DVnrM83n7fH/39azZuzA1TtUBCb9Yv+AqNBMRFDt0Zw4bLGCnZW/goy6r0JVC
	 26+UaI/yfGhFi5w1OwmeN+eMAYEusrxiBVPOdI3geKkiL/wSdKQHIskHzQS12WVOAS
	 udd4v3xxlpUhwL8kERq6n1FHMDfmuMXCvj7mOlhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgFASK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731012AbgFASKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:10:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2053206E2;
        Mon,  1 Jun 2020 18:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035042;
        bh=H7naidMd5Qa0u04rOXvuNj7VG6ToA776KEDM8xBVLYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+MDhmO/PbA39SKoyuYBQGOCKCYhIKN5WvJpAIbZvtl+5xEpo/Zk4bUZ7ttFTUe9b
         hKCfY/jA3HKMNO1ipS5G9qb00VBjXzHQagZk49UgXkxhv1AR4yzXt32Lrjf0JxCJqS
         n2NeGUSte516/Om3YPfStCMWxQy13FS4SJMWLDT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.4 126/142] esp6: get the right proto for transport mode in esp6_gso_encap
Date:   Mon,  1 Jun 2020 19:54:44 +0200
Message-Id: <20200601174050.848248627@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

commit 3c96ec56828922e3fe5477f75eb3fc02f98f98b5 upstream.

For transport mode, when ipv6 nexthdr is set, the packet format might
be like:

    ----------------------------------------------------
    |        | dest |     |     |      |  ESP    | ESP |
    | IP6 hdr| opts.| ESP | TCP | Data | Trailer | ICV |
    ----------------------------------------------------

What it wants to get for x-proto in esp6_gso_encap() is the proto that
will be set in ESP nexthdr. So it should skip all ipv6 nexthdrs and
get the real transport protocol. Othersize, the wrong proto number
will be set into ESP nexthdr.

This patch is to skip all ipv6 nexthdrs by calling ipv6_skip_exthdr()
in esp6_gso_encap().

Fixes: 7862b4058b9f ("esp: Add gso handlers for esp4 and esp6")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/esp6_offload.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -121,9 +121,16 @@ static void esp6_gso_encap(struct xfrm_s
 	struct ip_esp_hdr *esph;
 	struct ipv6hdr *iph = ipv6_hdr(skb);
 	struct xfrm_offload *xo = xfrm_offload(skb);
-	int proto = iph->nexthdr;
+	u8 proto = iph->nexthdr;
 
 	skb_push(skb, -skb_network_offset(skb));
+
+	if (x->outer_mode.encap == XFRM_MODE_TRANSPORT) {
+		__be16 frag;
+
+		ipv6_skip_exthdr(skb, sizeof(struct ipv6hdr), &proto, &frag);
+	}
+
 	esph = ip_esp_hdr(skb);
 	*skb_mac_header(skb) = IPPROTO_ESP;
 


