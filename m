Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0FBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFFD4204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592585123;
	bh=3svkiPAt5UNYdkxCJzrbDmwJg9gPgmdtyAUnzLi/NK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KdFr2VEsgBDFqytNvwo8f63z0u/53728Vvd+3Jaav2KBcblYJ98WnKzR1dNM/7GJC
	 e4lMoXiVqWnz+5f/ejGcF4QaDp7zkWGZh/SkRZX5oOtb6hb6pDb4c0k+MyjL0VOCdQ
	 INPBmB15Xu52upiM4POi8lRonMYVQSlFtCPmQDJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbgFSOmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387972AbgFSOl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:41:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F1DF20A8B;
        Fri, 19 Jun 2020 14:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577719;
        bh=3svkiPAt5UNYdkxCJzrbDmwJg9gPgmdtyAUnzLi/NK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uvl14QNjtLXY8efTtuUTY+J27WP8207oPrUZluOTdhfexUzePr6dfaAeYMmpObcrU
         4KkXTVEckqdw7xP603a3W1DTpxNuk4SqMfDME48NaCD4cNKw7+QPvtFyM1MZHH7hoB
         BXvok7lAKBHxepi86IF7G1iu4RgXoL/xxV+sLC8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 031/128] spi: No need to assign dummy value in spi_unregister_controller()
Date:   Fri, 19 Jun 2020 16:32:05 +0200
Message-Id: <20200619141621.814004193@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit ebc37af5e0a134355ea2b62ed4141458bdbd5389 ]

The device_for_each_child() doesn't require the returned value to be checked.
Thus, drop the dummy variable completely and have no warning anymore:

drivers/spi/spi.c: In function ‘spi_unregister_controller’:
drivers/spi/spi.c:2480:6: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
  int dummy;
      ^~~~~

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d74d341f9890..7fec76dd532f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2025,8 +2025,6 @@ static int __unregister(struct device *dev, void *null)
  */
 void spi_unregister_master(struct spi_master *master)
 {
-	int dummy;
-
 	if (master->queued) {
 		if (spi_destroy_queue(master))
 			dev_err(&master->dev, "queue remove failed\n");
@@ -2036,7 +2034,7 @@ void spi_unregister_master(struct spi_master *master)
 	list_del(&master->list);
 	mutex_unlock(&board_lock);
 
-	dummy = device_for_each_child(&master->dev, NULL, __unregister);
+	device_for_each_child(&master->dev, NULL, __unregister);
 	device_unregister(&master->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);
-- 
2.25.1



