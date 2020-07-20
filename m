Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3966C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B161A22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260177;
	bh=H7D3Miw68vud+znh8t/BZ0rXpdV6OGMQUH0kWEm/MbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UZ0urS70VYaa5hMR/K95ZB96k4rjyWmfqbaDlwa+9Nx8li6413gIWV6dsYQDZFwy6
	 vH46hQvkyn0aJ+EZXkP7UrF/+BeKxt9mxnCzP6Z8ODNQrYHfo1nkvprPke5mIUZuWw
	 5WLru1eTciIVus5upz+tFzt7HAEIeUKtUhtGW2oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgGTPtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbgGTPtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:49:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 913B02064B;
        Mon, 20 Jul 2020 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260172;
        bh=H7D3Miw68vud+znh8t/BZ0rXpdV6OGMQUH0kWEm/MbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEBr++ajramMBlkf/mAH2LDllc/WVhZTcEiZVJ330rpIg2ptdJEYDG0axWARWJUhM
         CwMDVR05PPt3YUHpnsT4jFQbQMNu9KNL/0+HUQDKpb8IWVFm94svfb63mCRw51/XF/
         lxYh69poqt4qtA0K7J00SYPrQmHrXId5Kq38gjus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 4.14 125/125] rxrpc: Fix trace string
Date:   Mon, 20 Jul 2020 17:37:44 +0200
Message-Id: <20200720152809.116132612@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit aadf9dcef9d4cd68c73a4ab934f93319c4becc47 upstream.

The trace symbol printer (__print_symbolic()) ignores symbols that map to
an empty string and prints the hex value instead.

Fix the symbol for rxrpc_cong_no_change to " -" instead of "" to avoid
this.

Fixes: b54a134a7de4 ("rxrpc: Fix handling of enums-to-string translation in tracing")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/trace/events/rxrpc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -333,7 +333,7 @@ enum rxrpc_congest_change {
 	EM(rxrpc_cong_begin_retransmission,	" Retrans") \
 	EM(rxrpc_cong_cleared_nacks,		" Cleared") \
 	EM(rxrpc_cong_new_low_nack,		" NewLowN") \
-	EM(rxrpc_cong_no_change,		"") \
+	EM(rxrpc_cong_no_change,		" -") \
 	EM(rxrpc_cong_progress,			" Progres") \
 	EM(rxrpc_cong_retransmit_again,		" ReTxAgn") \
 	EM(rxrpc_cong_rtt_window_end,		" RttWinE") \


