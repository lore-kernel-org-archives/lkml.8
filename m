Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3145C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 03:48:14 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FAD2072B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 03:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHdueZ7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FAD2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgDMDsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 23:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgDMDsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 23:48:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6942EC0A3BE0;
        Sun, 12 Apr 2020 20:48:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a201so8397209wme.1;
        Sun, 12 Apr 2020 20:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOqxL66FbwiBOL3LXXwgTnGg5mLB+6JiHF9fkHXdoqk=;
        b=eHdueZ7zFdz+7TXQqL4OoHrQ7V9wb5fcGX8I25YHfG809MzEvvbGSoSEdNSX6H8zFH
         AVWDCCjYr2GRJ9+p6jm1Jk21Rn/hhBauiTSnYYja62zzwXa70l5vRnwzdhmoW9lsKS9y
         lSRxHU3ZOlx+o/uyXS8yQIKfE82mXM1P93rEnr0hvLmMGgdzFU3tMIXuE0QAHHaEKxV2
         2J1EkElbvYGA+i4IQz8XdaTRhUJwZkAgokdfL/qFq2Uskqo9jrHOMEemtxLMI3Q9YJxS
         fUKT6k/BYYehjZ2hK61znbKtb5T9pFyX6LoVj/Ad2s8qFsDMWeqlIgbKKSX6krRUTXnY
         RtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOqxL66FbwiBOL3LXXwgTnGg5mLB+6JiHF9fkHXdoqk=;
        b=BNBHDkg5v7s0iuc7Yy2qFuN0CWqcAbgqQ15/pAx5aYNKbgw+i26juI9LBxuXx/uEgG
         PV2M8BMPu2FoyNCnHicklLCEHyf2B9NJni2yeejeWy2dRiWCEb5MjtRaTbbowEWwQAQf
         jfVBkQrBVeNf9UvgufcR2thZIibodpikB1lB8VsxUMxuV9ktlf/RXPGJpImF7DlhRtem
         OwHmfK8V7zQUy1RJlvPQ3ZeS/gglBN1oSC9jAwlvbmieB2KTdvoR8xZ+/uRfUeb3kmmW
         xOLK7KYvzd9m0hMbtJFtAl4SKa2h9ZbBql7WYNinISx39lpq/jPSuBArSIzwCfnCFIb5
         h+6g==
X-Gm-Message-State: AGi0PuYG2EDA1kW42ATirET9bDO2CjQ3Q/8ukFFR5srW/QHn0Crmk3sh
        xpcgWPFMkMNuMA58ux8Hh3cjRPRTLLk1Lg0SXyg=
X-Google-Smtp-Source: APiQypLf0tfaasI2t0Fqp4px2QP+9aipCRR/arb5tC7+oxmH737yZT6d6JyD7KYMwXYwrK5n8jc+1giTedXJ2R7CYmE=
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr16241410wma.26.1586749691152;
 Sun, 12 Apr 2020 20:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200408160044.2550437-1-arnd@arndb.de> <CABOV4+UocLs3jLi7-vTi8muiFqACVdxH7Td8=U1ABveLnmyCuw@mail.gmail.com>
 <CA+nhYX0H-czfJ6Kg+FK7X2=hHQK185UOLGoPdEP3nqWQWcA+bg@mail.gmail.com>
 <CAAfSe-s=dZe=6y7UH8CBcddL1BKoLOAvi24RekgdmVv0StxTTA@mail.gmail.com> <158657204622.199533.16589832598336244320@swboyd.mtv.corp.google.com>
In-Reply-To: <158657204622.199533.16589832598336244320@swboyd.mtv.corp.google.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 13 Apr 2020 11:47:35 +0800
Message-ID: <CAAfSe-tnKUios-kfN8tiqnen_bchOF5q6FqZgcMj2c_FitS6uA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] clk: sprd: fix compile-testing
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Sandeep Patil <sspatil@android.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Apr 2020 at 10:27, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Chunyan Zhang (2020-04-09 20:45:16)
> > We see this broken because I shouldn't leave clk Makefile a tristate
> > compile [1] after changing ARCH_SPRD to be tristate.
> >
> > If we will make ARCH_SPRD tristate-able in the future and you all
> > aggree that, I would like to do it now, and pay more attention to
> > Makefiles and dependencies.
> >
> > I can also make a change like below:
> >
> > diff --git a/drivers/clk/sprd/Kconfig b/drivers/clk/sprd/Kconfig
> > index e18c80fbe804..9f7d9d8899a5 100644
> > --- a/drivers/clk/sprd/Kconfig
> > +++ b/drivers/clk/sprd/Kconfig
> > @@ -2,6 +2,7 @@
> >  config SPRD_COMMON_CLK
> >         tristate "Clock support for Spreadtrum SoCs"
> >         depends on ARCH_SPRD || COMPILE_TEST
> > +       depends on m || ARCH_SPRD != m
> >         default ARCH_SPRD
> >         select REGMAP_MMIO
> >
> > Arnd, Stephen, Sandeep, what do you think? Does that make sense?
>
> Sorry, doesn't make any sense to me. The ARCH_FOO configs for various
> platforms are intended to be used to limit the configuration space of
> various other Kconfig symbols for the code that only matters to those
> platforms. The usage of depends and default is correct here already. The
> ARCH_FOO configs should always be bool. Any code bloat problems seen by
> config symbols enabling because they're 'default ARCH_FOO' can be
> resolved by explicitly disabling those configs.

Ok - alright, please feel free to merge Arnd's patch then.

Thanks,
Chunyan
