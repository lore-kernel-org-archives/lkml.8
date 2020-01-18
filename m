Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC82C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8801624690
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 18:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579372637;
	bh=oCcbqD2BKefGUR2pLUySW7Q2fxBsgBvkuKefpthD9pQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XSpOWpiU9o/D69dz9VjbDe2h/ulJ3qS0uPpdSCQ4uZAwLk/GZFuyjpKdFdxmMBi7e
	 j1+7jfEUkgccSkXUitLjiFE6OBMhI8rR/lItmDQdBDjx/dXkSyOUpdSv2VbiTyMWnn
	 3rzJ7/YJr/8IXgp16fkbu+FKwNKRv4STkihd9cR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgARShQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 13:37:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41159 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgARShQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 13:37:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so25671363wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=y0KWi/XyWEpllUi/P2qbvtRwe6JEOw32yM0u82ON12U=;
        b=dEAtND7byQb35XIyPBxviOZd/p9HK9p4bt5iUlJNvW91uq0XMdeqyLWgurwhKa3E9T
         zoW9z6Gniml/Vw6XsVyghXLGhsINUavG2s3XMYCZF9aTTkqAWTfdRcSNkmBmfatffDOr
         eAbxfeXlRnhR5iStJpbbZcoW+Kq23vQVJDqkCP9xnWjGewooj73aafcYlji3JoJ3vtta
         sLlaaklszNRqBy5jbHeDX+xQvmjJ9gfPGtf6oJH0GK8EphjmfCd+Z+NON5fMrmLIyOPf
         aSZh4IumZUazb2LLH64kRrb1z3vh7fZw0jkUg5IbQm+kGkcAIVmQUFTorfR1iJ6U0FWv
         Bfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=y0KWi/XyWEpllUi/P2qbvtRwe6JEOw32yM0u82ON12U=;
        b=AfqJFeb6JC39bnuLaueuALEAX7g0enz5UId+8VGzZ+t0V5Pt7C9Pa03M5sw2XQJZkd
         2JXt7MOv7E/NM8scha0Y4PIOQ/+6XUsY3j5FPDt+A2rMwRvJAVBQlqvxjljnIRqGoYeE
         XNyhFK7idEYmk4rFM3GY1sZKYQ8LVBlz/PSWlQEAHNTTIfVBPTbeUS2LroV6qcY8HRWn
         p/mXLDlSivzyrfjRZz6Q+GwX40NAK2xOMQqjNaEA2KXYB0LDBrhqfD1qPwnYw9CVR1nS
         s7DZNUU/XpfOghJurCOCyBhGItMlABFB115V0VRxHGr6T7xIQ+/NHztNgl8jEJFre4Vy
         2uIw==
X-Gm-Message-State: APjAAAWCbNHdnoFk3COSesP7tSL5y2TXdBypNJ73NALrKUG9GfqW4jZL
        7EKp49PDOgzECqBwRB8YX0ntf0s0
X-Google-Smtp-Source: APXvYqyMGUyBelucb2INmIIcE8rIczdcMdQw2T+T51TedOQ9dXi7gewHhriMEury/XTgwyKAvWxn+Q==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr10347804wrr.158.1579372633525;
        Sat, 18 Jan 2020 10:37:13 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o4sm38225056wrx.25.2020.01.18.10.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 10:37:13 -0800 (PST)
Date:   Sat, 18 Jan 2020 19:37:11 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] cpu/SMT fix
Message-ID: <20200118183711.GA52397@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest smp-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

   # HEAD: dc8d37ed304eeeea47e65fb9edc1c6c8b0093386 cpu/SMT: Fix x86 link error without CONFIG_SYSFS

Fix a build bug on CONFIG_HOTPLUG_SMT=y && !CONFIG_SYSFS kernels.

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      cpu/SMT: Fix x86 link error without CONFIG_SYSFS


 kernel/cpu.c | 143 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 72 insertions(+), 71 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index a59cc980adad..4dc279ed3b2d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1909,6 +1909,78 @@ void __cpuhp_remove_state(enum cpuhp_state state, bool invoke)
 }
 EXPORT_SYMBOL(__cpuhp_remove_state);
 
