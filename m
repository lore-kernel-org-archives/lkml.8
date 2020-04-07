Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D101C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401052063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="kCB4Ds65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDGSGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:06:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36133 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGSGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:06:50 -0400
Received: by mail-io1-f68.google.com with SMTP id n10so4381913iom.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFURkkgEI28LmHfSrGJJBsN6aispJEyV6widBHxa9UY=;
        b=kCB4Ds65lhJ0e+rTx+VtREwnxiOpVxi+97SRFICJ3k3FErV61ZIBlP3DxUwrD0rVtc
         vG/IkazIdBCiwAQyUF4KGSheGOIJNoKBRMgO2DGzgOZu4RqvDQTM0ZXE/9bqeN/y/JgI
         vDN8H0yY5BZ8VaO+l0kv1faoKQOnBb9aQpHod2Xe1UYjBYo3zA2htfflCyx+3H8zOlx9
         w0nzGHAhetJmUH3cr61InWFZtwg/dBawi7O9QqYclurYlqCwuMQ+3go/35KvUkCTEpj+
         zUlOhqvJRQJuzsRLw2GlwyfHrjbyadzN6T1NOdMM2kPgsxNJmTJQgdORsAvNt2BxVN6D
         mF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFURkkgEI28LmHfSrGJJBsN6aispJEyV6widBHxa9UY=;
        b=WIQ2HJu2SEjauZ5hZpnrONEgyu6aRwP/RI4E7iTg+IbTTqe33Ben08I0Df5Q+8Il4M
         dxVK7mggTIltbO/zF9Nspysg3KA2Wtu5FIRT6RGxPLNwtClo2jWKquO8sKjClgQMtq+t
         3Zmh/A7wy6xpTTmFihLUgAgSxpgxU5U+UC8l+FkotDw9NcNGb3NbExAdA+ZbA4KbDNnu
         XWAyw3hPu2tT2/gftOtA6k2ieKehYXrCf+ayPe02RFvJwxUclbLM0a714vYatIm5MG1I
         esVHPgMV/rPPdC41OrFadJ3DBBGz+CnSpHVmC4CVXuayrTlJA+yHhPFyCS59VPX17Ivz
         2xvw==
X-Gm-Message-State: AGi0PuZQ+KO/DQUA0vbKfc5fnCAwtDv1QnwUu8G8dKxmQJXaXNOUnSde
        JP+UY7/BCYieSvsFJhSw8AxAaHhna4XU8nhWS+2Qvw==
X-Google-Smtp-Source: APiQypL4FVAJZPNibJxXLqNhbYUFOY2CYAek1Zp52w6Gzd6t6sj8nRUoxVQfFhqruJd6xgT+a6hZ0UfzBuSozf7SHyY=
X-Received: by 2002:a05:6602:22c3:: with SMTP id e3mr3282683ioe.75.1586282808916;
 Tue, 07 Apr 2020 11:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200407011259.GA72735@juliacomputing.com> <20200407142002.jxzc3xcuyoznjgkh@two.firstfloor.org>
In-Reply-To: <20200407142002.jxzc3xcuyoznjgkh@two.firstfloor.org>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Tue, 7 Apr 2020 14:06:11 -0400
Message-ID: <CABV8kRwyik_5nB3JSxSJxKqpepENNeK2NCJUf5QqE+m+H12P0w@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

> The rationale from that post should have been in this description.

Yes, sorry.

> You can already do what you want using the clearcpuid= boot flags using the
> infrastructure in [1], which is in newer kernels.

Yes, that it useful, but doesn't solve the problem where
we're trying to jointly replay traces with differing XCR0 values
(as mentioned before, this is useful for recordings from multiple
nodes of a distributed system). Even for the single trace
case, having to reboot the system or boot a virtual machine
manually for every bug report I get would be operationally
annoying. A potential solution to the operational problem would
be using the raw kvm API to get a very lightweight VM
with modified XCR0 but that has performance
and complexity concerns.
