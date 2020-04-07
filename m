Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3949C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883F32076E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586270147;
	bh=uUUfBlLBVmrI407h4iuq4K2XwW9Hz2vHNDOeF14Nv1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z8Btid/7FWSmeCjQkCo+AgBDmGF/+UTKwmSFhWV0++/1aCkN0ADpKoY8y+qq+XJML
	 iDeCiniVDzmMlOL9rwYUfvtEv26vuAEEVHnLg34tBWqD3BcvNGnQmyuGiexHjb/UKQ
	 8fAHiyZIxBvvyFwMaP443pQZluqrs0gHPmGe18sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgDGOfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgDGOfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:35:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F4E2072A;
        Tue,  7 Apr 2020 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586270145;
        bh=uUUfBlLBVmrI407h4iuq4K2XwW9Hz2vHNDOeF14Nv1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vw+fi1YImMQ/v+btFUxWr/B8BtnaY6U61zM5JzUTZ02m5OSJMk6fNH1TIeeHd1sSo
         JOMoMBZUi7+Ulp+tvVyGMKYlySrU6hRcJ7pbzG8mVo7hi/3CFxSB/1RHbZ9+JRczq2
         z9xcQS8o6fd8T8DRmV1i+xOPgJ3VrQ7f6W+i5iWI=
Date:   Tue, 7 Apr 2020 16:35:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, jannh@google.com, keescook@chromium.org,
        David.Laight@aculab.com, dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-ID: <20200407143543.GB876345@kroah.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.352324393@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407111007.352324393@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 01:02:39PM +0200, Peter Zijlstra wrote:
> It turns out that with Split-Lock-Detect enabled (default) any VMX
> hypervisor needs at least a little modification in order to not blindly
> inject the #AC into the guest without the guest being ready for it.
> 
> Since there is no telling which module implements a hypervisor, scan
> all out-of-tree modules' text and look for VMX instructions and refuse
> to load it when SLD is enabled (default) and the module isn't marked
> 'sld_safe'.
> 
> Hypervisors, which have been modified and are known to work correctly,
> can add:
> 
>   MODULE_INFO(sld_safe, "Y");
> 
> to explicitly tell the module loader they're good.

What's to keep any out-of-tree module from adding this same module info
"flag" and just lie about it?  Isn't that what you are trying to catch
here, or is it a case of, "if you lie, your code will break" as well?

thanks,

greg k-h
