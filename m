Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6278AC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416F020786
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZlDt7fat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGJX1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgGJX1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:27:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD063C08E6DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:27:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so3254117pjw.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=1KgjCvGYsPEwY3hIMJvN1I+nBQQMZD4O0k3S1JS7Jzc=;
        b=ZlDt7fatfStgfAIZPJqQmlFZpkGnO9iuPVXSVxTanufGMgMlhHMxUo3jBKYtQE0znR
         SR+WcB3ZwxCGOtVUKtjcgO3ePLoorGRfPXAf8M25lOws0li5gXoYvmem/P6VagpqImRt
         nKL/T8GT3xJGbkcTdHWmqEubc/Zzg+gpv+ePc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=1KgjCvGYsPEwY3hIMJvN1I+nBQQMZD4O0k3S1JS7Jzc=;
        b=dtzsswpMv/1pleRdNc1GyUC/OfqYGQrtiOx+rPFLm+t+1fXsck7Sp0X3RR1rBGe+U2
         VFTg18XMTiMMKTTYhQv0XTMnY09ML23v8WJIs70wKeVG/cO0eI5kLwN7UnAUTDR/1Sb7
         UcSgO2zhpPmUoJGQyCaGfOn2BvPk2fmhFKS9DGp5qR1naBluh2A2j/P8B05n5su0LVml
         KH53WBdyCMAZ7JnPHjAMK+5KImBtmMDpf1A6jaz+bl1wgICU7kNKZO0uUb5qivBZ1rxB
         IqX7q9XaNOn+PvpaWU38c5XWKTtPC8Qbn7yd9FuMikuXtAR7QN6AHiu92y6/hXbpNrAN
         miwg==
X-Gm-Message-State: AOAM5332mYHqjIvCxS2rHL1YdKvb2N0ygn/4Cf5s6i5xDLLCBb/evyjd
        53nXsVs2GSZUsHWt58IX1kyX5A==
X-Google-Smtp-Source: ABdhPJwkvHuJGy/BobEJFjeeamXIZFvC9w8oHpTxafgWv0gdfY9kS4v8UzTMQwlP2PwG+JyMcl0n+w==
X-Received: by 2002:a17:90b:23d5:: with SMTP id md21mr8444282pjb.0.1594423667073;
        Fri, 10 Jul 2020 16:27:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id o17sm6475469pjq.6.2020.07.10.16.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:27:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CALAqxLW14f4Gn6Q3b89X10y7=Zct2NJSgjagUqxez_bObcp42w@mail.gmail.com>
References: <20200625001039.56174-1-john.stultz@linaro.org> <20200625001039.56174-4-john.stultz@linaro.org> <159315737502.62212.16093934831673347066@swboyd.mtv.corp.google.com> <CALAqxLVNGar8g+FvHaVHN_e-MOZZ+=ZPmDt_GKKSC8AS-wLFGg@mail.gmail.com> <87wo3setn8.wl-maz@kernel.org> <159436097057.1987609.13993891118929459851@swboyd.mtv.corp.google.com> <CALAqxLW14f4Gn6Q3b89X10y7=Zct2NJSgjagUqxez_bObcp42w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] irqchip: Allow QCOM_PDC to be loadable as a permanent module
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        iommu@lists.linux-foundation.org, linux-gpio@vger.kernel.org
To:     John Stultz <john.stultz@linaro.org>
Date:   Fri, 10 Jul 2020 16:27:45 -0700
Message-ID: <159442366514.1987609.434612639050774557@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting John Stultz (2020-07-10 15:44:18)
> On Thu, Jul 9, 2020 at 11:02 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Does it work? I haven't looked in detail but I worry that the child
> > irqdomain (i.e. pinctrl-msm) would need to delay probing until this
> > parent irqdomain is registered. Or has the hierarchical irqdomain code
> > been updated to handle the parent child relationship and wait for things
> > to probe or be loaded?
>=20
> So I can't say I know the underlying hardware particularly well, but
> I've been using this successfully on the Dragonboard 845c with both
> static builds as well as module enabled builds.
> And the same patch has been in the android-mainline and android-5.4
> kernels for a while without objections from QCOM.
>=20
> As to the probe ordering question, Saravana can maybe speak in more
> detail if it's involved in this case but the fw_devlink code has
> addressed many of these sorts of ordering issues.
> However, I'm not sure if I'm lucking into the right probe order, as we
> have been able to boot android-mainline w/ both fw_devlink=3Don and
> fw_devlink=3Doff (though in the =3Doff case, we need
> deferred_probe_timeout=3D30 to give us a bit more time for modules to
> load after init starts).
>=20

Ok I looked at the code (sorry for not checking earlier) and I see this in
msm_gpio_init()

        np =3D of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
        if (np) {
                chip->irq.parent_domain =3D irq_find_matching_host(np,
                                                 DOMAIN_BUS_WAKEUP);
                of_node_put(np);
                if (!chip->irq.parent_domain)
                        return -EPROBE_DEFER;

so it looks like we'll probe defer the pinctrl driver until the pdc module
loads. Meaning it should work to have pinctrl builtin and pdc as a module.
