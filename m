Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5EEC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E4721D81
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beSw2q4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgCZQdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:33:08 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:52967 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgCZQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:33:08 -0400
Received: by mail-oi1-f201.google.com with SMTP id c123so5152153oig.19
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/J9DKIJKhoNAqIER9UasEoSb9g40NhzAqb5br/ibrT0=;
        b=beSw2q4SdKcg2ewSfNyzPzqQi7r3biZrSQXp2knPVxfAerelXJjmhK9TCYS7rW12ie
         aTfz4SLt5zbajIBh5cWhhcq5lEyvYrN4uGoXQZnwbJWqrq3tjKl9b4tWRK00frEKMoOd
         x5BZCE6CXh6GWMjkOchwFfFL0bdrCtl7EhdrEa/6cugeK0y3wR4KzQobSR/39xve71eZ
         KNUzTShRtOJMZTRegK23KRRi8V/m8GTBht1NvCfuAfGyD73L/1/j5P0SRjukQ7C5oAq0
         7FHVxIAjG3yXjk0ncnwiH2N20DUV+YIWeZ8KfdSdB5+zmd+nwxbX354Ym7/YIv73XaeF
         R8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/J9DKIJKhoNAqIER9UasEoSb9g40NhzAqb5br/ibrT0=;
        b=FLoPr+XwEGrtcAf8f8R13EuCqAnsUX55xNPWMbBBEAt5wxn0oPtu6z+C5NGas3CISK
         OJlKv5ppSLmsdGuvweWTonjGR052JPL7pVsKFZ/ZNUltl+W3ZGdchOve+vFcFU2qWxMn
         YqV5nRwAxnBR5eKuCT7W/Fsacb1FRzeMCj52BHXDdLyqcuAaZejXv3uempJECG0FRcOY
         QhBnkFVOCYgXPUn/P0jB8iJZRhhzcSVyVA6t8D/dRCLzVlv181xb2ai+nrcGR9IxRhN4
         J1l+OxT8DzBDoembCsLblyA8dQZ9uWjUDIUnd1PviL56/k/829W1ZJixDuZ/45qbR6Tg
         ID5g==
X-Gm-Message-State: ANhLgQ2LUuwgpXbxlxY5VIpsAvC5zmdJmp1SWpZahr0SrBvHRbZKMy7E
        I314mJiaxCHPeMStyNn8nmIoMMlXNw==
X-Google-Smtp-Source: ADFU+vswccn+Q+WfsmaOAwBveKU2nHAMiMFJYzibgK2DXdmsoT2sJImOAdVerEb5afTmMyP5wKACsOobtw==
X-Received: by 2002:a9d:8e4:: with SMTP id 91mr7312036otf.130.1585240387114;
 Thu, 26 Mar 2020 09:33:07 -0700 (PDT)
Date:   Thu, 26 Mar 2020 17:32:43 +0100
Message-Id: <20200326163245.119670-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH 0/2] Make printk_deferred() work properly before percpu setup
 is done
From:   Jann Horn <jannh@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While I was doing some development work, I noticed that if you call
printk_deferred() before percpu setup has finished, stuff breaks, and
e.g. "dmesg -w" fails to print new messages.

This happens because writing to percpu memory before percpu
initialization is done causes the modified percpu memory to be
propagated from the boot CPU to all the secondary CPUs; and both the
printk code as well as the irq_work implementation use percpu memory.

I think that printk_deferred() ought to work even before percpu
initialization, since it is used by things like pr_warn_ratelimited()
and the unwinder infrastructure. I'm not entirely sure though whether
this is the best way to implement that, or whether it would be better to
let printk_deferred() do something different if it is called during
early boot.

Jann Horn (2):
  irq_work: Reinitialize list heads for secondary CPUs
  printk: Reinitialize klogd percpu state for secondary CPUs

 kernel/irq_work.c      | 22 ++++++++++++++++++++++
 kernel/printk/printk.c | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)


base-commit: 76ccd234269bd05debdbc12c96eafe62dd9a6180
-- 
2.25.1.696.g5e7596f4ac-goog

