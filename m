Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08B3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7CB206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dn6j24tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437257AbgE1WiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436945AbgE1WiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:38:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D3EC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5JtCJN4R91Qw51mlPzBtDAjT1k3jMKVe+nsnhQ4R1w8=; b=Dn6j24tf1xQfTci0TdCtf/EDX6
        eWvDSpUR07JtIu6SP/hvQrZkwqMYBCRTsuY8qiWAI/Bd5n++TUb1tqkKftYBDYAkkJuYT1bO51ONf
        aAcIF9nXCrdw8MebTQLNtSy0N26TyK7wqB8XNeUPpsGyOnc7h4EcFm8dvMW/BsazeKPVwKi95JjhQ
        avCEh2vKL0u2pw4LTbAtPUl2Pdnf884bipcMiEI4lbkjKDpSIjSY9TAwzhuTDO/Q7BBQAvyolr1Ns
        iPAHAscUXgGRwEr5IjghVn4JGIOrpdCFzfZdk9lj7OTMg9vS/upHxwS9x+Qi9+irdEk34Mh3ls04U
        xF4uuc6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeR9o-0006tZ-QD; Thu, 28 May 2020 22:37:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4215F9834F3; Fri, 29 May 2020 00:37:46 +0200 (CEST)
Date:   Fri, 29 May 2020 00:37:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        andrew.cooper3@citrix.com, daniel.thompson@linaro.org
Subject: Re: [RFC][PATCH 6/6] x86/entry: Remove DBn stacks
Message-ID: <20200528223746.GT2483@worktop.programming.kicks-ass.net>
References: <20200528201937.038455891@infradead.org>
 <20200528202328.708732152@infradead.org>
 <CAJhGHyBsFgDRGS+kihijgH2MbnULkkUS2xfDJsNF09F782EM5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyBsFgDRGS+kihijgH2MbnULkkUS2xfDJsNF09F782EM5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:35:07AM +0800, Lai Jiangshan wrote:
> There will be a compile error about N_EXCEPTION_STACKS
> in arch/x86/kernel/dumpstack_64.c. It should have
> 
> - BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
> + BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);

Yeah, I actually have that, but forgot to refresh before sending :/
