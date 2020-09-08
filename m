Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6E6C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589C820936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599585298;
	bh=PphcyuCEjcpjgvyrg7TXwzG/mPSRor/MhDAMLjwjhjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wL1Vq44gipVgohhpCGofCt8dukbKl8bCD8acpXR/y9G/miHY1oe+stbB6lzQnd8LL
	 IGUqTN6mm0+yAZ6nWxeCgDmXLCppzHJfBj+FyfHQx2Snu/TaCGTKpPlc/2LF1nhF6f
	 Gat4iX+GVhMZMNCE9PHeH/32akHKiZXvuMwxzeMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgIHROx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731785AbgIHQS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:18:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2B42481E;
        Tue,  8 Sep 2020 15:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579845;
        bh=PphcyuCEjcpjgvyrg7TXwzG/mPSRor/MhDAMLjwjhjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGmWxg4CI6J7rBGu5LDg10YimX5iPTuP0COCoShbmBI/B7/jwSIlSGe57XdlSJ4Fo
         IKT5KpaOlV3K/F9oJllIj/bHCEhpOjfQ93op+ozhkDR9cd3rwNMKs3jqhB2zIhPGS1
         yFDwyAJoSqRJFNBgIS3ZctWRfyM/LoqQASr8CHU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Grant <al.grant@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 057/129] perf tools: Correct SNOOPX field offset
Date:   Tue,  8 Sep 2020 17:24:58 +0200
Message-Id: <20200908152232.548821601@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Grant <al.grant@foss.arm.com>

[ Upstream commit 39c0a53b114d0317e5c4e76b631f41d133af5cb0 ]

perf_event.h has macros that define the field offsets in the data_src
bitmask in perf records. The SNOOPX and REMOTE offsets were both 37.

These are distinct fields, and the bitfield layout in perf_mem_data_src
confirms that SNOOPX should be at offset 38.

Committer notes:

This was extracted from a larger patch that also contained kernel
changes.

Fixes: 52839e653b5629bd ("perf tools: Add support for printing new mem_info encodings")
Signed-off-by: Al Grant <al.grant@arm.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index bb7b271397a66..fabe5aeaa351a 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1131,7 +1131,7 @@ union perf_mem_data_src {
 
 #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
 /* 1 free */
-#define PERF_MEM_SNOOPX_SHIFT	37
+#define PERF_MEM_SNOOPX_SHIFT	38
 
 /* locked instruction */
 #define PERF_MEM_LOCK_NA	0x01 /* not available */
-- 
2.25.1



