Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F775C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3696D24681
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Om+3agWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgAQKJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:09:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36626 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgAQKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:09:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so22111879wru.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 02:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YISpyKpQLeyZzuM7GvuVJ7EJ8elz6lBBgLI3G6qJUsI=;
        b=Om+3agWx46v380MyT9qje7b/bQzpX0c/qhvN22fywDLm1tTCm2GcXoYQ2lCUebzlgj
         3yCWrKdYDnUKiF9C/Rl//6Jls4A8WD/DloB3kmzerntdReN50d6xl42Jc9uogVPAoPor
         OuvmwQXwvrKcSpE0pJ39dVTZx1Fm3qmAVT4THCgI1y9k/yN7EFRcBeg1CH8lmF3nDwcK
         8D77pMvun+tUB3cx9FAs0Z0kpLv2ZKDCxfMbA2gOQ8y+QAAQS6LT/8U7pW6qLZegb2G3
         PNXNu3euC1TTSJ0Wdc9eer67lT/9qPZH9pYOMNEkBVTttE2l0Cpxb64y3CIeMobWjFfb
         LfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YISpyKpQLeyZzuM7GvuVJ7EJ8elz6lBBgLI3G6qJUsI=;
        b=FRMZ+49qhX51CpnXKXOoYRfPI4RLExxhJf1wpecwKhKVBKzBNoI5UjULFlauPdSz03
         dmo0fHtH8OeEIoH62EusYF2X0nIOjGlxn94E+5yK8pUJY3ZPkDw0gg02FOIDWeIqv5Z6
         4xgUwrtHpp6SimMyMNGhvKuKsQG5oEMoris+nbCFaLis1zlmwfTHBK7dj4hnQQFgseMw
         PnTLbKaui8EVTlJLyrkYQdNUgcLozUuXqxbgahJFk8RbHogwyMOgBC1J4ZicJQWium/B
         fI+KDUlR/Hdn7fHO2r/NZ36zK472zPdxH5N+CFdGvRWdAzFqVOYxnGGZ27+VWCwHwBlw
         tzBQ==
X-Gm-Message-State: APjAAAX+T6g5VFXDw05RUBUUVR2hOxOeWcjCaSqzYYpPXc/mh7vWzID1
        VLReDQqIIzCoUMrSynSBh3FadDJLCQ0=
X-Google-Smtp-Source: APXvYqxqEtLipEsHaogoR2jMoOo5aO/vN4KHKR3WBBi6RlhbAW3j19TXXptHwp0RyDPCHGXRHpnrbA==
X-Received: by 2002:a5d:6089:: with SMTP id w9mr2243772wrt.228.1579255791363;
        Fri, 17 Jan 2020 02:09:51 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id 5sm33493552wrh.5.2020.01.17.02.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 02:09:50 -0800 (PST)
Date:   Fri, 17 Jan 2020 10:10:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] mfd: bd70528: Fix hour register mask
Message-ID: <20200117101009.GC15507@dell>
References: <20200115082933.GA29117@localhost.localdomain>
 <83e8e1ecc40a58e2e6d1960bbb41c8dcfe730ce1.camel@fi.rohmeurope.com>
 <20200117075714.GA1822218@kroah.com>
 <b5835b0fe842a01888d66c07281e13fc64c2c9ef.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5835b0fe842a01888d66c07281e13fc64c2c9ef.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020, Vaittinen, Matti wrote:

> 
> On Fri, 2020-01-17 at 08:57 +0100, gregkh@linuxfoundation.org wrote:
> > On Fri, Jan 17, 2020 at 07:44:07AM +0000, Vaittinen, Matti wrote:
> > > 
> > > Is it possible to get this in 5.4 stable - while leaving this out
> > > of
> > > current MFD tree and applying the BD71828 series to MFD?
> > 
> > We only take patches that are in Linus's tree for the stable tree,
> > unless there are very big reasons not to do so (i.e. it is totally
> > rewritten in a different way there.)
> > 
> > Once the change/fix is in Linus's tree, then you can backport it to
> > stable in a different way if you want, but you need to give lots of
> > reasons why it is done that way.
> 
> Right. Thanks for the explanation Greg. I have no _strong_ reasons -
> which means I'll split the RTC support patch in BD71828 series into two
> - first of the patches being this fix, second being the BD71828
> support. Then this fix can be taken in 5.4 after it has been merged to
> Linus' tree - the BD71828 support can be omitted from 5.4
> 
> I hope the BD71828 series could still make it to next release - but if
> it wont, then it might be in next after that :]
> 
> Lee, please skip this one, I'll do v10 of the BD71828 series where this
> fix is included as separate fix-patch.

Will look out for it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
