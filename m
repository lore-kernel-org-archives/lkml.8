Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D547DC433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFB320738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLOh+BHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgG0Toh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0Tog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:44:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D54C061794;
        Mon, 27 Jul 2020 12:44:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so2800927pfh.3;
        Mon, 27 Jul 2020 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzzZKFqE1nfVRb0bTdQAza1honJ2T0+1vW2BFXwTzqA=;
        b=HLOh+BHLV83GvCy5qUxFSaZI0+nJP44EMKDBWsLY8Ovleoz0qJzz9U/WHyEcv8UmBR
         K6dzaNevQflsp7u1+vL5BpA3XgDFl66RzHvFTsbEJAoMUxj8tAYHWQ5e2pNuo8db9gJe
         PJegFSJz/dE71vnOhQ4JE8F7CAkptW/6IiGqB18TtsZS+FvQ+fpDtHyKSpGeyycOmDGk
         +61FWMMRgSO3dsJRPTJYfH7iezRNM7LIchSAZBCfb8kF4+kXRublXv+myOcu6UNAEBgi
         rLsNTbH1/YK8y3dO6mBN28vzkIqqhsJwgLugHq2jPJAK7F4CjOjeLidnlm6kM8JEwKL4
         gi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzzZKFqE1nfVRb0bTdQAza1honJ2T0+1vW2BFXwTzqA=;
        b=PyK+AxFqwavXoNnGZH2qOAPdlhoHmp60s5BR2CP+a/jJl/tNxTcXwnwplDAaM7nS6t
         w9fZU1WMECHpmbd3ANQPVuY6wb01YNDPPufTiPV06dZJNZMOwWaXc+OY0ZvJQOKArfCp
         exGVr3BdG2/HAauiWMydt3Gc6xKXy9tj6+M3eH/kW7zSEa+OayoesKkT5fnjxOKCOXD6
         fREiuCyjEBr8QSCr6RkvB4aDtKsS4Gh82ZfIUJIWIaNtjy2uMAesscs6KocB7k05VbKy
         DgGXMgKcQDB+LM1f1Ng8+6GVFkzEN9JFGkcleSEnhIs51BQbcocEzR7ZWq/9ffMltvtF
         gYJA==
X-Gm-Message-State: AOAM530mzj6zkTZJ8MZIo+e9eT/gFSkgTAVCA1+TYmqP192/S3esU6VD
        cCpH4sWV7HpZ2j2TGP054GJJ6u9Xl+ZFZGgqFigzjVwPTQ0=
X-Google-Smtp-Source: ABdhPJzEd9N2EW8275FRzfeT1fNAW9ksND1FAyY1KyG0A8DkhI41cM9sG0GJE6Li/KdL/CE30l9gi3zTMIRToWH2OsA=
X-Received: by 2002:a62:758f:: with SMTP id q137mr3064389pfc.170.1595879075906;
 Mon, 27 Jul 2020 12:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200727092346.19780-1-amelie.delaunay@st.com>
 <20200727092346.19780-4-amelie.delaunay@st.com> <CAFBinCCXuUC4PHgrobYjj=yjA3Tz73Wwx0KWz+B6PfCw_OSi_w@mail.gmail.com>
In-Reply-To: <CAFBinCCXuUC4PHgrobYjj=yjA3Tz73Wwx0KWz+B6PfCw_OSi_w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 22:44:19 +0300
Message-ID: <CAHp75Ve75d+K87cokb4YYgim_wU0gTidGuiPs3BmohRKfTh5gA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] usb: dwc2: don't use ID/Vbus detection if
 usb-role-switch on STM32MP15 SoCs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:04 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> On Mon, Jul 27, 2020 at 11:23 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> > -       p->activate_stm_id_vb_detection = true;
> > +       p->activate_stm_id_vb_detection =
> > +               !of_property_read_bool(np, "usb-role-switch");
> the rest of params.c uses device_property_read_* instead of of_read_property_*
> I thought I'd mention it so you can decide yourself whether this is
> fine or needs to be changed

Better to change and leave all on one line.

-- 
With Best Regards,
Andy Shevchenko
