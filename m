Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C205C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20083206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgENJsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:48:38 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51857 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbgENJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:48:37 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1jZATg-002tCk-Gy; Thu, 14 May 2020 11:48:32 +0200
Received: from p5b13a426.dip0.t-ipconnect.de ([91.19.164.38] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.93)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1jZATg-002JTl-9i; Thu, 14 May 2020 11:48:32 +0200
Subject: Re: [PATCH] ia64: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200513204848.1208864-1-christian.brauner@ubuntu.com>
 <3908561D78D1C84285E8C5FCA982C28F7F6266E0@ORSMSX115.amr.corp.intel.com>
 <79e58d9b-5a39-390c-2f0c-0d87b63442b4@physik.fu-berlin.de>
 <20200514074606.vkc35syhdep23rzh@wittgenstein>
 <6b298416-1e64-eee7-0bb4-3b1f7f67adc6@physik.fu-berlin.de>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; keydata=
 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
 scOkTAZQGVpD/8AaLH4v1w==
Message-ID: <d6c94d4f-a431-9de5-7a0f-661894dbec01@physik.fu-berlin.de>
Date:   Thu, 14 May 2020 11:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6b298416-1e64-eee7-0bb4-3b1f7f67adc6@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.38
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/20 9:53 AM, John Paul Adrian Glaubitz wrote:
> The kernel is currently building, you should get it by the evening (CEST).
> 
> The machine also serves as a Debian buildd which is why it's a bit more
> busy than other servers.
I applied the patch against 5.7-rc5, it applied fine and builds fine.

It seems though that systemd crashes but I'm not sure it's related:

[   14.267489] init[1]: General Exception: IA-64 Reserved Register/Field fault (data access) 2199023255600 [1]                     
[   14.267489] Modules linked in:                                                                                                  
[   14.267489]                                                                                                                     
[   14.267489] CPU: 0 PID: 1 Comm: init Not tainted 5.7.0-rc5 #1                                                                   
[   14.267489] Hardware name: hp server BL860c                   , BIOS 04.25                                                            07/02/2010                                                                                                                   
[   14.267489] psr : 0000121008526030 ifs : 8000000000000510 ip  : [<a00000010000c541>]    Not tainted (5.7.0-rc5)                 
[   14.267489] ip is at sys_clone2+0x61/0x80                                                                                       
[   14.267489] unat: 0000000000000000 pfs : 0000000000000510 rsc : 0000000000000003                                                
[   14.267489] rnat: 0000000000000000 bsps: 0000000000000000 pr  : 000000000001a959                                                
[   14.267489] ldrs: 0000000000000000 ccv : 0000000000000002 fpsr: 0009804c8a70033f                                                
[   14.267489] csd : 0000000000000000 ssd : 0000000000000000                                                                       
[   14.267489] b0  : a00000010000c540 b6  : a0000001000edf80 b7  : a000000100369560                                                
[   14.267489] f6  : 1003e000000000000b8a4 f7  : 1003e00000001754e8d69                                                             
[   14.267489] f8  : 1003e0000000178311d69 f9  : 100098000000000000000
[   14.267489] f10 : 1000eb8a3fffff475c000 f11 : 1003e000000000000b8a4
[   14.267489] r1  : a0000001017a6f10 r2  : 0000000000000000 r3  : 0000000000000006
[   14.267489] r8  : 0000000000000066 r9  : 0000000000000060 r10 : e0000100800d8e68
[   14.267489] r11 : 0000000000000002 r12 : e00001008027fe30 r13 : e000010080278000
[   14.267489] r14 : e0000100800d8e04 r15 : e0000100800d8e08 r16 : 0000000000000002
[   14.267489] r17 : 0000000000000001 r18 : 0000000000000002 r19 : 0000000000000003
[   14.267489] r20 : 0000000000000004 r21 : e00001008027fb98 r22 : e000000001146d02
[   14.267489] r23 : 00000000000030c8 r24 : 00000000000030c8 r25 : 00000000000030ca
[   14.267489] r26 : 00000000000030ca r27 : 00000000000030ca r28 : e00001008027fb90
[   14.267489] r29 : 0000000000000400 r30 : 00000000000002e8 r31 : 0000000000000400
[   14.267489] 
[   14.267489] Call Trace:
[   14.267489]  [<a000000100015090>] show_stack+0x90/0xc0
[   14.267489]                                 sp=e00001008027f9f0 bsp=e000010080279288
[   14.267489]  [<a000000100015780>] show_regs+0x6c0/0xa20
[   14.267489]                                 sp=e00001008027fbc0 bsp=e000010080279218
[   14.267489]  [<a000000100029590>] die+0x1b0/0x4a0
[   14.267489]                                 sp=e00001008027fbe0 bsp=e0000100802791d0
[   14.267489]  [<a00000010100e690>] ia64_fault+0x770/0xd80
[   14.267489]                                 sp=e00001008027fbe0 bsp=e000010080279180
[   14.267489]  [<a00000010000ce60>] ia64_leave_kernel+0x0/0x270
[   14.267489]                                 sp=e00001008027fc60 bsp=e000010080279180
[   14.267489]  [<a00000010000c540>] sys_clone2+0x60/0x80
[   14.267489]                                 sp=e00001008027fe30 bsp=e000010080279100
[   14.267489] Disabling lock debugging due to kernel taint
[   14.267489] init[102]: General Exception: IA-64 Reserved Register/Field fault (data access) 4398046511152 [2]
[   14.350730] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
    [1 4 . 31540.733500]7 3-0-]- [- -e-n[d  eKnedr nKeelr npealn pani[c   -  1n4o.t2 6s7y4n8c9i]n g:
:Attem [D      1 4 . 2 6 7 4 8 95]. 7C.P0U-:r c15  P#I1D
i e1=002x 0C0o0m0m0:0 0ibn i]t- -T-a
 nted: G      D           5.7.0-rc5 #1

I have to perform more testing. The machine boots fine with a 5.5.x kernel.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
