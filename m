Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E58C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9100A23126
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwGGIzfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgEMIBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgEMIBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:01:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3348C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:01:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l17so6063558wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qOmmunlWx5TbxpEYsCi6LXm1KoaU+vaRN5iuBeMyAvA=;
        b=wwGGIzfhjfM9NgXhcpJu8mIl16HfUpZxpzVQ0jfZyEuuJGGHo6S3WyOm4VQNJqtNJ/
         Zz93RR+VCNEoT+QCqEzG2uAUgNhcaMiybCUp+DobkeU64t8Za/EyWgGHc9O6Lx3oOsNM
         TPIQ/1bNv/yAs6qveLsyOUaJqV9S+l0LnS4N4ndUR6IBwgVktAZUDeGPg7lDs/1TbkiZ
         pizBletTSn7fUiS6rRNQXESiQuNFvoYgScCVqHaNRqRbl4ZwuzRVNOOOxtYuf6WvO1Ty
         thsS1053p4825+Sh7yU70apSzy1Va35O3gTFABx8YTEocfHcEsW9hfxnvgtZ1lcPFeY9
         umjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qOmmunlWx5TbxpEYsCi6LXm1KoaU+vaRN5iuBeMyAvA=;
        b=KeYlTNQheZU1/OQIJngPWkxyf297qhBogsc0U3eP9vMpHVHtvqBzRzETPT77m9FV39
         3RfkdkprwQexy7OafeMb/M0jUOdlokMra4W3aF6lSvvb4oWPu5/mD1/yeSfcXtGBfN+L
         dAI4oUKvgBYy3XdGJbPJa35UVcz/NX+bff/nDo0SWsIp+Hf+Sv3ls8VuEg1WF7wtbXxx
         aIzHmnyZVXlk4xiUNGtzI9m+FCUwbe51zxNeruYcVoJjV2qHDsgLauz1mBirCjOzo3KC
         H/b97ZHQkD8I+fiWtW/uN0dm6JlUvmRe878OD9JEpwWNGAGnVjjsAuI7uMhzL0FXkrB2
         IY+Q==
X-Gm-Message-State: AGi0PubFx0R+oiE8CvuxCY/x5gg4QLeqwFPrzZ5mfYJQ+CHpqK0ppssF
        qPRvBXrU7EdeLkQI9gmn7Sx5WA==
X-Google-Smtp-Source: APiQypLqRksq0eSlol4tSTwedgyaTVM2PgFckTaG8ma5JptZgQpiUumnGNrPnWn12cdi9hLSZsxIVQ==
X-Received: by 2002:adf:80d0:: with SMTP id 74mr15451539wrl.338.1589356862397;
        Wed, 13 May 2020 01:01:02 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id c25sm33770259wmb.44.2020.05.13.01.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 01:01:01 -0700 (PDT)
Date:   Wed, 13 May 2020 09:00:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] video: backlight: tosa_lcd: convert to use
 i2c_new_client_device()
Message-ID: <20200513080059.GD3548@dell>
References: <20200326210959.13111-1-wsa+renesas@sang-engineering.com>
 <20200326210959.13111-2-wsa+renesas@sang-engineering.com>
 <20200417101446.GB3737@dell>
 <20200512162546.GG13516@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512162546.GG13516@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020, Wolfram Sang wrote:

> On Fri, Apr 17, 2020 at 11:14:46AM +0100, Lee Jones wrote:
> > On Thu, 26 Mar 2020, Wolfram Sang wrote:
> > 
> > > Move away from the deprecated API and return the shiny new ERRPTR where
> > > useful.
> > > 
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > ---
> > >  drivers/video/backlight/tosa_lcd.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Applied, thanks.
> 
> Thanks! I don't see it in -next, though?

Just pushed.  Should be there soon.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