+#ifdef CONFIG_HOTPLUG_SMT
+static void cpuhp_offline_cpu_device(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	dev->offline = true;
+	/* Tell user space about the state change */
+	kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
+}
+
+static void cpuhp_online_cpu_device(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	dev->offline = false;
+	/* Tell user space about the state change */
+	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
+}
+
+int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
+{
+	int cpu, ret = 0;
+
+	cpu_maps_update_begin();
+	for_each_online_cpu(cpu) {
+		if (topology_is_primary_thread(cpu))
+			continue;
+		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
+		if (ret)
+			break;
+		/*
+		 * As this needs to hold the cpu maps lock it's impossible
+		 * to call device_offline() because that ends up calling
+		 * cpu_down() which takes cpu maps lock. cpu maps lock
+		 * needs to be held as this might race against in kernel
+		 * abusers of the hotplug machinery (thermal management).
+		 *
+		 * So nothing would update device:offline state. That would
+		 * leave the sysfs entry stale and prevent onlining after
+		 * smt control has been changed to 'off' again. This is
+		 * called under the sysfs hotplug lock, so it is properly
+		 * serialized against the regular offline usage.
+		 */
+		cpuhp_offline_cpu_device(cpu);
+	}
+	if (!ret)
+		cpu_smt_control = ctrlval;
+	cpu_maps_update_done();
+	return ret;
+}
+
+int cpuhp_smt_enable(void)
+{
+	int cpu, ret = 0;
+
+	cpu_maps_update_begin();
+	cpu_smt_control = CPU_SMT_ENABLED;
+	for_each_present_cpu(cpu) {
+		/* Skip online CPUs and CPUs on offline nodes */
+		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
+			continue;
+		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
+		if (ret)
+			break;
+		/* See comment in cpuhp_smt_disable() */
+		cpuhp_online_cpu_device(cpu);
+	}
+	cpu_maps_update_done();
+	return ret;
+}
+#endif
+
 #if defined(CONFIG_SYSFS) && defined(CONFIG_HOTPLUG_CPU)
 static ssize_t show_cpuhp_state(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -2063,77 +2135,6 @@ static const struct attribute_group cpuhp_cpu_root_attr_group = {
 
 #ifdef CONFIG_HOTPLUG_SMT
 
-static void cpuhp_offline_cpu_device(unsigned int cpu)
-{
-	struct device *dev = get_cpu_device(cpu);
-
-	dev->offline = true;
-	/* Tell user space about the state change */
-	kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
-}
-
-static void cpuhp_online_cpu_device(unsigned int cpu)
-{
-	struct device *dev = get_cpu_device(cpu);
-
-	dev->offline = false;
-	/* Tell user space about the state change */
-	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
-}
-
-int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
-{
-	int cpu, ret = 0;
-
-	cpu_maps_update_begin();
-	for_each_online_cpu(cpu) {
-		if (topology_is_primary_thread(cpu))
-			continue;
-		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
-		if (ret)
-			break;
-		/*
-		 * As this needs to hold the cpu maps lock it's impossible
-		 * to call device_offline() because that ends up calling
-		 * cpu_down() which takes cpu maps lock. cpu maps lock
-		 * needs to be held as this might race against in kernel
-		 * abusers of the hotplug machinery (thermal management).
-		 *
-		 * So nothing would update device:offline state. That would
-		 * leave the sysfs entry stale and prevent onlining after
-		 * smt control has been changed to 'off' again. This is
-		 * called under the sysfs hotplug lock, so it is properly
-		 * serialized against the regular offline usage.
-		 */
-		cpuhp_offline_cpu_device(cpu);
-	}
-	if (!ret)
-		cpu_smt_control = ctrlval;
-	cpu_maps_update_done();
-	return ret;
-}
-
-int cpuhp_smt_enable(void)
-{
-	int cpu, ret = 0;
-
-	cpu_maps_update_begin();
-	cpu_smt_control = CPU_SMT_ENABLED;
-	for_each_present_cpu(cpu) {
-		/* Skip online CPUs and CPUs on offline nodes */
-		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
-			continue;
-		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
-		if (ret)
-			break;
-		/* See comment in cpuhp_smt_disable() */
-		cpuhp_online_cpu_device(cpu);
-	}
-	cpu_maps_update_done();
-	return ret;
-}
-
-
 static ssize_t
 __store_smt_control(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
