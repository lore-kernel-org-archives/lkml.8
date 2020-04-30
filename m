Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC536C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C182208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255402;
	bh=7W7KGgcOD0KxtaNwh5YpKd1MlDkjCVjYH32gOIyUauQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0Y5yXOri6rXxa2V/RN2MZiV02LCkPT+F0NzSQBCgooBVs7LM9CA5g4AP562ZECERN
	 MxhDXh5Fbj21PXkVRVpN0CoOPeGjQ2vf89Jtmgb3kK73Rdp9sw9zvX5fYGHDMyqo0g
	 Abgx8gsfMWN4nFMF492nd41j8P2DtNgsEupWqGT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgD3ODV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgD3ODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:03:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02E0C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:03:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f11so6648446ljp.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqs6/WoFCiYvtJs2NOyJ4iHVgMuqbT1GqHeEFPhOPPQ=;
        b=O8t7ysvn4JbuCgfHB0iclVfyXqKjhyJMADH7fryiwgDIaikCUb2xUHFTGkfrv/kOGT
         ChdTR92r6FB9qFSdR0QPOufTNyG3cZsWdSpf9JRI7IcOooSDszEv4yLEcFZtwKJToURL
         x34EdQwoyAhaLyKmaBh1g7sFR+CWi6lGqj6Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqs6/WoFCiYvtJs2NOyJ4iHVgMuqbT1GqHeEFPhOPPQ=;
        b=dXDLZhckVRBa+1DHOQL9rW6RmR9SVqAP2aOFt63bJ+9Ew3wAW434OP2kwcpqXIJERP
         sHdXVemW14PMr+ND798zQ9hqcHIcHXDO1l8eo/oOD1dB/y5ow/Ufx9H3taZdyH266HXL
         A7rt1FcSdf4RMWBtlPfaSgLF31CrOM3/TAa+ODzWFkkwyViUzfyJTOJAVxGLYMn8gNZT
         2S/9TR9Am2dm5ct1e5FYYHjirZOf+QqJCzdqnK2eukeoLGUtiA5Yy1eWQsBmRtUcyU8w
         /stLpUatovVHBd4+KzG6pvUAFNbTI85+QCYNTTF3IEBd3BnAuCMDmB2XQddoK6xrZhqX
         sjYA==
X-Gm-Message-State: AGi0PubIfYxjb8a/Fy7s1a4EvH1gJzY0lo35oy3Hh7Fjd7U9M5bdLgxj
        32+qAyLkE4yjm06xLcJvpmgIUHwwIOI=
X-Google-Smtp-Source: APiQypJ88x8wx5yuj4nFsjPnKG7MasPJZHwq6GriUQ3I180xbuSCyVS6LOp1XwtDdiygaLnmz5sxqQ==
X-Received: by 2002:a2e:9712:: with SMTP id r18mr2360319lji.225.1588255393039;
        Thu, 30 Apr 2020 07:03:13 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id u3sm5254387lff.26.2020.04.30.07.03.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:03:12 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id u6so6606691ljl.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:03:11 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr2483575ljj.265.1588255391241;
 Thu, 30 Apr 2020 07:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Apr 2020 07:02:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
Message-ID: <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 1:41 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> With the above realizations the name "mcsafe" is no longer accurate and
> copy_safe() is proposed as its replacement. x86 grows a copy_safe_fast()
> implementation as a default implementation that is independent of
> detecting the presence of x86-MCA.

How is this then different from "probe_kernel_read()" and
"probe_kernel_write()"? Other than the obvious "it does it for both
reads and writes"?

IOW, wouldn't it be sensible to try to match the naming and try to
find some unified model for all these things?

"probe_kernel_copy()"?

              Linus
