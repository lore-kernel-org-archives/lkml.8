Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7043BC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEC92067C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583547682;
	bh=1hK61AOttKQjpFnefFnrB/B63DwRIlE6GKi1awj3rLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qby4XRaadsDVYvmvR2QHGijuVMdqW5eR8Vl4tPd70kqh7PQuRuUKhYQRcPHqObwLw
	 ESBR5D+/44onWZipFmVVlq+CLLvYrgP6hgAiy4SIVjEmsHdaiDaddYuGpHKwsLVZ3C
	 EucdJVBPCjHs/Eunfk5oFJSyFXkY5Q9gAUyIo0Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCGCVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 21:21:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgCGCVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:21:21 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B3F20705
        for <linux-kernel@vger.kernel.org>; Sat,  7 Mar 2020 02:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583547680;
        bh=1hK61AOttKQjpFnefFnrB/B63DwRIlE6GKi1awj3rLE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jcG2U+tAucUJrcdf7foxLHER+S18d0t0CiE/qHc4WbCDY03zDroQZDGNTbLOwzBRZ
         uZwjv2VD42ADy0659mYmwE8RFkF7NCiqw9DpSMWcOTZU2OFObfl81htkDgn/JDoEWB
         FUktMHVUpGjvJ0eMU31YO23HcoOugstPiZbTxg9k=
Received: by mail-wr1-f51.google.com with SMTP id v11so4471922wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 18:21:20 -0800 (PST)
X-Gm-Message-State: ANhLgQ1GwpEsOrl9/Xc8+H0wF8XkqIvgPh8BxVhQNpR50e0ngj5gbk1m
        b5vqE/T04Mnpmh1FZh/Fo4ylX44hjKECwA2vllJGFw==
X-Google-Smtp-Source: ADFU+vvz6h+4nO7ePltpnekglr/xa+6kV6sjumEIgtsaGDr0ysbdKMaLv1gEgmu6PKjoVg7vlEzAcOHSVAFHa6JBjiA=
X-Received: by 2002:a05:6000:1ca:: with SMTP id t10mr6716238wrx.75.1583547678734;
 Fri, 06 Mar 2020 18:21:18 -0800 (PST)
MIME-Version: 1.0
References: <25d5c6de22cabf6a4ecb44ce077f33aa5f10b4d4.1583547371.git.luto@kernel.org>
In-Reply-To: <25d5c6de22cabf6a4ecb44ce077f33aa5f10b4d4.1583547371.git.luto@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 6 Mar 2020 18:21:07 -0800
X-Gmail-Original-Message-ID: <CALCETrVHMO14Vcg9-pmuhN+MmXCuKnfR5Zipc6sqkqVHQGAQRg@mail.gmail.com>
Message-ID: <CALCETrVHMO14Vcg9-pmuhN+MmXCuKnfR5Zipc6sqkqVHQGAQRg@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 6:16 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> The ABI is broken and we cannot support it properly.  Turn it off.
>
> If this causes a meaningful performance regression for someone, KVM
> can introduce an improved ABI that is supportable.

Ugh, disregard this patch.  I flubbed the comment, and I'll send v2 shortly.
