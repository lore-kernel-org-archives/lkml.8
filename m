Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF83C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BE9206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GAE53uYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgA3PYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:24:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40540 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgA3PYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:24:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so4699704wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 07:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uCTyhmKfdCccEwrQOk0fVUnBISB3jTONcHNxq4l7HIQ=;
        b=GAE53uYi8uNfimoEBeIe2ka9cIt2Yi7okRCaue0wCs02Aay3LXYm1KuY0f7kjsGk8m
         mVYH4gH0VtIAkP2DbDvbTOxs7lDoU+k4qg6Hpvgh1VQj/sz87rO+5MzPc16TKLneHxAe
         vX7hVaE0rMHJ6SHmzhENpiswfo1damQwpAiLunNvhWmDT8meLHMWnr0Nc1jf+5MaBwFA
         M5pgkegtoWH+ElLSoYNrtmiM63BvQIhAbH3t1Dq5ZRMkwc0jQ1NOtvaECMtFm71OB4nt
         RwxPMVsedy2W/sWW9qyfu4rOolgoFiG+7eRRNQdzsT/4bL5Z4TEbU56L1QHXD/fvK50Y
         890A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uCTyhmKfdCccEwrQOk0fVUnBISB3jTONcHNxq4l7HIQ=;
        b=uSJkTyrF5MgwSfDmQSfy95aM8BiUXqkqp34jk3eE33vDbCbTp2lGXF4c7L3rKTKQfO
         sFRhjISwkSHQiHGpcWHhDzqYmumi2Bo4bXYg+PVZL16XXFKf8usFrMpJqDjSpV1K/fNA
         eHFThZS8ixdvcQwdw0pbsogKU2Wnw3Wqk8aJmTEGGfFC7P6CPDlTZnGl0pYYp4djWo1k
         xWn3/IppkWWp2LfEZMNJ2Uqs3c18Zlt8UaoC+KTXkdcyaRlMyBqPvwNJiMjFkx3Bin2r
         9UH+2pXulZltP8DeKJXcTP6tkGafUbBFYzdLDuZVp7an4DTrIq2AB4T/DICgTTZbOhse
         NHIw==
X-Gm-Message-State: APjAAAXpHiUP/vdHirvQpcUXwppF4F7TCrnzXM5PS6xrfNpnk0w5blyN
        CQn5JXayKThKZH1rAvogCH6eory7w7k=
X-Google-Smtp-Source: APXvYqwxpI2o0BEjEnRg2CnCAJWdOYjl4LYpZxuWWPxFiWIUDxm9OQLSE1VAz1ozZ1pt/vylMAG+Eg==
X-Received: by 2002:a7b:c8d3:: with SMTP id f19mr6118273wml.26.1580397855622;
        Thu, 30 Jan 2020 07:24:15 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id p7sm6523547wmp.31.2020.01.30.07.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 07:24:14 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:24:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: rn5t618: cleanup i2c_device_id
Message-ID: <20200130152428.GD3548@dell>
References: <20191211215731.19350-1-andreas@kemnade.info>
 <20200128194555.324cff21@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200128194555.324cff21@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020, Andreas Kemnade wrote:

> Hi,
> 
> just re-checking the patch again. Seems that I have added it on top of my RTC
> series. It breaks because of...
> 
> On Wed, 11 Dec 2019 22:57:31 +0100
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
> > That list was just empty, so it can be removed if .probe_new
> > instead of .probe is used
> > 
> > Suggested-by: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/mfd/rn5t618.c | 11 ++---------
> >  1 file changed, 2 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> > index 18d56a732b20..70d52b46ee8a 100644
> > --- a/drivers/mfd/rn5t618.c
> > +++ b/drivers/mfd/rn5t618.c
> > @@ -150,8 +150,7 @@ static const struct of_device_id rn5t618_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, rn5t618_of_match);
> >  
> > -static int rn5t618_i2c_probe(struct i2c_client *i2c,
> > -			     const struct i2c_device_id *id)
> > +static int rn5t618_i2c_probe(struct i2c_client *i2c)
> >  {
> >  	const struct of_device_id *of_id;
> >  	struct rn5t618 *priv;
> > @@ -251,11 +250,6 @@ static int __maybe_unused rn5t618_i2c_resume(struct device *dev)
> >  	return 0;
> >  }
> >  
> I added the pm stuff above ...
> 
> 
> > -static const struct i2c_device_id rn5t618_i2c_id[] = {
> > -	{ }
> > -};
> > -MODULE_DEVICE_TABLE(i2c, rn5t618_i2c_id);
> > -
> 
> and below it in my RTC series.
> 
> >  static SIMPLE_DEV_PM_OPS(rn5t618_i2c_dev_pm_ops,
> >  			rn5t618_i2c_suspend,
> >  			rn5t618_i2c_resume);
> 
> Do you want to have it rebased so it can be applied first?
> Sorry for the confusion here.

You may as well wait until -rc1 is out and rebase on top of that.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
