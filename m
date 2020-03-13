Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B10C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD595206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2dbZzf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCMQqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:46:17 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46497 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMQqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:46:17 -0400
Received: by mail-il1-f195.google.com with SMTP id e8so9502350ilc.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLfO+OW4oRiObD1mcWwejLJW0KZ7ehp7OtU4EnfKGnY=;
        b=K2dbZzf0Nn8BHIO22kvM9U0yfYXu2gWzb0d+PzeEv0ZsYACUferpfjoQysiSoLipXP
         O6kLUYk1bfULHeyZXR7uRfYuAw5kiNGKuTYcbrklHzW+UDxegCDKW/x+ibmhmp4D3diU
         yCMrZ81OoBxyoatFMa6cfN4CiTS/cOrb8S5qBN/Cr9wHuJs2S+NxbT+KK/UdOmby1Jg4
         6/T2C1i2Gjs0/OLYJdKpkb/SoHRbMU1MY/9xGK9HkUPVQG/AdODm5piTppHYZbeNXyTP
         u9mXEifEdVt2qwn4bBbkXhpx6xMMcwvUea9MatKGuTP5jBDugt9EbneoL1k2mRuSr5rG
         M2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLfO+OW4oRiObD1mcWwejLJW0KZ7ehp7OtU4EnfKGnY=;
        b=UL/Zu4xKm0KxG7szpa3yjKFVI0WXoRRpidIF5hHfLY2s1BkW6NiJ1nQZEKbfWilJQL
         mtGW9zfT913GuZpHlnj1AVCT57B++SGhPvlRjX8aHlp5Otz7Yw66cj4svu31MJdlQhJU
         uMW8KwVVEhloYDhTT5hrR0i2a/3zf32fPHgy83a76CoFurtWuCBZ9H3DxDFKByD3BdW9
         x/tTI63vu00GrzLtfXMxF1j68Ive+08l+XJ016KoWLb6I3kQs5bbfzI6rQDHh461PHaS
         ySsgH5QNS8txl41Jvtv5ud8u/E2NMmQ6qZ88Z2OKO6jGtmEU869hb4cI5VSzO9PdKPV1
         G/Og==
X-Gm-Message-State: ANhLgQ0JIpsTfz2MkN+gFur5hJS9/A+WT4fP36R65JWXTAmgYZYGlvsp
        OhYWtJ94epv9GBjs3RDgpBCctUx6ubOY9bqC1w==
X-Google-Smtp-Source: ADFU+vvTzFYHK/VoLB/yWrhBcpU9JrC3P6+QEoFKclsDoTKWNtbm7VQ9LwqF0C90UVcIxg98hNrTa8/E/9EulluiMWc=
X-Received: by 2002:a92:dad0:: with SMTP id o16mr13665643ilq.27.1584117976392;
 Fri, 13 Mar 2020 09:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200312134107.700205216@infradead.org> <20200312135041.641079164@infradead.org>
In-Reply-To: <20200312135041.641079164@infradead.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 13 Mar 2020 12:46:05 -0400
Message-ID: <CAMzpN2gkRGEYEzgO55rBhkTdQO3XhEEfHrq6+j1dy5kzn-C5AA@mail.gmail.com>
Subject: Re: [RFC][PATCH 04/16] objtool: Annotate identity_mapped()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 9:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Normally identity_mapped is not visible to objtool, due to:
>
>   arch/x86/kernel/Makefile:OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o := y
>
> However, when we want to run objtool on vmlinux.o there is no hiding
> it. Without the annotation we'll get complaints about the:
>
         call 1f
1:      popq %r8
        subq $(1b - relocate_kernel), %r8

It looks to me that this code is simply trying to get the virtual
address of relocate_kernel using the old 32-bit method of PIC address
calculation.  On 64-bit can be done with leaq relocate_kernel(%rip),
%r8.

--
Brian Gerst
