Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334BCC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB83B206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgDQNHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbgDQNHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:07:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29820C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:07:40 -0700 (PDT)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPQiS-00006l-6S; Fri, 17 Apr 2020 15:07:32 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D37BE104096; Fri, 17 Apr 2020 15:07:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v3 3/5] arch/x86/mm: Refactor cond_ibpb() to support other use cases
In-Reply-To: <20200408090229.16467-4-sblbir@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com> <20200408090229.16467-4-sblbir@amazon.com>
Date:   Fri, 17 Apr 2020 15:07:31 +0200
Message-ID: <87sgh2l0q4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <sblbir@amazon.com> writes:
>  
>  /*
> - * Use bit 0 to mangle the TIF_SPEC_IB state into the mm pointer which is
> - * stored in cpu_tlb_state.last_user_mm_ibpb.
> + * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
> + * stored in cpu_tlb_state.last_user_mm_spec.
>   */
>  #define LAST_USER_MM_IBPB	0x1UL
> +#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB)
>  
>  	/* Reinitialize tlbstate. */
> -	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
> +	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_IBPB);

Shouldn't that be LAST_USER_MM_MASK?

Thanks,

        tglx
