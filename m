Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80E1C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A0E2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="boKpOa5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbgAXLAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:00:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41126 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgAXLAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:00:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so1433163wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 03:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pvVTcmdkHq4QrYZRiMMxNdIvg0TySYTHHMAhoBk2JiQ=;
        b=boKpOa5UJJStmfYHjgjPvdfpxPD1HCiWrCiMe1wbK3CSnqaFBBg4CsDasj9QBjWFWF
         ZmOhJq0xlnEru86tarsw3nKBy8N3p4JW793PtefCyK25rbeipXYc4/LqFTY9ASin0O2u
         v/j54jVpe3efFhzGxuSs1dbwgZym+48Ie5wR6EiMKpoM5hPQz3CKiTSBngH7dQwm9S5T
         6HKWv6OSEEtHOkTen+cJE/0o2v3ERK6S92xLdUixzgggHn3dxrQJAGdsFiFVEzUtMLMD
         iIDKLLa0H0M61U5HhK4kZ2xx3TYQ6gk6V1/E1HP8sdv5gn2RIDVu3WpBeKb9jCMyEdPq
         iaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pvVTcmdkHq4QrYZRiMMxNdIvg0TySYTHHMAhoBk2JiQ=;
        b=k65tRSnOEENi0BM2UijFYushpWBfuySxdIZ8YLrg73raeXcVe31qce5VfZO+eMzc8d
         3NK887MRVcrFyYae9vmqEH9QXQa4BamMHW5F1fXh5ZYMVBi3UTedF7wXJhPAAzypmgm2
         m+m7rTLek3IFRhodQNQuFm0hhumHHOd2Y0692AqSVJ5r9fvWxmWVgNhx2zfYT0HrXRNR
         bEtDQNyNLjGuD0POjZnPhPFMZEWP5CXu6AcAlFdobm+BndSDg9l+0Aawo3BbAHWfNR70
         WwCHOL5eszCDHoIx0JJoAUzq9e2J/5ZAIyPTvVRIYJAY7F6wFIl4jpwdbTk53JIRDw9h
         0OOg==
X-Gm-Message-State: APjAAAXfYaqQpDMUQCqMbiKmqndn9mYa0/Xb/FaC4bxpkw4NR4VH18vo
        ZFuS9XCe6p5HclHTBC78Vt2LJksOzes=
X-Google-Smtp-Source: APXvYqwItrU1nQnB007oBxkHF4j67xd8TpR3rTt3vVb6twgjBG1+0pPLWD6tmOApucF5G/UHU+VXNg==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr3606877wrs.184.1579863606189;
        Fri, 24 Jan 2020 03:00:06 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id v83sm6388079wmg.16.2020.01.24.03.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 03:00:05 -0800 (PST)
Date:   Fri, 24 Jan 2020 11:00:18 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Helmut Grohne <helmut.grohne@intenta.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mfd: da9062: enable being a system-power-controller
Message-ID: <20200124110018.GR15507@dell>
References: <20200107120559.GA700@laureti-dev>
 <AM6PR10MB226306BDE8575CED80071148800F0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200124085310.GA27231@laureti-dev>
 <AM6PR10MB22636902FCF576272AC8F373800E0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR10MB22636902FCF576272AC8F373800E0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020, Adam Thomson wrote:
> On 24 January 2020 08:53, Helmut Grohne wrote:
> > On Thu, Jan 23, 2020 at 04:51:37PM +0100, Adam Thomson wrote:
> > > I have concerns about using regmap/I2C within the pm_power_off() callback
> > > function although I am aware there are other examples of this in the kernel. At
> > > the point that is called I believe IRQs are disabled so it would require a
> > > platform to have an atomic version of the I2C bus's xfer function. Don't know
> > > if there's a check to see if the bus supports this, but if not then maybe it's
> > > something worth adding? That way we can then only support the
> > pm_power_off()
> > > approach on systems which can actually do it.
> > 
> > On arm, machine_power_off calls the pm_power_off callback after issuing
> > local_irq_disable() and smp_send_stop(). So I think your intuition is
> > correct that we are running with only one CPU left with IRQs disabled.
> > 
> > I have tested this code on a board with an i2c-cadence bus. This driver
> > seems to use IRQs for completion tracking with no fallback to polling.
> > I'm now puzzled as to why this works at all. Given that I'm using
> > regmap_update_bits on a volatile register, it would have to complete the
> > read before performing the relevant write. Nevertheless, it reliably
> > turns off here. So I'm starting to wonder whether there is a flaw in the
> > analysis.
> > 
> > I also looked into whether linux/i2c.h would tell us about the
> > availability of an atomic xfer function. Indeed, the i2c_algorithm
> > structure has a master_xfer_atomic specifically for this purpose. The
> > i2c core will automatically use this function when irqs are disabled.
> > Unfortunately, very few buses implement this function. In particular,
> > i2c-cadence lacks it.
> > 
> > So I could check for i2c_dev->adapter->algo->master_xfer_atomic != NULL
> > indeed. Possibly this could be wrapped in a central inline function.
> 
> Yes, I'd be tempted to make this a nice wrapper function to hide the
> particulars, were someone to implement this.
> 
> > 
> > I concur that quite a few other drivers use a regmap/i2c from their
> > pm_power_off hook. Examples include:
> >  * arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c (i2c without regmap)
> >  * drivers/mfd/axp20x.c (regmap without i2c)
> >  * drivers/mfd/dm355evm_msp.c (i2c without regmap)
> >  * drivers/mfd/max77620.c (regmap and i2c)
> >  * drivers/mfd/max8907.c (regmap and i2c)
> >  * drivers/mfd/palmas.c (regmap and i2c)
> >  * drivers/mfd/retu-mfd.c (regmap and i2c)
> >  * drivers/mfd/rn5t618.c (regmap and i2c)
> >  * drivers/mfd/tps6586x.c (regmap and i2c)
> >  * drivers/mfd/tps65910.c (regmap and i2c)
> >  * drivers/mfd/tps80031.c (regmap and i2c)
> >  * drivers/mfd/twl4030-power.c (i2c without regmap)
> >  * drivers/regulator/act8865-regulator.c (regmap and i2c)
> > 
> > For this reason, I think the practice of using regmap/i2c within
> > pm_power_off is well-established and should not be questioned for an
> > individual device. In addition, the relevant functionality must be
> > explicitly requested by modifying a board-specific device-tree. It can
> > be assumed that an integrator would test whether the mfd actually works
> > as a power controller when adding the relevant property. Given that we
> > turned off other CPUs and IRQs, the behaviour should be fairly reliable.
> 
> I never like assumptions and they tend to catch people out. A lot of the time
> driver developers will use another as a template/example and so the same
> possible mistakes can be duplicated. I don't know for certain these are mistakes
> but the code seems to indicate that could be the case, and there's a good
> reason that atomic I2C transfer code has been added into the kernel. I also
> prefer code that helps people identify where a problem might lie so having a
> check for I2C atomic support would be useful to indicate if there is a problem.
> 
> Lee, do you have any further insight into any of this? Am I barking up the
> wrong tree here?

Not off-hand, sorry.  I would have to do a deep-dive to figure it
out for myself.

Maybe this is where Mark and/or Wolfram (Cc'ed) have some knowledge.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
