Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C036C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE8622B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="rU/7m59T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbgGaP3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgGaP3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:29:11 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37899C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:29:11 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c2so16779041edx.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3k2Qozw9K7T3ULHctZF2uRyGbKqkev5Yvd3i8BwLL6Q=;
        b=rU/7m59TNeq5RpPtiUF/ooEfv7y67ob0BFihzDNxqzyOmEpsLDWpdRWM7a1Ta8diX9
         7/KmEpDzjGcJg/Pwvj5CJyOTsZLukJCMCLa8+AoMszs4qJ2ovqLeTB8tvugBUABNICT+
         eDx8T4FKQBB7a3AF6wXJM4aILfpBArYOrJuEN4lkQy4uwl9e0jQGD8SXyeGbMZNORy2L
         yAShufuKVBs3/3TERLOxaa0ePPEogNjB9YElAimeP98Z0X7DEawjgep2fVgs0yc7Su75
         36fuiJkQisHXPKWkagRGrmyt7j/f6VdTzQ17F84MaIPjL3U9bAoqmxQ5O1LyXMSuNHUw
         J1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3k2Qozw9K7T3ULHctZF2uRyGbKqkev5Yvd3i8BwLL6Q=;
        b=ptDijIyMlCkOHq2FC0dMJKmq+bJA0gWpDZcbv7tHKt/PCK+EXPjFWZb5bZC3ghfjtk
         Ham8c2aBevwmPt0/RCJWY4AnN7z7AP1/id9vT2CIRjeM9glbJj07ENfwFiwaCKobzsIR
         boWvvLOVTF+xS23dkxg+PTAdGMdmqKZEREZWAdPZOxOiOP9KcXi4lQx5Baeh22bQXcEy
         IZAJmv7Z0bdsSgKzxTF4hC9VSvYEBslnv2KwDxJvbyWXSKg1IwrJanxbUZoRtauTngH4
         pcCPohwiS3UZYWKPpwLF0guuEDnghDRxOGzHdAXsBvRymI6gkmiJMygiiiutWoC5t/kp
         TQLA==
X-Gm-Message-State: AOAM530DBWpJAvKW5lcJjoPeZllp7DJ0Gw6y/8p1ygC3PfctIAkQgTFn
        5pa147jo6vyYeleStgEOKCF/ue5gFuguD09YNNUNLg==
X-Google-Smtp-Source: ABdhPJz0P/lPp3nduBpCI463CmMAzDxLqlASXNACZIK8CQVQjVPCG9CcO/+9HjqSM/KyFs+VY+csHhR3WhxQTYkaNqE=
X-Received: by 2002:a50:d51e:: with SMTP id u30mr2058575edi.296.1596209349842;
 Fri, 31 Jul 2020 08:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200709020629.91671-1-justin.he@arm.com>
In-Reply-To: <20200709020629.91671-1-justin.he@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 31 Jul 2020 08:28:58 -0700
Message-ID: <CAPcyv4iqkuzyU_u+VW1nsaK7tiy+HJtUxLtgAxtfX0aXXcKhfA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Fix and enable pmem as RAM device on arm64
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org, Linux-sh <linux-sh@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kaly Xin <Kaly.Xin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 7:06 PM Jia He <justin.he@arm.com> wrote:
>
> This fixies a few issues when I tried to enable pmem as RAM device on arm64.

What NVDIMM bus driver is being used in this case? The ACPI NFIT
driver? I'm just looking to see if currently deployed
phys_to_target_node() is sufficient, or if this is coming in a new
driver?
