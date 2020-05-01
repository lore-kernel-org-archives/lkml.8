Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3776AC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C63D24955
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339869;
	bh=edkgb4YFtV0pjk4fMcb3zIHYot/KfuGSfN95srNmDaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PfO+u14sx591mXjk3hC4MmjirIY3ESnEw0pkXinqqhX7qnBRk2JIkvp2EBOtGuQgK
	 Py4Of6SMWK5IYzj8QyYTo+vrmzkohHW1ndgSk6a50qcWfZu3sp+6a1WJ9ywQW/lKVk
	 QNo8h3VSrTuyycvlaZvIvNN+7SeFeDU5slM55d9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgEANbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729542AbgEANbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:31:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2886D208D6;
        Fri,  1 May 2020 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339864;
        bh=edkgb4YFtV0pjk4fMcb3zIHYot/KfuGSfN95srNmDaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlFTd18a/+PdkdlO5xvC9RvUrJJYtTe06niY5Owkq+pbTW/6Q77yEg2duGVt5tNFU
         JcLAzyJzcVQ7zb5yFPRj3S+ImHIbxEz5024NV/PWqyXBAzZ/TGES6It+cQd2pRRDFl
         62uX0Gq+KTRi+TtCrMFfwwtaEVe4/fvKDdWMCq5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 002/117] net: ipv4: emulate READ_ONCE() on ->hdrincl bit-field in raw_sendmsg()
Date:   Fri,  1 May 2020 15:20:38 +0200
Message-Id: <20200501131544.590806170@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolai Stange <nstange@suse.de>

commit 20b50d79974ea3192e8c3ab7faf4e536e5f14d8f upstream.

Commit 8f659a03a0ba ("net: ipv4: fix for a race condition in
raw_sendmsg") fixed the issue of possibly inconsistent ->hdrincl handling
due to concurrent updates by reading this bit-field member into a local
variable and using the thus stabilized value in subsequent tests.

However, aforementioned commit also adds the (correct) comment that

  /* hdrincl should be READ_ONCE(inet->hdrincl)
   * but READ_ONCE() doesn't work with bit fields
   */

because as it stands, the compiler is free to shortcut or even eliminate
the local variable at its will.

Note that I have not seen anything like this happening in reality and thus,
the concern is a theoretical one.

However, in order to be on the safe side, emulate a READ_ONCE() on the
bit-field by doing it on the local 'hdrincl' variable itself:

	int hdrincl = inet->hdrincl;
	hdrincl = READ_ONCE(hdrincl);

This breaks the chain in the sense that the compiler is not allowed
to replace subsequent reads from hdrincl with reloads from inet->hdrincl.

Fixes: 8f659a03a0ba ("net: ipv4: fix for a race condition in raw_sendmsg")
Signed-off-by: Nicolai Stange <nstange@suse.de>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/raw.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -520,9 +520,11 @@ static int raw_sendmsg(struct sock *sk,
 		goto out;
 
 	/* hdrincl should be READ_ONCE(inet->hdrincl)
-	 * but READ_ONCE() doesn't work with bit fields
+	 * but READ_ONCE() doesn't work with bit fields.
+	 * Doing this indirectly yields the same result.
 	 */
 	hdrincl = inet->hdrincl;
+	hdrincl = READ_ONCE(hdrincl);
 	/*
 	 *	Check the flags.
 	 */


