Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3D2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CDD205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699851;
	bh=jhYhNXYSQxDA8+pS7YjeAPEndnmHw6INZ+Q9N6cpRkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kVN7LvhbSoBJCJuthJ0L7At1kAx0QESABDz3lw5d11p95Zcrl065GbTjp1gX/06Io
	 ePoxJ3xPnlgTBpglfXx1plC22aQ1dowLW/p5zaQlgDFuJerTzgttpNx0PJ/Y5LmhYa
	 aUNtVbsh5j9dAmVsAGan/JZhtH1y3gxmQK2uSF1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgAVNVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:21:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730305AbgAVNVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:21:34 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49B82467C;
        Wed, 22 Jan 2020 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699294;
        bh=jhYhNXYSQxDA8+pS7YjeAPEndnmHw6INZ+Q9N6cpRkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xGbxiDJG+2ituwU1CFzprqy7sn5X0PHEJZZMmx08EiyBnMyhZTnaVbGGY5UsvnUqz
         0OcFWD+N31X0GTWqGZUlZcEzyLXej/GIgCbU69NK4T3QD54b4b/oPm6x/ktfbdZV4p
         3/C2ehslWHTD+5AG4s5lQU4+Bxyc0DIT+qat7hws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.4 073/222] s390/setup: Fix secure ipl message
Date:   Wed, 22 Jan 2020 10:27:39 +0100
Message-Id: <20200122092838.945601820@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Rudo <prudo@linux.ibm.com>

commit 40260b01d029ba374637838213af500e03305326 upstream.

The new machine loader on z15 always creates an IPL Report block and
thus sets the IPL_PL_FLAG_IPLSR even when secure boot is disabled. This
causes the wrong message being printed at boot. Fix this by checking for
IPL_PL_FLAG_SIPL instead.

Fixes: 9641b8cc733f ("s390/ipl: read IPL report at early boot")
Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1059,7 +1059,7 @@ static void __init log_component_list(vo
 
 	if (!early_ipl_comp_list_addr)
 		return;
-	if (ipl_block.hdr.flags & IPL_PL_FLAG_IPLSR)
+	if (ipl_block.hdr.flags & IPL_PL_FLAG_SIPL)
 		pr_info("Linux is running with Secure-IPL enabled\n");
 	else
 		pr_info("Linux is running with Secure-IPL disabled\n");


