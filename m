Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DB1C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2822924955
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588998997;
	bh=HcfK77nS4aKIjEFU+hhPyEW3u3yDaiQ4T8RgmtFvL/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DDCMyI417UAHbt65cw83JHXKjCR89rvQnjz34+xwoOorywGU8qV21SsWiQ+szvM7H
	 eW6grY0QgUghmX72zPG5SCgSHZLkkDCmPWca8OGSgDkpkXMa3Zrauyiofx1OBGQp/I
	 5/rMorxiycqSrumtB/FlHxQs46ZnZeBO2fYHh+xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgEIEgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 00:36:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44575 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgEIEgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 00:36:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id b8so1623735plm.11;
        Fri, 08 May 2020 21:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fkqGWbH5fd6+qOPQE43ttfsUeppV/4L6Bb1ZIdoGWrc=;
        b=LgvH0QhjjtSDFBKQMOf2MHLZU9gUPc38L1hXb1X5WdNcyKGv+zVdXq4g9y580nFnS7
         v0MUQiVP4ATVFg0Su4sjyaKccjliCkHa9uHwPn9VFzs5hMbOTmAGAn2EsUiLoo/aZlNL
         9p6Tq6p7T9t43ACDBj+MV2kWQVZDWl6NlXLgODfz1IX9WowbPKeD5spegMdfrDlfRa3V
         nV0OjXdgBCoEUkZ28x6Z5lZFIbHDiMPJKXhX4YY+6EZgjEXskn4tKpGV9yYOefkB4gzJ
         Ynea54WsLRenhCxsGqWYOadfGmiBOolXFf7efCf/WXJ3eoZc2cV9/H7HJ9ZQkIlco8uQ
         yGfw==
X-Gm-Message-State: AGi0Pub+hkMRazY5OJfdtnRlQsTLIWGB7eoWZbDM9tRb1BtrGFxDgWh2
        LOJnpzCF6D0M59WEH6RFlz0=
X-Google-Smtp-Source: APiQypKD38soKAjfYzfpYHiIwmAGTj5kZFhFb+SpFc0hytV+W/MnQnW4pBqhpHlyApNAA3BYg/UBVw==
X-Received: by 2002:a17:90a:2401:: with SMTP id h1mr9201853pje.1.1588998973439;
        Fri, 08 May 2020 21:36:13 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p8sm3736106pjd.10.2020.05.08.21.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 21:36:07 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 28AB74223D; Sat,  9 May 2020 04:36:01 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jeyu@kernel.org
Cc:     akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Douglas Miller <dougmill@linux.ibm.com>
Subject: [PATCH 08/15] ehea: use new module_firmware_crashed()
Date:   Sat,  9 May 2020 04:35:45 +0000
Message-Id: <20200509043552.8745-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200509043552.8745-1-mcgrof@kernel.org>
References: <20200509043552.8745-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes use of the new module_firmware_crashed() to help
annotate when firmware for device drivers crash. When firmware
crashes devices can sometimes become unresponsive, and recovery
sometimes requires a driver unload / reload and in the worst cases
a reboot.

Using a taint flag allows us to annotate when this happens clearly.

Cc: Douglas Miller <dougmill@linux.ibm.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 0273fb7a9d01..6ae35067003f 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -3285,6 +3285,8 @@ static void ehea_crash_handler(void)
 {
 	int i;
 
+	module_firmware_crashed();
+
 	if (ehea_fw_handles.arr)
 		for (i = 0; i < ehea_fw_handles.num_entries; i++)
 			ehea_h_free_resource(ehea_fw_handles.arr[i].adh,
-- 
2.25.1

