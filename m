Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D338EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CA82074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IzCvvhpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgGIKac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgGIKab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:30:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76938C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GZFLWUIyc3VG2hyuIp/fo+DHwBuH9gLfwaAJrXrF8Lo=; b=IzCvvhpv/zodeGhHERmZaR/roF
        sM2uulpe7QzslQvx6aNZEz4EhJ+1v48k0nSb6cogOmrZn1CJTtYB2cdxb2fosp5Hj6RmaZyRgyA2L
        quHDeaThqukQOc3ax8WkeZvkfxsOrWWwYvhZ66gKkFlfwCcmuDAuTN9aYQZPyDdHZYCI51dQ+Hrd/
        zYABFz7vou6OBxgf4+wyAsOfrBfE/Yzaizbmlx0WaE6tXBNqDTMtvUV0l1Fe56HzALGyHxKCxoLSd
        B0421IaM4tfFe3nIBzOuCMBfvricC/vRNS/LgNWmVZmqP1XjmV7Wm7H+UBxu9AecaPpKdRqPB4oU0
        Yb6OS5nA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtTov-00025D-Rm; Thu, 09 Jul 2020 10:30:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B547630047A;
        Thu,  9 Jul 2020 12:30:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1EE2285718DD; Thu,  9 Jul 2020 12:30:24 +0200 (CEST)
Date:   Thu, 9 Jul 2020 12:30:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 02/10] x86/percpu: Clean up percpu_to_op()
Message-ID: <20200709103024.GO597537@hirez.programming.kicks-ass.net>
References: <20200530221127.459704-1-brgerst@gmail.com>
 <20200530221127.459704-3-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530221127.459704-3-brgerst@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 06:11:19PM -0400, Brian Gerst wrote:
> +	if (0) {		                                        \
> +		typeof(_var) pto_tmp__;					\
> +		pto_tmp__ = (_val);					\
> +		(void)pto_tmp__;					\
> +	}								\

This is repeated at least once more; and it looks very similar to
__typecheck() and typecheck() but is yet another variant afaict.

