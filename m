Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2C3C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FCC22CAD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597163675;
	bh=oGUG079ed7aLBG+yeXa+0MIFK8VtpV+CJMUo8gk4tGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ddAv6lB4QnlQvzZGmzGnbH3J7Ib0gs4kzIMS5hfpB0MhFn+FEdHnmr8s7DOS3Tc6D
	 jCUB/68hJpkaGfMV4WGSafhUDRmI5dI1AsYtGBMyK9XbyiaFO9YM4BWE7SKMe2bADM
	 tFa+wa2KOgskXMCk4ibQdPOlA8Pn+fiOmpZNbZOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgHKQee convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:34:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33572 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgHKQed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:34:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id p20so12078865wrf.0;
        Tue, 11 Aug 2020 09:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WA8/uq9qyQrCKNou4NrEBKiSZTsOfyBYRvbV3dkHbXw=;
        b=g2S/a67aXmSyv8iWxyvhAIBtPnYZI0/7GaxMhsVmMn6ILY8I/iM8vRWXdxgtFwqngR
         3vimIztZ0TQf2SPW1VhoRuIwZFrG4xdz36wG+3kufIDwz89xhRaL/SSy5W89vPPtTzFV
         9ynQ53CMCXdgptEeRE4m1XMS0YLIODeIi7tSupXetPby/Toz22CAfA8lj7Ax+iQHxoqb
         4ftZ7nIfNM9y36E2c4OWrNIZdi4TTLkEwiDKOAfn5E/7/Q/DlFG+JHzYFdD3UQV/gl5m
         UYToYLQml4I9rgF96hX9arU+cP5WO7PGITY2/fbsSI70xBTmKeJWcYsyABE3fTvWNsuI
         nN3w==
X-Gm-Message-State: AOAM531RDl8N2KoJNBUKiEjCbIwKTf8zLekxiic561t/tJ8fDVrzwe89
        QHjqAiqYrbuQ4+t1W6x7QgM=
X-Google-Smtp-Source: ABdhPJxy8C3pgBduxTbDV01QUwU5s+1RIZQnIOOMBrhfOsueSTfgTsvP11We8WcsbYJKvfjZklpQow==
X-Received: by 2002:adf:b352:: with SMTP id k18mr31171523wrd.386.1597163671405;
        Tue, 11 Aug 2020 09:34:31 -0700 (PDT)
Received: from kozik-lap ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id s8sm5886575wmc.1.2020.08.11.09.34.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Aug 2020 09:34:30 -0700 (PDT)
Date:   Tue, 11 Aug 2020 18:34:28 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] clk: samsung: Prevent potential endless loop in the
 PLL set_rate ops
Message-ID: <20200811163428.GA7590@kozik-lap>
References: <CGME20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54@eucas1p2.samsung.com>
 <20200811112507.24418-1-s.nawrocki@samsung.com>
 <CA+Ln22Hfys7r2EDstOsdks1X88Fuv77DLTuXLWDynTt4kmiCiQ@mail.gmail.com>
 <20200811162358.GA7169@kozik-lap>
 <CA+Ln22Es+Mtokw91wzUaoWC2yCQHRJDEvW6=U1Rbt2H7PbDOeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CA+Ln22Es+Mtokw91wzUaoWC2yCQHRJDEvW6=U1Rbt2H7PbDOeA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 06:28:18PM +0200, Tomasz Figa wrote:
> 2020年8月11日(火) 18:24 Krzysztof Kozlowski <krzk@kernel.org>:
> >
> > On Tue, Aug 11, 2020 at 02:59:07PM +0200, Tomasz Figa wrote:
> > > Hi Sylwester,
> > >
> > > 2020年8月11日(火) 13:25 Sylwester Nawrocki <s.nawrocki@samsung.com>:
> > > >
> > > > In the .set_rate callback for some PLLs there is a loop polling state
> > > > of the PLL lock bit and it may become an endless loop when something
> > > > goes wrong with the PLL. For some PLLs there is already (a duplicated)
> > > > code for polling with timeout. This patch replaces that code with
> > > > the readl_relaxed_poll_timeout_atomic() macro and moves it to a common
> > > > helper function, which is then used for all the PLLs. The downside
> > > > of switching to the common macro is that we drop the cpu_relax() call.
> > >
> > > Tbh. I'm not sure what effect was exactly expected from cpu_relax() in
> > > the functions which already had timeout handling. Could someone shed
> > > some light on this?
> >
> > For us, it should not matter much, except:
> > 1. when on A9 with ARM_ERRATA_754327, but we do not enable it on our
> >    platforms,
> > 2. it is a generic pattern for busy loops.
> >
> > On other architectures it could mean something (e.g. yield to other
> > hyper-threading CPU).
> 
> Okay, thanks for confirming that it doesn't matter for us.
> 
> Now, I wonder if the readx_poll_*() helpers are supposed to take all
> of those into account or on systems which would benefit from such
> operations, it would be the caller's responsibility.

That's a very good point. In case of ARM_ERRATA_754327, busy waiting
should have a barrier thus cpu_relax() is desired. I guess the generic
macro for busy waiting therefore should use them.

Best regards,
Krzysztof

