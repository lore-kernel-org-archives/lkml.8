Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F58C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B2E20707
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxC8V3Cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgE2WA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:00:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35337 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726975AbgE2WAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZj1hG47vKjeF+F917Yc6ZUOleHAcqUJyjRf7Wzg1YQ=;
        b=cxC8V3Cnvv4ey/mcGQLrHuZ1mltNsM0PaS2MEoRULDJKCSvVO9lxIKZkycqS1GbkgS1FPJ
        XTjQaSuGyUHsOULkKXBw3fQLHx5hrR75oaDlow2GeQ723DQKgKa47rzBGO8bq2PsaMKq0w
        3AN9A5Cpk93/CUmXrkseWWPB85iyuAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-OPaxZCHPPua7Dev79u-PPw-1; Fri, 29 May 2020 18:00:19 -0400
X-MC-Unique: OPaxZCHPPua7Dev79u-PPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 016D5800D24;
        Fri, 29 May 2020 22:00:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 337CE5EE0E;
        Fri, 29 May 2020 22:00:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/27] rxrpc: Map the EACCES error produced by some ICMP6 to
 EHOSTUNREACH
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:00:16 +0100
Message-ID: <159078961633.679399.6049692176688342256.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map the EACCES error that is produced by some ICMP6 packets to EHOSTUNREACH
when we get them as EACCES has other meanings within a filesystem context.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/peer_event.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index b1449d971883..112e490ebbcd 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -271,6 +271,9 @@ static void rxrpc_store_error(struct rxrpc_peer *peer,
 		break;
 
 	case SO_EE_ORIGIN_ICMP6:
+		if (err == EACCES)
+			err = EHOSTUNREACH;
+		/* Fall through */
 	default:
 		_proto("Rx Received error report { orig=%u }", ee->ee_origin);
 		break;


