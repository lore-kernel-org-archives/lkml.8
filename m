Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD74C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F29D20771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khk/dVYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbgFSOJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgFSOJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:09:23 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C31DC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:09:23 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id q2so5672996vsr.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSN+a2RVNGMBSxMoxwqKpJqZZbVxq/HTpK1YQsoLOvQ=;
        b=khk/dVYTi6EwwazULEZ22xn6wr4m9EWCJc0ruPwHDfNSiO2Ghl8ifOFklLvezpLcLj
         HLL91p161trSUnoVwYgLI5bdzH7DDL2CV9BHH7W1sPkkOfYES78xqlXzDQ0yLSr9oFX3
         0tqtaO8x+IJnZFtS7DD1JQHcCegeTaJVZf1odfIhadequ2cjDsyNXEYSB8nXyWDjCyi7
         GUgFP1QIqXLuPjIg6b8mMDNwksmfJUx49MWjS6lhD7vJnhY0Rc3QOe9RUUGDoPHg0Ykt
         gQci6L6xS840ab1z2MW5iBFt9vmZvor/RxNyTScU3A+dmyFC9uAI5aA6CRtQNd9LtYjd
         A4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSN+a2RVNGMBSxMoxwqKpJqZZbVxq/HTpK1YQsoLOvQ=;
        b=tI9HgjWPffiNyiNS8De5LM9X4JjHR2THuOZ57aRN1CGt/FMx8RQjSMQoe7fT1AjIp0
         MxR2jVlh7Og/rlaUIHfknDI6r/3URU2GM0ayCxJdP/SALR1QVXHVlZGuUc4d7m81Oy95
         hdwkbhSmSZebD1rlT4q1AWqdc+dG+nvlfggR6973AMZtT9t6gPh7TLiRzUuAOhnV6oHJ
         FyJ9VW0VgopbE41yK8m/dO9yl2/0ygaGyH1okwhCs2BEqveZpeVUlWjNCt9CWfDK6SzT
         DFqItNfDeIhL1X8Y3gmHS5BI8Sja3w+tNPlwHDMTkObU6SFnkiBGLxC9FlMdJ6rrdmLW
         ETNA==
X-Gm-Message-State: AOAM531XOXvtxqveK2ueQtl/wo4sAYOfHMGVifobeiLiYTNyeUsByRE0
        O3f9BkrbjHWLzX9KYDmPGJ8czeVJ45MdkwNrqx8=
X-Google-Smtp-Source: ABdhPJwaU8EKkHibn0F4QFCG8an0FYGeNjzihahv6zqla/Y73Ma4JM6yScH+GXFH+vMBDQsiN+yKoefvaa9GtQbEi60=
X-Received: by 2002:a67:d597:: with SMTP id m23mr7913365vsj.209.1592575762106;
 Fri, 19 Jun 2020 07:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com> <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <23babf62-00cb-cb47-bb19-da9508325934@intel.com> <CAD2FfiFbGdf5uKmsc14F4ZuuCUQYFwfnirn=Y0fu2F0=njvWug@mail.gmail.com>
 <80578b72-cb6f-8da9-1043-b4055c75d7f6@intel.com> <CAD2FfiG1BgYvR6wkeXGro8v6FQtVjKemmAOOf2W14z5KUWLqhw@mail.gmail.com>
 <d55f94bc-3b26-a556-f7e6-43e9b1007e13@intel.com>
In-Reply-To: <d55f94bc-3b26-a556-f7e6-43e9b1007e13@intel.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 19 Jun 2020 15:09:09 +0100
Message-ID: <CAD2FfiHCi2MfShGWaYWk_GcXW4xVr6chsLPZs78OJE+2_GErVg@mail.gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 at 14:58, Dave Hansen <dave.hansen@intel.com> wrote:
> > Right, but for the most part you'd agree that a machine with
> > functioning TME and encrypted swap partition is more secure than a
> > machine without TME?
>
> Nope.  There might be zero memory connected to the memory controller
> that supports TME.

So you're saying that a machine with TME available and enabled is not
considered more secure than a machine without TME?

What I want to do is have a sliding scale of TME not available < TME
available but disabled < TME available and enabled < TME available,
enabled and being used. The extra nugget of data gets me from state 2
to state 3.

> > Can I use TME if the CPU supports it, but the platform has disabled
> > it? How do I know that my system is actually *using* the benefits the
> > TME feature provides?
>
> You must have a system with UEFI 2.8, ensure TME is enabled, then make
> sure the OS parses EFI_MEMORY_CPU_CRYPTO, then ensure you request that
> you data be placed in a region marked with EFI_MEMORY_CPU_CRYPTO, and
> that it be *kept* there (hint: NUMA APIs don't do this).

So my take-away from that is that it's currently impossible to
actually say if your system is *actually* using TME.

Richard.
