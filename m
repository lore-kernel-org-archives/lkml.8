Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977A4C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF0B206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hgm0O5D0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgD0KWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbgD0KWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:22:45 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A85C0610D6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 03:22:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z1so7118140pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1CyxLaZcj63tQcR7tpc4uGoE1KDGBKikBpluCv751iQ=;
        b=Hgm0O5D0lCarAkzn4DV0qMdx7tM3kC1QJVrjbaAa/X38bcsMUwXZDOePZRakepLaEi
         ya2IRGM2AuFx6/UTyzBLHVx9q79FtdJq/l/m3VSUHXUvl5AGOsXg02/t+JpagqTKBY+l
         obX+tcG3SyQnpGzNDAdirBSQEglqgR6wCxsUrwAQQzjt2Bu+XzZsIEHvDpjMra1GLSlQ
         MSEf4ffKitmCDwnSIVAkqJSZNUB/aQfo6Ui2zLT0F5Ryz8LEqvNYgvQGnyKwe77+XYoS
         Vxb+SytqcBGuoccm99VXH3I6Ke6RBkkw2FA3eFkxWF4W/BvMnNrec62dGeUBH+npxyEk
         XcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1CyxLaZcj63tQcR7tpc4uGoE1KDGBKikBpluCv751iQ=;
        b=Z3eFkPB6pRBjdCS3O8KDvXR5rPgsZZlf7Ww8tUoSCaZpvtl8kS3i7MXwMLeoBvKlc2
         nOLnBE0PEl5lJyvXbtB/PYM8pFlifr6Z1OPtgEl0dcP3F4VzCEjaf2Y3ep+6nxql9wuv
         ts23ZZeVCV9hApx6OiJaAgI14MI4jqYMf19iJEB67cJRzw1q9P9MAV829ZTW9JJ5T5gJ
         EQdhqHxtWkLL1wYzipifeHB4jcteGfE599sqvhLwqS5iaGLEnQVJAcKnIVA/1SfSDJ5b
         jhFcZan0TpCv6dSuaxzeC5pcoXym78MdkauxCTrF+tFSF8KvLaJeucieMptFnn8NRety
         UTxg==
X-Gm-Message-State: AGi0PubYYoH4LRpAkjfLk/h2wfBTAfmu9p+tJT3Hc+YyogiMlsO91Cua
        6/J92UzkH7EJwCH+3kUIBm36Eg==
X-Google-Smtp-Source: APiQypK3z4yQqpVlHsZhnbToQmUFhKubYEh51/9LQwynKZdCC2YUpDM70yeaRzHItaf4MzlKveltLA==
X-Received: by 2002:a62:fc82:: with SMTP id e124mr23801311pfh.126.1587982963367;
        Mon, 27 Apr 2020 03:22:43 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id h31sm11276301pjb.33.2020.04.27.03.22.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 03:22:42 -0700 (PDT)
Date:   Mon, 27 Apr 2020 15:52:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 10/10] cpufreq: dt: Add support for r8a7742
Message-ID: <20200427102240.jsskbskczvctvcwv@vireshk-i7>
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV6J-_gBkzhUXtA8OrxhJVzyrAqjA8oeGJGBp86X-C3Nw@mail.gmail.com>
 <20200427092408.g2vpc6j2c6it4x2i@vireshk-i7>
 <CA+V-a8vwF=u53dZ_U4vX3oAUHrBh5uVUBeOTiDqTZJfV8UUeCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8vwF=u53dZ_U4vX3oAUHrBh5uVUBeOTiDqTZJfV8UUeCA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-04-20, 11:20, Lad, Prabhakar wrote:
> Hi Viresh,
> 
> On Mon, Apr 27, 2020 at 10:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 27-04-20, 11:22, Geert Uytterhoeven wrote:
> > > Hi Prabhakar,
> > >
> > > This patch should be merged through Viresh's cpufreq tree (CCed).
> > >
> > > On Thu, Apr 23, 2020 at 11:41 PM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > Add the compatible strings for supporting the generic cpufreq driver on
> > > > the Renesas RZ/G1H (R8A7742) SoC.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Prabhakar,
> >
> > Please resend the patch with all dependencies to me so I can apply it.
> >
> This is the only patch which is needed for R8A7742 SoC which needs to
> be applied for drivers/cpufreq. Shall I still repost it or you are
> happy to pick this one up ?

would be easier for me if you repost it. I don't have it in my
mailbox.

-- 
viresh
