Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3343DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9CD20774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="3J5kaZr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbgFIAqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbgFIAqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:46:02 -0400
Received: from mail-ot1-x363.google.com (mail-ot1-x363.google.com [IPv6:2607:f8b0:4864:20::363])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2FDC03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 17:46:01 -0700 (PDT)
Received: by mail-ot1-x363.google.com with SMTP id n6so5913920otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 17:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:from:to:cc:subject:date
         :message-id:in-reply-to:references:content-transfer-encoding;
        bh=NKSJp0rZrw1+cKT/x08zXjzbpHqLU8j+v1TneyTidX4=;
        b=kfvgcVAnS1CeClTtPwQakmiXugkL1wHk0BbPkua+4k8ke2Vp/hOqUmBfaKkp06w+8j
         xNijS9wcOW9/wwE5rYZDE+q5A+sUTZJRw6lZsGEhf8JjLhtFdD4NbRRm1FaAI9ECaoCw
         HYyuDzRQG4+xDD8M96ixQz4mWxS80wTk0YrOtL3AmPvrPu7ymmYyXtP+YBXnswZ5/EmQ
         3xi3mT77U20pw8rNi/jmHLf8FXMfDrlR7nFWglX/aWS7Z9uu5oy0Hl0OXRbc+DKZPmTM
         AC1HAN25HBhdjJ849Cp6wsUya6g4hByS5tl4MIkMcEAQl1J4xllyW1V7TIG2k9ppo7VK
         6IJA==
X-Gm-Message-State: AOAM530PwSy0qmQxkdjQE9BzkqCSaUW+YRoLHhNAdfa7tOC03BYsGaoB
        L0LdR7D+y0Vgy/lZyhG6/yengDxnVgSBLmKoyxdjwQINv12/
X-Google-Smtp-Source: ABdhPJw0RrINSi0Nk5/hDpaHJzNHQDZThqaFZ+50TnYmqReJYNYn8O6jMQwcW0TY8GgrGAM5wURE2fGA9QNP
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr20388013otq.74.1591663560501;
        Mon, 08 Jun 2020 17:46:00 -0700 (PDT)
Received: from smtp.aristanetworks.com (smtp.aristanetworks.com. [52.0.43.43])
        by smtp-relay.gmail.com with ESMTPS id m4sm1417083oop.4.2020.06.08.17.46.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 17:46:00 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from chmeee (unknown [10.95.85.208])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 8E36A3002D17;
        Mon,  8 Jun 2020 17:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1591663559;
        bh=NKSJp0rZrw1+cKT/x08zXjzbpHqLU8j+v1TneyTidX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=3J5kaZr1W/Tba7a0Donvx5VHiNzWXfoDjbRVOW8UkDKZAPDwMOtADpSJzSi+R+s68
         lpOhcvisCPLrW8OQxQNRcoS8XWbH7JgjGudfIcsmnUFUnZE/5XWvCI/ZoBZNop544N
         rwTrAIAwUd240TkN20zajDQZZNshyXFD4fxP31Hs/s2bBnVz3EknFpVb0FECfsYp3x
         5atcP2O5L5U7jWtGEdpHCCUGgG1f/CV31ysx15Zh9J8lV/E2wJp5Stpr/sYbi47HHa
         WQNIWZrO47A40Ar9bEi8Jmwm1govO7xUqxKPYeS6OAa0/aoUjo8K/ZMkZbCG1AnvPy
         HSpVEyyt9gEyw==
Received: from kevmitch by chmeee with local (Exim 4.93)
        (envelope-from <kevmitch@chmeee>)
        id 1jiSOr-005RRq-FD; Mon, 08 Jun 2020 17:45:57 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Kevin Mitchell <kevmitch@arista.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/apic: remove boot_cpu_physical_apicid hacks
Date:   Mon,  8 Jun 2020 17:44:49 -0700
Message-Id: <20200609004451.1296880-2-kevmitch@arista.com>
In-Reply-To: <20200609004451.1296880-1-kevmitch@arista.com>
References: <20200609004451.1296880-1-kevmitch@arista.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that mpparse can be relied upon to not sabotage
boot_cpu_physical_apicid with nonsense, the hacks that tried to work
around that nonsense can be removed.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 arch/x86/kernel/apic/apic.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4b1d31be50b4..c1722a71aca5 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2361,27 +2361,8 @@ int generic_processor_info(int apicid, int version)
 	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
 				phys_cpu_present_map);
 
-	/*
-	 * boot_cpu_physical_apicid is designed to have the apicid
-	 * returned by read_apic_id(), i.e, the apicid of the
-	 * currently booting-up processor. However, on some platforms,
-	 * it is temporarily modified by the apicid reported as BSP
-	 * through MP table. Concretely:
-	 *
-	 * - arch/x86/kernel/mpparse.c: MP_processor_info()
-	 * - arch/x86/mm/amdtopology.c: amd_numa_init()
-	 *
-	 * This function is executed with the modified
-	 * boot_cpu_physical_apicid. So, disabled_cpu_apicid kernel
-	 * parameter doesn't work to disable APs on kdump 2nd kernel.
-	 *
-	 * Since fixing handling of boot_cpu_physical_apicid requires
-	 * another discussion and tests on each platform, we leave it
-	 * for now and here we use read_apic_id() directly in this
-	 * function, generic_processor_info().
-	 */
 	if (disabled_cpu_apicid != BAD_APICID &&
-	    disabled_cpu_apicid != read_apic_id() &&
+	    disabled_cpu_apicid != boot_cpu_physical_apicid &&
 	    disabled_cpu_apicid == apicid) {
 		int thiscpu = num_processors + disabled_cpus;
 
@@ -2498,15 +2479,6 @@ static void __init apic_bsp_up_setup(void)
 {
 #ifdef CONFIG_X86_64
 	apic_write(APIC_ID, apic->set_apic_id(boot_cpu_physical_apicid));
-#else
-	/*
-	 * Hack: In case of kdump, after a crash, kernel might be booting
-	 * on a cpu with non-zero lapic id. But boot_cpu_physical_apicid
-	 * might be zero if read from MP tables. Get it from LAPIC.
-	 */
-# ifdef CONFIG_CRASH_DUMP
-	boot_cpu_physical_apicid = read_apic_id();
-# endif
 #endif
 	physid_set_mask_of_physid(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
-- 
2.26.2

