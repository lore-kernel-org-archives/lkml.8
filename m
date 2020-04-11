Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F641C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F97C20673
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607291;
	bh=wE60NzE6a4XNodsKvRma5brB+q02opg97ymdIJvL9Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YfWtA9IV/oh1xovfZ3MocM+pYkkvpGvF2m0v0XT3EvaC8FXI9uP1ipeQFKSHEygur
	 JXXXPeMkYJWmMHBIThtMvUKZmmAAPXJxancfmv7K8kkzezTNjUzNFMpRWiOZoarStA
	 gsdvAKOx3Y3UIvC+WbqtBOhzxsfucYf9sgjT0KqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgDKMOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgDKMOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:14:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1742220692;
        Sat, 11 Apr 2020 12:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607281;
        bh=wE60NzE6a4XNodsKvRma5brB+q02opg97ymdIJvL9Rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKDowyYA0cAwZ2pbXeZMCLe5WhDmyPdoTFoIKOk7IHHkrQ60zKCr2uH6kRbn3JEha
         3hDY49Awh1aD++Svd9zTRRrgFUWrjTH8NGlpPC+koF7Yk27GCcQQ4SUO/zcuOLRTH+
         QOZiUT3UQjQygmIdveRJjZrMYn/MbJwfb8XEjs5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 10/54] tools/power turbostat: Fix gcc build warnings
Date:   Sat, 11 Apr 2020 14:08:52 +0200
Message-Id: <20200411115509.251668935@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115508.284500414@linuxfoundation.org>
References: <20200411115508.284500414@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

[ Upstream commit d8d005ba6afa502ca37ced5782f672c4d2fc1515 ]

Warning: ‘__builtin_strncpy’ specified bound 20 equals destination size
	[-Wstringop-truncation]

reduce param to strncpy, to guarantee that a null byte is always copied
into destination buffer.

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 02d123871ef95..fb665fdc722a4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5144,9 +5144,9 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 	}
 
 	msrp->msr_num = msr_num;
-	strncpy(msrp->name, name, NAME_BYTES);
+	strncpy(msrp->name, name, NAME_BYTES - 1);
 	if (path)
-		strncpy(msrp->path, path, PATH_BYTES);
+		strncpy(msrp->path, path, PATH_BYTES - 1);
 	msrp->width = width;
 	msrp->type = type;
 	msrp->format = format;
-- 
2.20.1



