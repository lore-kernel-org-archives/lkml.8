Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91EDC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4702137B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646343;
	bh=rAT7k9QfL/uRKMskwddcHA1BKZ5ENz8y42pgaEwLH+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rpmnIvUhnmmxQHB1b7/B4STH+ZrLJUmdVCjV/V0+Plzx1lKVoxrrlZDl+h5GzOOuA
	 DEo/5w8Mhucn9I9qgGravxfeJrjKg81D452jzHyUdMJ9ZLWQ0L8E34BlcF89eRK6b7
	 enVhc2HhH/c9t+qA9kfoCEDrFiOMJ3m/DR0XAzhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbgCaJTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732176AbgCaJS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:18:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB02720772;
        Tue, 31 Mar 2020 09:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646338;
        bh=rAT7k9QfL/uRKMskwddcHA1BKZ5ENz8y42pgaEwLH+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2wDzUSosVxmGkMB/GmUWlKkXZghOk3iO8V9f5m/GapAmJUSOCKohO68cgwHNK0o1/
         5mm7zrJyIQVxlk6kHJ4uAjM8Yv6JmUgKcz6CS4FppAZh3Ym3aQNG4VLwVm0pE5H+o/
         eUz4mxCXrabKT7b8F9HixGePiXIhL4A3hE9UPuXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 5.4 145/155] staging: kpc2000: prevent underflow in cpld_reconfigure()
Date:   Tue, 31 Mar 2020 10:59:45 +0200
Message-Id: <20200331085434.378979716@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 72db61d7d17a475d3cc9de1a7c871d518fcd82f0 upstream.

This function should not allow negative values of "wr_val".  If
negatives are allowed then capping the upper bound at 7 is
meaningless.  Let's make it unsigned.

Fixes: 7dc7967fc39a ("staging: kpc2000: add initial set of Daktronics drivers")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200224103325.hrxdnaeqsthplu42@kili.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/kpc2000/kpc2000/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -110,10 +110,10 @@ static ssize_t cpld_reconfigure(struct d
 				const char *buf, size_t count)
 {
 	struct kp2000_device *pcard = dev_get_drvdata(dev);
-	long wr_val;
+	unsigned long wr_val;
 	int rv;
 
-	rv = kstrtol(buf, 0, &wr_val);
+	rv = kstrtoul(buf, 0, &wr_val);
 	if (rv < 0)
 		return rv;
 	if (wr_val > 7)


