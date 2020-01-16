Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C029C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBAE2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216795;
	bh=tKvAIWa8NVZfJV1Dg44IZpM00pJUHt+tW3x/2Qr252Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=13xXfz7cF84r2NRL9k1xyfAHiqIpWixpWqAQCA4Z/gI8IUM1uVlWvw5/54f7IOx3/
	 DUsDtVmdpjOzVyyaWO2nlpJ1y8lTqv1tS1ohHB1Yo95oEsQwTW9OmcGAPWs+k3wvgW
	 qnLnyTlzkPpZKrGdIm+RsMX2FIiVwYDG+tVAJQ+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390509AbgAPXTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:19:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390496AbgAPXTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:19:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A442073A;
        Thu, 16 Jan 2020 23:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216790;
        bh=tKvAIWa8NVZfJV1Dg44IZpM00pJUHt+tW3x/2Qr252Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CX4MY5nf1Owa0+2UwdpQPUC4NHz0OzzvbbXeMO0maopF0joeXmIbjuxe9s/EYj48G
         xvLNWlFtwITGu9kMpuizQe+DFGqXQjOiJ+L8ajNFgUb6YQiONJImtnjb4LvIGSYRBt
         sSI0/B3lCwuO3+09BEkMPBPbs4C7n0fjmDI241C8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 020/203] selftests: loopback.sh: skip this test if the driver does not support
Date:   Fri, 17 Jan 2020 00:15:37 +0100
Message-Id: <20200116231746.379551057@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

commit cc7e3f63d7299dd1119be39aa187b867d6f8aa17 upstream.

The loopback feature is only supported on a few drivers like broadcom,
mellanox, etc. The default veth driver has not supported it yet. To avoid
returning failed and making the runner feel confused, let's just skip
the test on drivers that not support loopback.

Fixes: ad11340994d5 ("selftests: Add loopback test")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/net/forwarding/loopback.sh |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/tools/testing/selftests/net/forwarding/loopback.sh
+++ b/tools/testing/selftests/net/forwarding/loopback.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 ALL_TESTS="loopback_test"
 NUM_NETIFS=2
 source tc_common.sh
@@ -72,6 +75,11 @@ setup_prepare()
 
 	h1_create
 	h2_create
+
+	if ethtool -k $h1 | grep loopback | grep -q fixed; then
+		log_test "SKIP: dev $h1 does not support loopback feature"
+		exit $ksft_skip
+	fi
 }
 
 cleanup()


