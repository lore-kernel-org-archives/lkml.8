Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F0CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9114420CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577555;
	bh=/yiwJt2Ym0/+aaH/zOczKqsSnUNtR8CrvV3jupuKf0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x/xm/VI/vchloEDrQ93IulmEUrJLRa3LVX8dv8y4SjGDv3GNEeituLl+BKbWrBebx
	 l7OQVZ5Zjs7oTMA8aWVK7EcsWUxSW9wRbtshubDydFC3caQQQofR+4Ld4k7t9Siidw
	 XoulX8ww+ioheWwij9KVcxY0t+LXsgncb7Psb0Xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbgFSOjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387991AbgFSOjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:39:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D1DB20CC7;
        Fri, 19 Jun 2020 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577548;
        bh=/yiwJt2Ym0/+aaH/zOczKqsSnUNtR8CrvV3jupuKf0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cL70GwHe+K1NUFyXWN2OrL0uHWfL6REE636pFsawz4V/Gnga6o812LoDC+wubtAJM
         mYggl06ZZcOPMLW0vKhajLeH5bG0rQ7hRfXm06xz+gSY4pE7xigeU89ggNwBnf6h1m
         K/9J1VU5fcZNgCthFmTpFSw/ggvdfZj1X08s+AlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4.4 093/101] kernel/cpu_pm: Fix uninitted local in cpu_pm
Date:   Fri, 19 Jun 2020 16:33:22 +0200
Message-Id: <20200619141618.842658814@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

commit b5945214b76a1f22929481724ffd448000ede914 upstream.

cpu_pm_notify() is basically a wrapper of notifier_call_chain().
notifier_call_chain() doesn't initialize *nr_calls to 0 before it
starts incrementing it--presumably it's up to the callers to do this.

Unfortunately the callers of cpu_pm_notify() don't init *nr_calls.
This potentially means you could get too many or two few calls to
CPU_PM_ENTER_FAILED or CPU_CLUSTER_PM_ENTER_FAILED depending on the
luck of the stack.

Let's fix this.

Fixes: ab10023e0088 ("cpu_pm: Add cpu power management notifiers")
Cc: stable@vger.kernel.org
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20200504104917.v6.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/cpu_pm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -97,7 +97,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_unregister_noti
  */
 int cpu_pm_enter(void)
 {
-	int nr_calls;
+	int nr_calls = 0;
 	int ret = 0;
 
 	read_lock(&cpu_pm_notifier_lock);
@@ -156,7 +156,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_exit);
  */
 int cpu_cluster_pm_enter(void)
 {
-	int nr_calls;
+	int nr_calls = 0;
 	int ret = 0;
 
 	read_lock(&cpu_pm_notifier_lock);


