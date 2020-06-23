Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B39C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570682070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943951;
	bh=4AXab2Rh2xx5uDjJ2f3oS2YN0MKoWagKU3PPDoFZhKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I4e8xp/Xsw4C84gCVvJmGZ6v6u9+UFVb30EcDrjpa8Nha0VKgS7AzW/1nTAwayCGf
	 w3YroyZhprjykOGuRVmcdLMgyM0g2XwQ7HXflxkMc781Mcl7DtzcVOUEgC+qP/jA84
	 mOR8llxusrKmaiPDC0MQlwWxeOqV9Z2IY2c1XdN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390161AbgFWUZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390579AbgFWUZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:25:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A35B206C3;
        Tue, 23 Jun 2020 20:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943942;
        bh=4AXab2Rh2xx5uDjJ2f3oS2YN0MKoWagKU3PPDoFZhKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gLWim1Nf8s1/bNVgsX3a6VwxjRtZiuLhzwd1CuGR+zesQToJXgJxGr8D/8TioXuvh
         Wcg0eyANFDxImy2Xt9ZbuwNN6us0PP2pCqIYaa1WwuxD9UBZy5rnyt5C4Vk8xfmw2W
         3yGHkyTWmtGTaJHznqZxmQud/3lwH5Dl/nZaPgtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 112/314] soundwire: slave: dont init debugfs on device registration error
Date:   Tue, 23 Jun 2020 21:55:07 +0200
Message-Id: <20200623195344.210083135@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
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
index 6473fa602f82c..611f4f5bc36ab 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -57,6 +57,8 @@ static int sdw_slave_add(struct sdw_bus *bus,
 		list_del(&slave->node);
 		mutex_unlock(&bus->bus_lock);
 		put_device(&slave->dev);
+
+		return ret;
 	}
 	sdw_slave_debugfs_init(slave);
 
-- 
2.25.1



