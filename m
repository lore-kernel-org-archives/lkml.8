Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B213C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3F724697
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220657;
	bh=j8rWYIl7op3a5y5mWe+e4U2V6//pAYtScwjRtyU02XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ClUUo8BjEOSrWQRZjGINF7QyZMH4jQQuMAu8c0WaavpzgySl3cuUbdS2O5jtutZ7B
	 wj/qcRf1uHDymuhWICFXk/31/JAwopTTrRnUDnvKFGu2FTzaXaGnxXtW49fuz4vKXZ
	 h3a4CGskYcYEeRgoUG1jk6sfGvqZTNQa/xS+ZPEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgA1OKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:10:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbgA1OKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:10:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91ADD20678;
        Tue, 28 Jan 2020 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220652;
        bh=j8rWYIl7op3a5y5mWe+e4U2V6//pAYtScwjRtyU02XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpmRowuevHUXNCsNpnUTmZENN4qeAfdSGXo+tVOJVAYQA+3R6CeuP/GvtCQ8UXZ0t
         s61/Uq7Kt++bsTFRQUzXNPmZ7NygCuGBSqop1n+jryMD8H4CUijMA8aTFG5WWiUOVc
         rjdYjbX/ezuPV9OmV3SfLI17YGlSQW8IOnnrI1/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 092/183] kdb: do a sanity check on the cpu in kdb_per_cpu()
Date:   Tue, 28 Jan 2020 15:05:11 +0100
Message-Id: <20200128135839.305506761@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b586627e10f57ee3aa8f0cfab0d6f7dc4ae63760 ]

The "whichcpu" comes from argv[3].  The cpu_online() macro looks up the
cpu in a bitmap of online cpus, but if the value is too high then it
could read beyond the end of the bitmap and possibly Oops.

Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/debug/kdb/kdb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index ebc52c7bd8a6c..cba287a5c9760 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2632,7 +2632,7 @@ static int kdb_per_cpu(int argc, const char **argv)
 		diag = kdbgetularg(argv[3], &whichcpu);
 		if (diag)
 			return diag;
-		if (!cpu_online(whichcpu)) {
+		if (whichcpu >= nr_cpu_ids || !cpu_online(whichcpu)) {
 			kdb_printf("cpu %ld is not online\n", whichcpu);
 			return KDB_BADCPUNUM;
 		}
-- 
2.20.1



