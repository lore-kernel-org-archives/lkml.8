Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC4C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 06:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1B32083E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 06:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StnKe5Di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgCIGc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 02:32:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44507 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgCIGc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 02:32:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id g19so10671831eds.11;
        Sun, 08 Mar 2020 23:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Rrh4xCN93yxbiysM7hoI7Kgy/YimZpuBsdoKrd3usOU=;
        b=StnKe5DiDViKVTU5ESIRLLy9/7LegDlur4llvA5MAnCpOuvCk4Enm2+nHJ08bb91gS
         pLMS01RGNRfB1ISYDKlXrY273BlHMPQlMVVGx9kJoiEA8DcOeTv+qSUsDAphv+3ZQ78P
         bRp/z3Fhea/5/shGRSw1/MntmdHyQLKD9iaAqpxRkfm1xrZzfEeaVGhZ/6mDhBtBHEkP
         IAbSMe8NQX1pt1dL6whTbV5/gykzdtLLeT7lU7n9QqPYe9eUEfIG5Ad92gWwijYmlSSz
         7SEnZQUmwU/Bt7qhL8pS1qYkdYE9XSWumWWrCPNm9Vzlgt+rdWFq/O7rN1vKIx6gFshU
         mLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Rrh4xCN93yxbiysM7hoI7Kgy/YimZpuBsdoKrd3usOU=;
        b=sBCPdU39seZVWpy8G2ZaJZUbBI+dRy4Y6m6n/5ewYhqZ4m2OuruUmmwHKcgBfZO3D/
         iWwOB5IwcthG1xuVrAYYk9AqnhiZzyNkttvYPkiBVF9CrS5mL4oQRGyn+wJLp4k4AhBa
         9UQCUTF1JvzYfV8FlPBr/yATCGoNKpXpXcDrNxzSiMHNR3JaQIl1iFjF2np0Q0R+Kt3+
         LbBP+gy/ZY/fu7PmEI+7iNf/PGGjTOahHan0upGXXsEg7TYQ/Vp/Oj3ThWfY6StuzCCm
         jBKXtkcyYtpEVBjH2NLeRSIjxnlECYhv6rBCyYsIISKMUpHXoO9nV0gISEy+rU825RKG
         Ap8A==
X-Gm-Message-State: ANhLgQ3m2KA4jCC2TYT0axz4xXrefNritlxBYRJ/9E/NklH4f5wvfzns
        Gr/HqPkgRR30PdF6vKz4U9T1u3jG
X-Google-Smtp-Source: ADFU+vvupTomHBM1nfQRacQtbkCNZUpJi5figDBPnt0zQEe7VWQbyhnDdwOrbA6Qu+yioWKJcwNoRg==
X-Received: by 2002:a17:906:c82c:: with SMTP id dd12mr13118915ejb.241.1583735545631;
        Sun, 08 Mar 2020 23:32:25 -0700 (PDT)
Received: from felia ([2001:16b8:2d7b:9300:78ce:ab50:7651:7014])
        by smtp.gmail.com with ESMTPSA id o9sm1265981ejg.12.2020.03.08.23.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 23:32:25 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 9 Mar 2020 07:32:10 +0100 (CET)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Guenter Roeck <groeck@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] MAINTAINERS: include GOOGLE FIRMWARE entry
In-Reply-To: <5129f7dbd8506cc9fd5a8f76dc993d789566af6c.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2003090702440.3325@felia>
References: <20200308195116.12836-1-lukas.bulwahn@gmail.com> <CABXOdTcrxoBCz24Ap=YJYZnr+oLAmaR10xZ9ar2mYbE1=RAoug@mail.gmail.com> <5129f7dbd8506cc9fd5a8f76dc993d789566af6c.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Mar 2020, Joe Perches wrote:

> On Sun, 2020-03-08 at 15:32 -0700, Guenter Roeck wrote:
> > On Sun, Mar 8, 2020 at 12:51 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > > All files in drivers/firmware/google/ are identified as part of THE REST
> > > according to MAINTAINERS, but they are really maintained by others.
> []
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > > @@ -7111,6 +7111,14 @@ S:       Supported
> > >  F:     Documentation/networking/device_drivers/google/gve.rst
> > >  F:     drivers/net/ethernet/google
> > > 
> > > +GOOGLE FIRMWARE
> > > +M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > +M:     Stephen Boyd <swboyd@chromium.org>
> > > +R:     Guenter Roeck <groeck@chromium.org>
> > > +R:     Julius Werner <jwerner@chromium.org>
> > > +S:     Maintained
> > > +F:     drivers/firmware/google/
> > > +
> > 
> > FWIW, I would not mind stepping up as maintainer if needed, but I
> > think we should strongly discourage this kind of auto-assignment of
> > maintainers and/or reviewers.
> 
> Auto assignment should definitely _not_ be done.
> 
> This is an RFC proposal though.
> 
> Sometimes it's better to not produce an RFC as
> a patch, but maybe just show a proposed section
> and ask if is appropriate may be a better style
> going forward.
>

Please interpret the RFC patch similar to an email as Joe wrote below, 
simply reaching out to you.

There is no auto-assignment intended, nor did I expect the patch to be 
picked up on the first attempt of uneducated guessing.

There are currently around 3,000 files identified being part of THE REST;
so they are all assigned to Linus and LKML.

To confirm that they actually are maintained by someone else and reflect 
that in MAINTAINERS, a bit of educated guessing who to contact and to 
which entry to add the files to is required.

I am starting with the "bigger" clustered files in drivers, and then try 
to look at files in include and Documentation/ABI/.

Here is a rough statistics on how many files from each directory are in
THE REST:

   1368 include
    566 tools
    327 lib
    321 Documentation
    100 drivers
     91 kernel
     84 scripts
     75 samples
     13 ipc
     13 init
      8 usr
      2 arch
      1 virt

 
> Maybe just emailing Greg, Stephen, Guenter and
> Julius (cc'ing LKML) asking something like the
> below would be better:
> 
> ----------------------------------------------------
> 
> Hey all.
> 
> Files in drivers/firmware/google/ do not seem to
> have a listed MAINTAINER.
> 
> Would a section entry in MAINTAINERS like this be
> appropriate?
> 
> GOOGLE FIRMWARE
> M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> M:     Stephen Boyd <swboyd@chromium.org>
> R:     Guenter Roeck <groeck@chromium.org>
> R:     Julius Werner <jwerner@chromium.org>
> S:     Maintained
> F:     drivers/firmware/google/
> 
> Is there a git tree somewhere that should be added?
> What would be the
> status of this proposed section?
> Does someone really look after it at
> all?
> 

Thanks for the proposal; I was not sure about the best way to reach out to 
others on suggesting to add new entries.

In the future, I will simply send out emails, as those above, when 
suggesting to add new entries.

Thanks for the feedback and sorry for the churn. Once most files are 
assigned, it is much easier to follow when someone missed to adjust the 
MAINTAINERS file and send out a friendly hint. I hope that is worth the 
initial churn for some people at the beginning of this clean-up.

Lukas
