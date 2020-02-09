Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92508C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5354C20733
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYTkjx1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgBIMIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 07:08:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44815 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgBIMIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 07:08:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so1649307plo.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 04:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfCaKlZQhEjtJ1METU94/WdR9krBtEtoavX/Z8F305s=;
        b=XYTkjx1Bl+76YegyEfUm/8AvgGmzmCfs2/C0+Xagaqudyr6nrK2U7iPbTkmGU3PK5I
         cIBrVDMGfjZA0yPt3/SR/v07SD87gWJaDGgH5D9LnEtW7TWYrl6vpbRBLwqJ61IQKpuz
         XDpp9vSe5oCtLoMWiZLmPzmK7QWlF/X4EOGVutmyy9+gQdCTmmGXSgRqVN2Y5o5XAm/G
         LnbrKUpoVdmeSK+cpeOAkOt1p9LVLlf3qsooF9vL2+HSuLCiSgZBRvj/gZwZNrjx1pKH
         b1PFmmpCejv1dwKniPbttZsoTSNrOF0iGmnzICuDFFZeIsbbqbl6saEwoY4LqK68USSJ
         +ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfCaKlZQhEjtJ1METU94/WdR9krBtEtoavX/Z8F305s=;
        b=HhJ6TCW8RLbyOc9UIgy3iYMrcJVC+Rmf2o3M3yQF4IDgAWSATgPsFFJZqeM+F2zXoo
         G0DAa5lztS9zdOFjuyg6ncJogXruWbZS+c6Q4QhKde1YG5Cf2qBUtu1oXBiARBUmKeCu
         KDi59P4HtTNvY31JAGgV5TyP5s5sgvpTrwRjG95OuhnZqy7qv8m+2A83R3ohotjcH2gH
         eReJ2k/4PKLZHkpt+e6FSp4gcNvNwLjZ19CzL9UAB5R7JNa7aOGMtrBXrBNySObklB0N
         5+TpipstbNaa6Kob19TDEEBX4sugQP1xA3QE+7yrwiL+WgS7Y1+4RCASLzq786hlVRII
         jChQ==
X-Gm-Message-State: APjAAAVkNNku6NFvt8A59LjOjJGMBChaAsKSEEjI4j+T+rUa+uv22WmH
        Xt4OyIAaQYDd21IKWB2jGNo9Po7mrjLy5W0Qdv4=
X-Google-Smtp-Source: APXvYqwYWcDg//RgThlLsV59stGtTl7RGwl1W4/icIuIHTHuIOzZx94vSuYpoySnXW6vXp0hG+33ksFECKHgfldkMCA=
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr7773482plf.255.1581250134511;
 Sun, 09 Feb 2020 04:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20200208184407.1294-1-tomas.winkler@intel.com>
 <CAHp75Ve0PGO_s-nRk6zwk6QTcFi4Jm3yA-QZ7j7dxqVkYB=svA@mail.gmail.com> <29e51a81900f4009ab173058bdf9ebde@intel.com>
In-Reply-To: <29e51a81900f4009ab173058bdf9ebde@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Feb 2020 14:08:42 +0200
Message-ID: <CAHp75Ve_=edHqb9DMMzFR4NZAhZV1BeLH+EBYLz-+fDsNP_vYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 V2] mfd: constify properties in mfd_cell
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 1:58 PM Winkler, Tomas <tomas.winkler@intel.com> wrote:
> > On Sat, Feb 8, 2020 at 8:44 PM Tomas Winkler <tomas.winkler@intel.com>
> > wrote:

> > > V2: drop platform_device part
> >
> > Btw, when you prepare series, you may use -vX command line parameter,
> > where X is a version number. The scripts will put v2 in each Subject line
> > uniformly.
> Right, just the second patch was a new one, so not sure I should mark it v2.

Yes, it evolved from the v1 of one patch. So, just mark both of them like
  v2: per subsystem split from v1
or alike.

-- 
With Best Regards,
Andy Shevchenko
