Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE11C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F5520734
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgFROKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbgFROKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:10:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85690C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:10:34 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jlvF6-0003LK-7Q; Thu, 18 Jun 2020 16:10:12 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8CCA9101482; Thu, 18 Jun 2020 16:10:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH V2 0/4] x86/entry: simply stack switching when exception on userspace
In-Reply-To: <CAJhGHyC+LswHw+=Ymo92CX-ffFB=PJRP0bSLOWEN42KLPfvJ6w@mail.gmail.com>
References: <87mu5roov6.fsf@nanos.tec.linutronix.de> <20200529082618.1697-1-laijs@linux.alibaba.com> <CALCETrXKdh=nBWz96pow5roLmh0ez2YeQ9P+H5gxdor5TfrqUQ@mail.gmail.com> <CAJhGHyBSzhm7h5dROAKSzdSD3czmUNG+80rS9tpaau_U23p4Ug@mail.gmail.com> <CAJhGHyC+LswHw+=Ymo92CX-ffFB=PJRP0bSLOWEN42KLPfvJ6w@mail.gmail.com>
Date:   Thu, 18 Jun 2020 16:10:11 +0200
Message-ID: <877dw4cvng.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lai,

Lai Jiangshan <jiangshanlai+lkml@gmail.com> writes:

> Hello and Ping

you have poked on that on Tuesday, i.e. 2 days ago. It's on the todo
list, but not the must urgent problem on the planet.

Thanks

        tglx
