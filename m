Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AE9C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60C020708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339307;
	bh=/kmyYt9ZI3NOmd4VftzPhAPuJR8J8CHxBHA/slhwnJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N7HrTbxOlRNJ9Z2CLyv8w32uP6mPTptGIL9g17OBWRmZCTtbitvkposMP1XlrLqae
	 HRRpJ1N6Wrc4mdSuNc0zj47Xx9NapRajsGRaI1h4Tv68agdOB5JknTtBy/NeKmD8kf
	 065rMtH4sOvldICXV82jS3/PNFRysv5z9Umnr+YY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgBJMzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:55:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgBJMlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:52 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C2520842;
        Mon, 10 Feb 2020 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338511;
        bh=/kmyYt9ZI3NOmd4VftzPhAPuJR8J8CHxBHA/slhwnJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1o8uz+8OYRuvHlOPG7ur95B73AtDTJSnFbMJ1O+EN+LWsHcSPUBqHjH7amldy9mv
         E2MckRIwX7rUiSyS6bkRJBwBS8hW4eqwGD5J+TjwG5RTRDvDMxfnOh9jj63v5KlGOK
         EjRVTMK02ixke4lNxweevSh0pXXg4ABAhoVLw39w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 317/367] devlink: report 0 after hitting end in region read
Date:   Mon, 10 Feb 2020 04:33:50 -0800
Message-Id: <20200210122452.405722316@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit d5b90e99e1d51b7b5d2b74fbc4c2db236a510913 ]

commit fdd41ec21e15 ("devlink: Return right error code in case of errors
for region read") modified the region read code to report errors
properly in unexpected cases.

In the case where the start_offset and ret_offset match, it unilaterally
converted this into an error. This causes an issue for the "dump"
version of the command. In this case, the devlink region dump will
always report an invalid argument:

000000000000ffd0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
000000000000ffe0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
devlink answers: Invalid argument
000000000000fff0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

This occurs because the expected flow for the dump is to return 0 after
there is no further data.

The simplest fix would be to stop converting the error code to -EINVAL
if start_offset == ret_offset. However, avoid unnecessary work by
checking for when start_offset is larger than the region size and
returning 0 upfront.

Fixes: fdd41ec21e15 ("devlink: Return right error code in case of errors for region read")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/devlink.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -3986,6 +3986,12 @@ static int devlink_nl_cmd_region_read_du
 		goto out_unlock;
 	}
 
+	/* return 0 if there is no further data to read */
+	if (start_offset >= region->size) {
+		err = 0;
+		goto out_unlock;
+	}
+
 	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &devlink_nl_family, NLM_F_ACK | NLM_F_MULTI,
 			  DEVLINK_CMD_REGION_READ);


