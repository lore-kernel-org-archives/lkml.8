Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAB0C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E4D207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261619;
	bh=jMZAkAiRPeB/WryBfB1XZTDKBjG80bl3r5X+Z+hlUPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ANnlvASAXKj/myr9AlPbbs9x4q4AJ2pgJ5zciIB4da2ykQY3QyboVxhNdoY6/saYc
	 POOiRsFuI8fu8k7AstSIascbxYkr0lrYm98vgjzg70D0WTio3R+a8lteILkvJ0iA9K
	 PQq6kVXl/WcXPdB0FE5TaGs7aM47hYkdf5XS1tAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbgGTQNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732632AbgGTQN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:13:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629E42064B;
        Mon, 20 Jul 2020 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261606;
        bh=jMZAkAiRPeB/WryBfB1XZTDKBjG80bl3r5X+Z+hlUPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zm9ZTwFhxSXrDrDfp57VJ9u4FFOPIFTb8Ie6jQFTVd53AFA8rFwYTbmCJ/0sFxGrN
         EVCrm6vQ6ctY3uPCyWT6XNuwip466pjIpU1x/xgoNMihNWvLJY+cq9bDMLL3WGIfjw
         vaeOHqGz8P8v//rPgJDsgb70faai4cQEUNUN5zoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5.7 146/244] slimbus: core: Fix mismatch in of_node_get/put
Date:   Mon, 20 Jul 2020 17:36:57 +0200
Message-Id: <20200720152832.795778263@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

commit 01360857486c0e4435dea3aa2f78b47213b7cf6a upstream.

Adding missing corresponding of_node_put

Fixes: 7588a511bdb4 ("slimbus: core: add support to device tree helper")
Signed-off-by: Saravana Kannan <saravanak@google.com>
[Srini: added fixes tag, removed NULL check and updated log]
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200511151334.362-3-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/slimbus/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -283,6 +283,7 @@ EXPORT_SYMBOL_GPL(slim_register_controll
 /* slim_remove_device: Remove the effect of slim_add_device() */
 static void slim_remove_device(struct slim_device *sbdev)
 {
+	of_node_put(sbdev->dev.of_node);
 	device_unregister(&sbdev->dev);
 }
 


