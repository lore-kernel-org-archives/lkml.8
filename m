Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED7FC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9BE20836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581993720;
	bh=xe0nsEvKHFqa4kQqrM3BFS8ArtxhgoosRSM61VUGdEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vDR+TWB4neNAy9ERUlN0WskqZG9Pn1mvTdUbGSOysJ92TTD1nyEhS/mcIzfqM0YJk
	 YQOx/LPOoWYTnOA+ejx9/d9C9k7hPY7j3r8IWg4m5YnhEQfZzIaVDlajNcvh+Ln+84
	 ipxASepZkprlELCZ7l4YBmFF7Fz82tiloyd+a7PE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgBRCl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgBRCly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:41:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 943CD24654;
        Tue, 18 Feb 2020 02:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581993713;
        bh=xe0nsEvKHFqa4kQqrM3BFS8ArtxhgoosRSM61VUGdEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nuTh7PjODGcY1YzTuT+gGQxPyWFr0V/sRoTpyiXJv/E0I8N1wBninhVzmBrp2m1TV
         85QopJyNNh1PbEUKGS3xhIkH2NDIiMMWmHcVs8tFu8MWOO4khaUf86msJm+czLrEQ5
         T7im23qZgyQ65t96UOlpkAJ/hWrx79k9MDWScyck=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 08/11] tools/lib/lockdep: Hook up vsprintf, find_bit, hweight libraries
Date:   Mon, 17 Feb 2020 21:41:30 -0500
Message-Id: <20200218024133.5059-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218024133.5059-1-sashal@kernel.org>
References: <20200218024133.5059-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They already exist in tools/lib/, and are now required by liblockdep, so
just add them to the build manifest.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/lockdep/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/lockdep/Build b/tools/lib/lockdep/Build
index 219a9e2d9e0ba..1e7c25690b8ea 100644
--- a/tools/lib/lockdep/Build
+++ b/tools/lib/lockdep/Build
@@ -1 +1 @@
-liblockdep-y += common.o lockdep.o preload.o rbtree.o ../../lib/bitmap.o
+liblockdep-y += common.o lockdep.o preload.o rbtree.o ../../lib/bitmap.o ../../lib/vsprintf.o ../../lib/find_bit.o ../../lib/hweight.o
-- 
2.20.1

