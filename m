Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AE4C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A402076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BG+c11hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCRONZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:13:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCRONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a6rXRXuEvmp73wHvl4f4azfPwXDCiqL2RZ8HLe1AGQY=; b=BG+c11hqEncKrl0ZEOd+f82Jiy
        zjdiNA9XxJ+B7yE8Dyi6VjhQ4qYF+P4pA6LW7Ii8i+xJbAPVT+arfXdsHWC2An5MxI2NOV/Lb62oL
        3RyyObTOKPr+2ZKujsczvdYYnpxcLhGUVNSdy3jEau38aXFL0NfRnX1ga/H4AEVKKlzEi/eqXapdV
        yD9QF3kf8F6O0d3jVlD/ZNzPSnPWL/ofBFU9PYHxVT9G2nKzFoOsaxQUhl1pN9qB8bVKrDgLSTwPe
        v+g02BkGvaxbHYHKFFu2S65ovwTniCkQFQVesFmgbIpH0Yie38VtoRfcR2RfcS94HX1dyDQlXkJS1
        0ENl0OHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEZRf-0005ED-TP; Wed, 18 Mar 2020 14:13:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DEC23010C1;
        Wed, 18 Mar 2020 15:13:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F2562015FD4D; Wed, 18 Mar 2020 15:13:18 +0100 (CET)
Date:   Wed, 18 Mar 2020 15:13:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [RFC][PATCH v2 20/19] kbuild/objtool: Add objtool-vmlinux.o pass
Message-ID: <20200318141318.GA20760@hirez.programming.kicks-ass.net>
References: <20200317170234.897520633@infradead.org>
 <20200318131845.GG20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318131845.GG20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 02:18:45PM +0100, Peter Zijlstra wrote:
> 
> This seems to 'work', must be perfect etc..

Uhu.. the moment I ran it on a kernel which has .noinstr.text

> +objtool_link()
> +{
> +	local objtoolopt;
> +
> +	if [ -n "${CONFIG_VMLINUX_VALIDATION}" ]; then
> +		objtoolopt="check"
> +		if [ -n "${CONFIG_FRAME_POINTER}" ]; then

I found that that ought to be -z :-)

> +			objtoolopt="${objtoolopt} --no-fp"
> +		fi
