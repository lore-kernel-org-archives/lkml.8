Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17291C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38DC205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699305;
	bh=FWHswXzkNQm18OyLbLiUrWXEQH2JOo9N+oPvZnCU2vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C468cQ3wSvAB0i4c3reRimteF742LJ84Q6/AuPvc8MT8WN9kTfBwrHX1m6aQTEn/h
	 ahb7yHsz1yyx4dJW9m2wg3AbdbvIMw+4KlJ/AL1nP3fKytNgnIIjD9Vsi6WXVpCFb5
	 C8Xfdn/UMEbU3bRBNjrCqD4ImXofa7NJnmFCIpgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgAVNVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729499AbgAVNVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:21:41 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 247ED205F4;
        Wed, 22 Jan 2020 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699300;
        bh=FWHswXzkNQm18OyLbLiUrWXEQH2JOo9N+oPvZnCU2vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWBuSHmZxzqyiL5vsvY93rdR8YX5WBqMHF6tLBQwGInbLfIrZtA9UQWXeeZct1kvk
         CpmXarsl3KiiQWmskqSV8zqgEAYBBjzzXB+cr0r4eK/21N/SpINsCvqh2KTIhnnEx/
         hwEohdwRFsVOAs2X0dvTHK7cJWf5XsMPnSnKdOyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 5.4 101/222] reset: Fix {of,devm}_reset_control_array_get kerneldoc return types
Date:   Wed, 22 Jan 2020 10:28:07 +0100
Message-Id: <20200122092840.971841376@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 723c0011c7f6992f57e2c629fa9c89141acc115f upstream.

of_reset_control_array_get() and devm_reset_control_array_get() return
struct reset_control pointers, not internal struct reset_control_array
pointers, just like all other reset control API calls.

Correct the kerneldoc to match the code.

Fixes: 17c82e206d2a3cd8 ("reset: Add APIs to manage array of resets")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/reset/core.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -861,8 +861,7 @@ static int of_reset_control_get_count(st
  * @acquired: only one reset control may be acquired for a given controller
  *            and ID
  *
- * Returns pointer to allocated reset_control_array on success or
- * error on failure
+ * Returns pointer to allocated reset_control on success or error on failure
  */
 struct reset_control *
 of_reset_control_array_get(struct device_node *np, bool shared, bool optional,
@@ -915,8 +914,7 @@ EXPORT_SYMBOL_GPL(of_reset_control_array
  * that just have to be asserted or deasserted, without any
  * requirements on the order.
  *
- * Returns pointer to allocated reset_control_array on success or
- * error on failure
+ * Returns pointer to allocated reset_control on success or error on failure
  */
 struct reset_control *
 devm_reset_control_array_get(struct device *dev, bool shared, bool optional)


