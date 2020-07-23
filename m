Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8049C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D8720768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595509066;
	bh=G+78cGpjN3WK6Hl2NxA9uDiBV/yF4HOvTtyKm84UAUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G3EJQK37LNnIIWxs3C04qz8OmueYD05X5rBOZCP8nP11MGRMifjllq0mr/WXjdJbk
	 01HBomJZrhxmApg7PMn7AYV5OGVo8zG2bJm+8OKBXdSMW3C1iC+1yuH/mZXId4etGH
	 gA5Sd/QE0FcQ3fBM8shpxR1/uJHrByNLq9vC0ZvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgGWM5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:57:45 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:38893 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWM5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:57:45 -0400
Received: by mail-ej1-f66.google.com with SMTP id br7so6281150ejb.5;
        Thu, 23 Jul 2020 05:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e9LofUs8gAfR6XrMny4GZ85gpBoKqLeNU4Y7+2YVIZA=;
        b=X3DAUyGb+ou9it2EVVsbLjXPEGZ5Ksy+EKFLbKnYXrQ/SQlujemsNc02B+jkzqvskG
         bmrUiC4mPN4EyIhf4kAuJR3FFO2b/7AxvuVA+S+zU1ecJn2yeRlZ5T1Nhs2r4EfffIRX
         gTJZdrPJB9QOdI5EjniuBL91Kc53PII0+uM+gX1H8wFeSdXV3yhAklLWoAk6GpRnleRF
         ABR2elNeoMxCvSwaDScutqqqwrZT1MovVIt4IuID2MFwmnhooJNaevFHjMu6ZQ9oPg9Y
         hucHSMQqt441xPUOifyDt0c1LeT4kiudZYdJJV0IgNB1Zbzd6cRNOoFbV7YARxQnWMld
         vKMA==
X-Gm-Message-State: AOAM531vIf8//Q25X0Kjp/cFSisbTp3Zv5AQjtyUEssgJ0dxRAyRzuVz
        Pg5VqIVS8cUoglRwsFqEw2E=
X-Google-Smtp-Source: ABdhPJyQQG+1vJWyFqmWfy7zG77XSzSOGLUh7E7RkFOEh/412ICpjHYCDA57DaHlSBEXOrjZotrDKQ==
X-Received: by 2002:a17:906:abd5:: with SMTP id kq21mr2406890ejb.291.1595509062854;
        Thu, 23 Jul 2020 05:57:42 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id q21sm2000004ejr.75.2020.07.23.05.57.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jul 2020 05:57:42 -0700 (PDT)
Date:   Thu, 23 Jul 2020 14:57:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] sh: clk: Fix assignment from incompatible pointer type
 for ioreadX()
Message-ID: <20200723125732.GA9795@kozik-lap>
References: <20200723082017.24053-1-krzk@kernel.org>
 <c77eb720-1ded-f9d4-fbe4-92429e81857f@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c77eb720-1ded-f9d4-fbe4-92429e81857f@physik.fu-berlin.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 02:49:46PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Krzysztof!
> 
> On 7/23/20 10:20 AM, Krzysztof Kozlowski wrote:
> > Maybe because it depends on commit 58c4d8659186 ("sh: clkfwk: remove
> > r8/r16/r32") which landed later?  Anyway it should go through your tree,
> > I think.
> > ---
> >  drivers/sh/clk/cpg.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
> > index a5cacfe24a42..fd72d9088bdc 100644
> > --- a/drivers/sh/clk/cpg.c
> > +++ b/drivers/sh/clk/cpg.c
> > @@ -40,7 +40,7 @@ static int sh_clk_mstp_enable(struct clk *clk)
> >  {
> >  	sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
> >  	if (clk->status_reg) {
> > -		unsigned int (*read)(void __iomem *addr);
> > +		unsigned int (*read)(const void __iomem *addr);
> >  		int i;
> >  		void __iomem *mapped_status = (phys_addr_t)clk->status_reg -
> >  			(phys_addr_t)clk->enable_reg + clk->mapped_reg;
> 
> Is that a reverted patch, by any chance? The patch does not apply for me and looking at
> the sources, the qualifier is already "const" [1].

The patch is for Andrew Morton's tree which contain two commits:
1. sh: clkfwk: remove r8/r16/r32
2. iomap: constify ioreadX() iomem argument (as in generic implementation)

This patch here was actually part of #2 because of being based on
linux-next. However it disappeared when applying to Andrew's tree
because patch #1 came later.

Best regards,
Krzysztof

