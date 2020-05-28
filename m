Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE0AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56522075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="DYXl7VpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgE1IpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgE1IpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:45:06 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC485C05BD1E;
        Thu, 28 May 2020 01:45:05 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q13so3303237edi.3;
        Thu, 28 May 2020 01:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQcXBvkMwxE9iWumM/mUqdHHLaKvFZVd13/D5ygOhgs=;
        b=DYXl7VpDckkXySt6oIMOto7vbGkR/j9ZvZuaVoM5E30/q7xewNL00ENVJVete8+3vB
         XQuufPVh+h4SM3LX6Ie53tIL46EwxtUEOruqy7Qy0NpVdLeuE9UZgzTH0uMrO/j5cMRj
         pnTfzu78X29iv3qXom6T4Yu04Yfre4i8mnXm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQcXBvkMwxE9iWumM/mUqdHHLaKvFZVd13/D5ygOhgs=;
        b=jZfjIlQ3BdIIonfMRmVEcYQSB+WoDX4BG12/hyHI1s14S55CggL3YVCg2qBd5y00od
         R/4r5jxzYaBOmRMGgg4TEFfaM9pafsSfvPKcuqOqX/zysnSTvU1kzIPV7zDs9INy42xJ
         zU0Zwfi39ptvBIXKxgXlq/rPBClGBxv4vA9zGDfymY8cQOp/4B6iNPA92SDwWW4iZiOt
         qxvTK++6UZimD4KTy796kjwF1OeEFt+68d/lyX3errEVe0A57tba/nSSpVh+8b4Kb25L
         qc05/UqIyoVa70nVxd+/HryBDJKaWmUiRfP8IKwhDXF/RW9ZVEoh011DDBcUQKSFlh8a
         ubTA==
X-Gm-Message-State: AOAM533WCcSuA1+biYJad6wtmuX5QqnK5OnWGgTIaXdllYnRUsoU+uAh
        UYoDzX6ftYM25AOiqJfjsg2+aif3smks3kl0saJwxzX8
X-Google-Smtp-Source: ABdhPJzc4mtJtpxewDS587u9arbInhu6wD/K/+A70Wl6P9sv9Xn/UmIRJYS6g9GJiiw6E+MNisHU4pt+1LOju1NbYgA=
X-Received: by 2002:a50:e444:: with SMTP id e4mr1856165edm.191.1590655504448;
 Thu, 28 May 2020 01:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200528072037.1402346-1-joel@jms.id.au> <20200528072037.1402346-3-joel@jms.id.au>
 <20200528183115.05b2519a@canb.auug.org.au>
In-Reply-To: <20200528183115.05b2519a@canb.auug.org.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 May 2020 08:44:52 +0000
Message-ID: <CACPK8XeXt3fzrMiq4=+8k9+9t2am4k=YZLJ4FUYkn2k1=2AMsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] checks: Improve i2c reg property checking
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 at 08:31, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Joel,
>
> On Thu, 28 May 2020 16:50:37 +0930 Joel Stanley <joel@jms.id.au> wrote:
> >
> >
> >  #define I2C_OWN_SLAVE_ADDRESS        (1 << 30)
> > +#define I2C_TEN_BIT_ADDRESS  (1 << 31)
> >
> >  static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node *node)
> >  {
> > @@ -1057,10 +1058,13 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
> >               reg = fdt32_to_cpu(*(cells++));
> >               /* Ignore I2C_OWN_SLAVE_ADDRESS */
> >               reg &= ~I2C_OWN_SLAVE_ADDRESS;
> > -             if (reg > 0x3ff)
> > +
> > +             if ((reg & I2C_TEN_BIT_ADDRESS) && reg > 0x3ff)
>
> Shouldn't this be
>
>                 if ((reg & I2C_TEN_BIT_ADDRESS) && ((reg & ~I2C_TEN_BIT_ADDRESS) > 0x3ff))

Yes, good catch.

There are no device trees that set the I2C_TEN_BIT_ADDRESS flag in the
kernel, so it is untested.
