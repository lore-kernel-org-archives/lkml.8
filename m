Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663D8C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A84320838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgBZTyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:54:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59378 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgBZTyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:54:09 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j72kp-0005SP-0D; Wed, 26 Feb 2020 20:53:59 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5BF4F104099; Wed, 26 Feb 2020 20:53:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 7/8] x86/entry: Move irq tracing to prepare_exit_to_user_mode()
In-Reply-To: <db063edd-f1de-bbb4-3c8b-465904308aad@kernel.org>
References: <20200225220801.571835584@linutronix.de> <20200225221305.919875257@linutronix.de> <db063edd-f1de-bbb4-3c8b-465904308aad@kernel.org>
Date:   Wed, 26 Feb 2020 20:53:58 +0100
Message-ID: <87pne1azvt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On 2/25/20 2:08 PM, Thomas Gleixner wrote:
>> which again gets it out of the ASM code.
>
> Why is this better than just sticking the tracing in
> __prepare_exit_from_usermode() or just not splitting it in the first
> place?

The split is there because prepare_exit_from_usermode() is used from the
idtentry maze as well. Once that stuff is converted in the later series
the split goes away again.

Thanks,

        tglx
