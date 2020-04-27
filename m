Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE5AC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 081D82064C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiFPn5ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgD0JFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgD0JFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:05:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E01C061A41
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 02:05:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so19582932wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t0Qb3M+KoO7rshy7LxfHgJoujvSz6frs1GElCox2b5s=;
        b=KiFPn5ig/JKiOhaz02UnaLlnM3E8H8eyZzRXSgpgUO41XBVvN2o0dl8F35rNzr5/fP
         M6d4vtcAdWrgC2ZqKCoTgLP4AgzuIMc1qN/3l/+HxvYd1zY0rJhpp9LNNi9k1kFhlyBZ
         ymqiZ6+D/a+5NUOtNineXVJL593LPnBbBKiTxurunGLd5ELXd8bYFwg+xhk6NNxKfTNf
         6CBdSmQY8GKAzYPVGKG53XQ3FeoIaZXG7yq5nsIEtHFm0L9lO4N80M2L0xDLhGiegXKx
         tigV4d7V10rfAc9U9fdzaXGRfJKJAMq7gifpJIt6BDgTeVY+pEsAGXTqg18enuabO6YL
         UPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t0Qb3M+KoO7rshy7LxfHgJoujvSz6frs1GElCox2b5s=;
        b=KiNUCGZYgaoDfiUcwDQWVCDoyAZBZcqbUzUqEv615AwUF6Df8B007Fsf64KvypLOYU
         gGWOeF7q2vPPBIdSVig29mRXYEyz2OFUbFuVM/M1KDOPK/c1ximj7ZrOdMvR59bRYq0M
         jOpt2xwqsGtIuIpxpTqviLedD2xkFhRLvFDK2serNL+N1kCO3mjjctAWUxYuZtXRIV0Y
         r86c/brsArCek7K9ZscNGRb9BXu9rjrJ/ecL6qGbKKqdp1cIehtDeueUaXvtGDpc7nEM
         gYAcuLBztiL33ClQ5K187h+WeouWtvLMyudAGty7SIOjTx+n8bz3f/aSHA/0Fka/gOtm
         NS3A==
X-Gm-Message-State: AGi0PuZ+qB0DtaeYB7adH6/HfshBJnMcYM4yD42FhvlpnKN5K1Qvb5/b
        KTuECDNMaC8heIHLI+Bxq+6QeQ==
X-Google-Smtp-Source: APiQypLpoDDhhdpdCRaX2x6X7Pxrq+PxdaeSfgMI7TOujsZcV/bIZhc1xo/+1EofweXOdW56V/D2bQ==
X-Received: by 2002:a05:6000:11cb:: with SMTP id i11mr26886292wrx.339.1587978321185;
        Mon, 27 Apr 2020 02:05:21 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id l9sm19962876wrq.83.2020.04.27.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 02:05:20 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:05:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mfd: syscon: Add Spreadtrum physical regmap bus
 support
Message-ID: <20200427090518.GG3559@dell>
References: <c2fd765aa388d4510194ba02c017e39bde57c8d4.1587478171.git.baolin.wang7@gmail.com>
 <CADBw62rJ8VYTgnW_3q4=TkCyZx2B1DHsG+oOmiph8FLsukUROQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADBw62rJ8VYTgnW_3q4=TkCyZx2B1DHsG+oOmiph8FLsukUROQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020, Baolin Wang wrote:

> Hi Arnd and Lee,
> 
> On Tue, Apr 21, 2020 at 10:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Some platforms such as Spreadtrum platform, define a special method to
> > update bits of the registers instead of read-modify-write, which means
> > we should use a physical regmap bus to define the reg_update_bits()
> > operation instead of the MMIO regmap bus. Thus we can register a new
> > physical regmap bus into syscon core to support this.
> >
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> 
> Do you have any comments for this patch? Thanks.

Yes.  I'm not accepting it, sorry.

I'd rather you duplicate the things you need from of_syscon_register()
in your own driver than taint this one.

> > ---
> > Changes from v2:
> >  - Fix building errors without enabling CONFIG_ARCH_SPRD.
> >
> > Changes from v1:
> >  - Add WARN_ONCE() for seting bits and clearing bits at the same time.
> >  - Remove the Spreadtrum SoC syscon driver, instead moving the regmap_bus
> >  instance into syscon.c driver.
> >
> > Changes from RFC v2:
> >  - Drop regmap change, which was applied by Mark.
> >  - Add more information about how to use set/clear.
> >  - Add checking to ensure the platform is compatible with
> >  using a new physical regmap bus.
> >
> > Changes from RFC v1:
> >  - Add new helper to registers a physical regmap bus instead of
> >  using the MMIO bus.
> > ---
> >  drivers/mfd/syscon.c | 83 ++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 81 insertions(+), 2 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
