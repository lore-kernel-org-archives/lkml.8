Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD12208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931279;
	bh=rYL2IwAIcAFoDXZRpBmPjSQUP7VADmZhoj4Za1W7tt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lh4MH5o0L1tDs7Zs/7UHlhBBuRxMUNQCwha1BfYrYsACiSL2cVpVUrM84UbqWNRm5
	 /oWg2E1FwuIpSAN1DM1/f+Nmx7fQeH4XRlw/nYvsOHMF9WVUmccMfWFwMUPIdpq975
	 lUvo79Ll7BJZ4AKnitqHVHz3kpSeG39rL0Yuf914=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgHTNmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgHTJ3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:29:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E32622CB2;
        Thu, 20 Aug 2020 09:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915771;
        bh=rYL2IwAIcAFoDXZRpBmPjSQUP7VADmZhoj4Za1W7tt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdJD2B0vtEqDxXJPdSod66qt9gRMofWTdnTVHuQI6Y8rV6ODYQFrQmLI/D9mkr69z
         cRumilPWCXjqWnwWIW8W4BTTcB9DKUVVbG+pUVCt2CYSrlYknUFbuz6yN61iFWlAJM
         ydOmgy7HMcnjIQIHwKu0wC0eyxiI9UHQI964vohY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.8 099/232] dm: dont call report zones for more than the user requested
Date:   Thu, 20 Aug 2020 11:19:10 +0200
Message-Id: <20200820091617.626527301@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

commit a9cb9f4148ef6bb8fabbdaa85c42b2171fbd5a0d upstream.

Don't call report zones for more zones than the user actually requested,
otherwise this can lead to out-of-bounds accesses in the callback
functions.

Such a situation can happen if the target's ->report_zones() callback
function returns 0 because we've reached the end of the target and then
restart the report zones on the second target.

We're again calling into ->report_zones() and ultimately into the user
supplied callback function but when we're not subtracting the number of
zones already processed this may lead to out-of-bounds accesses in the
user callbacks.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Fixes: d41003513e61 ("block: rework zone reporting")
Cc: stable@vger.kernel.org # v5.5+
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -504,7 +504,8 @@ static int dm_blk_report_zones(struct ge
 		}
 
 		args.tgt = tgt;
-		ret = tgt->type->report_zones(tgt, &args, nr_zones);
+		ret = tgt->type->report_zones(tgt, &args,
+					      nr_zones - args.zone_idx);
 		if (ret < 0)
 			goto out;
 	} while (args.zone_idx < nr_zones &&


