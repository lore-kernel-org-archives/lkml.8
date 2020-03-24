Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ABFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A70208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgrieuKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgCXNEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:04:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36324 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgCXNEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:04:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so15302169wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1oa8yxV7xzZ+tD1LcZwM67jLdYW/JjWbnu15B5rKnAc=;
        b=pgrieuKBguK79BGSzhI7qQoDKjs7oVSsEZFIkfliQlS4z5oJJ8i92cBNzbOc6KuF1k
         eeh8US59wuikVQM5bbteGvBBxvsZWujEwU6Wt/GOypCDV7QldRZo2bm2Z3Z/oDT3qUxy
         IyyWUye5I8LOmsJlNfr1zBUhQVPRbiik4yERyYY8ajgeowR6YD9qVW9h8wHNhdTpBj34
         1nWgV2/0E+YFu3oaFa7h1tC6MO5jeXwowcGsQVjUfVFZi0+WKfIAiVpGy1hfpaOZeze7
         5SJ81Lzjc5G+49LBl1KyN8/cbBUg/ehWOfDEBzOwCJL3GV09zAwFEDDUuzXEF1FC2GTw
         Lxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1oa8yxV7xzZ+tD1LcZwM67jLdYW/JjWbnu15B5rKnAc=;
        b=nRIVXOlfH8VqdvOoodzib7pNZqeMJ3vzkYfrAieFSiETOwG0ckT71hX/UNxkELI6DI
         b071ZViWazmYS3/t9Z+Z6GPi4KPTzwOmZnLRHkhBt9z7jNU9ZZIX7vL0SYYJTHqlZUff
         A4AAxnO5ODzcR+VmynXIJoFTzKCHdq/72c0de9lS6PbtE+XMarrHHIWSvnBVTPI6JXpB
         VACpvY9RCF5hAE4I/w1N/bsU+/H+3mi61k9h8ADx1RpE2xl/zZI6O/pf2XBAf9GEo1j2
         S2uKPn7QsclInYE+dDZdZsXQWQCqMzf6wihJgk8BwAB1WLVF2cswltKk9GfE/AA/ZOkw
         tSFw==
X-Gm-Message-State: ANhLgQ0d93Lr1kG63EOjJ/sml/ZLjukctjQ2+yrhX8BTEM0pYCI3b2N1
        8h4X2IwqBoSLHB+ennvbNx+9/g==
X-Google-Smtp-Source: ADFU+vt/tZsuKl1gh3b+r/lHzGLKErJB8LKeO5CV2x9BnDtJ1QJrNAMaaIoqumVT6rOFGRemUbUOqQ==
X-Received: by 2002:adf:afdb:: with SMTP id y27mr37198227wrd.208.1585055052854;
        Tue, 24 Mar 2020 06:04:12 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v2sm30204625wrt.58.2020.03.24.06.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 06:04:12 -0700 (PDT)
Date:   Tue, 24 Mar 2020 13:04:10 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v11 10/12] backlight: pwm_bl: Use 64-bit division function
Message-ID: <20200324130410.dwlg767ku6kwequv@holly.lan>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <17fc1dcf8b9b392d1e37dc7e3e67409e3c502840.1584667964.git.gurus@codeaurora.org>
 <20200320133123.GD5477@dell>
 <20200324110710.GL5477@dell>
 <20200324125735.2mjuvbxt5bpon2ft@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324125735.2mjuvbxt5bpon2ft@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 01:57:35PM +0100, Uwe Kleine-König wrote:
> Hello Lee,
> 
> On Tue, Mar 24, 2020 at 11:07:10AM +0000, Lee Jones wrote:
> > On Fri, 20 Mar 2020, Lee Jones wrote:
> > 
> > > On Thu, 19 Mar 2020, Guru Das Srinagesh wrote:
> > > 
> > > > Since the PWM framework is switching struct pwm_state.period's datatype
> > > > to u64, prepare for this transition by using div_u64 to handle a 64-bit
> > > > dividend instead of a straight division operation.
> > > > 
> > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > > Cc: linux-pwm@vger.kernel.org
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: linux-fbdev@vger.kernel.org
> > > > 
> > > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > > ---
> > > >  drivers/video/backlight/pwm_bl.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > Can this patch be taken on its own?
> > 
> > Hellooooo ...
> 
> Conceptually it can. As the last patch depends on this one (and the
> others) some coordination might be beneficial. But that's up to Thierry
> to decide how (and if) he want this series to be applied.

... and on the backlight side we definitely need to know about the "if"
otherwise there's no point in taking it.


Daniel.
