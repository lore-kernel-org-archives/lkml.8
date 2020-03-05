Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACC3C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6CC20716
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583434306;
	bh=ZC3B/czm5sXyN+zg1eniDW4R7/IH4E7e99uEpDEQv3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FjDGFZ3der+I3+vdWI160JNiK+pYnczQbbmGYP3W5IFQELFwFELwEu1S3NvTmHqsH
	 Y0npqzqXQbGYKp/5dwGuLra6prTKeueLwJ9b7t2b8ebLD7zIx/Q1v/YNQ0Ys3Z8Jyt
	 1t1pCl3MbpsSL30I14N/iPjOcw5WoZsz9sBE/N48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCESvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:51:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37012 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCESvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:51:45 -0500
Received: by mail-io1-f65.google.com with SMTP id k4so2116035ior.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVv6AJd6bBrTXrDKZfvcwskLDNuykZnEwGxDnO6gleo=;
        b=NosQg/dDBPylczuOudsaCOt2Wy3lcV1PT7hKYOVRoSkfJ+eNlJfzNDp8iKCEPyabBs
         7ijGVjmDDkVeHS+mphZq8yulaRZIrDr0ERC2vSfh5WEDhfJi0aWFUsuDUCABp1zGL29i
         GzZi3kYiPM96HwrrhGF/bVmIWhCcRegdRwoRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVv6AJd6bBrTXrDKZfvcwskLDNuykZnEwGxDnO6gleo=;
        b=W5ueEf+2TH3S5R6FZnV4n71YEChhvvwd50SN2dLVfc0PXmnUlm6z+qpdESi5qM0hH4
         diFRmkcju6n1+7cxTW7ju2qXkZ9Sf23y9tqOccQGtdClADJ0LNDiwtl5NcKB+J3UTGQC
         F0/ZDDDVzW6cNfmycxDzTQXbfSg7rL5ECOQFITYf/wn28iU4gfcuK5GLVBKkTlv3/MS8
         lDDxgQ2ufj6Hzct98DFJ4WjRAhCnyXODI9EhiTT5x8b0Qlb+lnIg5Bj9rQGVoiFaqb37
         AeNFLJtUDtXOa3ZiWmVDDFgBMTxvJJdMMOe2hAfgYN4JyuIweDewq5/ifVOQT46Aq99q
         nbbA==
X-Gm-Message-State: ANhLgQ2/JU5JwGpmK8wxHBCmt4m87W/6Fe5ZiHYWeCCZB+r6fGPGHwIA
        ebP9M9p+8qFgC7w/O3fsuwvoSRUrHy56XZaweHQTgg==
X-Google-Smtp-Source: ADFU+vsbcs2QgeYXIqkD+c4bTE0VoOgWuVE+so2YReoLzqoxVPopVlkOtVPt0fcQ4lBq2p8/yZ+g4Aa9dVjEkBhbM+c=
X-Received: by 2002:a6b:ec05:: with SMTP id c5mr376507ioh.107.1583434304466;
 Thu, 05 Mar 2020 10:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20200304124707.22650-1-yanaijie@huawei.com> <202003041022.26AF0178@keescook>
 <b5854fd867982527c107138d52a61010079d2321.camel@buserror.net>
In-Reply-To: <b5854fd867982527c107138d52a61010079d2321.camel@buserror.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Mar 2020 12:51:33 -0600
Message-ID: <CAADWXX8guqt=Yz-Lo+qU6Ed0t-mG-B=UkqSDaSr3bH+Q2aOn-Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] implement KASLR for powerpc/fsl_booke/64
To:     Scott Wood <oss@buserror.net>
Cc:     Kees Cook <keescook@chromium.org>, Jason Yan <yanaijie@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        lkml <linux-kernel@vger.kernel.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 3:16 PM Scott Wood <oss@buserror.net> wrote:
>
> The frustration is with the inability to set a flag to say, "I'm debugging and
> don't care about leaks... in fact I'd like as much information as possible to
> leak to me."

Well, I definitely don't want to tie it to "I turned off kaslr in
order to help debugging". That just means that now you're debugging a
kernel that is fundamentally different from what people are running.

So I'd much rather have people just set a really magic flag, perhaps
when kgdb is in use or something.

> In any case, this came up now due to a question about what to use when
> printing crash dumps.  PowerPC currently prints stack and return addresses
> with %lx (in addition to %pS in the latter case) and someone proposed
> converting them to %p and/or removing them altogether.

Please just use '%pS'.

The symbol and offset is what is useful when users send crash-dumps.
The hex value is entirely pointless with kaslr - which should
basically be the default.

Note that this isn't about security at that point - crash dumps are
something that shouldn't happen, but if they do happen, we want the
pointers. But the random hex value just isn't _useful_, so it's just
making things less legible.

                  Linus
