Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4271FC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AB5222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nj+SbZ34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgANH6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:58:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39355 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgANH6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:58:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so12511053wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 23:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2tqeA9SVRpbYOWNEv52NfjSgUYnaSyLjZ8VbKBWvkB8=;
        b=nj+SbZ34MQo3ObpLHJ81f1fsqNyqoIbFh9D59Ut6hwJJqqviusHEBofnbn9WEMHTkH
         BowT+qANUEoaF7Ya4KZP1bSuMDzr3BrfBc4qXVeGmkv+W2YkD64gZdlGT1o3hIs69C+R
         Frm7G0TnEgQN+CcgJpGTHzupvS2axENPUO9tDbkad1jsACJb/T7vVOMZjXrau9B0y1xP
         Nivrll2vslPIaal6ObHQgNrwwh1/ns4IANfiXYseBn8G6sPo2cLt3Q1oVOcocUcMuoWB
         jAj8yw5pFR5ln7Zr+jVforKxx/vd60vD57WvedRNYlKMdSDCMYBSbGYeBhIY1f5KuAo0
         4RCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2tqeA9SVRpbYOWNEv52NfjSgUYnaSyLjZ8VbKBWvkB8=;
        b=p+q+QXy2VynOplO8S6PgvD83sIvNVW0XEi5NPk7emuXnLva+/X4lMNESCKNqL7y8aO
         sV+3fP8Zili70gQE8+VH5NtlG59php/dANv/PKeuohzifSeVyklCzzliyhxJQ+Nw7A2+
         AcRMtN5ZMkPyEuUfKkDaEuyZLUxJhG91j/1uad7q3nOTwJNQx44eQvphBScRKuyp5XPP
         5aH4fq24kYctvAm8MvsfL0lk045uGjvVD9ReU6pGnGA0WbsBCajfVq7YrG+Atvsk0kCF
         /osvGaERnCW5IkCso3eR3NZUacwWOTtzdcHZxiTnq0jtURyYfoQqT8f09q5+7kFUYqKD
         yK7A==
X-Gm-Message-State: APjAAAVsr0WKndVy8wIrDeffuw7yi5F+UMWfN0F5ALRrsOKw6VHmXrdQ
        yLS0Ol2yTzW+JdWWxYKsgXWMaw==
X-Google-Smtp-Source: APXvYqxpPA4KEPMdkCalFXAmGAvGmPtnz+o0nFOyZiKWNQHG3sc/7GlSmvHxayF93Mper9G7Nk467g==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr25125804wml.107.1578988714621;
        Mon, 13 Jan 2020 23:58:34 -0800 (PST)
Received: from dell ([95.147.198.95])
        by smtp.gmail.com with ESMTPSA id k16sm18893042wru.0.2020.01.13.23.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 23:58:34 -0800 (PST)
Date:   Tue, 14 Jan 2020 07:58:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Subject: Re: [PATCH 3/4] regulator: mt6359: Add support for MT6359 regulator
Message-ID: <20200114075855.GA325@dell>
References: <1571218786-15073-1-git-send-email-Wen.Su@mediatek.com>
 <1571218786-15073-4-git-send-email-Wen.Su@mediatek.com>
 <1578969594.4495.3.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1578969594.4495.3.camel@mtkswgap22>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020, Wen Su wrote:

> Dear reviewers, 
> 
> 	Gentle ping for this patch set.

Not a good idea.

If you think a patch has slipped through the net, please apply all
your received *-by tags and resubmit the set, changing "PATCH" to
"RESEND" in the subject line.

> On Wed, 2019-10-16 at 17:39 +0800, Wen Su wrote:
> > From: "wen.su" <wen.su@mediatek.com>
> > 
> > The MT6359 is a regulator found on boards based on MediaTek MT6779 and
> > probably other SoCs. It is a so called pmic and connects as a slave to
> > SoC using SPI, wrapped inside the pmic-wrapper.
> > 
> > Signed-off-by: wen.su <wen.su@mediatek.com>
> > ---
> >  drivers/regulator/Kconfig                  |   9 +
> >  drivers/regulator/Makefile                 |   1 +
> >  drivers/regulator/mt6359-regulator.c       | 859 +++++++++++++++++++++++++++++
> >  include/linux/regulator/mt6359-regulator.h |  58 ++
> >  4 files changed, 927 insertions(+)
> >  create mode 100644 drivers/regulator/mt6359-regulator.c
> >  create mode 100644 include/linux/regulator/mt6359-regulator.h

[...]

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
