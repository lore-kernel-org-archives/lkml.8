Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD49C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3C320715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G6q7Jud7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgGFBUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgGFBT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:19:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0AAC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 18:19:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t15so1878153pjq.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 18:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hsValw4wLMzxskO9JAsxS8IlkvauPBZYj9ebYBYapKQ=;
        b=G6q7Jud7BYrDbF5YMMzI6atIeRmAy2r3a0Dk7TutymmDTzE5dI+ipZeZ+nNejcqFhr
         Gu0K42r8orIAVelK0CNQZTVlYc52Ivv0Rh3txYaPkTxO238GeJGlQLQjw65xP3zPLCnd
         d1u99CnvcHMKV/razA5QrnIucnkvaXQKMLB/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hsValw4wLMzxskO9JAsxS8IlkvauPBZYj9ebYBYapKQ=;
        b=SC1LWrZM4M30tpbA9SiPo4VNQFaGM8D1HChXyomToWIj5xFkIfEmN+IDTUSyCvFpIS
         P+qG3FqV76NSRejm3peUTqtVSZ5lTCqhskFHi+8C00hpZoyhY56Ve9QDrkJvFUQPrT6I
         rMacBQ5dhsgzp89LhDzn8UIUNBexv0vlXxFw9oMsu1LtBb7DDAz0D2rCUN3DUAJHGpbJ
         YjQIVz35M3mS9AAL3Sm2/CVOedYy/ueuHVwZzjJauKiho+9bj/+CVb6YirR/GoD1Vwtc
         //rCKCwg5rHSJgzGXw+5ONBY8ddDXZESPGKC2C2Z2CDdCYjGUV3QIlvh5auKJDyMD+mE
         9Q9A==
X-Gm-Message-State: AOAM533DxSzsCaXF/TSM4rCWXbICgAcwmF6eeUpGdTPTDakEA7Z8baDq
        A2wJT4OYsXccBmndQqNWjRVejQ==
X-Google-Smtp-Source: ABdhPJyRQMl8X2jOh3kV2RfeE5+zaKw6r/y3dmR0L3SXZayvtA4SqleWN0dDJU/g4lAJNhGdolwYwQ==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr35985832plp.77.1593998397876;
        Sun, 05 Jul 2020 18:19:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t137sm17967077pgc.32.2020.07.05.18.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 18:19:57 -0700 (PDT)
Date:   Sun, 5 Jul 2020 18:19:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        Greentime Hu <green.hu@gmail.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH] riscv: Add STACKPROTECTOR supported
Message-ID: <202007051819.0ECAD4E6@keescook>
References: <1593930255-12378-1-git-send-email-guoren@kernel.org>
 <202007042350.4C153C4F8@keescook>
 <CAJF2gTQFqH7GMvRgmtb=hBwvUy6NZyM8xLqOsUTvnYhO48tQbg@mail.gmail.com>
 <202007051328.FE9EF99@keescook>
 <CAJF2gTTCEEoP3a9i_REXPwkJZ4Si_hYfjk_hwqHxkyfgw_xBLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTCEEoP3a9i_REXPwkJZ4Si_hYfjk_hwqHxkyfgw_xBLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 08:55:35AM +0800, Guo Ren wrote:
> On Mon, Jul 6, 2020 at 4:31 AM Kees Cook <keescook@chromium.org> wrote:
> > Sure -- I assume get_cycles64() is architecturally "simple"? (i.e. it
> > doesn't require that the entire time-keeping subsystem has started?)
> Yes, it's just a csr read. But it's necessary? get_random_bytes should enough.

Well, that depends on how early _all_ riscv platforms are able to
initialize their random pool correctly. I'd include a csr mix.

-- 
Kees Cook
