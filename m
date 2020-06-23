Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8768EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5840D20707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3M0SxSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbgFWNrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732658AbgFWNrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:47:00 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C07C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:47:00 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x62so12025550qtd.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yB7mBYOb5pHmRDyADOswCcoM+Wao7KTnBuR1N0wTjcI=;
        b=r3M0SxSQyPOiFsM6AdXBkzfLEs0ccEX18X/VK2sm+iGNVloEXppIt21C4F2MZzwn7J
         Q4y4dfqn36aZt0P5k7RBV8CcmPHacaOttgozh0h8rsivQWB5SBBxlJH/GRjBsQdWgzWm
         ieswkemih+o7RJ2R9TNfVB1VxiBfGv5kLAHQ1OkXAps/j8pqE2dfBYoUAgw4zm/kH2G+
         YajKfaNjM1h8JWGxm43c393ZFVL/MExnBiP2++QrD+tnHKthwzOB6l2MNGwF29PWKtwW
         fdUVrXiLowep1hUjoykGwAKJ3rAM2Y8OgXlosAq/j/N0vHaAo0V0L17r/8kt9V8H2J36
         7ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yB7mBYOb5pHmRDyADOswCcoM+Wao7KTnBuR1N0wTjcI=;
        b=mmR2ydL5SYWdr++cWja7BblUrtLGBQGTDrhb2ewtqbAPf2hBG2kFZK0agYnLwE57um
         zO8bgpG5I4B9N+WZN5B/pFCBQX00rN1r2WzTfo7p7/dp/QZNoV9h7xzlXL+A5EAnzJ48
         POMInPRcNyeG07IStTy/uH9H/ku7yDtHVBlT/AocXIUtPBb5jU+obq3w0k90VeoVkMNN
         B5c1WC4xgN5RgXc4A2kTRWbJJYziZlO+8M5liRHLzoFj6ArZSCzZ/ox4Q/rABiNDwbNN
         oWA+Ns8STulxy6lJUl/XspCWTAtUAoZctYPZqc3iYe/XQ3tgJiBKdWM2uDIMEeWr7P4G
         u0RQ==
X-Gm-Message-State: AOAM530Gz136ldnNtIi6eIhmaGq5OmnaL52SJ8Q8Gj2cIBbaYR6rGDBG
        v7iiuYP2Zb28HZGlfjltswg=
X-Google-Smtp-Source: ABdhPJzE3SVlL/lDweknKn10aGqC2G3tm9SJivoOuqHOvgHrqy8VOjOJLe7+dKq85lzF81Ji1OXKJA==
X-Received: by 2002:ac8:4d44:: with SMTP id x4mr1288201qtv.34.1592920019691;
        Tue, 23 Jun 2020 06:46:59 -0700 (PDT)
Received: from localhost.localdomain (209-6-208-110.s8556.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.208.110])
        by smtp.gmail.com with ESMTPSA id o6sm600754qtd.59.2020.06.23.06.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 06:46:58 -0700 (PDT)
Date:   Tue, 23 Jun 2020 09:46:56 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ibft: Replace zero-length array with flexible-array
Message-ID: <20200623134656.GB5499@localhost.localdomain>
References: <20200507185544.GA14695@embeddedor>
 <20200521183235.GA29907@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521183235.GA29907@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 01:32:35PM -0500, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this?

It is in the tree. Let me send out a git pull to Linus in a week or two.

Thanks!
> 
> Thanks
> --
> Gustavo
> 
> On Thu, May 07, 2020 at 01:55:44PM -0500, Gustavo A. R. Silva wrote:
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> > 
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> > 
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> > 
> > Also, notice that, dynamic memory allocations won't be affected by
> > this change:
> > 
> > "Flexible array members have incomplete type, and so the sizeof operator
> > may not be applied. As a quirk of the original implementation of
> > zero-length arrays, sizeof evaluates to zero."[1]
> > 
> > sizeof(flexible-array-member) triggers a warning because flexible array
> > members have incomplete type[1]. There are some instances of code in
> > which the sizeof operator is being incorrectly/erroneously applied to
> > zero-length arrays and the result is zero. Such instances may be hiding
> > some bugs. So, this work (flexible-array member conversions) will also
> > help to get completely rid of those sorts of issues.
> > 
> > This issue was found with the help of Coccinelle.
> > 
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/firmware/iscsi_ibft.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
> > index 96758b71a8db..7127a04bca19 100644
> > --- a/drivers/firmware/iscsi_ibft.c
> > +++ b/drivers/firmware/iscsi_ibft.c
> > @@ -104,7 +104,7 @@ struct ibft_control {
> >  	u16 tgt0_off;
> >  	u16 nic1_off;
> >  	u16 tgt1_off;
> > -	u16 expansion[0];
> > +	u16 expansion[];
> >  } __attribute__((__packed__));
> >  
> >  struct ibft_initiator {
> > 
