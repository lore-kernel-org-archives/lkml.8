Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B01C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD9D204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596097303;
	bh=Eph3QW0aaPO48pHnrnIKuOzspV351jibzFbPUh/gqyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uX6PjiuHapXwoETQa+uhuC30M1Dyndc/FPOk2js6mHCdfiFVBxxUBT4VhujoxFHmu
	 KabdO3raogVCCU24pCqUMJuTZ4U4ijOGOMeaSrfd2AGmncu/YpZIghS1SEjo3U1amR
	 O1MgvyNg8OIVJIPsrHxoM7oDltph0O+xiz8HO7Bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgG3IEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbgG3IEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:04:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CCAA20672;
        Thu, 30 Jul 2020 08:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096279;
        bh=Eph3QW0aaPO48pHnrnIKuOzspV351jibzFbPUh/gqyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPvC8dVISs7myLuevf6cr63oR5X1Uzg2KAPcv3BloNtKGAUQ/5Nqt7TMaiJ6TpuUi
         is3QWo0hn0nOisZ2MH4oNdS6e83qKx6a2tvg4s2QnPHR1hprCUEKJ9qO/DH6e0XtMe
         n+apuMnXaIZNlvDYUL2M76+HQmG7O6PfZtlbswZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c82752228ed975b0a623@syzkaller.appspotmail.com,
        Peilin Ye <yepeilin.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 01/20] AX.25: Fix out-of-bounds read in ax25_connect()
Date:   Thu, 30 Jul 2020 10:03:51 +0200
Message-Id: <20200730074420.605225404@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.533211699@linuxfoundation.org>
References: <20200730074420.533211699@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peilin Ye <yepeilin.cs@gmail.com>

[ Upstream commit 2f2a7ffad5c6cbf3d438e813cfdc88230e185ba6 ]

Checks on `addr_len` and `fsa->fsa_ax25.sax25_ndigis` are insufficient.
ax25_connect() can go out of bounds when `fsa->fsa_ax25.sax25_ndigis`
equals to 7 or 8. Fix it.

This issue has been reported as a KMSAN uninit-value bug, because in such
a case, ax25_connect() reaches into the uninitialized portion of the
`struct sockaddr_storage` statically allocated in __sys_connect().

It is safe to remove `fsa->fsa_ax25.sax25_ndigis > AX25_MAX_DIGIS` because
`addr_len` is guaranteed to be less than or equal to
`sizeof(struct full_sockaddr_ax25)`.

Reported-by: syzbot+c82752228ed975b0a623@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=55ef9d629f3b3d7d70b69558015b63b48d01af66
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ax25/af_ax25.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1187,7 +1187,9 @@ static int __must_check ax25_connect(str
 	if (addr_len > sizeof(struct sockaddr_ax25) &&
 	    fsa->fsa_ax25.sax25_ndigis != 0) {
 		/* Valid number of digipeaters ? */
-		if (fsa->fsa_ax25.sax25_ndigis < 1 || fsa->fsa_ax25.sax25_ndigis > AX25_MAX_DIGIS) {
+		if (fsa->fsa_ax25.sax25_ndigis < 1 ||
+		    addr_len < sizeof(struct sockaddr_ax25) +
+		    sizeof(ax25_address) * fsa->fsa_ax25.sax25_ndigis) {
 			err = -EINVAL;
 			goto out_release;
 		}


