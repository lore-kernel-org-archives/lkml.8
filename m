Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CC7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 157E120791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597347511;
	bh=6pxveVZ3xSMQqFetFGb6uZ5k6h8qTu3Ah/OpxuNnmCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=reZORIoTkJSBIhPn1JdQ55x/RevI9Rn+M5U6UnMOV4cewUoQi5Elp/QyKlySSo5b7
	 VJp2zk7e4g7rpxEHGw4pByXELcc0vWmBWecalNj0F0F8CE/3HpT2T2qeK75K7FiRmN
	 MUI82OUNkHG6Egu0LXk8UZxFohGLL9A9qHXEYrj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHMTi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHMTi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:38:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4231C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:38:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g6so7443555ljn.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9W/SZeITS+AOoA4ttv/qU5QwDchpBVv5HiBD0RqF18=;
        b=O5r2PL0p+XpJ6S3GE9bB/rYkb8fKW6yN0yzIs6vae75h+b/I0X8VTtLjHFYb7iGfUV
         bIHmmvMUpNy0fsJCFYb4OVkNirjORwNJhqq/rgMLA/eQUHXrFniNjpYTNDyvC/SrcnEC
         U1QS9xuVeavWnezgmM15HeeWRVKU9tqNWH4Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9W/SZeITS+AOoA4ttv/qU5QwDchpBVv5HiBD0RqF18=;
        b=UHtX/yPNvW3BnnIU48RXcMfcUNocXwZaoAACsfAdOZM3a6nxai9XiXTlL5jFF+YH0D
         DwiEUb7V4L1ECc/zx7HnvQGWBFKXTbEGvgDXlNcogUf7AalFRu+vVDZu/NreFva3aTkL
         fWkR1Os4c+DkVijpAXsa55Ng1qfTzraUDeOiMwOnkzSNLrnn16T2O0JKW7BHHcDSbpfH
         ZnC90SMuJAqJg1n2pl2qk/PsnvMRTEYZN6ao1n8oq3PYlIoBM0as9hfnCaFBwmtHU1HW
         yOQsJlykFDiwUC9q7fGJUtoy2g9h0A7mfIRut72sa6WO00smGOnYoYOAUHZRxszGDTEj
         I/uw==
X-Gm-Message-State: AOAM533yEQx9DtEYMng1mQe/xP3hcxDvLDfX5eUsICcERKKSGF0YPuVU
        8AQy+DslaN8EcIPfrLcVGMyqSvwj+fw=
X-Google-Smtp-Source: ABdhPJzmh4Wig8dN4UkCR+ESdf5N4f6E8156HFWjRmA3Gn5B54GnPRD2bH9sGspsxT9biiio/uSQkg==
X-Received: by 2002:a2e:3312:: with SMTP id d18mr2682223ljc.222.1597347506685;
        Thu, 13 Aug 2020 12:38:26 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id b17sm1320761ljp.9.2020.08.13.12.38.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 12:38:25 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id w14so7484690ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:38:24 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr2937304ljp.312.1597347504250;
 Thu, 13 Aug 2020 12:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200803190354.GA1293087@gmail.com> <20200805110348.GA108872@zx2c4.com>
 <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
 <20200806131034.GA2067370@gmail.com> <20200806185723.GA24304@suse.de>
 <CAHk-=wg7PHCUMD1xY=YCCeVHspAhw0YNEhyO3CnHfRPwsf6P8A@mail.gmail.com>
 <20200806212019.GA2149204@gmail.com> <20200807084728.GA29510@suse.de> <20200813193008.GB2338781@gmail.com>
In-Reply-To: <20200813193008.GB2338781@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Aug 2020 12:38:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmywKf9HZ95HZD+pv6JEmCnXaUz=Kx3=6m3jwSa4CmNQ@mail.gmail.com>
Message-ID: <CAHk-=wjmywKf9HZ95HZD+pv6JEmCnXaUz=Kx3=6m3jwSa4CmNQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 12:30 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> Would be tentatively scheduled for v5.10 though, we've had enough
> excitement in this area for v5.9 I think. :-/

I think I can take it for 5.9 again if you send a pull request my way.

If it causes any other problems, we'll obviously revert it again and
at that point it's final for 5.9.

But the one report it got was fixed early and quickly enough that I
don't feel like things were _horribly_ broken, just a mistake that
wasn't something horribly fundamental that needs another release to
think about.

                  Linus
