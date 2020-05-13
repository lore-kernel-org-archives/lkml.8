Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3E8CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5776320769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363284;
	bh=SJHZR4v2GT/tBR3ARVobu8OYQ9bM0tjaXbMt0fwbS5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ejq2oCjGn+O86GYWfA/d+2cRFhTfktYKwKJPDIACusAemVWOu8H4+teWKCgh9Mlm0
	 JHTtXu4vEZYBDBQqIgY1oD8IAWKdrK10OLpVlhsUVu+/gX0k/6+rFixTk+HxAuw2Sy
	 V2KwJz+lUSYYfc9Ci29w//O2B4RlIyexDLbvnS18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbgEMJsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732859AbgEMJr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:47:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6151F2078C;
        Wed, 13 May 2020 09:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363278;
        bh=SJHZR4v2GT/tBR3ARVobu8OYQ9bM0tjaXbMt0fwbS5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IM/R5ifpFNU9LMp5cNT2oZuLiodRdtqONNolO7NoYbU0hC2RO+9Cxv+Zm7aOoWMfq
         jqigJXpZJhn67405pWyVN+5W9ZyE5WSyyzw1k4WAlAj9D3tcIm82uVobg8wjoGj8I7
         gQMVuoL3T0MqLuc8j0IIUhm+SaBXNWz0wjCY/aZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 10/90] devlink: fix return value after hitting end in region read
Date:   Wed, 13 May 2020 11:44:06 +0200
Message-Id: <20200513094410.220623579@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094408.810028856@linuxfoundation.org>
References: <20200513094408.810028856@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 610a9346c138b9c2c93d38bf5f3728e74ae9cbd5 ]

Commit d5b90e99e1d5 ("devlink: report 0 after hitting end in region read")
fixed region dump, but region read still returns a spurious error:

$ devlink region read netdevsim/netdevsim1/dummy snapshot 0 addr 0 len 128
0000000000000000 a6 f4 c4 1c 21 35 95 a6 9d 34 c3 5b 87 5b 35 79
0000000000000010 f3 a0 d7 ee 4f 2f 82 7f c6 dd c4 f6 a5 c3 1b ae
0000000000000020 a4 fd c8 62 07 59 48 03 70 3b c7 09 86 88 7f 68
0000000000000030 6f 45 5d 6d 7d 0e 16 38 a9 d0 7a 4b 1e 1e 2e a6
0000000000000040 e6 1d ae 06 d6 18 00 85 ca 62 e8 7e 11 7e f6 0f
0000000000000050 79 7e f7 0f f3 94 68 bd e6 40 22 85 b6 be 6f b1
0000000000000060 af db ef 5e 34 f0 98 4b 62 9a e3 1b 8b 93 fc 17
devlink answers: Invalid argument
0000000000000070 61 e8 11 11 66 10 a5 f7 b1 ea 8d 40 60 53 ed 12

This is a minimal fix, I'll follow up with a restructuring
so we don't have two checks for the same condition.

Fixes: fdd41ec21e15 ("devlink: Return right error code in case of errors for region read")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/devlink.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -3907,6 +3907,11 @@ static int devlink_nl_cmd_region_read_du
 		end_offset = nla_get_u64(attrs[DEVLINK_ATTR_REGION_CHUNK_ADDR]);
 		end_offset += nla_get_u64(attrs[DEVLINK_ATTR_REGION_CHUNK_LEN]);
 		dump = false;
+
+		if (start_offset == end_offset) {
+			err = 0;
+			goto nla_put_failure;
+		}
 	}
 
 	err = devlink_nl_region_read_snapshot_fill(skb, devlink,


