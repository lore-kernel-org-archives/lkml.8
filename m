Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A37C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C544206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262835;
	bh=AG4I3spYSEDOvYCxeDwOAlMSzxFFcwmx5ctqqB2EVvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pV2Ddnh0fkWSB9o64JvvvAx9iSnhgNNeV9w2AEzQgqZly1lndCYATLhEnAec/DqqW
	 MT7nfcBgS62+0g5A0UxZiyys2i5IDMyys3LSaSpNRcGyI+P0bwVg0+36f/q+oHTGc1
	 N3l972qsaSQH+BbFFSA5LijKhR/qRrG5MjW0CJTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbgGTQdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731711AbgGTPzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:55:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52FD52065E;
        Mon, 20 Jul 2020 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260540;
        bh=AG4I3spYSEDOvYCxeDwOAlMSzxFFcwmx5ctqqB2EVvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFbFirYyupl9UVFOmshBbePNXaRyy+Hf34MvDH875TKaCyJCpI1tkLEzYDNp95DJW
         FvHVAeHO/KThyy1rCKuojTt8hDUNdR/oqOJtyOYnoTR1bvDKq0D7P9EMpP85WDn1Yx
         l7Fz4JQn/xADByr9zd2osHY1L6c4zkWp1XC4BjAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 4.19 132/133] rxrpc: Fix trace string
Date:   Mon, 20 Jul 2020 17:37:59 +0200
Message-Id: <20200720152810.113481154@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
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
@@ -408,7 +408,7 @@ enum rxrpc_tx_point {
 	EM(rxrpc_cong_begin_retransmission,	" Retrans") \
 	EM(rxrpc_cong_cleared_nacks,		" Cleared") \
 	EM(rxrpc_cong_new_low_nack,		" NewLowN") \
-	EM(rxrpc_cong_no_change,		"") \
+	EM(rxrpc_cong_no_change,		" -") \
 	EM(rxrpc_cong_progress,			" Progres") \
 	EM(rxrpc_cong_retransmit_again,		" ReTxAgn") \
 	EM(rxrpc_cong_rtt_window_end,		" RttWinE") \


