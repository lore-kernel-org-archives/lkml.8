Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2025DC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37E720780
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552427;
	bh=w2PUQYTQ73NwbewyrZ1u9QihBf5HuPs7RlYsAgFI3/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u9Uhb82GXxbVHE9mGU/cA/aJPcLcuMZR1WZhgBpF7b3WWte90gYYfHuceHIXTCyJ2
	 uAu3bCtGHKD28tmTF5HndIivK7wci8furftlWZ9v6YwgDm9dhT90ojZFheXpTdl1ta
	 zfmJ7B9ZGJ/B50ivTDXqVXjUJa0zS9rDyJ9UgVD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbgDVKrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbgDVKQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:16:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D4720575;
        Wed, 22 Apr 2020 10:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550568;
        bh=w2PUQYTQ73NwbewyrZ1u9QihBf5HuPs7RlYsAgFI3/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXXSggWKAZIJvvqqtcGA1DDoV9ppZO3e4DsEVOsKgw4SnnRrMnXVXHMrGMX6MvYV2
         Z6DTmGj7DnNOBhpzW/BaL0p3NLkOMzPzZYr+t9hYhZHWQE+YEyAXg04Gn7FDybSS/y
         CLLMcPlsdM8ryl+r7Gv3ggTpNPldB2n82qTLsBVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wenyang@linux.alibaba.com>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 4.19 62/64] mtd: phram: fix a double free issue in error path
Date:   Wed, 22 Apr 2020 11:57:46 +0200
Message-Id: <20200422095024.382706291@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095008.799686511@linuxfoundation.org>
References: <20200422095008.799686511@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang@linux.alibaba.com>

commit 49c64df880570034308e4a9a49c4bc95cf8cdb33 upstream.

The variable 'name' is released multiple times in the error path,
which may cause double free issues.
This problem is avoided by adding a goto label to release the memory
uniformly. And this change also makes the code a bit more cleaner.

Fixes: 4f678a58d335 ("mtd: fix memory leaks in phram_setup")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Joern Engel <joern@lazybastard.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20200318153156.25612-1-wenyang@linux.alibaba.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/devices/phram.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -240,22 +240,25 @@ static int phram_setup(const char *val)
 
 	ret = parse_num64(&start, token[1]);
 	if (ret) {
-		kfree(name);
 		parse_err("illegal start address\n");
+		goto error;
 	}
 
 	ret = parse_num64(&len, token[2]);
 	if (ret) {
-		kfree(name);
 		parse_err("illegal device length\n");
+		goto error;
 	}
 
 	ret = register_device(name, start, len);
-	if (!ret)
-		pr_info("%s device: %#llx at %#llx\n", name, len, start);
-	else
-		kfree(name);
+	if (ret)
+		goto error;
 
+	pr_info("%s device: %#llx at %#llx\n", name, len, start);
+	return 0;
+
+error:
+	kfree(name);
 	return ret;
 }
 


