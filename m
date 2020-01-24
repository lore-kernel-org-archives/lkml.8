Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C0CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646B420718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858884;
	bh=dJeyaT77qcrUN/bwzNmWLg2GEbFAflWn7Hduqn7i86o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oUnCLeMTFENOoZcqZPlUglO8daENtSd8n0kwpuYBtP647Y8I0ekgqHNM2oJi/0qo5
	 Zxepk+kUFazA23LcgaaxzWkpK0YCjVynw/gATLFrYHKBbicj6TjCvwVlNOnDOo0Z1u
	 QpcffjbpzZK5DqyarkKrFo2Y2SIarfOaqLJD9iP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbgAXJlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730704AbgAXJlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:41:20 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 781A52070A;
        Fri, 24 Jan 2020 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858879;
        bh=dJeyaT77qcrUN/bwzNmWLg2GEbFAflWn7Hduqn7i86o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKgNl9xgkk1aktXqRfbBFO+o+EtlFJX8jqOmMMhfhkksHAx+aHQTOrgXHlBn83E8K
         /NmCEDhNERh0uPv6V35Bnsx2XStjDSLWwTueGBg3v8A5xErvI2bL/+Gw5G/Hy8Uyhq
         /utbg7ALv2MOXEtvCPsW/mJcLnWZ68Xmq+5jiovA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Blakey <paulb@mellanox.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Greg Rose <gvrose8192@gmail.com>,
        William Tu <u9012063@gmail.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 072/102] net: openvswitch: dont unlock mutex when changing the user_features fails
Date:   Fri, 24 Jan 2020 10:31:13 +0100
Message-Id: <20200124092817.471257300@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

[ Upstream commit 4c76bf696a608ea5cc555fe97ec59a9033236604 ]

Unlocking of a not locked mutex is not allowed.
Other kernel thread may be in critical section while
we unlock it because of setting user_feature fail.

Fixes: 95a7233c4 ("net: openvswitch: Set OvS recirc_id from tc chain index")
Cc: Paul Blakey <paulb@mellanox.com>
Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Tested-by: Greg Rose <gvrose8192@gmail.com>
Acked-by: William Tu <u9012063@gmail.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/datapath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 23f67b8fdeaae..3eed90bfa2bff 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1667,6 +1667,7 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 				ovs_dp_reset_user_features(skb, info);
 		}
 
+		ovs_unlock();
 		goto err_destroy_meters;
 	}
 
@@ -1683,7 +1684,6 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 
 err_destroy_meters:
-	ovs_unlock();
 	ovs_meters_exit(dp);
 err_destroy_ports_array:
 	kfree(dp->ports);
-- 
2.20.1



