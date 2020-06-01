Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5644C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F76B206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035565;
	bh=rcGXyxVBSk7HlozhEm2slr0mzTvuHZEvCmq80wwX4hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lAbz4DB/UajyBv073D//kfe2mboPka7bff3uQKxD0p1SdsNjbOijW35HAiE8b78Dn
	 lP4E3yQpOoErenWmdov9EGJnFCi8UkRJrDcwvoM2fGA4Kld45YlhKZK34t0eBf1Wxs
	 csWKN99mqeIBdrHk5BDXkZ/PpbwUox/uKAA5MzmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgFASRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729783AbgFASRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:17:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A342068D;
        Mon,  1 Jun 2020 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035422;
        bh=rcGXyxVBSk7HlozhEm2slr0mzTvuHZEvCmq80wwX4hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vxG2SuVebm74tlG6D6TXXzz5Imx7XHQLk9igQfEIIYbewoLqHl9d9iaNg1IfXDpDX
         cugeHva4zKrMEqV20L2tET5UTaRGTiPdacC97E0MhVxXIQX1T0aV1ncZAy+hyVg3+B
         6l/k3ii0EtoBCg+6IF9IboMfQ1TwGpfzVRQTyJ9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Antony Antony <antony@phenome.org>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.6 152/177] xfrm: fix error in comment
Date:   Mon,  1 Jun 2020 19:54:50 +0200
Message-Id: <20200601174101.073042657@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antony Antony <antony@phenome.org>

commit 29e4276667e24ee6b91d9f91064d8fda9a210ea1 upstream.

s/xfrm_state_offload/xfrm_user_offload/

Fixes: d77e38e612a ("xfrm: Add an IPsec hardware offloading API")
Signed-off-by: Antony Antony <antony@phenome.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/xfrm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -304,7 +304,7 @@ enum xfrm_attr_type_t {
 	XFRMA_PROTO,		/* __u8 */
 	XFRMA_ADDRESS_FILTER,	/* struct xfrm_address_filter */
 	XFRMA_PAD,
-	XFRMA_OFFLOAD_DEV,	/* struct xfrm_state_offload */
+	XFRMA_OFFLOAD_DEV,	/* struct xfrm_user_offload */
 	XFRMA_SET_MARK,		/* __u32 */
 	XFRMA_SET_MARK_MASK,	/* __u32 */
 	XFRMA_IF_ID,		/* __u32 */


