Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF8AC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCEC206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="J5dJtf5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbgCDAnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:43:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36952 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387396AbgCDAnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:43:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id m9so5454333qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 16:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DRZPjOU86C+QBTaOB6DsJlZhFthqBDzzJfXy4mDxK2E=;
        b=J5dJtf5oYmzUXexSyHe+zHPOgeJmiMlpBKHCOi4i4YYu4dpJRn+Pbu450LBkIBtNDJ
         uyNQlkVBnAyZQ6CvoXptBQSCXSwVGZq1GSk1YYKrIkaBLFe/fV5jlamq7cMbwKQlJojW
         S/lAP4inVw4lAR88C4BzNgptPwd3Kq53+D/WrM3nPrKh5cEoc2BSIIpNIs1tnRQnYUD6
         aqSv/l34Gtn3NsWHJapV8yGVO5MDmf5rGMtsD5LevkFpQP14UdWwJrrWKKEJZzFq8nFp
         XfZCrFT1+/5SJvnYSr0cMI9opufqhxEUqeX9yzoP9BSyqRmRTHRraCHGzWCfPMwMlOq4
         g0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DRZPjOU86C+QBTaOB6DsJlZhFthqBDzzJfXy4mDxK2E=;
        b=sgiyFDwebqHAcVzBgzCbA6m84Ui6unzpEl71J6WBFVaYGVuw5gaRRu8hftO8hdk37Y
         f+kKfXWQ49i0On1FJ98zpbMfgRs9BKGrOnRVXjbOc2qNzAnQuzoWOtJf1YIfAK57MdRB
         3s2nhFKtvFpmWW7glohFgyVTwr5Qw5fd77Ba+T+s2m2RfzRX9VQdSiSAkBELqRH1rfr9
         6fzdAOFifhiC2oOcO1ydLRg5n7UVRt8l3mZZu/H8sXA3WgB6ajUx6S5gYc8JgiDbGTmO
         QDl8drv7v3EKGqNeB2ucX2quIlypSVMRX0MH0P1NJ/23A79o1Dl7BrTC2813+OXocMZN
         FDCw==
X-Gm-Message-State: ANhLgQ0GMXMSg5vLGIcLVSc6001wxiFe69KvqoxieXVMjaVr5cF8+ytq
        BtNHo4kQONmL/53xKa1KRnsfOyvzJd07OQ==
X-Google-Smtp-Source: ADFU+vsgG146lXuiifbBZ94JzvpBcPtzlNUuXJJh3mMTUvsDDiTgL3moviBSD4srwd5s+UiV0qppcw==
X-Received: by 2002:a05:620a:806:: with SMTP id s6mr664391qks.235.1583282625401;
        Tue, 03 Mar 2020 16:43:45 -0800 (PST)
Received: from ovpn-121-139.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id w48sm14038759qtc.40.2020.03.03.16.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 16:43:44 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de
Cc:     ebiederm@xmission.com, oleg@redhat.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] posix-cpu-timers: fix memory leaks for task_struct
Date:   Tue,  3 Mar 2020 19:43:36 -0500
Message-Id: <20200304004336.960-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent commit removed put_task_struct() in posix_cpu_timer_del()
results in many memory leaks like this,

unreferenced object 0xc0000016d9b44480 (size 8192):
  comm "timer_create01", pid 57749, jiffies 4295163733 (age 6159.670s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000056aca129>] copy_process+0x26c/0x18e0
    alloc_task_struct_node at kernel/fork.c:169
    (inlined by) dup_task_struct at kernel/fork.c:877
    (inlined by) copy_process at kernel/fork.c:1929
    [<00000000bdbbf9f8>] _do_fork+0xac/0xb20
    [<00000000dcb1c445>] __do_sys_clone+0x98/0xe0
    __do_sys_clone at kernel/fork.c:2591
    [<000000006c059205>] ppc_clone+0x8/0xc
    ppc_clone at arch/powerpc/kernel/entry_64.S:479

Fixes: 672ebe8eb017a5 ("posix-cpu-timers: Store a reference to a pid not a task")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/time/posix-cpu-timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index afd1e959a282..e0b580deb61a 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -446,8 +446,10 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 
 out:
 	rcu_read_unlock();
-	if (!ret)
+	if (!ret) {
 		put_pid(ctmr->pid);
+		put_task_struct(p);
+	}
 
 	return ret;
 }
-- 
2.21.0 (Apple Git-122.2)

