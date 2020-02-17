Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40FDC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E0320725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581929336;
	bh=Ptjr1cz0Lgc+HdS6rtnv8fDAJC0PSu3Ia1ihRFuI/kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cePxnWtnSwQf1avnEABH9HjqxwRhvHBbpJ9CRMf4mJEZyflmzwDdBtCp7Q3B7ofx2
	 z16x2KIOYmAVLG2ECjr41Xa6/k7O0r6RwNlnWYqBIaRZ6KoW2sxw6rDclTm82IE9lK
	 g1/jaa2eGp5aqyXGaaDcl0SWgQzn4ni12rqMn2b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgBQIsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:48:55 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46299 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728245AbgBQIsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:48:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 833255A8;
        Mon, 17 Feb 2020 03:48:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 17 Feb 2020 03:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=zFN5hgyJe3TtyC4xmLFL/ZQlcvBNI
        bla0NMXIYckHbo=; b=wV/IdaOx9UVtHBfBnPVTg7+s00lL6FOVxef/MY9CIqb//
        EoHNuzyeiVEDtcLJW4vFvDXSFFugPhOH7MlzJEqDrEcDR+bP6tQ02zq4AQE3Ut7c
        jr+msOMsJOyvKc+X3YIWR+LP9EKI1TMNTIfllWFxf/wuTQXxkH2t7IHqgHZJdj1l
        LFVp48ydWxX6W0U9+3x6CLQBdcTzc3RhbBWggR2q6rf4iqf/PakLcGWhtS3psArF
        HKoZFUp2JPVVPRiXVx39CHDF472TGmdqPRpEHzBKmXZknn99ZYYq/49zFCg1Ho9H
        YSkSuBua9WJEHGl1SfJP9obUE78nFW0ghSv+nDkEQ==
X-ME-Sender: <xms:c1NKXrCBl_FEYZubRJWjJ_RM1EjnOHED5viLFNaBE0xbayQ-FZqzPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfsedttdertdertddtnecuhfhrohhmpedfvfhosghinhcu
    vedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppe
    dvtdefrddujeefrddvkedrudektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:c1NKXobTp5Sfegn5FM84c_gmcLo_YSdrIOa9XGv7iSWPbIak9ry7zw>
    <xmx:c1NKXjj1mFExCHaRDZZbQ01zg3P7kxWRZjFD1Bjy8Sk3GerBt13arg>
    <xmx:c1NKXq7C4ze4rrQ8AgMbiKZqunWJwO1U8IAsOI4SVCg77zRicWJh2Q>
    <xmx:c1NKXsdNA3W1fLP3qDAjis8tyHok6gT0Y72uALcvFKar6Q7C83ETtQ>
Received: from ares.fritz.box (203-173-28-180.dyn.iinet.net.au [203.173.28.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 313D23280060;
        Mon, 17 Feb 2020 03:48:48 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Christoph Lameter <cl@linux.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tools: vm: slabinfo: Replace tabs with spaces
Date:   Mon, 17 Feb 2020 19:48:27 +1100
Message-Id: <20200217084828.9092-2-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217084828.9092-1-tobin@kernel.org>
References: <20200217084828.9092-1-tobin@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have some rouge tabs within the output string of `slabinfo -h` causing the
description output of the `--partial` option to be incorrectly aligned when
printed.

Replace the tabs with spaces, correctly aligning all option description
strings.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/vm/slabinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 68092d15e12b..29f8ecb59cf6 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -125,7 +125,7 @@ static void usage(void)
 		"-n|--numa              Show NUMA information\n"
 		"-N|--lines=K           Show the first K slabs\n"
 		"-o|--ops               Show kmem_cache_ops\n"
-		"-P|--partial		Sort by number of partial slabs\n"
+		"-P|--partial           Sort by number of partial slabs\n"
 		"-r|--report            Detailed report on single slabs\n"
 		"-s|--shrink            Shrink slabs\n"
 		"-S|--Size              Sort by size\n"
-- 
2.17.1

