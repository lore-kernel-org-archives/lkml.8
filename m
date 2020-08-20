Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EE4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC9322BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597929239;
	bh=A5/9brDvRPF70ERveEC5pLTQSGpg8dEFelBfyXyhmX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OMe84L5U8HibiqUwGZFsAkZAiZaJ9jKB3I03g700ZDxQtyhfatl6SVM0LfT7wmBlV
	 ZZA3HuVWgKA/7tGKr6se9hfnV8zKZyPOj63ZBX4Q+Ey48WqIhn8ix33/Tip8nAlEeg
	 oLHSVy8pPHlegFqNQpoV78263cg5xDZKjiq5PHCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgHTJgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgHTJgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:36:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0389F207DE;
        Thu, 20 Aug 2020 09:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916175;
        bh=A5/9brDvRPF70ERveEC5pLTQSGpg8dEFelBfyXyhmX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZbahDrovj1TARmE3l48Xp2FBXEvoy7tXPsEZpYhmU5tzQAWRq3oXHxeKFt0zAins
         x66jH+WcQQde00wb/ZBUaHoXgAyfhcn7DY50bumPFvKIDDEDfadrDoGdN5d9D+Wule
         emJy/jf9/7yt8mhNXdMpCpWIE/fZZe3DTafgZ4jM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 5.7 037/204] arm64: perf: Correct the event index in sysfs
Date:   Thu, 20 Aug 2020 11:18:54 +0200
Message-Id: <20200820091608.123251565@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaokun Zhang <zhangshaokun@hisilicon.com>

commit 539707caa1a89ee4efc57b4e4231c20c46575ccc upstream.

When PMU event ID is equal or greater than 0x4000, it will be reduced
by 0x4000 and it is not the raw number in the sysfs. Let's correct it
and obtain the raw event ID.

Before this patch:
cat /sys/bus/event_source/devices/armv8_pmuv3_0/events/sample_feed
event=0x001
After this patch:
cat /sys/bus/event_source/devices/armv8_pmuv3_0/events/sample_feed
event=0x4001

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/1592487344-30555-3-git-send-email-zhangshaokun@hisilicon.com
[will: fixed formatting of 'if' condition]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/perf_event.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -155,7 +155,7 @@ armv8pmu_events_sysfs_show(struct device
 
 	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
 
-	return sprintf(page, "event=0x%03llx\n", pmu_attr->id);
+	return sprintf(page, "event=0x%04llx\n", pmu_attr->id);
 }
 
 #define ARMV8_EVENT_ATTR(name, config)						\
@@ -244,10 +244,13 @@ armv8pmu_event_attr_is_visible(struct ko
 	    test_bit(pmu_attr->id, cpu_pmu->pmceid_bitmap))
 		return attr->mode;
 
-	pmu_attr->id -= ARMV8_PMUV3_EXT_COMMON_EVENT_BASE;
-	if (pmu_attr->id < ARMV8_PMUV3_MAX_COMMON_EVENTS &&
-	    test_bit(pmu_attr->id, cpu_pmu->pmceid_ext_bitmap))
-		return attr->mode;
+	if (pmu_attr->id >= ARMV8_PMUV3_EXT_COMMON_EVENT_BASE) {
+		u64 id = pmu_attr->id - ARMV8_PMUV3_EXT_COMMON_EVENT_BASE;
+
+		if (id < ARMV8_PMUV3_MAX_COMMON_EVENTS &&
+		    test_bit(id, cpu_pmu->pmceid_ext_bitmap))
+			return attr->mode;
+	}
 
 	return 0;
 }


