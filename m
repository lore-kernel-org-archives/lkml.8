Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D195FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A695B20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I+G+8vAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgCZS2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:28:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39986 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgCZS2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mchJhWy78UOAMgl1C3IsTG+i6Njh78XReHFvvDrBBYI=; b=I+G+8vAiultIOC5GApAmNq0dsd
        S5djnLy/8+F9ob6Bo9Glu4BwoJne3D7OMuWPqXCm2tWWygSn3ojNOtwfkMqB7P09tvRdibdAe8XGE
        Ug1xN0wYsEyIMSFRuWnwBgIG0nOKLAW/OuLhpW3RFNacrqWXX2XYjNtqklIze9ibQHCGx85zYmChT
        his8KsXMsge+Xk4mRYbkcPizS4oDFX9xYLdG/uIMY2glCLYJOqad2NmEWuibrbDiCc7aKiHov8dAh
        +rz6xMapLhRZAXl7zsVufGDBeurhLf0J6RxJzmOrO3gAfV3QghpRdsqA5On9k+Q1121sIDyq7QdR5
        URqA+kgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHXEw-0007XV-Gb; Thu, 26 Mar 2020 18:28:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF411983531; Thu, 26 Mar 2020 19:28:23 +0100 (CET)
Date:   Thu, 26 Mar 2020 19:28:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        tglx <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
Subject: Re: [RESEND][PATCH v3 06/17] static_call: Add basic static call
 infrastructure
Message-ID: <20200326182823.GB2452@worktop.programming.kicks-ass.net>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.632535759@infradead.org>
 <12A30BA0-18DA-4748-B82F-6008179CC88C@vmware.com>
 <20200326170128.GQ20713@hirez.programming.kicks-ass.net>
 <9D47A4CA-39AD-4408-879B-677BE9D891B7@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9D47A4CA-39AD-4408-879B-677BE9D891B7@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 06:09:07PM +0000, Nadav Amit wrote:

> I think that the kernel underutilizes the pure attribute in general.
> Building it with "-Wsuggest-attribute=pure” results in many warnings.
> Function pointers such kvm_x86_ops.get_XXX() could have been candidates to
> use the “pure” attribute.
> 
> The syntax is what you would expect:
> 
>   static void __attribute__((pure))(*ptr)(void);
> 

Well, I didn't in fact expect that, because an attribute is not a
type qualifier.

> However, you have a point, gcc does not appear to respect “pure” for
> function pointers and emits a warning it is ignored. GCC apparently only
> respects “const”. In contrast clang appears to respect the pure attribute
> for function pointers.

Still, we can probably make it happen for static_call(), since it is a
direct call to the trampoline, all we need to do is make sure the
trampoline is declared pure.

It does however mean that static_call() inherits all the dangers and
pit-falls of function pointers with some extra on top. It will be
impossible to validate this stuff.

That is, you can static_call_update() with a pointer to a !pure function
and you get to keep the pieces.
