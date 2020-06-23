Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D069EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB073206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948351;
	bh=6/dQmFsaYiZudDlU15aTEKI+ILQi1VWmGyK/oRBAY90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MzEqFb+jBPCI/yq2ng4ny0sc2y2x1TLb5Jeg23IFq0kpO1JoOJz51esKExjbO/MEJ
	 BJuk/wqARdoA3vZEk9ng2S0LxVKkmRZmtDeIN0HtGvwj/3QZPN+nmHxiTTBwR1bIwl
	 fjOEs4EO0BbQOpew74kXZ4VHtW/WCBKWchLgQNu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393751AbgFWVjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388169AbgFWUHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:07:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E3B320EDD;
        Tue, 23 Jun 2020 20:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942851;
        bh=6/dQmFsaYiZudDlU15aTEKI+ILQi1VWmGyK/oRBAY90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ke37qeNduM96bhk0sSh2mHXMb93OuYJh6JQ3ItDa7Kfv/OUZmZ6jEN+PjMOURZkTn
         BCJxv8B/uNsOC7fY5f2QL+3Pxlqt1j25X9rR4JsMcQcsBL2Zpvw2khhpVLVG+dKUXx
         FL6qeZDDlMiBYHm0OkT9VvVvC279GIEc7u/0aLFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 160/477] soundwire: slave: dont init debugfs on device registration error
Date:   Tue, 23 Jun 2020 21:52:37 +0200
Message-Id: <20200623195415.163746051@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 8893ab5e8ee5d7c12e0fc1dca4a309475064473d ]

The error handling flow seems incorrect, there is no reason to try and
add debugfs support if the device registration did not
succeed. Return on error.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Link: https://lore.kernel.org/r/20200419185117.4233-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/slave.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index aace57fae7f83..4bacdb187eab8 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -68,6 +68,8 @@ static int sdw_slave_add(struct sdw_bus *bus,
 		list_del(&slave->node);
 		mutex_unlock(&bus->bus_lock);
 		put_device(&slave->dev);
+
+		return ret;
 	}
 	sdw_slave_debugfs_init(slave);
 
-- 
2.25.1



