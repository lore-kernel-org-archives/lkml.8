Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33051C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B502073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551846;
	bh=RKJ7Yog8jQWWRje6qQ+jbTWQkqvorlLM1SYf3LrHV7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KdV/Od4VxVkqbJSXRFdEGK8wzmKZgX2YCqKLf611agCmqfp2LzZ4gsyaiHvlodFaR
	 6GsD9rRFuB3W6dIyqn6+C4cSkC/MaTkbN5aqRevZL+oxuX14t1aOvn3KFh6tYuxcmF
	 EWgcRa4FgMJ/t3eSXYRbKAQpLj527rDjiPqMsGc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbgDVKhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbgDVKW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:22:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D57C42076E;
        Wed, 22 Apr 2020 10:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550948;
        bh=RKJ7Yog8jQWWRje6qQ+jbTWQkqvorlLM1SYf3LrHV7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pATepj8vynOvrcNCJyb2+Oeq1tOJ5FIzRoFqQemtKEjBsX79rgQPx6thSSWoWQhaq
         V5ilHoZlSW1+Yr5ngA7JWm4j+DemLD1CARv60qmPYqokaK7jHLbnzh9FW3PgDuu4Ym
         Ukq9JleXO/TByzdsvK5DnwoVEzPKkMYgLtavD+/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Erhard F." <erhard_f@mailbox.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.6 022/166] of: unittest: kmemleak in of_unittest_platform_populate()
Date:   Wed, 22 Apr 2020 11:55:49 +0200
Message-Id: <20200422095050.910886620@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

commit 216830d2413cc61be3f76bc02ffd905e47d2439e upstream.

kmemleak reports several memory leaks from devicetree unittest.
This is the fix for problem 2 of 5.

of_unittest_platform_populate() left an elevated reference count for
grandchild nodes (which are platform devices).  Fix the platform
device reference counts so that the memory will be freed.

Fixes: fb2caa50fbac ("of/selftest: add testcase for nodes with same name and address")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/unittest.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1155,10 +1155,13 @@ static void __init of_unittest_platform_
 
 	of_platform_populate(np, match, NULL, &test_bus->dev);
 	for_each_child_of_node(np, child) {
-		for_each_child_of_node(child, grandchild)
-			unittest(of_find_device_by_node(grandchild),
+		for_each_child_of_node(child, grandchild) {
+			pdev = of_find_device_by_node(grandchild);
+			unittest(pdev,
 				 "Could not create device for node '%pOFn'\n",
 				 grandchild);
+			of_dev_put(pdev);
+		}
 	}
 
 	of_platform_depopulate(&test_bus->dev);


