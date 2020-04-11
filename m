Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D456DC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC1820753
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4puwzcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgDKBzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:55:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46562 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgDKBzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:55:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id k191so1703655pgc.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 18:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E2bgb+oAffEcAeqUQQsolpBF7Sog6SMgq/QFxjAFZ7E=;
        b=m4puwzcBIV/VTFWnJGyENhqTPmhh4XIOMy47RIuxV3TKzVlyumWFjMN9HtMR74j2f2
         +j8ruJBuoZ0lLzLmd9NxBi9pF4uNP+PD+d4mnP3TwvGQ5ElZ7lvJ/HDm5dfPKTz0do70
         dIpHKSiAG8+AwMyNZY1ttFNPS7rGbeicOe20eIBQOVGifuXE/qlSfZZpIr6UMgYQZIYj
         EHGn+jkROhii88gOcXrQoTbb6Pp4/2zcfW5+wosyvg04Vk77na1lBARiI++l9oLnBMNo
         h84Jx3Q4m9J2sDA0/szn6lX+oiUtqH0cZtoHdCrL7NG8jOjElCbm5DbCRTzUr64xt6ew
         gqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E2bgb+oAffEcAeqUQQsolpBF7Sog6SMgq/QFxjAFZ7E=;
        b=lyIh9STSz4Ne9QrJGZ1iO3eAn6n9gCXCtqD3dZyxuUTiBB/DxHpKjVjS5GEIp4CSJN
         7TA/XtZlml6V5lX/+TMkmEFrF6GvFN10ZYkybDH9l8ox8+jgxQcm7iRxhvDsq0E+KR81
         pjWITqGdA57WRM+FzY1YKTDf/HeBnN4/+Xmc2XpoZw5rkeJbJHJc3OZfWXWvLn0s/PlJ
         b0SzoGOnVE4yUXjqS4FLlkphYNgNlXZ4opDbQ3vdegYJw/y6CDROPr39nHtv/rWSxuYK
         HlUD0dmqZ4fFI3dc9aHdl2Vr7iGNVCke66gCLnVBg6H18VAMVszbqd4u+FW8jW8UdVh2
         GODg==
X-Gm-Message-State: AGi0PubIMA0WkP0hCgc1jbwIBf7wjdQMjWmVgHdUcv4VK4VynnBtiAMB
        cGNbDBfHJxft3DCN6lg022GpMJ5NV9k=
X-Google-Smtp-Source: APiQypIgjtE6PdNfV7oGEV7Cgn7+5O3AAkZ7ITrRrIrJTS4dpVhLJsBaF7xVSidhIcDKmzrrwznL5w==
X-Received: by 2002:a63:4625:: with SMTP id t37mr6712802pga.83.1586570113100;
        Fri, 10 Apr 2020 18:55:13 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m11sm2830542pfh.57.2020.04.10.18.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:55:12 -0700 (PDT)
Date:   Fri, 10 Apr 2020 18:55:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] remoteproc: use filesz as backup when translate
 memsz fail
Message-ID: <20200411015522.GK576963@builder.lan>
References: <1586420572-28353-1-git-send-email-peng.fan@nxp.com>
 <1586420572-28353-2-git-send-email-peng.fan@nxp.com>
 <20200410012226.GV20625@builder.lan>
 <AM0PR04MB4481B8AA8ADB836ED8398ADF88DE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481B8AA8ADB836ED8398ADF88DE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09 Apr 18:32 PDT 2020, Peng Fan wrote:

> Hi Bjorn,
> 
> > Subject: Re: [PATCH 2/2] remoteproc: use filesz as backup when translate
> > memsz fail
> > 
> > On Thu 09 Apr 01:22 PDT 2020, Peng Fan wrote:
> > 
> > > Since we no need memset if memsz is larger than filesz, we could use
> > > filesz for the da to va translation when memsz translation fail.
> > >
> > 
> > To me this implies that the firmware has a segment that's larger than the
> > memory that it's going to run in. I think even if we're not writing to the entire
> > memsz, asking da_to_va for the entire memsz provides a valuable sanity
> > check.
> 
> da_to_va implies that Linux should have the va map to da. However
> that will be case that Linux is not able to touch all da, it only able touch
> half. Then Linux should also map all da?
> 

So you have memory described in your ELF that can only be accessed by
the remoteproc? And this memory is covered by segments of type PT_LOAD?

What's your strategy for making sure that filesz stays within the
boundaries that the ELF loader is allowed to touch?

Regards,
Bjorn

> Thanks,
> Peng.
> 
> > 
> > Regards,
> > Bjorn
> > 
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/remoteproc/remoteproc_elf_loader.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_elf_loader.c
> > > b/drivers/remoteproc/remoteproc_elf_loader.c
> > > index cc50fe70d50c..74d425a4b34c 100644
> > > --- a/drivers/remoteproc/remoteproc_elf_loader.c
> > > +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> > > @@ -229,8 +229,16 @@ int rproc_elf_load_segments(struct rproc *rproc,
> > const struct firmware *fw)
> > >  		if (!ptr) {
> > >  			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
> > >  				memsz);
> > > -			ret = -EINVAL;
> > > -			break;
> > > +
> > > +			ptr = rproc_da_to_va(rproc, da, filesz);
> > > +			if (!ptr) {
> > > +				dev_err(dev,
> > > +					"bad phdr da 0x%llx mem 0x%llx\n",
> > > +					da, filesz);
> > > +				ret = -EINVAL;
> > > +				break;
> > > +			}
> > > +
> > >  		}
> > >
> > >  		/* put the segment where the remote processor expects it */
> > > --
> > > 2.16.4
> > >
