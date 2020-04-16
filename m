Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF21C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B540208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="kVCy0Jgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgDPBP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgDPBP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:15:29 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20AC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:15:27 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c17so5325946ilk.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZL/AdIrqcubn1U6a/kqjvBwExmLiwQWSdp5NsKlE2G8=;
        b=kVCy0JgiCTNp8xA5ArpyuEjQuv1ZH9GrNMbR0QowCSzC5k71Op/5CoOmKx2+RV5yPg
         OKwIeny8DZUEFtnebOkOTS2HctgRWgw/eQNwZ+rtm9ws95Ui6HfLChpK47K85zm5UW1d
         dB5xsx5exINXJVKsHZSYMG6oaV1FgCEXSES7w9855aGSHsbz2wtjMfqspaYp3B1w4+6P
         XOS5yPF0tK+/361BP6mmlnp3kglzZEwWpld1zTCGzEsrzLIz1hScmOQciYhesAeC2jiN
         kZ5myzIWKRt0xXY4hZEh5Oe+w7nQ2PJva+H5YfZQRg1Fk2bBuGq9u4pujTfSeRr88o6v
         XItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZL/AdIrqcubn1U6a/kqjvBwExmLiwQWSdp5NsKlE2G8=;
        b=KkuZWCPVsRz6zNY/X5LqOB4HoClGFJa/eeHbjmIgGBvFnqyIpH6102U7oMmg/a1Tsv
         rjkw0eyYSA8HlFr4jStOiwtVH94DUiW3ubBw1AHdrnpj5G254U4ryYhupkNoYwPzHfd3
         1X60gJUjepdAD+ajevNcFnO03qrlYrQF3RNBEwuI9BxFS2uS05c8WNgwsjLdjgwbKJm8
         8W+IOs4vC8DVM1yUeNxVZ+WCTJuB58PLB9oWw4HZm7BzD25erXztXfX88ynU/NcqBUOs
         3CLn1KTUon/NrKVNReVSjbojYRpm3IeqQUcneUyWrSPKq2ONpfBb8EgDCCXpseCdi+GY
         7B2Q==
X-Gm-Message-State: AGi0PuYpfeLb7eIfU6cgDTiWE8nCc0ZpJGM4JcsvIa4wABeDvC8RElMd
        e9V0lOTZy3Scq2FlEaUUD5UuaMI2jKDhEc+NVlchbA==
X-Google-Smtp-Source: APiQypImPr+lJTIA0mH628UTAgJvY94phN98qKggSSMZ1EUaSkryiCYaW55QSKAJ8dHKCKIqwgo9tErb1Ayh1BLiZHo=
X-Received: by 2002:a92:cf50:: with SMTP id c16mr8339951ilr.181.1586999726924;
 Wed, 15 Apr 2020 18:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <a5b07aa9-96ea-a9b5-13db-e5dcbd7760e6@intel.com>
 <BEA3CCB8-5127-4E6A-9696-E293C00BFA82@amacapital.net> <CABV8kRxqcCmPKtX3DDOf+47Re1hO1gMeUPhCd6HtDP0-SpcSBw@mail.gmail.com>
 <CALCETrVmsWZ+w6C4RV50DWoL0Qaiy+S6BtXr=QKQEg3MYgAc6w@mail.gmail.com>
 <CABV8kRxfMNxzy8r2P4GKj-22i+GMj=VDfPWAZB-VSgfrsQsjCA@mail.gmail.com> <CALCETrWTDrcynTwpWZ6u6JXRL1rz6_vakLK7=BqMjCPCkQ+9dg@mail.gmail.com>
In-Reply-To: <CALCETrWTDrcynTwpWZ6u6JXRL1rz6_vakLK7=BqMjCPCkQ+9dg@mail.gmail.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Wed, 15 Apr 2020 21:14:50 -0400
Message-ID: <CABV8kRzbGgF4Uc9+VyzBUiH-kGfMALd8tDtjE3hjyE2Z5VD3-g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it make matters easier if tasks with nonstandard XCR0 were not
> allowed to use ptrace() at all?  And if ARCH_SET_XCR0 were disallowed
> if the caller is tracing anyone?

That would be fine by me (as long as you're still allowed to ptrace them of
course). I do think that using the kernel XCR0 is the best choice, but since
I don't really have a use case for it, I'm happy to disallow that and
let anybody who does have a use case come back here and
argue for it one way or the other.
