Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87339C4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577FF20801
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGEEl7rm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgBZRqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:46:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34319 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgBZRqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:46:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id z15so4214259wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UlkKnDdC74Y3bgeE6cEbPgpR1UfcBBF9OT0zkr0EUcg=;
        b=BGEEl7rmEJYfaMnxUESPvUOgeSbE0vRSPk4AeQjFIwdfBqYXStXjR+rObFWAaQbqg1
         bdOXNcZYOR+hFebyfy7thu2k30LD1Epy2eOgsjn2SuwHoRCJF0Kr0DjH22TAgWxY41Dc
         C0PcGYnjSiPRM14Hw2u0Z+2cwUCdQyjwFvYmSiRwtnHdOIcJvaLybuk0VDxnmE+PZJnn
         4QRNIzz04bdlHohCuatcxOucvZ/Blllhhelky/i5lwYCXd4SKOspi5gFSfrWYCblUndd
         xEShQS4T63fHgE3ImaZRxkrl8P2+FnSF52tCc/zApvyPYTpmoo/A2s2FttSQYn0waYFI
         xy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UlkKnDdC74Y3bgeE6cEbPgpR1UfcBBF9OT0zkr0EUcg=;
        b=JzH07hYoUZJTO1iaYglmDUqHmYZ+sF7Wxn3Hy5jjOXjCnKamqS5EsDRJTog7RAdXVi
         K5qDaPRwlMU+w7q/4+s1QoT7V90XwMCeY3iJCO6sPGAXOwWjpZcW++0jlC1NoIW00Zti
         nu15jfUvmvrWyEjlZrpp4gFQ85MtysD3/Y4/VYfzm0r2IYjNJC5pqamQq9t5ii1FkrzE
         wKdfZFW0gAJHy2Ja+ewAMsFhkSh5CPdQKl6C2jPltEMF9ZB6UkJ69V5k29R/eBU+Mvym
         HMuNrvvLHtBT+lOO0Yimr2yceHODTsBWiwVTqXd/FO/sLYIZam049I+0IWzuDu4cjCFz
         TOfA==
X-Gm-Message-State: APjAAAUPOsMcGG83zBXAmcG4SH4KQoaEnyPkVY8+2jhv06Bmgtm+nRrE
        4cjl+MlsuRgcySixseA/qtKzhg==
X-Google-Smtp-Source: APXvYqznWapegakHJtPU90RjlpTQd/0Tw1lU93h5a+hpgxjq61bdBeFBGzJDvg53TH5tsUPPbp4LDg==
X-Received: by 2002:adf:fc12:: with SMTP id i18mr6690147wrr.354.1582739168790;
        Wed, 26 Feb 2020 09:46:08 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id d76sm3849939wmd.39.2020.02.26.09.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:46:08 -0800 (PST)
Date:   Wed, 26 Feb 2020 17:46:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org,
        jic23@kernel.org
Subject: Re: [PATCH v5 1/2] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200226174640.GR3494@dell>
References: <20200223131638.12130-1-andreas@kemnade.info>
 <20200223131638.12130-2-andreas@kemnade.info>
 <20200226154055.GQ3494@dell>
 <20200226174914.047667d5@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226174914.047667d5@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, Andreas Kemnade wrote:

> On Wed, 26 Feb 2020 15:40:55 +0000
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Sun, 23 Feb 2020, Andreas Kemnade wrote:
> > 
> > > This adds a subdevice for the ADC in the RC5T619
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > depends on:
> > > https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/
> > > 
> > > Changes in v3:
> > > re-added it to the series because of
> > > "Oh, it looks like there was a conflict.  Could you collect any Acks
> > > (including mine) rebase and resend please?"  
> > 
> > Looks like there is still a conflict.  Sure, it's not a complicated
> > fix, but that's beside the point.  What tree is this set based on?
> > 
> It must be applied on top of my rc5t619 rtc series here:
> https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/
> 
> I expected it to make it into 5.6 and when I first sent the RTC series
>  (in October) I had no idea when I will continue with other stuff.
> 
> That is why I sent this ADC series separately, also to give the IIO
> maintainer plenty of time to review. 

If a patch-set can or should be applied on its own, you should send it
based on an upstream commit, or else things like this happen.

My advice would be to maintain topic branches, each based on an
upstream release, which you can merge together into an integration
branch for full coverage testing.

> Do you want me to resend all that pending stuff together in one series?
> I have little experience with this multi-subdevice process.

It makes more sense to rebase this set onto the latest full release
and resubmit this set on its own.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
