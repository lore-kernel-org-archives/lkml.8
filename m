Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E802DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF26924672
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ6By73B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCAVjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 16:39:16 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35436 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAVjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:39:15 -0500
Received: by mail-pj1-f67.google.com with SMTP id s8so1751610pjq.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 13:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJNHUDzAdLWChqG1N9revlyKtIZEHKpvhkJX7T9UBbE=;
        b=LZ6By73BdbPoU4r2bSGdOY1WV4P79kzob+KJaemZh0Kocoq9IBzXEUB8EMLoHA8d+r
         +fJU7jB6rXoUjuwCQW1ejO7mhiN1R4AzzNaGxaj1oL/gEU+qbP+5hCIqqFG2ZxUhwPsi
         bwQLZBtKpe0qBgQky2613dMqBpP+Ka72x7aAAVhvgpwBD9tB/wmBKqYc6NNaBsfWVdsR
         wEM26x8gzEPOi0yTWprBD1ZKKyOeJKhz/uK65RV45d5GywNLJ+64hXz0h9UpF4a5eQL3
         E2THmIEd0WmZYvJIszGQWG4NMSU6Q9VgvZMN9jRHWM86/DZ7gklZETfu3WhxvxCIqcAC
         CHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJNHUDzAdLWChqG1N9revlyKtIZEHKpvhkJX7T9UBbE=;
        b=Jn+IVJ/rexDecO3wbTFDrIFWV8Znb4rKdfbXEZQC0ZX1sPekF/CQbGJgRZ4rZF1YSD
         0CrbZ44NOVTn+48rKi5pedV4r113Q29rTC1FSvp+55bJmoI/NkCyK6mZEXY/M12Gx7DD
         FCmkPIzz9nfFozCVZbZTcSTaKvenGSrghqEjXmy0r/m2goBtoEVi7WeQ1gTb8dnnDvR4
         WasTwYMejtTDhTeoDOqu50peYxYspdNFxf1GXf2cOzuEDHRCPAlpqjg5hjCbcQigdjaI
         0sLTspQeTfFYfN9Uuj0O+XDf4yDvj2OHIsiCzZcmtXtelmTLFJQG7t1LpmFMU8JbSP5J
         RlAw==
X-Gm-Message-State: ANhLgQ3FjiaIHl8/vEbQ64nTFYPcz1awQ+yaN+ZwRkscv31fpNRdFu8G
        cobPY3HhpaOD4iDAUhKFI57oMVWA
X-Google-Smtp-Source: ADFU+vuLrpCWb5J6xm7FDp6xlja4TsDZ/bD3diKdvDp/uq3M20KtjfJTS4LTlJRnpFEHJnCXX+KKUA==
X-Received: by 2002:a17:902:5998:: with SMTP id p24mr7056846pli.215.1583098753022;
        Sun, 01 Mar 2020 13:39:13 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id c15sm17184087pgk.66.2020.03.01.13.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 13:39:12 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 3/3] openrisc: Cleanup copy_thread_tls docs and comments
Date:   Mon,  2 Mar 2020 06:38:51 +0900
Message-Id: <20200301213851.8096-4-shorne@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200301213851.8096-1-shorne@gmail.com>
References: <20200301213851.8096-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously copy_thread_tls was copy_thread and before that something
else.  Remove the documentation about the regs parameter that didn't
exist in either version.

Next, fix comment wrapping and details about how TLS pointer gets to the
copy_thread_tls function.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/openrisc/kernel/process.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 5caa47f7de4f..6bcdca424e11 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -122,7 +122,6 @@ extern asmlinkage void ret_from_fork(void);
  * @usp: user stack pointer or fn for kernel thread
  * @arg: arg to fn for kernel thread; always NULL for userspace thread
  * @p: the newly created task
- * @regs: CPU context to copy for userspace thread; always NULL for kthread
  * @tls: the Thread Local Storage pointer for the new process
  *
  * At the top of a newly initialized kernel stack are two stacked pt_reg
-- 
2.21.0

