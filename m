Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B6DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76CFE207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IRzbKPJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390078AbgEMSMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732611AbgEMSMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:12:23 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C9C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jnYTd18dSt41BdQZ/PWGHqIR6HBkzj/uEIanKzmnO+A=; b=IRzbKPJ6DXtGr5nbItdojQAhW
        5k6xDuRy1MCEEvWDnp26LePXrbz8jjqpHozkA0ME0Y4Xp2WQA6mcnY9WdmhaRG8tNYAShsi9/7qZa
        kT8XSSedzCzi44W0lk/24sP9yiCBJOgZZWaTzt8wZmqiga/zamBspmq3q5uOXGN7ymAh+0ApL/9HE
        ZjR9H7nh9zC50sq4KrOqW9iCvOWX8sp7JRCxWs2gub+E0XeBNVGQsXlFVMooRBu4+ikRE+vybVEn0
        1SObZnj6H/eNxn5Ifn6li42GX3zHsFQYXxkAyyNYOLmPV+Yi0bsBX8N4jGqpiKzmYCm2cFKsLflr2
        yr9IDrSjw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60030)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jYvra-0005SJ-3J; Wed, 13 May 2020 19:12:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jYvrW-0007zk-5b; Wed, 13 May 2020 19:12:10 +0100
Date:   Wed, 13 May 2020 19:12:10 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Fredrik Strupe <fredrik@strupe.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>
Subject: Re: [RFC PATCH] arm: Don't trap conditional UDF instructions
Message-ID: <20200513181209.GM1551@shell.armlinux.org.uk>
References: <b2042f19-9477-272c-0989-d6cab1572cca@strupe.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2042f19-9477-272c-0989-d6cab1572cca@strupe.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 05:41:58PM +0200, Fredrik Strupe wrote:
> Hi,
> 
> This is more of a question than a patch, but I hope the attached patch makes
> the issue a bit clearer.
> 
> The arm port of Linux supports hooking/trapping of undefined instructions. Some
> parts of the code use this to trap UDF instructions with certain immediates in
> order to use them for other purposes, like 'UDF #16' which is equivalent to a
> BKPT instruction in A32.
> 
> Moreover, most of the undef hooks on UDF instructions assume that UDF is
> conditional and mask out the condition prefix during matching. The attached
> patch shows the locations where this happens. However, the Arm architecture
> reference manual explicitly states that UDF is *not* conditional, making
> any instruction encoding with a condition prefix other than 0xe (always
> execute) unallocated.

The latest version of the ARM architecture reference manual may say
that, but earlier versions say different things. The latest reference
manual does not apply to earlier architectures, so if you're writing
code to cover multiple different architectures, you must have an
understanding of each of those architectures.

So, from the code:

	ARM:   xxxx 0111 1111 xxxx xxxx xxxx 1111 xxxx

From DDI0100E:

3.13.1 Undefined instruction space
       Instructions with the following opcodes are undefined
       instruction space:

       opcode[27:25] = 0b011
       opcode[4] = 1

       31 28 27 26 25 24                                     5 4 3     0
       cond  0  1  1  x  x x x x x x x x x x x x x x x x x x x 1 x x x x

So, in this version of the architecture, undefined instructions may
be conditional - and indeed that used to be the case.  The condition
code was always respected, and cond=1111 meant "never" (NV).

Hence, trapping them if the condition code is not 1110 (AL) is
entirely reasonable, legal and safe.  If an ARM CPU defines an
instruction coding that matches the above, then it won't take the
undefined instruction trap, and we'll never see it.

Now, as for UDF usage in the kernel, it may be quite correct that we
always use the AL condition code for them, but it would be very odd
for there to be an instruction implemented with a different (non-NV)
condition code that can't also have it's AL condition code encoding.
You could never execute such an instruction unconditionally.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
