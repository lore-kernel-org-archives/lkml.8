Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF57C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CBE20776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549925;
	bh=RWLeXoutRgfPC7VgJhR9K9c937W8nDWYj2QA4fqneZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O3+MWIcL9ms4bu0kvElAGic0bhW4TkSKNbz9oaF/mPuRA4WlLcLpEv9U9ff3QYSfU
	 xMbCVPz2flZ7moRcoXNUZSnHk1Oz90iHkHi7qEb7WA7L3cQnHQ6aqU2PUuDare3BXv
	 7P3QDQvHuqwJaOzMR5o+FvkZinXUUki8AuWVk6/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgDVKFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgDVKFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:05:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD1EA20774;
        Wed, 22 Apr 2020 10:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549916;
        bh=RWLeXoutRgfPC7VgJhR9K9c937W8nDWYj2QA4fqneZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqOi/1BnWPQq0ZzfmaLxSf3Mm+zPvO0WMQYw0Uz2u7EJC52bnCHiB5/khhbGcJzWz
         5yT/uAzPm28ZMqXoB1b2LxBHmcfTOb8fNpu3xC76Wu8X+4OajG+HKvcywZi6hUefdK
         jMj3r+SpI6dJuzLaChVC+ZJrr9Gc4NXOnCo8tjZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 4.9 052/125] s390/diag: fix display of diagnose call statistics
Date:   Wed, 22 Apr 2020 11:56:09 +0200
Message-Id: <20200422095041.942359520@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Mueller <mimu@linux.ibm.com>

commit 6c7c851f1b666a8a455678a0b480b9162de86052 upstream.

Show the full diag statistic table and not just parts of it.

The issue surfaced in a KVM guest with a number of vcpus
defined smaller than NR_DIAG_STAT.

Fixes: 1ec2772e0c3c ("s390/diag: add a statistic for diagnose calls")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/diag.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -76,7 +76,7 @@ static int show_diag_stat(struct seq_fil
 
 static void *show_diag_stat_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos <= nr_cpu_ids ? (void *)((unsigned long) *pos + 1) : NULL;
+	return *pos <= NR_DIAG_STAT ? (void *)((unsigned long) *pos + 1) : NULL;
 }
 
 static void *show_diag_stat_next(struct seq_file *m, void *v, loff_t *pos)


