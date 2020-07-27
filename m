Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8FAC433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C076220A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892567;
	bh=h34qtxaIin9fvca5iz4rgj6oOZSApYPiXFr73+LDPjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SV/q4ddCvBe3BJheXhTd7c4EE6XRlC/Sptdm9i5TrwsxHVNRcLiGnerS28x4m+1t0
	 QBA4cfab1zJLVnQeWcZgrRgb5wHAmSSmZHJrb4PtJV7YypYKDE32/79KwmGuc61Uev
	 6zmmZ98tjA2SI1WRebdkOECseSdULZ+BiIS4WX+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgG0X30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0XYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:24:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DEE02173E;
        Mon, 27 Jul 2020 23:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892245;
        bh=h34qtxaIin9fvca5iz4rgj6oOZSApYPiXFr73+LDPjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0TETOFPJ4YcNgEhVxA1UVuq5Pbif0kCWRscX9+EgSsPnkb/sG24s7DHBu5s1hjMd
         sDPvSX2wx7XOeZ2Wzxa8UrNS5qQpp3tAq+vOB4hwGS/l29Y8EoH3VDC9uIg2Zkt2/p
         gMfd/uHvSlI37AzeLMEHAf8usGo4g9yXnYWLQwfg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Pisati <paolo.pisati@canonical.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 14/25] selftest: txtimestamp: fix net ns entry logic
Date:   Mon, 27 Jul 2020 19:23:34 -0400
Message-Id: <20200727232345.717432-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727232345.717432-1-sashal@kernel.org>
References: <20200727232345.717432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Pisati <paolo.pisati@canonical.com>

[ Upstream commit b346c0c85892cb8c53e8715734f71ba5bbec3387 ]

According to 'man 8 ip-netns', if `ip netns identify` returns an empty string,
there's no net namespace associated with current PID: fix the net ns entrance
logic.

Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/txtimestamp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/txtimestamp.sh b/tools/testing/selftests/net/txtimestamp.sh
index eea6f5193693f..31637769f59f6 100755
--- a/tools/testing/selftests/net/txtimestamp.sh
+++ b/tools/testing/selftests/net/txtimestamp.sh
@@ -75,7 +75,7 @@ main() {
 	fi
 }
 
-if [[ "$(ip netns identify)" == "root" ]]; then
+if [[ -z "$(ip netns identify)" ]]; then
 	./in_netns.sh $0 $@
 else
 	main $@
-- 
2.25.1

