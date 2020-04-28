Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A5AC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D768206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp4LAKom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgD1IJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgD1IJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:09:21 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0295BC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:09:21 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j14so16116191lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kqa38YVLi7QYLTLJZZ98QduYEyE7k3ch1m+jgKR4ttM=;
        b=Qp4LAKomQILI/2tAvM4aA0DBEvzilLjP1lu63igtRn3zAu3vcuEZXruRMYKHEtis5p
         u0Kwte31H8Vzt4w9fRELwsKgRZlD9787lL86lP+i+RdF1jPnG4aslfhhdp6Pc30DOFLD
         AoWN+Qa8UUl4dQjSZexfDylq1gfw8wJiUJXLj6pBq8FzDqltl3fVDEcCW21/3K9g+d2X
         zSLHRbz9DLYT5/z1Pm8747clwSiPgl40F/LPYnfBcQzkNhz64hGucLMX33hbaLozo2/B
         q5owKRkdaN6E9QuiVitkufiMdcflD7sYGtQVdQBcr1KWPwuPDFOtVYzGIpB40H98f9oW
         cJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kqa38YVLi7QYLTLJZZ98QduYEyE7k3ch1m+jgKR4ttM=;
        b=fuzI+gpsJSA6qjyWo21IWF5dOEjqM5f7P69QDyH08vCgtZex/0baQQBqjDhpmjY3rk
         jZOXo2J4NOOcPxPnAByeIFyueu6iSvNwn+8kmfnTrcXAE/+sATErdKCSrZWmZoeHezl4
         reLGTy7mJf3sppZsv4+JyPOXNlxoXF4od/yEw+8ezf2k7EgSFNNK9AUq/uPuq1uql3kJ
         0FI/ezVrW5XCBWUYP/WxhNWnLr4L+PHeH47jz15cCGEYOBwfGtxv8cxcTLfGluYZ2qiu
         mg/G65F8m2pbSY6OlTlF5goMIAIhGzPGwb+30f/YVAI8A1Nk3hJA7/ZrXQ0sCqj7UgtT
         gxjw==
X-Gm-Message-State: AGi0PuYUPdX63AhtZtK2uQlmdttSlz0vXS1EKJikZmeQq77YFuwhZVEY
        6pG4Z9TYpSbqrN5nfCZ1SGEoauMmoUBIDoYq09M=
X-Google-Smtp-Source: APiQypIcbp/b/DnOyM07Z/UydAFYokUInguVPq1krfdT83rmW4qthkvs5N+288CwxFuCtt7Js7pGXQlnrk1EmEpIDVs=
X-Received: by 2002:a05:6512:74:: with SMTP id i20mr18261664lfo.104.1588061359536;
 Tue, 28 Apr 2020 01:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <c2fd765aa388d4510194ba02c017e39bde57c8d4.1587478171.git.baolin.wang7@gmail.com>
 <CADBw62rJ8VYTgnW_3q4=TkCyZx2B1DHsG+oOmiph8FLsukUROQ@mail.gmail.com>
 <20200427090518.GG3559@dell> <CADBw62qXtNnoNq0F1iZrvQHryMTy86GEqcD-qXBzsJJL-B8mQg@mail.gmail.com>
 <20200428071447.GJ3559@dell>
In-Reply-To: <20200428071447.GJ3559@dell>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 28 Apr 2020 16:09:08 +0800
Message-ID: <CADBw62o=D-hmp1yB=oPXPJfBucOEEa87cZado5+1mTKsCWDKfg@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: syscon: Add Spreadtrum physical regmap bus support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 3:14 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 28 Apr 2020, Baolin Wang wrote:
>
> > On Mon, Apr 27, 2020 at 5:05 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Mon, 27 Apr 2020, Baolin Wang wrote:
> > >
> > > > Hi Arnd and Lee,
> > > >
> > > > On Tue, Apr 21, 2020 at 10:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > >
> > > > > Some platforms such as Spreadtrum platform, define a special method to
> > > > > update bits of the registers instead of read-modify-write, which means
> > > > > we should use a physical regmap bus to define the reg_update_bits()
> > > > > operation instead of the MMIO regmap bus. Thus we can register a new
> > > > > physical regmap bus into syscon core to support this.
> > > > >
> > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > >
> > > > Do you have any comments for this patch? Thanks.
> > >
> > > Yes.  I'm not accepting it, sorry.
> > >
> > > I'd rather you duplicate the things you need from of_syscon_register()
> > > in your own driver than taint this one.
> >
> > Thanks for your comments and I can understand your concern. But we
> > still want to use the standard syscon APIs in syscon.c, which means we
> > still need insert an callback or registration or other similar methods
> > to support vendor specific regmap bus. Otherwise we should invent some
> > similar syscon APIs in our vendor syscon driver, like
> > sprd_syscon_regmap_lookup_by_phandle/sprd_syscon_regmap_lookup_by_compatible.
>
> So long as the generic driver stays generic.  Providing a registration
> function sounds cleaner than tainting the code with vendor specifics.

So seems my V1 patch set [1] was on the direction as you suggested,
but Arnd did not like that.

[1]
https://lore.kernel.org/patchwork/patch/1226161/
https://lore.kernel.org/patchwork/patch/1226162/

-- 
Baolin Wang
