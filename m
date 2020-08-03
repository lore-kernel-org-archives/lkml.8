Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8235C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E94E20719
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZpPiDdU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgHCJh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHCJh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:37:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCBDC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 02:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UbRjqa0bLC9sUnNplV+mhL8Jmlbwd8SnDkco5utAUSc=; b=ZpPiDdU+LOwUbCnqWeNDxyTS3P
        83SJlXZhJQgAAwhUfujeYkdc6b/zHYQ4yD/THmovQlRkn0XwKrT067ZiIw8wCbF06UG78SPG8DbdW
        /6cNzRUkhcURd+0y/H1m/A5lHIp1r3RAfdUCVdc4ZrXEv4eW7gly+TRSgrQGpi+5oozDHH/M3QZDX
        NGVY5ox+e6i2aWawk4OJRkvsEQoTupMQmLiWoIbQZsNYgNWIDNTBrUS9vHcDYKksw8Hqp5ooPWCl3
        rDnlzx1kExokVOXpGU0vSAzIZIbwYjm7yqEPBrLI7RNv/nCrjZn6Hguh/g72gbljQ6mlwXRtsVi6O
        TiT9gzDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2Wun-0007dB-9T; Mon, 03 Aug 2020 09:37:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A23F3301A66;
        Mon,  3 Aug 2020 11:37:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 940C8236F1EB3; Mon,  3 Aug 2020 11:37:51 +0200 (CEST)
Date:   Mon, 3 Aug 2020 11:37:51 +0200
From:   peterz@infradead.org
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 4/4] context_tracking: uninitialize static variables
Message-ID: <20200803093751.GD2674@hirez.programming.kicks-ass.net>
References: <0/4>
 <20200801184603.310769-1-jbi.octave@gmail.com>
 <20200801184603.310769-5-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801184603.310769-5-jbi.octave@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 07:46:03PM +0100, Jules Irenge wrote:
> Checkpatch tool reports an error at a staic variable declaration
> 
> "ERROR: do not initialise statics to false"
> 
> This is due to the fact that this variable is stored in the buffer
> In the .bss section, one can not set an initial value
> Here we can trust the compiler to automatically set them to false.
> The variable has since been uninitialized.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  kernel/context_tracking.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 36a98c48aedc..21881c534152 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -190,7 +190,7 @@ NOKPROBE_SYMBOL(context_tracking_user_exit);
>  
>  void __init context_tracking_cpu_set(int cpu)
>  {
> -	static __initdata bool initialized = false;
> +	static __initdata bool initialized;

So personally I prefer having the '= false' there. It used to be that
compilers were stupid and would put any initialized static variable in
.data, even if it was initialized with 0. But AFAIK compilers are no
longer that stupid.

