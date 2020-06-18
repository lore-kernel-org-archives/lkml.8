Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD338C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8301020776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443352;
	bh=tXZguFDtMNtJqm3M9bfTwLckJP+68oggVDjUs9RehoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=olhusq6DPZJ9yD69jTdn8eJVLucmybXLj8W7h8BQhltqxoo+4emribhMJD1wtbIpD
	 /UGKOuS4wFvAk6o+Bc1eftwOxWo7bHhNPa98MY3sBVkzkj6zQHnz61+e2lbxwfFIgQ
	 4gehpSPga8XD9WmTvZdPKt7qqYDnFXNlc3+H9FGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgFRBWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbgFRBTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:19:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BAD221D90;
        Thu, 18 Jun 2020 01:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443151;
        bh=tXZguFDtMNtJqm3M9bfTwLckJP+68oggVDjUs9RehoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hu8wbbD1ONcjaDunbL1pXAFR5efvZsUyYJaqAhtBK8W90iKze4VDgwdAjuFNACvKr
         xuO/+R+SHfCuyVUkD9+gIFC4qJ9PEi2AZjyw3m0JUfLIOKW9GMhfbuJKkSDiYiLZE/
         O/JJuFQb4jOBSUyK2LzfCEgOoXFKoXo0Hjkn2sS4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matej Dujava <mdujava@kocurkovo.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.4 119/266] staging: sm750fb: add missing case while setting FB_VISUAL
Date:   Wed, 17 Jun 2020 21:14:04 -0400
Message-Id: <20200618011631.604574-119-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matej Dujava <mdujava@kocurkovo.cz>

[ Upstream commit fa90133377f4a7f15a937df6ad55133bb57c5665 ]

Switch statement does not contain all cases: 8, 16, 24, 32.
This patch will add missing one (24)

Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
Link: https://lore.kernel.org/r/1588277366-19354-2-git-send-email-mdujava@kocurkovo.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/sm750fb/sm750.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 59568d18ce23..5b72aa81d94c 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -898,6 +898,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		fix->visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
 	case 16:
+	case 24:
 	case 32:
 		fix->visual = FB_VISUAL_TRUECOLOR;
 		break;
-- 
2.25.1

