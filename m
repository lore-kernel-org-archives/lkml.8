Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEDE20738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdA2/nJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbgFXXOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732894AbgFXXOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:14:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F458C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:14:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so2003845pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+7AF3Ce4clllGfpNaJa1qHwB1pRt3ZfsyY5W1G7hgnM=;
        b=NdA2/nJIb2yNcbFuDf+G5/HR9byziIurJeeXmi74xEeKThuTJd8qHOsZGE25kWwzYb
         bdYt01AvsgD7MS5fBWEIlNIF/Gz0va2G/rpcmxA9BEb7Ks0NkSD3KS+PxM2OWGFs55NF
         VIROe437BOgGfd6t0VGbHTfYko0la78gArKYVVA0oNeHDtEdZz8O4BJgyXyQ6it+sB+I
         ARwydNIIof/8tj5jSrTwFl6ZPDHUJrDxw+ANuSU9TDXz7sdCHhlm0fFF+2Y7aUGhf5dy
         pf8U/YoUZmlp6mv/Wq65RAcxJLo73UXus8VCmTBik55LaZKvT0GFccMZT3ZNEM4X53cx
         yPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+7AF3Ce4clllGfpNaJa1qHwB1pRt3ZfsyY5W1G7hgnM=;
        b=NOtm06rvMutxMdUMo1Pt97GvnCJwV2G69yBTuX+2fJS9o6Uj++zLRPAdWAdrU8L7vj
         DvuPHWZ71z+zWm6BrA7maqc8C60sswEu99I2qwwPJWKkVlSnjbEBAnWOFKAI3YZjKJF3
         nBrEIKp53/aH0AYzYaA8nPkFUQgnkgJUB/tC5kaTbcB+8+DmM6ck5+kV5YfoYjfGNXur
         yLxNAU/crYy6wsdlURf5GzcH/1c+ffvcE6E9WrLIGAe98916AaPQwZRvlyDF3Rj+iPmZ
         S7bGcaST6zhfY9s4hN0GRTDR0tFEEuH1eb4/D70T3JNvVB83jXuBn7FoZN0cB/UyABR1
         vxyA==
X-Gm-Message-State: AOAM532wCEpKDETXxs0Pz8sP14iDoruOTps0ysn7cY9F8at6c+K2oW01
        IJBXmX9yLyXXhXpAstKP4FR0KA==
X-Google-Smtp-Source: ABdhPJyqWuRmhH4/SkSh4oTDaEYmxriQ6XdWOSZZEn8/35ILfr0Skv325Imu5mALqyP6NDrVByCl3g==
X-Received: by 2002:a65:6393:: with SMTP id h19mr7002597pgv.278.1593040445494;
        Wed, 24 Jun 2020 16:14:05 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y204sm4880467pfb.111.2020.06.24.16.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 16:14:04 -0700 (PDT)
Date:   Wed, 24 Jun 2020 17:14:02 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, Suman Anna <s-anna@ti.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] remoteproc: ingenic: Added remoteproc driver
Message-ID: <20200624231402.GA1933376@xps15>
References: <20200515104340.10473-1-paul@crapouillou.net>
 <20200515104340.10473-4-paul@crapouillou.net>
 <8cdcf5ef-1268-89f6-b229-ac711a80b790@ti.com>
 <FR8SBQ.5WXNHNH8P2P7@crapouillou.net>
 <fc1e14e7-4551-48c3-2820-f5889c50becb@ti.com>
 <G3ATBQ.KJYAFROKKWDP1@crapouillou.net>
 <20200621193022.GA149351@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200621193022.GA149351@builder.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 12:30:22PM -0700, Bjorn Andersson wrote:
> On Fri 12 Jun 04:47 PDT 2020, Paul Cercueil wrote:
> > Le jeu. 11 juin 2020 =E0 19:21, Suman Anna <s-anna@ti.com> a =E9crit :
> > > On 6/11/20 5:21 PM, Paul Cercueil wrote:
> > > > Le jeu. 11 juin 2020 =E0 16:47, Suman Anna <s-anna@ti.com> a =E9cri=
t :
> > > > > On 5/15/20 5:43 AM, Paul Cercueil wrote:
> [..]
> > > > > > diff --git a/drivers/remoteproc/ingenic_rproc.c
> > > > > > =7F=7F=7Fb/drivers/remoteproc/ingenic_rproc.c
> [..]
> > > > > > +    /* The clocks must be enabled for the firmware to be
> > > > > > loaded in =7F=7F=7FTCSM */
> > > > > > +    ret =3D clk_bulk_prepare_enable(ARRAY_SIZE(vpu->clks),
> > > > > > vpu->clks);
> > > > > > +    if (ret) {
> > > > > > +        dev_err(dev, "Unable to start clocks\n");
> > > > > > +        return ret;
> > > > > > +    }
> > > > >=20
> > > > > You are enabling the clocks directly here and also trying to
> > > > > manage =7F=7Fthem through pm_runtime callbacks again.
> > > >=20
> > > > Yes. The clocks need to be enabled in the probe.
> > >=20
> > > For the preferred non CONFIG_PM case now and lack of
> > > prepare/unprepare().
> >=20
> > I want to make it clear that I'm not against having .prepare/.unprepare=
, but
> > I want to see what maintainers have to say.
> >=20
>=20
> I think it's perfectly reasonable to enable all the resources here and
> then if CONFIG_PM isn't set you just leave them enabled throughout.

In my opinion the best way to deal with the status of the CONFIG_PM
configuration option is to move clock relate operations to the prepare/unpr=
epare
callbacks.  Doing so would have several advantages:

1) If rproc->auto_boot is false then clocks aren't enabled needlessly betwe=
en
the time the driver is probed and the remote processor is started.

2) It would allow for the removal of the runtime PM calls in the core, whic=
h in
the current state, prevents the runtime PM mechanic to really serve its pur=
pose.
Indeed, calling runtime PM operations in rproc_fw_boot() and rproc_shutdown=
()
prevents the remote processor from being suspended during periods of inacti=
vity.
If all that is required for Ingenic's remote processor is to set the clocks
before accessing device memory and switch them off when no longer needed, I
think prepare() and unprepare() are the best choice.

3) As Suman pointed out having runtime PM operations in remoteproc core mak=
es the
task of supporting scenarios where the remote processor is loaded by another
entity more complex.  Given the distinct nature of managing power for remote
processors and the characteristics of each platform I beleive the best plac=
e to
call runtime PM operations is in the rproc operations, as it is done
omap_remoteproc.c

Since we are quite early in the release cycle all we need is a couple of sm=
all
patches: one to move clock manipulation in the Ingenic driver to the remote=
proc
core's prepare/unprepare function and another one to remove runtime PM
operations from the core.

Thanks,
Mathieu

>=20
> Regards,
> Bjorn
