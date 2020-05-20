Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E475C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D470B20756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="e2K+Bb6J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="De1I4CrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgETAot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:44:49 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33821 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgETAos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:44:48 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 65FD83A3;
        Tue, 19 May 2020 20:44:47 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Tue, 19 May 2020 20:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=7JDNF
        nvw/MKQRxgiZIZhKdf/m6vfiT2RDShepmoc0+E=; b=e2K+Bb6JoaXZ44iWH/Zda
        koaFIu7QNM0zQrULlqLWeRbD8qrBlAPnZUbE39suS5tPuL9e3gL0TcRHeLAVqgiz
        zuh9MiUb2dhHCnm65EWfkb27Pky8M4OY67P58946TTQylxPgLlDsv92pDNecmdie
        mJ+PpKU+lLSUcqs/ldeK3WJSxay8ENI+PuxmkB5DY8v1kDm8kYrGxlx+JslclDBZ
        jEVSGXJkPL9KLNhlvC1MHf62NJ4Jf5voBwR8zYuJOwi+SHTHkYsIOOkjwD6OaLE1
        EwPqrR8Z+RS2LyuAeaniyp/avSYij1OJDz7CE4H6vGBhc4Y4IigciRcXRUK1VYbH
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=7JDNFnvw/MKQRxgiZIZhKdf/m6vfiT2RDShepmoc0
        +E=; b=De1I4CrAnX/+QuzNoMsr0XWMSCEwUMzoNdf19T1nHoBuYWIccH3t3zSqO
        S/cSlT4R4zR1pfk67xMmmyQrO02vKZigtCj0oZ6vtsIJpqRqqzKnoJagrv15ePcm
        3mbjAX2WzRo2UY9r5YokVd+fsxgQJ4u3cm6xAnt/ODe16JtP4zPv0WyQfTu3yCdY
        /8E/BVA2YLo2Hv2pvbwZtOF/0Ah334OQCH8CYCC+pbSJHzhAGHGoFU0TIEXUw/4n
        XzEm5k0iJYbfARNxLCFyf4yMyOMrCa8TzeJW+MsBDmpOCQyVy9Eg45X7unfyxpRf
        hiK/POZuodpFqwnRtrIOoR4NIH2lQ==
X-ME-Sender: <xms:e33EXgja6gDCTOmYkynLq3AJop1WzrQV7Vmu2ngAahCTQQ20OUDwaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtkedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtgfesth
    hqredtreerjeenucfhrhhomhepfdetnhgurhgvficulfgvfhhfvghrhidfuceorghnughr
    vgifsegrjhdrihgurdgruheqnecuggftrfgrthhtvghrnhepvdegkeehgeefvdfhteehhf
    duteetgeeugefgieeigeeuheekudegtdekgfelgfehnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:e33EXpAhOJsHGMoEqdeWe-SJ6dKibie68CJGTCOur5-mSfpgsjDtoQ>
    <xmx:e33EXoECLk1sDKzPvg8LHXVXkIR3Lz05RqB1c-pDH2jox87bzN2Wzw>
    <xmx:e33EXhRjpqQY0awCucs72fiI9HvVqhCsxgal6FXZUa3X7zDLybMUJA>
    <xmx:f33EXraObipJwgvnbuVQ6Bxkyg5RHSejXxcUbVJ07TZMnxrTUD60dg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 439F8E00BD; Tue, 19 May 2020 20:44:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-464-g810d66a-fmstable-20200518v1
Mime-Version: 1.0
Message-Id: <a9a7f3d5-6c9b-4c2c-848e-2d61971ae37b@www.fastmail.com>
In-Reply-To: <20200519150204.GG1551@shell.armlinux.org.uk>
References: <20200519143132.603579-1-andrew@aj.id.au>
 <20200519150204.GG1551@shell.armlinux.org.uk>
Date:   Wed, 20 May 2020 10:14:23 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Russell King" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, oleg@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: Implement functions for HAVE_FUNCTION_ARG_ACCESS_API
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Wed, 20 May 2020, at 00:32, Russell King - ARM Linux admin wrote:
> On Wed, May 20, 2020 at 12:01:32AM +0930, Andrew Jeffery wrote:
> > This allows extraction of kernel function arguments via kprobes on A=
RM.
> > Based on the arm64 implementation and adapted for the 32-bit AAPCS.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > The description for HAVE_FUNCTION_ARG_ACCESS_API was pretty vague on=
 what was
> > required. I've implemented enough to enable argument extraction for =
kprobes; is
> > there anything else needed to satisfy HAVE_FUNCTION_ARG_ACCESS_API?
>=20
> What about 64-bit arguments?  How do they get handled?
>=20
> regs_get_kernel_argument() talks about 'n' being the argument number,
> and maps this directly to a register.  If a function argument
> prototype is:
>=20
> 	(something *foo, long long bar, int baz)
>=20
> The foo is in r0, bar is in r2/r3 on EABI, and baz is on the stack.
>=20
> n=3D0 will return foo.  n=3D1 will be undefined.  n=3D2 will return pa=
rt of
> bar, and n=3D3 will return the other half.  Is this what is expected?

Certainly doesn't feel right, however the broken behaviour seems to be a=

compromise accepted in the existing couple of implementations for arm64
and x86. The API prototype doesn't give us any type information, so we'r=
e
left to guess.

Here's the commentary from the others:

arch/x86/include/asm/ptrace.h:
```
/**
 * regs_get_kernel_argument() - get Nth function argument in kernel
 * @regs:       pt_regs of that context
 * @n:          function argument number (start from 0)
 *
 * regs_get_argument() returns @n th argument of the function call.
 * Note that this chooses most probably assignment, in some case
 * it can be incorrect.
 * This is expected to be called from kprobes or ftrace with regs
 * where the top of stack is the return address.
 */
static inline unsigned long regs_get_kernel_argument(struct pt_regs *reg=
s,
                                                     unsigned int n)
{
...
```

arch/arm64/include/asm/ptrace.h:
```
/**
 * regs_get_kernel_argument() - get Nth function argument in kernel
 * @regs:       pt_regs of that context
 * @n:          function argument number (start from 0)
 *
 * regs_get_argument() returns @n th argument of the function call.
 *
 * Note that this chooses the most likely register mapping. In very rare=

 * cases this may not return correct data, for example, if one of the
 * function parameters is 16 bytes or bigger. In such cases, we cannot
 * get access the parameter correctly and the register assignment of
 * subsequent parameters will be shifted.
 */
static inline unsigned long regs_get_kernel_argument(struct pt_regs *reg=
s,
                                                     unsigned int n)
{
...
```

As for handling arguments on the stack, arm64 doesn't and I cribbed from=

that:

```
static inline unsigned long regs_get_kernel_argument(struct pt_regs *reg=
s,
                                                     unsigned int n)
{
#define NR_REG_ARGUMENTS 8
        if (n < NR_REG_ARGUMENTS)
                return pt_regs_read_reg(regs, n);
        return 0;
}
```

Would you accept a v2 that adds stack argument handling but leaves the
=C2=AF\_(=E3=83=84)_/=C2=AF ABI behaviour? Or will I need to fix the API=
?

Thanks for the quick response.

Andrew
