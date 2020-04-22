Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC7FC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11D820776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551078;
	bh=dgsp2o5jhO3cVaLbl6yI7GcuL8xJF4PWHyAwkSBbIFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GMNHRne2JwudZNzYkHQ0RZEXlA8wV9JjxmJNqKeg1tkNbC/XmPFzqJfVKZphRRe0t
	 s/HmWJ8coCtTW0NpxhP+yKmBaagkeNyLnO0tI36p0WJ/Pg3S6urhduXYhTFpW0aff8
	 gmAnBtjPmKf8yYqUKpOJq9zXddOu/aed0h/L3iJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgDVKYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbgDVKXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:23:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A77DB2076B;
        Wed, 22 Apr 2020 10:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551032;
        bh=dgsp2o5jhO3cVaLbl6yI7GcuL8xJF4PWHyAwkSBbIFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWIJTMC45aiQN/C16lNhDB751ePEr9LYUCf215Lia9A4gOvgyzQlhF663a9jENkFO
         ewybp+7I3jG2aQ4WSWpqvXNNzZIP9VIhLHgiaYkYwoROKkZ6dslYU6zjhB2yynIdCP
         cqsxOEjn17J3hhBoIMK4y/cRH6D+6kBY0GEAgBtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bui Quang Minh <minhquangbui99@gmail.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 5.6 020/166] xsk: Add missing check on user supplied headroom size
Date:   Wed, 22 Apr 2020 11:55:47 +0200
Message-Id: <20200422095050.640912048@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Karlsson <magnus.karlsson@intel.com>

commit 99e3a236dd43d06c65af0a2ef9cb44306aef6e02 upstream.

Add a check that the headroom cannot be larger than the available
space in the chunk. In the current code, a malicious user can set the
headroom to a value larger than the chunk size minus the fixed XDP
headroom. That way packets with a length larger than the supported
size in the umem could get accepted and result in an out-of-bounds
write.

Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
Reported-by: Bui Quang Minh <minhquangbui99@gmail.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=207225
Link: https://lore.kernel.org/bpf/1586849715-23490-1-git-send-email-magnus.karlsson@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xdp/xdp_umem.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -343,7 +343,7 @@ static int xdp_umem_reg(struct xdp_umem
 	u32 chunk_size = mr->chunk_size, headroom = mr->headroom;
 	unsigned int chunks, chunks_per_page;
 	u64 addr = mr->addr, size = mr->len;
-	int size_chk, err;
+	int err;
 
 	if (chunk_size < XDP_UMEM_MIN_CHUNK_SIZE || chunk_size > PAGE_SIZE) {
 		/* Strictly speaking we could support this, if:
@@ -382,8 +382,7 @@ static int xdp_umem_reg(struct xdp_umem
 			return -EINVAL;
 	}
 
-	size_chk = chunk_size - headroom - XDP_PACKET_HEADROOM;
-	if (size_chk < 0)
+	if (headroom >= chunk_size - XDP_PACKET_HEADROOM)
 		return -EINVAL;
 
 	umem->address = (unsigned long)addr;


