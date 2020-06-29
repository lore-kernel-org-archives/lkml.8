Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40634C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2457120702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593458424;
	bh=+P3lwz5oXBLMnEGQYs3uIzBwkqbw+S6t1wotcxU+IpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lYxblm6LDUeEXiCNgxXflg/a7yHjOy3KZODT1RAeWhBpC+CsYjLnC6nv0NK2kSCel
	 /0WEJm9yzVC+TyVN+etAaQ4OYqL3QGWmt+nnB39TbCZwnyHmOjUH4iF4vrlnYXgZwZ
	 SRqXWNrO0IksYCQVrYnr5ZXsfftggDP/YGijNzMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgF2TUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732107AbgF2TUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:20:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DFE525492;
        Mon, 29 Jun 2020 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445452;
        bh=+P3lwz5oXBLMnEGQYs3uIzBwkqbw+S6t1wotcxU+IpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REc/32gerX69pcFIF82f5lAJmmLklezajeR7LX8Vfxdx+4O4CJpXlHHZtuS/awt4g
         k8L5/fEMaDz20IqFmbFzOShI1YXt1zTlPetJC2o9BQmrLBXKqoRrLVts9ZYNx1ZUFi
         VsmlVLMqYchwwsra2rKuX5lNh81mSydmPEZGul3Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 191/191] Linux 4.9.229-rc1
Date:   Mon, 29 Jun 2020 11:40:07 -0400
Message-Id: <20200629154007.2495120-192-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
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
index af23d7b67442c..f9eb288348690 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 4
 PATCHLEVEL = 9
-SUBLEVEL = 228
-EXTRAVERSION =
+SUBLEVEL = 229
+EXTRAVERSION = -rc1
 NAME = Roaring Lionus
 
 # *DOCUMENTATION*
-- 
2.25.1

