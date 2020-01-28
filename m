Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B6CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D4124688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221241;
	bh=Rk4OD4o8v34OyMsxhlUP5rkQyxMDOFTUgNk8kknpdaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O7dCW8vr/n8CvdJA09HsbjMkr8qvOog6pZrjraa/+57MXvdhENQasrI+K0T8c46am
	 zxdEkX9C1Gpmp3lRtzizXLDHljIvJtvFw5yFuC2P5iqqF3r/fHhkpYKWA2hcRpDB7j
	 qAnmu53NuEqTbufqGiW8SzHQK/fYYt9gqZM+06Ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgA1OUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:20:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730766AbgA1OUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:20:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5853B24688;
        Tue, 28 Jan 2020 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221233;
        bh=Rk4OD4o8v34OyMsxhlUP5rkQyxMDOFTUgNk8kknpdaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHoOc+Lk3tXsmt1pNu5eaGDF4WzYSzrhDJqZKrfHZcmOFoH5Cb1aZ4QR0j7HHJukB
         HeN5YaMPjdphoA0WCXjWPl+vnjwKdf+B9fXf0QrYghfRWf1phWieMiNAEA4JxWoS75
         4tHggXQUuIsj+CjUwY/3QsHtAkuu+bZE/u6XJ2ig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 141/271] kdb: do a sanity check on the cpu in kdb_per_cpu()
Date:   Tue, 28 Jan 2020 15:04:50 +0100
Message-Id: <20200128135903.067256865@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
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
index 5a58421d7e2d7..a52a6da8c3d09 100644
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



