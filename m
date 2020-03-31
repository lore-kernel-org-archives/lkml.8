Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F40DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D599F206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HK2UfQWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbgCaNGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:06:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22395 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730473AbgCaNGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585660003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TEnvRQUG2NaO2WXEs+JHaZkj1OJo/2Aq4DgDrJCFUmo=;
        b=HK2UfQWUnVIv+vPfMYr3+in6ht+/OBsPo4JrJKLCmKBqQzZIevCzqTRSNZKMEjQ6nMZwli
        hmipU17TQXODFbPOQKeWn9bszTvIiPxVvNcVDfBfVdg6VR+trQUiiodfo930EpTaXOv2cW
        hkCjDAOl8zMcpqthBbNasfmgej6iluA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-eoYx2jAsPdKOexGShbHIyg-1; Tue, 31 Mar 2020 09:06:41 -0400
X-MC-Unique: eoYx2jAsPdKOexGShbHIyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 430DA80573C;
        Tue, 31 Mar 2020 13:06:40 +0000 (UTC)
Received: from localhost (ovpn-116-139.gru2.redhat.com [10.97.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87C7F94B5C;
        Tue, 31 Mar 2020 13:06:36 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, micron10@gmail.com, ast@kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH] net/bpfilter: remove superfluous testing message
Date:   Tue, 31 Mar 2020 10:06:30 -0300
Message-Id: <20200331130630.633400-1-bmeneg@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A testing message was brought by 13d0f7b814d9 ("net/bpfilter: fix dprintf
usage for /dev/kmsg") but should've been deleted before patch submission.
Although it doesn't cause any harm to the code or functionality itself, i=
t's
totally unpleasant to have it displayed on every loop iteration with no r=
eal
use case. Thus remove it unconditionally.

Fixes: 13d0f7b814d9 ("net/bpfilter: fix dprintf usage for /dev/kmsg")
Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 net/bpfilter/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
index efea4874743e..05e1cfc1e5cd 100644
--- a/net/bpfilter/main.c
+++ b/net/bpfilter/main.c
@@ -35,7 +35,6 @@ static void loop(void)
 		struct mbox_reply reply;
 		int n;
=20
-		fprintf(debug_f, "testing the buffer\n");
 		n =3D read(0, &req, sizeof(req));
 		if (n !=3D sizeof(req)) {
 			fprintf(debug_f, "invalid request %d\n", n);
--=20
2.25.1

