Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381A1C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F002073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTYiiw3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgAQNlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:41:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44516 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgAQNlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:41:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so22758370wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 05:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GcZb4xy6ZyhyYGDUt5837z6AQgG8YRO7IyEEfNPumZ0=;
        b=jTYiiw3De4JIpE0kvJsG3viHnTrL4mYP6IcmOYyhAlSSW+3UxOUfwB+R5mbA7nmzkJ
         hsYzGxmDtAIBxHo1tbwpMSm4mIGIlChRiQLBtTFQUEwhf9h6wE2TxZeRfztZtCq+cFlg
         QBOY7fdCWCKvFfH7VBJlC3XRCD+8/mCjtWaNKKLvNVcLCNNt+dEom6xSTfh1k2rdqJat
         l7N6x7+dsiwVCRWd/cxJ7pRFQxoBnAlaFZFNa3hHpMxoqwQRZI6e5eDDbdBApEv6880l
         ne5y1zcObcCEolGlmjxKzHq3imb349OxpZggYhkgqcqENJix8k5I1wR8N8pVhHUqJo0K
         0Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GcZb4xy6ZyhyYGDUt5837z6AQgG8YRO7IyEEfNPumZ0=;
        b=sSpGwhSj5PthZvGeosaqiFUT69xpy9IgfFbB+2I5GXkhJtAbG6b3gS22CXafeGfAbK
         aaFUG3SRXMGjGpFd38q8cYWxho2Gz84hjfVgm0eZsiYYO14wjvNfUM+1a08QvkHm+5Ie
         N9yLnauU/eVgpdN3F0Ftx8JS+G3Yq69iyEKP5cQlA/5Lk1afXG+72S1gRla98otBhhkd
         UBSqsi++aXsthEf1Weytl+lsvFIk7iqdCDPi5UxEJeFHrPqke+q7ND5KRTFci9myNuNX
         SKVqRySa5in44xWIsXfd42c6d7mLb0FM2fqt+mMpOgtYBn9IRpc4FCW2Zd6tR7RmCXJJ
         P26w==
X-Gm-Message-State: APjAAAUl665Pe6ooufopYm0Q3iQwa4ClpyWOmW99FTwswE4WnSz96ZQ3
        OY4w758VuZYbK1ZRhps7fCtrC4Q9VmM=
X-Google-Smtp-Source: APXvYqxqngVy4Kzykkotny3rt+MjstUka/CA8kZllavIWXpUgiGeBCvQ7LOpZEjYUEGiWESALEKHLA==
X-Received: by 2002:adf:e887:: with SMTP id d7mr3058845wrm.162.1579268494194;
        Fri, 17 Jan 2020 05:41:34 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id w83sm8977770wmb.42.2020.01.17.05.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:41:33 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:41:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH] mfd: ab8500: Fix ab8500-clk typo
Message-ID: <20200117134152.GN15507@dell>
References: <20191211114639.748463-1-linus.walleij@linaro.org>
 <20191216152240.GG2369@dell>
 <CACRpkdYQjXyFZfwpk8y66R2XTSm5fEMCb-s-WzPt0KegsCptFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYQjXyFZfwpk8y66R2XTSm5fEMCb-s-WzPt0KegsCptFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020, Linus Walleij wrote:

> On Mon, Dec 16, 2019 at 4:22 PM Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 11 Dec 2019, Linus Walleij wrote:
> >
> > > Commit f4d41ad84433 ("mfd: ab8500: Example using new OF_MFD_CELL MACRO")
> > > has a typo error renaming "ab8500-clk" to "abx500-clk"
> > > with the result att ALSA SoC audio broke as the clock
> > > driver was not probing anymore. Fixed it up.
> > >
> > > Cc: Stephan Gerhold <stephan@gerhold.net>
> > > Fixes: f4d41ad84433 ("mfd: ab8500: Example using new OF_MFD_CELL MACRO")
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > >  drivers/mfd/ab8500-core.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Applied, thanks.
> 
> For some reason this patch doesn't appear in mainline or linux-next,
> I guess it fell off the planet somehow :D
> 
> Or do I look in the wrong place?
> 
> Lee, could you look into it?

It was there, just not pushed in a while.

Pushed now, should be in -next tomorrow.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
