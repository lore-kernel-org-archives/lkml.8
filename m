Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05C4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3DA206CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pNYHdXo3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhK/PrOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgGFOqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgGFOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:46:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58E1C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:46:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594046794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LraJN8c9SSrjQA7IMqbSzEalKGMV2AcQF0lddX0uZjw=;
        b=pNYHdXo3uo06jVPYTs7f38ecXnHKAST/Jw10LKSmqNvuCrML0UwO0y/15jWeQnhradofZd
        +Nl/qgtAwILnB8NoKFCKisXkLWR7BtpP4mHV2ya3lIgKubzSrz7Nl8IuBnTTW43mC3De5h
        +mfn0kiSWX9QdJmpBvuTv2IXRX5UwFq9Fo8/FiakmA0lMaaDJZs0GZv3qrxznNXwUDqvz+
        wWpRu4VbbDA8w14w2X6A/nX73TXoIWs/OfLMGBjzWJKw5AK5veuHSrd/BObPv/AE9gDGes
        ax0bNOOZeDA78EEFKD5D8YRNG2L2FCKcd8ojCoHH8PpKzaXP07MyjIc9z0HaEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594046794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LraJN8c9SSrjQA7IMqbSzEalKGMV2AcQF0lddX0uZjw=;
        b=rhK/PrOrssg2qs4+fJwuPBKS2Jj0jnIlqtOcPI9cYaIDbhhyDfoo79VcXe6LobJDT3JFjY
        E3Gy6fH4LFPHTIAw==
To:     Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: Re: [PATCH RFC 3/7] x86: kernel: cpu: bugs.c: modify static_cpu_has to boot_cpu_has
In-Reply-To: <1593703107-8852-4-git-send-email-mihai.carabas@oracle.com>
References: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com> <1593703107-8852-4-git-send-email-mihai.carabas@oracle.com>
Date:   Mon, 06 Jul 2020 16:46:33 +0200
Message-ID: <87tuykr99y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mihai Carabas <mihai.carabas@oracle.com> writes:

> The usage of static_cpu_has in bugs.c file is counter-productive
> since the code is executed once but there is extra effort to patch
> it and keep alternatives in a special section --- so there is both
> space and time cost.
>
> Quote from _static_cpu_has definition:
> /*
>  * Static testing of CPU features. Used the same as boot_cpu_has(). It
>  * statically patches the target code for additional performance. Use
>  * static_cpu_has() only in fast paths, where every cycle counts. Which
>  * means that the boot_cpu_has() variant is already fast enough for the
>  * majority of cases and you should stick to using it as it is generally
>  * only two instructions: a RIP-relative MOV and a TEST.
>  */
>
> There are two other places where static_cpu_has is used and might be
> considered critical paths: __speculation_ctrl_update() and vmx_l1d_flush().
>
> Given these facts, changing static_cpu_has to boot_cpu_has is done in
> order to bypass alternative instructions which cannot be updated at runtime
> for now.

Not going to happen. We are not adding 4 conditionals to context switch
just to support that late loading horrors. There are better ways to do
that.

Thanks,

        tglx
