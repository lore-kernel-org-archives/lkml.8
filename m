Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAB4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D574D207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbgE0Nts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:49:48 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbgE0Ntr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:49:47 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhUQ7-1j91G51nmt-00ehEl; Wed, 27 May 2020 15:48:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/entry: Fix unused-function warning
Date:   Wed, 27 May 2020 15:48:33 +0200
Message-Id: <20200527134847.1014162-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rcxzRfm9RWNwTE4dnsLZHZdPXNdzdRgJGPsRh/Q/smTMbKuxO5b
 m+9MKjIhN2OCFBeb0CCwv4hIPhQDIpa56DOnBqgE/Dsf4JkuYsbtcUd1xnuquwVBWp3pWbE
 wmI+invZStS+QoGJh2zOMtgYqaafS10tA5rmSBkL42MaZEVsWNQ5mFeNwbgUZ+OK5X6hZji
 X/gL4yAQVhs4EJ7EBmasA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:og2mAToSSgk=:KHcxmul/2+PEwZ7qd/g53Z
 wFuZ3Q82LjTM8RWuWYqFcaIbC+eo99mqhrS9LkWgctft0WTvbJ4CtOiWAys/0Db85zc33JtiY
 lYZV/sk1zRu+VoeFTWwZB/5GEpOg76XQDU401aPAyKrciU073/wJ+1OpEY3KaJ3NXlkxime7p
 oSdJCk3/iBQDv1KwEA7XgvTfh+/KMkVTUN/EqJf2gOxbwItFuxRqTamEBnGUy51RX9XMNbmEj
 aGZvL6cWyyWxUBXM+NTs211yfcYWn+0lP1ZfaS0bEtBM5DRtpm0aMCt3O4c/wgetHQ5EOHnd2
 yb6GnoNSUgBsb8HT4cZmfOcBIYv7dz55ja+oBVwViVu60cefvSMmRkUpNXFGX8TikBk3ztsqy
 O7ucK3GG9nap8OJJ8HbcrP3GHUSuCV6lkyleQ8trHeMgY18u5txFOg39TBTsC6KWVPX5Nl4m5
 z/1O8k93esjAm9loPwMSiUkUDuzIIoM+Ar2cJX9apyF4GlEJ+xJWrY3eskO4VfteZU6er+07I
 iEM7Zwhmz1/69UCyl87EYcDe9r/WyRpgM0FTawhRNulkDndS/EQUmBQhe7evqRVrfMBC+asZp
 vTeG8/TRWM6E4xXb7uWxILLR6tvuiyncVHMD4TN/9KUumKavPfUSgUNmRJpNOdFh9gZuwYDv6
 YsVZ+/u6JJ5qPWnKx03zCgqHuHlm04y8unia7zWheXwkLKgvKnFwB3IRujCFk6BXfSBnY9t7a
 AEnUa62kZHi49AeAUE3fjGTckm06HIxk1+GEu56rvRTe77O/lVHro99KXiPSEwwY+2qq3WafC
 6bMyFWNA2oN+jFr48y8ND79lmwtIA9oGAeSSyWYYIo/VrpwKVU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new 'address' variable is only used in some configurations:

arch/x86/kernel/traps.c:332:16: error: unused variable 'address' [-Werror,-Wunused-variable]
        unsigned long address = read_cr2();

Change the #ifdef guard to cover this case as well.

Fixes: 095b7a3e7745 ("x86/entry: Convert double fault exception to IDTENTRY_DF")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 35298c1df32f..c9d0d466641a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -328,7 +328,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	static const char str[] = "double fault";
 	struct task_struct *tsk = current;
 
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && defined(CONFIG_VMAP_STACK)
 	unsigned long address = read_cr2();
 #endif
 
-- 
2.26.2

