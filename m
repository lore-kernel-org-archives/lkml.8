Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC739C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB67207E8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593657339;
	bh=8F1h3//G/kf9HnV7eaRR34OR8LtYeHBW0vpcDbroKrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OUNhxq3Sxa0Y2psLH/Leh4LvmhTq4qmBvB8o6Hv6OeNXY5FCEbbAADMh90yiQ9GRf
	 bZ7kk1rDqNv0626FMK3rktPvJV0EnhnBOuMyjXn6Ol8VTPo21e1C1dsKGt9Zb33maZ
	 zplidigzbnqhpBY8xnf7mv3s8gmEWqheQt7k8oAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGBCfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgGBCfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:35:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841E8C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 19:35:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k17so2181489lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 19:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dO+MYSL5JIFNDDAWCgnk88YYd0Gu8lu4qudIafhsIH8=;
        b=bTqo5ZsG+TwJIPH9BEUoRZxCg6Dlz/Z85DLm7635y496rV2cjz70C5+v96VBOLtiOl
         Rruu4lhV2PhcHK2DpL7/sbJuOMI+t75nQ4D2yGsRZwFXv0lcTxHOzA5ylZi0GBfPRaph
         IhzmyMeIhDyj/OUByXBJb+9nWZPrkSBnqcIKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dO+MYSL5JIFNDDAWCgnk88YYd0Gu8lu4qudIafhsIH8=;
        b=cPOCofvF02F69GO+ubZvdyDpK2LDcOTTYeRidwNv46CD38Jv3T+bWMC1xy5mxXaaia
         BPG8r2OazNNFwxafcQHGJelDciX/cilU5ArpuCtmlmxLytTaLIhg6jRmhcoZkZcy16NQ
         Q0B1hPgdmOfpbT6+OzjUhqfZUv12DrMK//VnVYHEix9yv4mLdei2YLtFDDXUGo6H2z79
         yNMtLM4wjZBEDOR43pkr8ic6DGUiExbqU+kGSpcSXYkzCCdywRDe1Tvo0fJq0SQSj2z/
         e6GPKt6RJED0iqqs/fKvuquebSo8LTB1en/iIQJa+39yyWa6aE5JcX0uSDklEEtDs3o4
         +FKA==
X-Gm-Message-State: AOAM530LLIBe5kVVKyJv2rc52DhNsJeb977O4QR4zvKumacTwlClg9ho
        B9QMXMb2g218IK6BFPT1jsIZtFA37uo=
X-Google-Smtp-Source: ABdhPJzoNm4I/Ycl2sWRcW52HJ6bCNkxT5aWv+n16a0qZ2zMTKm7LwgkxIzB8jafPGKcahzQ/xTesA==
X-Received: by 2002:ac2:4550:: with SMTP id j16mr16955864lfm.37.1593657335729;
        Wed, 01 Jul 2020 19:35:35 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j26sm2761399lfm.11.2020.07.01.19.35.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 19:35:34 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id b25so26094385ljp.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 19:35:34 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr9680ljc.285.1593657334480;
 Wed, 01 Jul 2020 19:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
 <5F1767D0-416A-4BA4-9DFF-E82D1EA3F5EE@amacapital.net> <CAHk-=wh0X1YBQm8b6dqu=FpE8jgHriisXDeqJ7jai41Ob+sJDA@mail.gmail.com>
 <CALCETrXpKAR2A0+96b+RWUE0vUmoPwmp-mfF1u=g2270DNi96w@mail.gmail.com> <CAHk-=wjXftMyC93Jg8J=_HiuERsHujPOa-RbOmMLuuxVoJCrfQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjXftMyC93Jg8J=_HiuERsHujPOa-RbOmMLuuxVoJCrfQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jul 2020 19:35:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmS2E26pa=K3QOGfPqPyrJpSaosXDbnUmuBt2dHFP3jQ@mail.gmail.com>
Message-ID: <CAHk-=whmS2E26pa=K3QOGfPqPyrJpSaosXDbnUmuBt2dHFP3jQ@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 7:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I guess we could do that. Are there cases where this actually helps?

Hmm. Thinking about it., using that approach might make the
"CONFIG_CC_HAS_ASM_GOTO_OUTPUT" choices simpler to handle.

With ASM_GOTO_OUTPUT it generates the perfect non-jump code. And
without it, it generates the (annoying, but inevitable) actual
conditionals.

            Linus
