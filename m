Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9D2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F78120721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HmNGNwT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgEUJiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgEUJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:38:07 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEACCC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 02:38:07 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id p67so1312427ooa.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRRenhNm9RcrMGaLaFDRHCMDiaKFzvbNFCQExEVcZEI=;
        b=HmNGNwT0/nTNwhk2QkQq2ieaY4fXPKzgGc6i93+BrNIwF1AtkKSu77TWtbfKwcwSc6
         dT/v4sy6DWT5wDaNmoJdoIAMrvhkxh2HNpgz8Hc2Vmu48egXDLCOqlFeI1mXEjLC/rb+
         APGPTYy2+DgT65Pc3waqCCRCvynp0Wbb3L5+UO+XfRz1RdirUXPJo9l8QPU4ylGmnxHp
         fJnleaCszpokXvQmkjyQuIjofri9zb8Pv2tjn3gaesbANbJzORgc/3wOTDWewar+37kF
         zlKDEVAHiOoKaaRAeVZZmW+ZKx7fqyCgVv6bS6xR9SGAr/PR/W8BIXM3MPItVGOW/6WM
         f72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRRenhNm9RcrMGaLaFDRHCMDiaKFzvbNFCQExEVcZEI=;
        b=U+wQ0bBD3F9MeaMYt9yx1zi7A0aXRD+GXv4wXvT+KT60Z0nnFkIg8T4Sn8fghIqfxD
         AR/8Qi3ZvaUhtV6QTDenTiYPoqFPuQjEXmjcoJ1WFSQRS2ZjWLlgIAb2UnmyAts1285G
         taSDHDm++VrxRAnEyhuiUMKsuw3mfh/e5OhF4uU8caRiTyxnRg694fHNbPaoUBPtjNN1
         +zVTEp8r5e8iyshtne/Al2zAIM5obA1LG2iEk0Fka8VPOeAJIx+Vt34IsMnuxY2oxZ4d
         9SSyTzc9+lAN667s7z5GllrTViEnTrVtYD0ZpyU6cwpEXWR/iJSUCFq0A5LP1hbHTm5H
         69ww==
X-Gm-Message-State: AOAM530voA3aRpqctUYOk8DY+dbO/bXk9NsbWqxL9r5P3H1fwz+Tp/5t
        5v40YZ/8R9o9NSb7K2sXf+GWSGMIwycBSDIYnsfYog==
X-Google-Smtp-Source: ABdhPJyw2BNtuFy9oINuCcU/aMPLnbDEf9QicF1fHmI3WsLhnZXh08jAfH1GiPiA2HkJL+Omfvf9ZHnVgwW65spkedY=
X-Received: by 2002:a4a:e836:: with SMTP id d22mr6691371ood.54.1590053886935;
 Thu, 21 May 2020 02:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200511204150.27858-18-will@kernel.org> <158929421358.390.2138794300247844367.tip-bot2@tip-bot2>
 <20200520221712.GA21166@zn.tnic> <CANpmjNPsEMF8qq4qHoJEDb8mi211QzXODvnakh2fj3BOw+56MQ@mail.gmail.com>
 <20200521072557.GA10099@zn.tnic>
In-Reply-To: <20200521072557.GA10099@zn.tnic>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 May 2020 11:37:54 +0200
Message-ID: <CANpmjNOJYWjhK3Z=mbbum8V8WzWOyfTWqz--+C3Z08LPCWm2Rw@mail.gmail.com>
Subject: Re: [tip: locking/kcsan] READ_ONCE: Use data_race() to avoid KCSAN instrumentation
To:     Borislav Petkov <bp@alien8.de>
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 at 09:26, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, May 21, 2020 at 12:30:39AM +0200, Marco Elver wrote:
> > This should be fixed when the series that includes this commit is applied:
> > https://lore.kernel.org/lkml/20200515150338.190344-9-elver@google.com/
>
> Yap, that fixes it.
>
> Thx.

Thanks for confirming. I think Peter also mentioned that nested
statement expressions caused issues.

This probably also means we shouldn't have a nested "data_race()"
macro, to avoid any kind of nested statement expressions where
possible.

I will send a v2 of the above series to add that patch.

Thanks,
-- Marco
