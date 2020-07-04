Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13720C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF6D208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="Y8nQNkZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgGDUqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:46:46 -0400
Received: from smtp90.iad3b.emailsrvr.com ([146.20.161.90]:54027 "EHLO
        smtp90.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726922AbgGDUqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1593895105;
        bh=5ney8wcxoUhFdBKeDod8XwHkj/JVxEXiRTZE1kuy1qg=;
        h=From:To:Subject:Date:From;
        b=Y8nQNkZf158j1IGCkq1nUI4RkRqBZ0+rcD5dwm071St6+qtXiCWUwXIgbHd8hXn//
         fOHF1cuCnbJdQReUcnTqCJewXe9z7wrB/eh2UwxOSSWdg4QGTBGozTxYeTM5Z88wTO
         OaHKVPYDsWih0akvxT0DkiA5Y3e4WnGXG799z18U=
X-Auth-ID: dpreed@deepplum.com
Received: by smtp20.relay.iad3b.emailsrvr.com (Authenticated sender: dpreed-AT-deepplum.com) with ESMTPSA id 93375A00CD;
        Sat,  4 Jul 2020 16:38:24 -0400 (EDT)
From:   "David P. Reed" <dpreed@deepplum.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "David P. Reed" <dpreed@deepplum.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] Fix undefined operation VMXOFF during reboot and crash
Date:   Sat,  4 Jul 2020 16:38:06 -0400
Message-Id: <20200704203809.76391-1-dpreed@deepplum.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629214956.GA12962@linux.intel.com>
References: <20200629214956.GA12962@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 64370b40-6b65-46c7-a817-521193c95a46-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the request of Sean Christopherson, the original patch was split
into three patches, each fixing a distinct issue related to the original
bug, of a hang due to VMXOFF causing an undefined operation fault
when the kernel reboots with CR4.VMXE set. The combination of
the patches is the complete fix to the reported bug, and a lurking
error in asm side effects.

David P. Reed (3):
  Correct asm VMXOFF side effects
  Fix undefined operation fault that can hang a cpu on crash or panic
  Force all cpus to exit VMX root operation on crash/panic reliably

 arch/x86/include/asm/virtext.h | 24 ++++++++++++++++--------
 arch/x86/kernel/reboot.c       | 20 +++++++-------------
 2 files changed, 23 insertions(+), 21 deletions(-)

-- 
2.26.2

