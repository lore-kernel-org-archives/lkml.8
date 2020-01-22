Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578B4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7AD24688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699172;
	bh=EsfXXKZ3mPxHUwIBoC1V7kBeQf4qR+1RmiqD89uuj60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fN9laIzLIOtUzZ0cIh+dIr8gxx1IVwPZ4GNTQxoET1Y7uBg2MZdPAewPH8NP8xIjI
	 DI0XmfoDkmTc0TTigukPIIE3ar5ZObJS3CIFZOkNuIXf5tM3vLqo1Msn7MJDXWqG8W
	 AkHDp0xUOvT1QZGAkvufXdCX2ZohAZ7WCjK9eZTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAVNTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgAVNT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:19:28 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 627072467E;
        Wed, 22 Jan 2020 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699168;
        bh=EsfXXKZ3mPxHUwIBoC1V7kBeQf4qR+1RmiqD89uuj60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iOu8h1UMBMUXHtOUP8EkFSZZqOOvkX1WT+96c+iJPiu+8MbQXRxyDaiwzclLMUNch
         kU9hk4cwMC6QzwtOHgZfQjU0V6KuQoirmOlreMoOnxlP8wEV2zLN5Qk5CkqmqIPuxL
         1+tACCvLTL+jvl24QLIFVjgjfXGcw9ghY/rtCSuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 034/222] cpuidle: teo: Fix intervals[] array indexing bug
Date:   Wed, 22 Jan 2020 10:27:00 +0100
Message-Id: <20200122092835.929918908@linuxfoundation.org>
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

From: Ikjoon Jang <ikjn@chromium.org>

commit 57388a2ccb6c2f554fee39772886c69b796dde53 upstream.

Fix a simple bug in rotating array index.

Fixes: b26bf6ab716f ("cpuidle: New timer events oriented governor for tickless systems")
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Cc: 5.1+ <stable@vger.kernel.org> # 5.1+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpuidle/governors/teo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -194,7 +194,7 @@ static void teo_update(struct cpuidle_dr
 	 * pattern detection.
 	 */
 	cpu_data->intervals[cpu_data->interval_idx++] = measured_us;
-	if (cpu_data->interval_idx > INTERVALS)
+	if (cpu_data->interval_idx >= INTERVALS)
 		cpu_data->interval_idx = 0;
 }
 


