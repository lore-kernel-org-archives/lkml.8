Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B1EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CF621707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584052;
	bh=3Gy/92jLZF+v7FYdCtBsRReY/y1P8gmS+TEu783FoGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t9zrsOqkFlZ+n8JdBWN2Kg29GvN23Jlp36s+Gy3j8kCtWudw9e81PVvg7Jl9am5Yn
	 k1Kf6Vs3wj/bGhFGC2kfd/s/SJ9sYnD6vhe4YyXnNZW3XFHk0v27uANEAQ8gxAkIQL
	 yI1057iWPLB0K/1tlpKZ2gZJpVXNT5CjBYIrQ2GE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394881AbgFSQ1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390007AbgFSOzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:55:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021A62158C;
        Fri, 19 Jun 2020 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578554;
        bh=3Gy/92jLZF+v7FYdCtBsRReY/y1P8gmS+TEu783FoGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=daIYJkwoBF5e3KwDglzGJdRV2hcndCDv+jG1k5R3v7qR35jNYk6vxT/uTvpp1dTkE
         QW91T/QuPHUTK4IIGeCFBthjDS0uVbD9mY7ECyHttIrfqxbX/KBieakYxm+DXm6ZUh
         yAUU7nueKt1qtX2NrPp0SDOtx/ZpP1niZWn/9+F8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tanner Love <tannerlove@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 067/267] selftests/net: in rxtimestamp getopt_long needs terminating null entry
Date:   Fri, 19 Jun 2020 16:30:52 +0200
Message-Id: <20200619141652.101127825@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tannerlove <tannerlove@google.com>

[ Upstream commit 865a6cbb2288f8af7f9dc3b153c61b7014fdcf1e ]

getopt_long requires the last element to be filled with zeros.
Otherwise, passing an unrecognized option can cause a segfault.

Fixes: 16e781224198 ("selftests/net: Add a test to validate behavior of rx timestamps")
Signed-off-by: Tanner Love <tannerlove@google.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/networking/timestamping/rxtimestamp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/networking/timestamping/rxtimestamp.c
+++ b/tools/testing/selftests/networking/timestamping/rxtimestamp.c
@@ -114,6 +114,7 @@ static struct option long_options[] = {
 	{ "tcp", no_argument, 0, 't' },
 	{ "udp", no_argument, 0, 'u' },
 	{ "ip", no_argument, 0, 'i' },
+	{ NULL, 0, NULL, 0 },
 };
 
 static int next_port = 19999;


