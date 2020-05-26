Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C49C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97FE20873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519809;
	bh=zeKq95DhOmLrpHzgSWJIwBe8YNcLCdaQI3NF/lFMEMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nYsl9iTVdU0fWwTHePdRtwElR7EsehaYnxhNhIVgvdXBzt/Ikg4LS4BzX9rfHXtut
	 fKhPaRY1NHL4SVPESgAp9VNoRfPmDnwetiJNxxm0nrfZn3fKM4jK1+z6s7bt7dI7eu
	 Mgs+Qf9bklM2HEYCHmT8+3I/XU4iBa1wGoIkLVS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391223AbgEZTD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391212AbgEZTD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:03:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFFAD2086A;
        Tue, 26 May 2020 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519805;
        bh=zeKq95DhOmLrpHzgSWJIwBe8YNcLCdaQI3NF/lFMEMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2OGK1oCW2EWLjqk6Q6vu3LQQ0v+0PJ1CX4LGck+/VujLpv0iNLVyYlVBX0HLeneU
         27MSS6PcJLIhz1PAEbF2/9eQXabZ+aTrt70uukpQcw/rw9mNQPXx2zC0TiQTM6pYVy
         vnOUW8PP/VRZO0ZjW92j3kPwJ/T5ozKbQl8LMzPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 24/81] component: Silence bind error on -EPROBE_DEFER
Date:   Tue, 26 May 2020 20:52:59 +0200
Message-Id: <20200526183929.846830526@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Hilliard <james.hilliard1@gmail.com>

[ Upstream commit 7706b0a76a9697021e2bf395f3f065c18f51043d ]

If a component fails to bind due to -EPROBE_DEFER we should not log an
error as this is not a real failure.

Fixes messages like:
vc4-drm soc:gpu: failed to bind 3f902000.hdmi (ops vc4_hdmi_ops): -517
vc4-drm soc:gpu: master bind failed: -517

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Link: https://lore.kernel.org/r/20200411190241.89404-1-james.hilliard1@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/component.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 7f7c4233cd31..ee4d3b388f44 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -235,7 +235,8 @@ static int try_to_bring_up_master(struct master *master,
 	ret = master->ops->bind(master->dev);
 	if (ret < 0) {
 		devres_release_group(master->dev, NULL);
-		dev_info(master->dev, "master bind failed: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_info(master->dev, "master bind failed: %d\n", ret);
 		return ret;
 	}
 
@@ -506,8 +507,9 @@ static int component_bind(struct component *component, struct master *master,
 		devres_release_group(component->dev, NULL);
 		devres_release_group(master->dev, NULL);
 
-		dev_err(master->dev, "failed to bind %s (ops %ps): %d\n",
-			dev_name(component->dev), component->ops, ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(master->dev, "failed to bind %s (ops %ps): %d\n",
+				dev_name(component->dev), component->ops, ret);
 	}
 
 	return ret;
-- 
2.25.1



