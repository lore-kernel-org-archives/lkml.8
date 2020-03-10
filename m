Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13FCC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C1D2469E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844731;
	bh=ECmkxUpoyr1wOSULnzk6Oo5QIYAGvgFnObdab+nzFdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cB5NzVkcpMGc/dmZkDlsm4KXrszD+YJq/oHPDsI1dcpGfiOyhXSq0/tsh2H3RJ7KV
	 IVYGA64vuvaeiZ6Ee9WvjVV3spcMju8l5SEoWu+W53fbOgXf86bQ6d+fKTzTY7rBvf
	 dvNfYEjYxHwPpqG26dC8RDBNpeEY7BRXDehrI9GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgCJMwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgCJMwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:52:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B2F2468E;
        Tue, 10 Mar 2020 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844726;
        bh=ECmkxUpoyr1wOSULnzk6Oo5QIYAGvgFnObdab+nzFdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkYRWIOiPHeN534CndoGwH33FIl6mo3kKsGVGG323U3cO+cf4OV5X37ujLgBzfvAX
         YC2OoJiEItCwacffNfRllH/RJw95WyN8QEoSg3P71mtwzk19lN6XmQecowfDa54sfq
         Gonlt7iA/Iad54yID6hK1yHDQurofsyWp7D/N0i0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 5.4 069/168] usb: cdns3: gadget: link trb should point to next request
Date:   Tue, 10 Mar 2020 13:38:35 +0100
Message-Id: <20200310123642.236417105@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

commit 8a7c47fb7285b23ca259c888016513d5566fa9e8 upstream.

It has marked the dequeue trb as link trb, but its next segment
pointer is still itself, it causes the transfer can't go on. Fix
it by set its pointer as the trb address for the next request.

Fixes: f616c3bda47e ("usb: cdns3: Fix dequeue implementation")
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200219141455.23257-2-peter.chen@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/cdns3/gadget.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2107,7 +2107,7 @@ found:
 	/* Update ring only if removed request is on pending_req_list list */
 	if (req_on_hw_ring) {
 		link_trb->buffer = TRB_BUFFER(priv_ep->trb_pool_dma +
-					      (priv_req->start_trb * TRB_SIZE));
+			((priv_req->end_trb + 1) * TRB_SIZE));
 		link_trb->control = (link_trb->control & TRB_CYCLE) |
 				    TRB_TYPE(TRB_LINK) | TRB_CHAIN;
 


