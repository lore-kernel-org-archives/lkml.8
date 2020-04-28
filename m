Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FCEC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161E820731
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgD1Vg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:36:57 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34859 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgD1Vg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:36:56 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1McY0L-1itOfZ46RB-00d2eD; Tue, 28 Apr 2020 23:36:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Jones <dsj@fb.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/unwind/orc: fix unused function warnings
Date:   Tue, 28 Apr 2020 23:36:09 +0200
Message-Id: <20200428213618.3587684-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iaNq6q+5ghuiuu58m8LDk4FJ+tg9i4IQrI1GyGElrpxuId1+22D
 VIJiaE0zxaYhdSTSSgu49Ibry/VJtOUnMokgybPHRnmeb4iQg5lq+4qLD/vmYTyMG652DBt
 28850mZsR3dd5y+U+XK1EzFAtbaERUrGATv9Z0zrbwrRzfU3+SDZ/VZ80OkTLiBh0AxJcn3
 2XS8/InY1dUCo8N2tlrxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R+m5ze29tqA=:QpckBXBwcVg6O2gB5XStoB
 S9blV3NsPizSTRkCf5W+GX+x9x0x/1v3//L7vSYIs1YmyNIHrqprfPIunPHC4vywjPlRGKHbj
 qlh0lzf7YV0hkzi/XRFAwcvQj0JGK9XXOgiCg2KrMhpgXEbXuFZFzwHaKM/x8j4aJn+uuoNW8
 XOm3HH9dqTc3ffosO2QO079AimD8a3epjFxdj5H5rzlva15pkgrkKv6UaoT2gozSuCgUPJ7Ld
 puXDIsXzcBGZWmB3GNO4proSD8HI1NG3Q7gFEBm5HQKQ1zJ1XSgnr5v69Zm9FRsX+iHW/AtGM
 Oes1f+uuvfgh5ZGl0g1KNCujKpLQfCt2JxpF6uRujHbyp9dFm6JnIYceVg3dl6JxsOOH3NucZ
 EGWWaejChg4hT27AlFQZzYrqtepOIvpe5DmBZSvY5Gz5hwD3SsOJdGdFcL2K5lb92IoKa/CTS
 zq6GX1CJ7KQdp/TtYLGkGM2s3Js8HEi3noyxaZbnVZPXAu4hRZSvs5tfz7yXyQsvj8oJ3Y9W1
 MQqEKJgEOFLrrDp5A9kW7NwK+c678TOW0p7fK9MGovBCnR3xFR8ELNEe12RON7B8rgUb5AiEc
 mDPrbihkJcw1SxC3cJnP/tIxkYN89y/x2AD2WF9ZDp4t4CNSu22tLuteva3GnuLdM5mubiEwj
 wKWpuA+Dbi7IMIyIAvNfLw8mJbSOhkuaBOPMsZwstdfDAaghglLyMv6iqgVhhVNBW5sM0SD4n
 npgA4vJzNjH6yy4Znvkuo/NoLm/+bs1q88ZDv/lEKlgD9ovLWu3nDkGYrHS3LxDov79ACGp7/
 YbWokPONatvrA/NsD/3kWwXxXXdI4ht2ZD53DiOqeVdahYgCpg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_MODULES, these two variables are unused:

arch/x86/kernel/unwind_orc.c:29:26: error: 'cur_orc_table' defined but not used [-Werror=unused-variable]
   29 | static struct orc_entry *cur_orc_table = __start_orc_unwind;
      |                          ^~~~~~~~~~~~~
arch/x86/kernel/unwind_orc.c:28:13: error: 'cur_orc_ip_table' defined but not used [-Werror=unused-variable]
   28 | static int *cur_orc_ip_table = __start_orc_unwind_ip;
      |             ^~~~~~~~~~~~~~~~

Move them into the #ifdef section.

Fixes: 153eb2223c79 ("x86/unwind/orc: Convert global variables to static")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/unwind_orc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 0ebc11a8bb45..ea8f2aba663f 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -25,8 +25,6 @@ static bool orc_init __ro_after_init;
 static unsigned int lookup_num_blocks __ro_after_init;
 
 static DEFINE_MUTEX(sort_mutex);
-static int *cur_orc_ip_table = __start_orc_unwind_ip;
-static struct orc_entry *cur_orc_table = __start_orc_unwind;
 
 static inline unsigned long orc_ip(const int *ip)
 {
@@ -191,6 +189,8 @@ static struct orc_entry *orc_find(unsigned long ip)
 }
 
 #ifdef CONFIG_MODULES
+static int *cur_orc_ip_table = __start_orc_unwind_ip;
+static struct orc_entry *cur_orc_table = __start_orc_unwind;
 
 static void orc_sort_swap(void *_a, void *_b, int size)
 {
-- 
2.26.0

