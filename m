Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDDCC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D188218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942152;
	bh=TP97m5R3CtqaMXtZ++WkaHcN9XZ3LDmzoitsQph8EPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OM7SPM1DrBCic9xS3f7RyQk4ZX5/g9DBdT3nhE9Zjw1qOnfz8YnbOhqxxvHggZhes
	 7NWazUUk87xC6O8baSkKVy9vndDqxBBTr1RfuyixkK8TqICYeSjEORn4G2twcH8L4L
	 DKm2KN4/mduycxdo2Cx7Z+9yHZscpli/lvwMc+BY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgEHMtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbgEHMsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:48:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FCEB21473;
        Fri,  8 May 2020 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942135;
        bh=TP97m5R3CtqaMXtZ++WkaHcN9XZ3LDmzoitsQph8EPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdw5AUefalhp2+8kY8/goSfmSUxfaga8fwDyDGoPvH1W04qa57uDzdI4avvbTVesi
         oJHEo0b/71ZsTZMVmmc9oc98mbCW8aW/MedYzGYky7VVZcBN/iPPAO2v1sxNhcoE02
         txKr5c/6tKDF6RVac8B2y/2c8VeB8YmhbA26cJYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jere=20Lepp=C3=A4nen?= <jere.leppanen@nokia.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 310/312] sctp: Fix SHUTDOWN CTSN Ack in the peer restart case
Date:   Fri,  8 May 2020 14:35:01 +0200
Message-Id: <20200508123146.325593469@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jere Leppänen <jere.leppanen@nokia.com>

commit 12dfd78e3a74825e6f0bc8df7ef9f938fbc6bfe3 upstream.

When starting shutdown in sctp_sf_do_dupcook_a(), get the value for
SHUTDOWN Cumulative TSN Ack from the new association, which is
reconstructed from the cookie, instead of the old association, which
the peer doesn't have anymore.

Otherwise the SHUTDOWN is either ignored or replied to with an ABORT
by the peer because CTSN Ack doesn't match the peer's Initial TSN.

Fixes: bdf6fa52f01b ("sctp: handle association restarts when the socket is closed.")
Signed-off-by: Jere Leppänen <jere.leppanen@nokia.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sctp/sm_make_chunk.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -857,7 +857,11 @@ struct sctp_chunk *sctp_make_shutdown(co
 	sctp_shutdownhdr_t shut;
 	__u32 ctsn;
 
-	ctsn = sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map);
+	if (chunk && chunk->asoc)
+		ctsn = sctp_tsnmap_get_ctsn(&chunk->asoc->peer.tsn_map);
+	else
+		ctsn = sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map);
+
 	shut.cum_tsn_ack = htonl(ctsn);
 
 	retval = sctp_make_control(asoc, SCTP_CID_SHUTDOWN, 0,


