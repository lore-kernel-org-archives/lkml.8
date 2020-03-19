Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367ACC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F288A206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623951;
	bh=lRTZN2oE+b/mRMO0TruZEH4BhQHL7dCEFWIEA4m/xVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gwxSfW2zvJiqLmFyXWCwXwltNjTzv0g6RLrtGOrcxnakSiyMtUIX/IJpDGVF+IALo
	 l8Yp9hdwnIP49u1ZfIGVZbSyyWORvVYbWcxuPQffK8c9qt6is4JN41RB1zBDyqZ+t+
	 QbMyBY4z/PuoOeA7KtNdzvfdR3rYJD3nl+4n+j0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgCSNTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbgCSNTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:19:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E73206D7;
        Thu, 19 Mar 2020 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623940;
        bh=lRTZN2oE+b/mRMO0TruZEH4BhQHL7dCEFWIEA4m/xVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3f642/QMPsVyoheIFjc2fuf/CCe9KfjaqvGqACeasF+OKK4dZb9AAe1xHdRm5m38
         bjVisJO4X3pU1+h22vHofbeW9eWta5t3C8VkFkaCZ+Gye/gcTQiKi0ZpreXLDhfV5J
         Om5IAtm0T6OHjRfpId8dNR7MpKhpR7etDAmXzpf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Eckelmann <sven.eckelmann@open-mesh.com>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.14 68/99] batman-adv: Always initialize fragment header priority
Date:   Thu, 19 Mar 2020 14:03:46 +0100
Message-Id: <20200319124001.868359273@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

commit fe77d8257c4d838c5976557ddb87bd789f312412 upstream.

The batman-adv unuicast fragment header contains 3 bits for the priority of
the packet. These bits will be initialized when the skb->priority contains
a value between 256 and 263. But otherwise, the uninitialized bits from the
stack will be used.

Fixes: c0f25c802b33 ("batman-adv: Include frame priority in fragment header")
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/fragmentation.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -500,6 +500,8 @@ int batadv_frag_send_packet(struct sk_bu
 	 */
 	if (skb->priority >= 256 && skb->priority <= 263)
 		frag_header.priority = skb->priority - 256;
+	else
+		frag_header.priority = 0;
 
 	ether_addr_copy(frag_header.orig, primary_if->net_dev->dev_addr);
 	ether_addr_copy(frag_header.dest, orig_node->orig);


