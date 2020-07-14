Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B094C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D460122464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPiADLSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGNM7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGNM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:59:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A59FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:59:44 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o38so12642362qtf.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UARzO1WFxZQcMjBB8yKfPoPlNkMAzXMUicHr6tVQpkQ=;
        b=QPiADLSq7fELwQRpXhcH/HkF/SzqCS7Dxdc3RMfwu+dOJOjE5PPFKYkZD/QX40fS0F
         7SB6TdT8j1TAwUtSvYR3AAd/xrM+DWFqNpy60fem81JA7mMpr0dQ5mA4AvxQ9z8CcEMx
         kgIf3B4h0nYBjjPJcWUHzjyoVgGjdAjE/xInulticD7yy1gwqaq3UHMC+uBitkyQN9gE
         EDlwADqCFqrkF3fJYBmGdyv5VTsBU5RV2aw9knkV7O6vCfiZqSJYBpDa4n1XK2wzO/+u
         G+joeYEPjKZjTKLkjhc2PJZS/4FpdtxwZsWEFfCQuPnCekqranbRnflXIMUOrfAdVMkt
         kqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UARzO1WFxZQcMjBB8yKfPoPlNkMAzXMUicHr6tVQpkQ=;
        b=Y3htpxKdCyheY7f7KG3ooyyR1/O/qFNMzB/LsWEY3PYrHAJLRxIxy/wbOZO1957Ixu
         xknqvugrV3p60BFynd51ItS7DSyc9cvf1T1dlK1EmVWIebTCBhzQqqTANoqZJ9NcBx/n
         mi4Xska2X1bs/d0U+FfUySraGYr/JVkLvKrWeG5e7Xk606lmzOpk35J/eYOqvYNkJ2oR
         ntP8FYvnKg235hhYzhxi0rJjHAygSnOAGYRMlvmTo1GJFwJWpsC7Ba8MLfUL3sG1kZHS
         Q71mbfNhFLu85c/NAKXU/tm24TFjnH/f5d34AjwxOzg9PNkTmBKbm3BdWQFFgoQKeYGo
         PmOQ==
X-Gm-Message-State: AOAM5332HY/s1vls5Vpk7L19nCPFyPdi/VsGyONCa9p7ApCboYNWOBjf
        gS0qrNe/cRdBUW4eGHdV0XXKlLNXBWtauvci
X-Google-Smtp-Source: ABdhPJwi1XBgprYkr6cCi1GRuE9QZYpOTdIcJa9DnHj0RhWCV50pNRKoKmcKfy2n9ncHevD4xqR53w==
X-Received: by 2002:ac8:4b4f:: with SMTP id e15mr4588639qts.305.1594731583374;
        Tue, 14 Jul 2020 05:59:43 -0700 (PDT)
Received: from Trinity.hsd1.ma.comcast.net ([2601:189:8200:19b0:8007:e577:f459:885a])
        by smtp.gmail.com with ESMTPSA id f4sm22582162qtv.59.2020.07.14.05.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 05:59:42 -0700 (PDT)
From:   peter.puhov@linaro.org
To:     linux-kernel@vger.kernel.org
Cc:     peter.puhov@linaro.org, robert.foley@linaro.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: [PATCH v1] sched/fair: update_pick_idlest() Select group with lowest group_util when idle_cpus are equal
Date:   Tue, 14 Jul 2020 08:59:41 -0400
Message-Id: <20200714125941.4174-1-peter.puhov@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Puhov <peter.puhov@linaro.org>

v0: https://lkml.org/lkml/2020/6/16/1286

Changes in v1:
- Test results formatted in a table form as suggested by Valentin Schneider
- Added explanation by Vincent Guittot why nr_running may not be sufficient

In slow path, when selecting idlest group, if both groups have type 
group_has_spare, only idle_cpus count gets compared.
As a result, if multiple tasks are created in a tight loop,
and go back to sleep immediately 
(while waiting for all tasks to be created), 
they may be scheduled on the same core, because CPU is back to idle
when the new fork happen.

