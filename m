Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB58DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC9DE2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593456996;
	bh=kDKUVPt/3p32cfcsLdYtxbB/zdyyDPW09NBOwmGzE6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7s5DcUK2FxhSdlRfuBlXftSst/F/FL7hmn9kxcatjdpjtPw0gqHnO47G3VpQe7pu
	 mFN7BImyfdjTNGqE/5fagn4NDyE+mEPKbQvbCbobo5xm/nkwfcveQ3q1qlqTreV1hx
	 H3Ju8ljygdPbjIskMvBkLl9ooMApfih+8W4PPtJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgF2S4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729977AbgF2SzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:55:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E001F25580;
        Mon, 29 Jun 2020 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446147;
        bh=kDKUVPt/3p32cfcsLdYtxbB/zdyyDPW09NBOwmGzE6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xSIIfZK5y3zVjSBhpllL8DtiERztgARXutG1jluiyCxJZzcGlgxQyzHqbvgw5WtK6
         fJ3VXOL9H80NyDQ402XCOozGztSnWcapB8FYDshMqCPTfQlZibNbjS4WufW9emLNzC
         Og1fkIwZXmmWM7vJ9hYfe2fg1QS0p9RZAMFVe2Uo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 135/135] Linux 4.4.229-rc1
Date:   Mon, 29 Jun 2020 11:53:09 -0400
Message-Id: <20200629155309.2495516-136-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 009a36b276f7e..1b4b356c1bcbe 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 4
 PATCHLEVEL = 4
-SUBLEVEL = 228
-EXTRAVERSION =
+SUBLEVEL = 229
+EXTRAVERSION = -rc1
 NAME = Blurry Fish Butt
 
 # *DOCUMENTATION*
-- 
2.25.1

