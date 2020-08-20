Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01251C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D565220738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919201;
	bh=IhIlyU5ImtlJe/dTnjvpXCpLAWNMPYqiVpzS4s4ET7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gs+czFCWyVs3HxdmniGuF0hnJXIpVJo5W6XbHaB2IfQMVxiTkokeDm5hSNpkQJfJi
	 uHnuGpncVUogU6xdjMeZOgsS7K2yQIWk4qdv1iRHR16MSi10tPx2kmoM3u6JZ9fMmq
	 zX+cs3pFATlbx88bJYNTH5yuozYtvJZdvXbh9Hho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgHTK0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731720AbgHTKWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:22:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F1B220658;
        Thu, 20 Aug 2020 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918971;
        bh=IhIlyU5ImtlJe/dTnjvpXCpLAWNMPYqiVpzS4s4ET7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCx88MXLaUi4ncGZaxpWNK54e8SEphi+Utk76ldxlLcSHT68OkTQ8/WdRJMriKHl/
         WuRahvhb18min79HecOizyz/ilEXBQstxhrE79i/ReFNF9DBB/E/HH/d+j125mOSiE
         WVrX1FzDXGiOzPHVQina5st9ww3BdVLXMr2AN2Ac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 106/149] net: Set fput_needed iff FDPUT_FPUT is set
Date:   Thu, 20 Aug 2020 11:23:03 +0200
Message-Id: <20200820092130.840109869@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit ce787a5a074a86f76f5d3fd804fa78e01bfb9e89 ]

We should fput() file iff FDPUT_FPUT is set. So we should set fput_needed
accordingly.

Fixes: 00e188ef6a7e ("sockfd_lookup_light(): switch to fdget^W^Waway from fget_light")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/socket.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/socket.c
+++ b/net/socket.c
@@ -456,7 +456,7 @@ static struct socket *sockfd_lookup_ligh
 	if (f.file) {
 		sock = sock_from_file(f.file, err);
 		if (likely(sock)) {
-			*fput_needed = f.flags;
+			*fput_needed = f.flags & FDPUT_FPUT;
 			return sock;
 		}
 		fdput(f);


