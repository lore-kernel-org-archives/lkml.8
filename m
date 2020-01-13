Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C1C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571AE20661
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Twb97kuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgAMKlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:41:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55967 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMKlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:41:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so9054083wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 02:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6jcup08EYfdIWJkOanS1mKfEl62Vehirifel7nrZFi8=;
        b=Twb97kuznKKWouAzZb6gfEs94jiWvVsrpQlqIlnqGPt1ci4uSIoG4CHcBwtASDnsQE
         zZyISJxTEMvvvG7LA0UcN9H44LxfCB273dB+3PaIkVQO3lEicu0eGVE5OF7kuatWEF9w
         WIPChvLGCkSxTIEeNln8JWyIbxU918XHophnLmzWhy7xjbW/YWCoisbzOZo+nU8y9KzP
         eRUDH5p8LTe2iYLOtn7+3vBKRWx5O6YDsxdBPmVWhOaAFzvvw8kz5K3p6YJhPAXVAQfh
         kmZc7uLTxQSGNKIkWwa/P05WLQ/BEqZTJIlvCmRc1jEsgKmgHjdvbs6v6atk109YCV3b
         GiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6jcup08EYfdIWJkOanS1mKfEl62Vehirifel7nrZFi8=;
        b=ccaBMIIPEFV76O0Y94NrYg6O/YDJGNs6GOdqABAbZEAiI4cE0Y8Yvw/utwEB9lBeG8
         87gjaLin/rPBJrIjuuzL1jzG87UROfXc6XQux7xODSrC1r+5bPQ7s4y16m73wXBC54V6
         lABiN23LKdnDEWf/JFdwG8kTFtyo1NTwvmuzRjKP4x0rNMbW+JOfjWAkGlNtl63m7wOv
         pPjMnkRtLv+3GRoDrQlwiaAqpZoi/2pptXZcrgjdvZajmshMA876Aymm7rpVgBejQq4S
         tokUNZB7UlAy2rcVUkcHbbtejzC85XeSbxUNrd7h3N47ZH2EcS1NQonnQ5e9z86S6+98
         YVpg==
X-Gm-Message-State: APjAAAWCCGZHSPQea/HTslJUhu53yQyDKEM8TSAg96KgeQRAK6e338GS
        4hmovz6DFx+XnOM3qONcopyclA==
X-Google-Smtp-Source: APXvYqx9YbeI8hRBLildMn6KQTJSQm3o5n+ERet7Ix0GsFULrr+vh/Vn1VdcOQ0Wkyg632JhNTohwg==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr19680976wmf.100.1578912081445;
        Mon, 13 Jan 2020 02:41:21 -0800 (PST)
Received: from dell ([95.147.198.95])
        by smtp.gmail.com with ESMTPSA id f1sm14642899wmc.45.2020.01.13.02.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 02:41:20 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:41:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] mfd: madera: Allow more time for hardware reset
Message-ID: <20200113104141.GC5414@dell>
References: <20200106102834.31301-1-ckeepax@opensource.cirrus.com>
 <20200107142742.GN14821@dell>
 <20200108084640.GI10451@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108084640.GI10451@ediswmail.ad.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jan 2020, Charles Keepax wrote:

> On Tue, Jan 07, 2020 at 02:27:42PM +0000, Lee Jones wrote:
> > On Mon, 06 Jan 2020, Charles Keepax wrote:
> > 
> > > Both manual and power on resets have a brief period where the chip will
> > > not be accessible immediately afterwards. Extend the time allowed for
> > > this from a minimum of 1mS to 2mS based on newer evaluation of the
> > > hardware and ensure this reset happens in all reset conditions. Whilst
> > > making the change also remove the redundant NULL checks in the reset
> > > functions as the GPIO functions already check for this.
> > > 
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > >  drivers/mfd/madera-core.c | 18 ++++++++++--------
> > >  1 file changed, 10 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
> > > index a8cfadc1fc01e..f41ce408259fb 100644
> > > --- a/drivers/mfd/madera-core.c
> > > +++ b/drivers/mfd/madera-core.c
> > > @@ -238,6 +238,11 @@ static int madera_wait_for_boot(struct madera *madera)
> > >  	return ret;
> > >  }
> > >  
> > > +static inline void madera_reset_delay(void)
> > > +{
> > > +	usleep_range(2000, 3000);
> > > +}
> > 
> > Hmm ... We usually shy away from abstraction for the sake of
> > abstraction.  What's preventing you from using the preferred method of
> > simply calling the abstracted function from each of the call-sites?
> > 
> > I could understand (a little) if you needed to frequently change these
> > values, since changing them in once place is obviously simpler than
> > changing them in 3, but even then it's marginal.
> > 
> 
> I don't mind manually inline it, we don't plan on changing the
> values very often certainly. It really was just to avoid future
> bugs if someone adds a new place that needs the delay or does
> indeed change the delay. Would you mind if I used a define for
> the time instead, if I am manually inlining? That keeps the same
> single place to update, but without the extra function.

That would be my preference, yes.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
