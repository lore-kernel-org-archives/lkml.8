Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81FDC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 12:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EFC2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 12:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581856463;
	bh=CK9AGexnenOmXyQKve9YVghVQRdcBjvKQyQ8y5gDoSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=K6hEZUq8jpEvquAKariHOr9muAjVhQdYtZ1RbSxaH3AM/RGxYKRbMJdVUjmUa2fOx
	 Gw+ucv7QDgX5NckRzU8A3A/EUQ4ONc5vJ9repfbDxlvCdOsg8T6LdvOPIGG9YuMPG5
	 WdjRu+4i1hERWLCoJsRFX9FF7wdaUiDC4NDf5mA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgBPMeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 07:34:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBPMeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 07:34:16 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E02E5206D7;
        Sun, 16 Feb 2020 12:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581856456;
        bh=CK9AGexnenOmXyQKve9YVghVQRdcBjvKQyQ8y5gDoSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lHvJhsvIL0eGKudTZzeOYp4p2dz5PjS6mB71vznX2KqIJass3jnGJFwrzZf5GxR7i
         M7hqLXVApLt9JLwbOJk6kWnneMXdQQb1gJmhn1M0xPa4+pdAxme8i2G5/73pnWmZhK
         UFmja6IjRgj9NmU+KzXu6B6cKE8Zd+4FxwXwBjW4=
Date:   Sun, 16 Feb 2020 21:34:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        stable@kernel.vger.org,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] powerpc/kprobes: Fix trap address when trap happened in
 real mode
Message-Id: <20200216213411.824295a321d8fa979dedbbbe@kernel.org>
In-Reply-To: <e09d3c42-542e-48c1-2f1e-cfe605b05bec@c-s.fr>
References: <b1451438f7148ad0e03306a1f1409f4ad1d6ec7c.1581684263.git.christophe.leroy@c-s.fr>
        <20200214225434.464ec467ad9094961abb8ddc@kernel.org>
        <e09d3c42-542e-48c1-2f1e-cfe605b05bec@c-s.fr>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2020 11:28:49 +0100
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Hi,
> 
> Le 14/02/2020 à 14:54, Masami Hiramatsu a écrit :
> > Hi,
> > 
> > On Fri, 14 Feb 2020 12:47:49 +0000 (UTC)
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> > 
> >> When a program check exception happens while MMU translation is
> >> disabled, following Oops happens in kprobe_handler() in the following
> >> test:
> >>
> >> 		} else if (*addr != BREAKPOINT_INSTRUCTION) {
> > 
> > Thanks for the report and patch. I'm not so sure about powerpc implementation
> > but at where the MMU translation is disabled, can the handler work correctly?
> > (And where did you put the probe on?)
> > 
> > Your fix may fix this Oops, but if the handler needs special care, it is an
> > option to blacklist such place (if possible).
> 
> I guess that's another story. Here we are not talking about a place 
> where kprobe has been illegitimately activated, but a place where there 
> is a valid trap, which generated a valid 'program check exception'. And 
> kprobe was off at that time.

Ah, I got it. It is not a kprobe breakpoint, but to check that correctly,
it has to know the address where the breakpoint happens. OK.

> 
> As any 'program check exception' due to a trap (ie a BUG_ON, a WARN_ON, 
> a debugger breakpoint, a perf breakpoint, etc...) calls 
> kprobe_handler(), kprobe_handler() must be prepared to handle the case 
> where the MMU translation is disabled, even if probes are not supposed 
> to be set for functions running with MMU translation disabled.

Can't we check the MMU is disabled there (as same as checking the exception
happened in user space or not)?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
