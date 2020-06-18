Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB16C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A08D2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448559;
	bh=aPTm7gnbRhn+AoOex2mpPU0mnV+1Gnr/jAxPnNYSzHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tZLSEnMWwCQ6gAgeFFuNGRVkwddY8Fe8hHMCN9legm6HxXOACRzkSezYnUDamQsIx
	 XRsnPqtRDLjSkP3/3790DeZLB2yv1TYk8obTQ5JOKh0VCe1Vn8rXcjeW+JfcwPDo5w
	 IRQmfbhYwjPPtZQjuDbMio2LLEjTWreZRyHjTxeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387914AbgFRCtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgFRBJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:09:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F3BB21D95;
        Thu, 18 Jun 2020 01:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442580;
        bh=aPTm7gnbRhn+AoOex2mpPU0mnV+1Gnr/jAxPnNYSzHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RB6XJph5mlPJrkWvLNzt3bJc6z+PvB93OCabOjX1tmwopGhnUapq9DVkjD+UrHpyV
         L8ajuTTEKIRerN+LrqOIQJ8L7eNaVSqBfCnhSHJR3WGaOlcSg7pgygQ44yse7AmunV
         4HXq9dGoeHFwjMMgurA1GYSJgkH7Vf/bNX5Cr7mg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.7 072/388] powerpc/ptdump: Add _PAGE_COHERENT flag
Date:   Wed, 17 Jun 2020 21:02:49 -0400
Message-Id: <20200618010805.600873-72-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 3af4786eb429b2df76cbd7ce3bae21467ac3e4fb ]

For platforms using shared.c (4xx, Book3e, Book3s/32), also handle the
_PAGE_COHERENT flag which corresponds to the M bit of the WIMG flags.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
[mpe: Make it more verbose, use "coherent" rather than "m"]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/324c3d860717e8e91fca3bb6c0f8b23e1644a404.1589866984.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/ptdump/shared.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
index f7ed2f187cb0..784f8df17f73 100644
--- a/arch/powerpc/mm/ptdump/shared.c
+++ b/arch/powerpc/mm/ptdump/shared.c
@@ -30,6 +30,11 @@ static const struct flag_info flag_array[] = {
 		.val	= _PAGE_PRESENT,
 		.set	= "present",
 		.clear	= "       ",
+	}, {
+		.mask	= _PAGE_COHERENT,
+		.val	= _PAGE_COHERENT,
+		.set	= "coherent",
+		.clear	= "        ",
 	}, {
 		.mask	= _PAGE_GUARDED,
 		.val	= _PAGE_GUARDED,
-- 
2.25.1

