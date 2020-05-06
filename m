Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE946C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8AC20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778618;
	bh=nV4FsL4gaZCGSOLpt7rbGhej7HcCC9CYYjzvzRjlWzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sMJRsvqCjdmOx30hXh2QyfSeJtSSnXFrkbPlz2PUQLVZPuYDFZOkz0tt3Aelb2++A
	 bDOopLXmQUdwyPZ33r87Qibxb0r4+SyzV0ktulWD4lJ2Vj+kVERKXG7aFz56DznWeX
	 r6eIsmLyexTIggUaWPJmqRHf3yTc+qY7a1mgyMbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgEFPXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729368AbgEFPXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:23:36 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D79221F7;
        Wed,  6 May 2020 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778615;
        bh=nV4FsL4gaZCGSOLpt7rbGhej7HcCC9CYYjzvzRjlWzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7w65TE3vCKrgmEnYo7ZNRN1hjisCTG+RB3zqNLkcQoyQgV9f3TXWP2tZeFwGQRKU
         zjL+RMWu8cQiQjDinXb2VLsPoEBkzBqcdSZ/1mpZ68LDATwdX+A313WCUTblam+Oz4
         5vZiyHZCeiLVtha0jVs60kxDqFKMBH8tO56XswGk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Zou Wei <zou_wei@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/91] perf c2c: Remove unneeded semicolon
Date:   Wed,  6 May 2020 12:21:17 -0300
Message-Id: <20200506152234.21977-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

Fixes coccicheck warnings:

 tools/perf/builtin-c2c.c:1712:2-3: Unneeded semicolon
 tools/perf/builtin-c2c.c:1928:2-3: Unneeded semicolon
 tools/perf/builtin-c2c.c:2962:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/1588064336-70456-1-git-send-email-zou_wei@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 0d544c4fb4be..0e14c1821dcb 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1709,7 +1709,7 @@ static struct c2c_dimension *get_dimension(const char *name)
 
 		if (!strcmp(dim->name, name))
 			return dim;
-	};
+	}
 
 	return NULL;
 }
@@ -1925,7 +1925,7 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 		FILTER_HITM(tot_hitm);
 	default:
 		break;
-	};
+	}
 
 #undef FILTER_HITM
 
@@ -2959,7 +2959,7 @@ static int perf_c2c__record(int argc, const char **argv)
 
 		rec_argv[i++] = "-e";
 		rec_argv[i++] = perf_mem_events__name(j);
-	};
+	}
 
 	if (all_user)
 		rec_argv[i++] = "--all-user";
-- 
2.21.1

