Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCBFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EDB4207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589388463;
	bh=9uD5GGq95GEOrIdgKq0RsYH4vkz3D0lu7+MGs0mk+O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0bCk1/I5Ac8evVIPRszdlxakY1EDEM2wFTOl/a8441e0BKJxfmp51TLCm7i21rcx4
	 36eUl8Gi83g3yut3tmC1xgA2QekmpKwaUwPcBfEWvraWlh+e1kkQwfzh0L9wDVdmgd
	 Qu78wpOl+/w2NC4tOcO28hNvgOgRLR3ZRZq5U5Xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389787AbgEMQrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389779AbgEMQrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:47:39 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9535E207CD;
        Wed, 13 May 2020 16:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589388459;
        bh=9uD5GGq95GEOrIdgKq0RsYH4vkz3D0lu7+MGs0mk+O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUGbaMdjR5Z5CqcYfNBX7cNUuwTss6vdSqc+h2r8BujPUbl6j+QZZc/7GgvQiZp5y
         TLq1308vIJXHtls1LekIvn2qUbVE7YbqzzQHFaGq/qdnsSNUgzZTWusMy7juX71II/
         +YmnbXMqw43mDNPtEE5wvEhBDCtP/KWXryb5wEN0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 10/10] rcu: Nocb (de)activate through sysfs
Date:   Wed, 13 May 2020 18:47:14 +0200
Message-Id: <20200513164714.22557-11-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200513164714.22557-1-frederic@kernel.org>
References: <20200513164714.22557-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not for merge.

Make nocb toggable for a given CPU using:
	/sys/devices/system/cpu/cpu*/hotplug/nocb

This is only intended for those who want to test this patchset. The real
interfaces will be cpuset/isolation and rcutorture.

Not-Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/cpu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2371292f30b0..ac6283dcb897 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2208,10 +2208,33 @@ static ssize_t show_cpuhp_fail(struct device *dev,
 
 static DEVICE_ATTR(fail, 0644, show_cpuhp_fail, write_cpuhp_fail);
 
+static ssize_t write_nocb(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	int val, ret;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val == 0)
+		rcu_nocb_cpu_deoffload(dev->id);
+	else if (val == 1)
+		rcu_nocb_cpu_offload(dev->id);
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static DEVICE_ATTR(nocb, 0644, NULL, write_nocb);
+
 static struct attribute *cpuhp_cpu_attrs[] = {
 	&dev_attr_state.attr,
 	&dev_attr_target.attr,
 	&dev_attr_fail.attr,
+	&dev_attr_nocb.attr,
 	NULL
 };
 
-- 
2.25.0

