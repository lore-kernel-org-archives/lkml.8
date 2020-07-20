Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FAEC433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC492065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260380;
	bh=Fm46hoXFhlO53sH9H9Ig3yawJJYkLxSZR5k2JOeOLNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=foVhIkiIWb3lEiA5XD02FGJwcQUroDZ8Hqi+yftGO8YjUOtIMaVHkl/MAR12wqIpV
	 +/gdckmbLq8vOdOzWV659nXQa8eyH9rH3yKQSroHJRMPa46SsYozz7gZZymF4p2RWm
	 2MFA8f00KaHp/EbId/gPI0MVrDQ0u9wWNbI9fNoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgGTPw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731429AbgGTPw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:52:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1805206E9;
        Mon, 20 Jul 2020 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260377;
        bh=Fm46hoXFhlO53sH9H9Ig3yawJJYkLxSZR5k2JOeOLNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AUkU0xbmdOJdVyjuZ+YKT9OC4QxpooHelPjwS+9+5E1wht1gmGFr6zDXDf7Z5AeuZ
         aTVY+o8zKlwiXysIF2y6hxXD+Af//WzRYTxbHPmivQztBE1dhqSoKYQsC6HGGaHrnN
         Tc/Jg1a7HzZpWhrTofgpJ9XXuaOEVydjS083PTfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4.19 081/133] slimbus: core: Fix mismatch in of_node_get/put
Date:   Mon, 20 Jul 2020 17:37:08 +0200
Message-Id: <20200720152807.621484917@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
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
@@ -236,6 +236,7 @@ EXPORT_SYMBOL_GPL(slim_register_controll
 /* slim_remove_device: Remove the effect of slim_add_device() */
 static void slim_remove_device(struct slim_device *sbdev)
 {
+	of_node_put(sbdev->dev.of_node);
 	device_unregister(&sbdev->dev);
 }
 


