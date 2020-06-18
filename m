Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E880C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C832222C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443883;
	bh=bIk6w6VvDx5GaB2S3OeclfhGrx+NuGFb52D0NAChQF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xfNP7FmCC73PaP4Gz+FIxupS6v+wMPNIstG2hZkqiMHTGaOHNt/NLOUdjyDVuVmOI
	 S4hrXO9YVxQLfc+eMdLfT0pRpxHVE9V3CaTvImcYKhK2nwIumPaqnlMuKri/15iFD9
	 s5vJedObjT5NhCSAKnxnvf0l41MFKrMOS70uSCRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbgFRBbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732052AbgFRB2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:28:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE9A02220D;
        Thu, 18 Jun 2020 01:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443695;
        bh=bIk6w6VvDx5GaB2S3OeclfhGrx+NuGFb52D0NAChQF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Hiau6h5cr6tgXFDNe8O+jlmn2ECBDwGlYIh59T1cIirtT9wJxvSbdw/qqzFTDawX
         a4KBzmLd3hWeUM91IUUNGa94gHznCp8LsD8ACuB15Z5EeirrDXtt5BzSsCAUf/7450
         sZwpu97/BTfii4VN8x4Aobpk5zSOq793I0095eUc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     tannerlove <tannerlove@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 106/108] selftests/net: in rxtimestamp getopt_long needs terminating null entry
Date:   Wed, 17 Jun 2020 21:25:58 -0400
Message-Id: <20200618012600.608744-106-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/networking/timestamping/rxtimestamp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/networking/timestamping/rxtimestamp.c b/tools/testing/selftests/networking/timestamping/rxtimestamp.c
index dd4162fc0419..7a573fb4c1c4 100644
--- a/tools/testing/selftests/networking/timestamping/rxtimestamp.c
+++ b/tools/testing/selftests/networking/timestamping/rxtimestamp.c
@@ -114,6 +114,7 @@ static struct option long_options[] = {
 	{ "tcp", no_argument, 0, 't' },
 	{ "udp", no_argument, 0, 'u' },
 	{ "ip", no_argument, 0, 'i' },
+	{ NULL, 0, NULL, 0 },
 };
 
 static int next_port = 19999;
-- 
2.25.1

