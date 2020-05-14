Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB85EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48CC2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgENKpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:45:50 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40025 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgENKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:45:50 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49N7Vb5M23z1rtMh;
        Thu, 14 May 2020 12:45:43 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49N7Vb2L9jz1shf3;
        Thu, 14 May 2020 12:45:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 9fyzBC6ghdJH; Thu, 14 May 2020 12:45:42 +0200 (CEST)
X-Auth-Info: pVwDJJtpUfoBr64P3JEQiSPJmEfJwtHfz/pV6AvkiZkIHmkeB4dn0AXJn6kIlp8+
Received: from igel.home (ppp-46-244-180-168.dynamic.mnet-online.de [46.244.180.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 14 May 2020 12:45:42 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id B4FD12C1E36; Thu, 14 May 2020 12:45:41 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Luck, Tony" <tony.luck@intel.com>,
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
Subject: Re: [PATCH] ia64: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
References: <3908561D78D1C84285E8C5FCA982C28F7F6266E0@ORSMSX115.amr.corp.intel.com>
        <79e58d9b-5a39-390c-2f0c-0d87b63442b4@physik.fu-berlin.de>
        <20200514074606.vkc35syhdep23rzh@wittgenstein>
        <6b298416-1e64-eee7-0bb4-3b1f7f67adc6@physik.fu-berlin.de>
        <d6c94d4f-a431-9de5-7a0f-661894dbec01@physik.fu-berlin.de>
        <20200514100459.pt7dxq2faghdds2c@wittgenstein>
        <2e22b0d2-b9ce-420d-48a0-0d9134108a5c@physik.fu-berlin.de>
        <20200514101540.25hvle74w63t66fs@wittgenstein>
        <20200514101914.fu7xhgaxtb5fy2ky@wittgenstein>
        <4aad9ad5-b0e9-12b0-0ad2-ac23fceae87b@physik.fu-berlin.de>
        <20200514103259.tdfjc5ds4igpmoxj@wittgenstein>
X-Yow:  NOW, I'm taking the NEXT FLIGHT to ACAPULCO so I can write POEMS about
 BROKEN GUITAR STRINGS and sensuous PRE-TEENS!!
Date:   Thu, 14 May 2020 12:45:41 +0200
In-Reply-To: <20200514103259.tdfjc5ds4igpmoxj@wittgenstein> (Christian
        Brauner's message of "Thu, 14 May 2020 12:32:59 +0200")
Message-ID: <877dxe6bhm.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 14 2020, Christian Brauner wrote:

>         pid = syscall(189 /* __NR_clone2 */, SIGCHLD, stack, STACK_SIZE, NULL, NULL);

Syscall 189 doesn't exist on ia64, they start with 1024 (and __NR_clone2
is 1213).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
