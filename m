Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0EAC35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C65208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgEGVfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:35:11 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGVfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:35:11 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M2fDl-1jYidz2tHb-004D2T; Thu, 07 May 2020 23:34:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Steve Whitehouse <swhiteho@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Richard Fontana <rfontana@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dlm: remove BUG() before panic()
Date:   Thu,  7 May 2020 23:34:28 +0200
Message-Id: <20200507213438.1886005-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MWsD4C2gbHQCzPSYpVZ0sRh+EhEaHN4oMDZVkk1sis4OPLEClxS
 9xPRJqaQrjFl8IZ2Wv+Imy6LKHFafuWPi7xy8fl6ubV2+zFiAgJ6IxDiVxaK4716fxwdvqh
 M5rEYTS93N64nWAN6gDJVXmzdZYNsNmMvQlR/FTzVXrvI8h/2iIzH/7IgDXLXgUGItn6TXu
 GD9+FlIaYKZw9eXdw7bPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zlN+6/l7oGM=:Dtq4zd5iUWJg9Z78qsfioZ
 8RK3MHA0rTEYRPIyN7utMpOZAgFAhbZRr2wZmJ6rZD7wYBQeVP6lJjJYNP0Y4pA8ziyluG+OA
 0emP49TXl7VaRidDwOBf3AIz1rvtgUEUmlqDcx7VPKsC49CK2ZxZq9BQYMIN9lKnSIPCe72y6
 LamOjF/74tCb2buLKP/rHpDHeatvFoo9xLhujqR7Nf2OyzkMsOdKLv/UfsDOTQGPuJJdVL+Bb
 punQYzmOEevxUCFpxvXnGSnKpqP6L8Z4S5riXlgoNOPgH/EegygOfE2jwHXlT7K2Noa+evqJ/
 TQn71PQJM5umwRSI+Df7ztizmEMrmNpbfSAQEjIxhNq42CeSWmWA1VI9uXMnguoveazaJ4aYT
 qFonyxDdXAdZkeYS3j3WLQZbUjNf9Pr71lF4fRkTLUvBM/qisoljjIa5TCb6hYEp1zjy/93rZ
 feBlVofAdNBshcUd3Z5/DLhZ0xJ8T3Pn+e2LBbv9xvv0aNTOx/7OVp/SFkosOQw12GOvCaN59
 8Lo6dSS+pK2H61RZulEtmOm6AItFAZKtPWi0OowNBIm13PffuCKmNhiD0aZt9Urdz7oPmRmAy
 t2PubAtayKfOzzrQjMLDVkZ9PzcMX1CohkcyKWJYuZ81BL3ajX5rnaIjlXyOuYo0IU7MERGhl
 dE+XXVaHj2cVQCMdASZIfIrWy7xM49XBBn4igMM96xL8ai9SJ0Rn1yS055OHKCBzc2AiP8nsG
 krVjtRPYFE/MBMvZeMC+tBjymko3ZImGZv/Rrn8kGdIuJUFFzEe8UpdekyHRZpbgZURXtsNKm
 fkZkKttRwrfOHBxEfx593W9WShzlz+bMYciYGVzrKlPqxjMlI8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building a kernel with clang sometimes fails with an objtool error in dlm:

fs/dlm/lock.o: warning: objtool: revert_lock_pc()+0xbd: can't find jump dest instruction at .text+0xd7fc

The problem is that BUG() never returns and the compiler knows
that anything after it is unreachable, however the panic still
emits some code that does not get fully eliminated.

Having both BUG() and panic() is really pointless as the BUG()
kills the current process and the subsequent panic() never hits.
In most cases, we probably don't really want either and should
replace the DLM_ASSERT() statements with WARN_ON(), as has
been done for some of them.

Remove the BUG() here so the user at least sees the panic message
and we can reliably build randconfig kernels.

Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/dlm/dlm_internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 416d9de35679..4311d01b02a8 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -97,7 +97,6 @@ do { \
                __LINE__, __FILE__, #x, jiffies); \
     {do} \
     printk("\n"); \
-    BUG(); \
     panic("DLM:  Record message above and reboot.\n"); \
   } \
 }
-- 
2.26.0

