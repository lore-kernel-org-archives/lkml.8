Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DD6C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5AC2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jXdfAA7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgDTJBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgDTJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:01:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E0DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WiWlW6CaV7PzmUJwrlRzwJYvEWO/rzOBqNvC+0/iQPs=; b=jXdfAA7HEWcbvX8TND9eSwULus
        5e/WRIWHIrvA8hpW3/U+6DWxcZtE7HqRTA9B8p6VaQj0JJ/nu8/bRZoCiVx93CQfGFWBFieCWbYl0
        6oedqMJfcxTylLRZI8lZUFQj+jkjMCN7FNI22Io5o0p1bonU350CyHQqGkzUvmwloSlyWzABp4DTX
        yGs9dGCGulkCV6DyiciQMB+W6R/tSJ6Imiu9fVdRnnMqZ0/StzlGAlFcvW653eCES2ulSJH0Y4pwO
        MnxDLMmRA4QrO/+Pl+Lq+WV6Zq9eqZKrKK+K4hih483mipmXcAY9rkl2uH8ZWzZ4hiDQmjxfmg2Hd
        cUGpZI5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQSIZ-0001Za-0T; Mon, 20 Apr 2020 09:01:03 +0000
Date:   Mon, 20 Apr 2020 02:01:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [patch 02/15] x86/cpu: Uninline CR4 accessors
Message-ID: <20200420090102.GB24518@infradead.org>
References: <20200419203137.214111265@linutronix.de>
 <20200419203335.856333226@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419203335.856333226@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -387,7 +387,30 @@ void native_write_cr4(unsigned long val)
>  			  bits_missing);
>  	}
>  }
> -EXPORT_SYMBOL(native_write_cr4);
> +#if IS_MODULE(CONFIG_LKDTM)
> +EXPORT_SYMBOL_GPL(native_write_cr4);
> +#endif

While this is better than what we had before we really need to have
a discussion on lkdtm - it needs a lot of crap that otherwise wouldn't
be exported, and I'm really worried about people enabling it and thus
adding exports even if they are conditional.  Can we force the code
to be built in require a boot option for it to be activated?