For example:
sudo perf record -e sched:sched_wakeup_new -- \
                                  sysbench threads --threads=4 run
...
    total number of events:              61582
...
sudo perf script
sysbench 129378 [006] 74586.633466: sched:sched_wakeup_new: 
                            sysbench:129380 [120] success=1 CPU:007
sysbench 129378 [006] 74586.634718: sched:sched_wakeup_new: 
                            sysbench:129381 [120] success=1 CPU:007
sysbench 129378 [006] 74586.635957: sched:sched_wakeup_new: 
                            sysbench:129382 [120] success=1 CPU:007
sysbench 129378 [006] 74586.637183: sched:sched_wakeup_new: 
                            sysbench:129383 [120] success=1 CPU:007

This may have negative impact on performance for workloads with frequent
creation of multiple threads.

In this patch we are using group_util to select idlest group if both groups
have equal number of idle_cpus. Comparing the number of idle cpu is 
not enough in this case, because the newly forked thread sleeps 
immediately and before we select the cpu for the next one. 
This is shown in the trace where the same CPU7 is selected for 
all wakeup_new events.
That's why, looking at utilization when there is the same number of
CPU is a good way to see where the previous task was placed. Using
nr_running doesn't solve the problem because the newly forked task is not
running and the cpu would not have been idle in this case and an idle
CPU would have been selected instead.

With this patch newly created tasks would be better distributed. 

With this patch:
sudo perf record -e sched:sched_wakeup_new -- \
                                    sysbench threads --threads=4 run
...
    total number of events:              74401
...
sudo perf script
sysbench 129455 [006] 75232.853257: sched:sched_wakeup_new: 
                            sysbench:129457 [120] success=1 CPU:008
sysbench 129455 [006] 75232.854489: sched:sched_wakeup_new: 
                            sysbench:129458 [120] success=1 CPU:009
sysbench 129455 [006] 75232.855732: sched:sched_wakeup_new: 
                            sysbench:129459 [120] success=1 CPU:010
sysbench 129455 [006] 75232.856980: sched:sched_wakeup_new: 
                            sysbench:129460 [120] success=1 CPU:011


We tested this patch with following benchmarks:
master: 'commit b3a9e3b9622a ("Linux 5.8-rc1")' 

100 iterations of: perf bench -f simple futex wake -s -t 128 -w 1
Lower result is better
|         |   BASELINE |   +PATCH |   DELTA (%) |
|---------|------------|----------|-------------|
| mean    |      0.33  |    0.313 |      +5.152 |
| std (%) |     10.433 |    7.563 |             |


100 iterations of: sysbench threads --threads=8 run
Higher result is better
|         |   BASELINE |   +PATCH |   DELTA (%) |
|---------|------------|----------|-------------|
| mean    |   5235.02  | 5863.73  |      +12.01 |
| std (%) |      8.166 |   10.265 |             |


100 iterations of: sysbench mutex --mutex-num=1 --threads=8 run
Lower result is better
|         |   BASELINE |   +PATCH |   DELTA (%) |
|---------|------------|----------|-------------|
| mean    |      0.413 |    0.404 |      +2.179 |
| std (%) |      3.791 |    1.816 |             |


Signed-off-by: Peter Puhov <peter.puhov@linaro.org>
---
 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..abcbdf80ee75 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8662,8 +8662,14 @@ static bool update_pick_idlest(struct sched_group *idlest,
 
 	case group_has_spare:
 		/* Select group with most idle CPUs */
-		if (idlest_sgs->idle_cpus >= sgs->idle_cpus)
+		if (idlest_sgs->idle_cpus > sgs->idle_cpus)
 			return false;
+
+		/* Select group with lowest group_util */
+		if (idlest_sgs->idle_cpus == sgs->idle_cpus &&
+			idlest_sgs->group_util <= sgs->group_util)
+			return false;
+
 		break;
 	}
 
-- 
2.20.1

