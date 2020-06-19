Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FA8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5329F2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGBlgQlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393728AbgFSQbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395042AbgFSQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:31:40 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7090C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:31:39 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id s192so2431210vkh.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dEf83idZXvrPsVKGcPR3p3YRd+fKXVKhp9TXt5Kn60U=;
        b=DGBlgQlCnRLuOM3zrU/WFVPlQWoH3/GzaxHTx7AqPPQ5bnm1kf7M3WdU0IEjH0YpoD
         /SfedgbVSc+qL4Xnuqg2YoRwDs5k0GM8lEgD5rLnYyomCnpJss/+90Qf0kIGFDNbvcHQ
         0T+jhrh9b8lGPjrLghzK2xc4+MG8m7I3gPuS5rQOySza9Ewp8TBsL60R6i6day2Qb7GT
         eYXBgGK0X67NR4eIkTC1DOgtIYA88hk70LNH036MzfrQyrdF0BatJS+sML7zIo4Q2Vjw
         XRq9r7E/lh+kolFEz65lAECGDlKwZcXCBXvaUHKV9G2scpUFYMSuT/Kg+LOHFv+besKq
         8c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEf83idZXvrPsVKGcPR3p3YRd+fKXVKhp9TXt5Kn60U=;
        b=pjc5ZYPdhmoaeFd7aevUHVhZKxiWvX46ZZz6dO2WlWrQ4I4kTQLtLOgv61kW9hkunE
         cDJh3DQ4sUAvFHKoHIM39eK05gNfh5Y9gxLa0bRieqHk/9sImrx62soh44587Tao8EK9
         Wzqx2p5UItzDnEecpabYNTmQ0SMkGbDskD7E6cZF4ZMnvtdwki6NBsQlLmAk0W3gHLo3
         R/iMyGoiUXAJirFz2eY6Yzgf+g1NH9xZORS7RvMmWgioc4vr5VuegPPYJYopJz1+i/qL
         hNpgoR7scXZdtxuFbfpAW3CWHW+ekrOcf65nAIEYhhyUZXsV2BZKeKdxYwmnjkErsuwN
         A6qQ==
X-Gm-Message-State: AOAM530dafxv0qNYboDqDS6CfXkNtSaxAge7KdH8K92HGdqxv5OFy4u8
        f/E9b7DlpvnPRIiuvzVRPT/biMKcDDpjT7LWkkk=
X-Google-Smtp-Source: ABdhPJwWPW63BfO1YDNPwCOSif9q+11rpQa+AaCJvnFL8cqqzFrXlVBHqmDD9oS9TmjW1375YHGcBAWEmte6ApUzeo8=
X-Received: by 2002:a1f:4303:: with SMTP id q3mr8159836vka.65.1592584298930;
 Fri, 19 Jun 2020 09:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
 <0DD7FAE4-3976-4835-8090-80B84B737F3E@amacapital.net> <20200619161752.GG32683@zn.tnic>
In-Reply-To: <20200619161752.GG32683@zn.tnic>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 19 Jun 2020 17:31:27 +0100
Message-ID: <CAD2FfiFt0zm1uk6Z8RF_EUFeEd8ZT61B9+jtdAHrF5hOrcTk_w@mail.gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Daniel Gutson <daniel@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
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

On Fri, 19 Jun 2020 at 17:17, Borislav Petkov <bp@alien8.de> wrote:
> Well, I believe all the kernel can do is supply bits of information -
> just like MSRs - and depending on the settings of those bits, userspace
> can decide what the situation is. For example:
> bit 0 - CPUID support
> bit 1 - BIOS enabled

Yes, something like this would be entirely fine for my purpose -- I
don't mind where or how I get the data out of the kernel, but parsing
the entire systemd journal for a magic string is something I really
want to avoid.

Richard.
