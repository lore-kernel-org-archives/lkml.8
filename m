Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562ECC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E252086A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658413;
	bh=c2Wu/NtLfKX+UwRJ27t5hZuq60xwZemUMXwA1lnPM/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AxmLDwfaqyv8yHDnlpRaciw5X0Ldo5/IUdUqN+eD58FivsDLbSjx+isimKfZv4CJE
	 d/uLNSGoPi4jIY5Lx4j8V6fYy+ipW1Y700it6iUVBqKhQ/yYhJOddMlyVfzYT8fy9V
	 N9xyEcMzaA4XZmqGDXVqokZLPkJLQjUd2l3t/tSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbgFHXUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbgFHXQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:16:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C50B0214F1;
        Mon,  8 Jun 2020 23:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658181;
        bh=c2Wu/NtLfKX+UwRJ27t5hZuq60xwZemUMXwA1lnPM/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8Cig1K6y/HP3eiseywCiHCwvX0s5KchJh3JVxjl/VMhZvo4Pc+M091/j6MDRjKE2
         7Niuma3vEUDRjl6ug+SuFofABaeBXCDWIzv2Gp3v/4gFpkz3WtUQjDK8Zts0/7xodV
         orHg6fjUfZD3WMGj36IncwjkfDw3OzOx0fsNhRqA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 206/606] Linux 5.6.15
Date:   Mon,  8 Jun 2020 19:05:31 -0400
Message-Id: <20200608231211.3363633-206-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d00e14219e27..3eca0c523098 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 6
-SUBLEVEL = 14
+SUBLEVEL = 15
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
-- 
2.25.1

