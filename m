Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FCEC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CD220735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387595;
	bh=7CwSGAnApzkj0TifNjJBsWcj8qqd9Xu9EoZHAW2GmvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJLlpRAyw/djpVYpwcDpuO5YT6Mjmo++RSL62C8kQcGlAqQ3gYqg86/Nni3Gm7TR7
	 cpNXAzid5PgZFgApahIY3Ujzljid5ta7dP1UyIsSTZjEM3xiIT/Eo4kpGGklG2Nlt4
	 y8IoYXvUijoq/zuPlPZyco0CJZmLiaO31nBN4UTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgDTMk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgDTMkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:40:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 242A12070B;
        Mon, 20 Apr 2020 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386454;
        bh=7CwSGAnApzkj0TifNjJBsWcj8qqd9Xu9EoZHAW2GmvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b81Qhn0gWgyfLN7+IATWc1tJxsNMHV6vUHhWJncWXQKj/gmCQ6d1TUj0XYMhWK4vM
         bp7qq41BSBYK7U4H0sFgxQkvRJazhBIAG+FHcKQYm84pxBMoHE6lqL0tjUHLmXTBD0
         udJ6NeZIpshCXe+jL27bqCGNmXOGZpXaoI/Ey124=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bruno Meneguele <bmeneg@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 29/65] net/bpfilter: remove superfluous testing message
Date:   Mon, 20 Apr 2020 14:38:33 +0200
Message-Id: <20200420121512.524078157@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bruno Meneguele <bmeneg@redhat.com>

commit 41c55ea6c2a7ca4c663eeec05bdf54f4e2419699 upstream.

A testing message was brought by 13d0f7b814d9 ("net/bpfilter: fix dprintf
usage for /dev/kmsg") but should've been deleted before patch submission.
Although it doesn't cause any harm to the code or functionality itself, it's
totally unpleasant to have it displayed on every loop iteration with no real
use case. Thus remove it unconditionally.

Fixes: 13d0f7b814d9 ("net/bpfilter: fix dprintf usage for /dev/kmsg")
Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bpfilter/main.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/bpfilter/main.c
+++ b/net/bpfilter/main.c
@@ -35,7 +35,6 @@ static void loop(void)
 		struct mbox_reply reply;
 		int n;
 
-		fprintf(debug_f, "testing the buffer\n");
 		n = read(0, &req, sizeof(req));
 		if (n != sizeof(req)) {
 			fprintf(debug_f, "invalid request %d\n", n);


