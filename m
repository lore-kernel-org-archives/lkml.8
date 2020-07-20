Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB7C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82183207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ExhLOtf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgGTErT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgGTErS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:47:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AC2C0619D2;
        Sun, 19 Jul 2020 21:47:17 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n2so11812235edr.5;
        Sun, 19 Jul 2020 21:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4fc45IcLsicHhtLrVqSsoKWL7WlpOp+mi3KXR3SVAc=;
        b=ExhLOtf3Xmakmdh7RWnLzDdIOVhpIDJdrp+ojzMv74tDkBc/WYOanglWg0JJ8gWEzh
         l8A1UTRrNwszNQvXw9jXZhvLnKAcaC61yGwpCEwM/cZaOPIT0TJk/2FBeQ0eqpV//bpf
         ZzzNTPGT5cFr5W0sofdFuXj5UO1jLI+xJglPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4fc45IcLsicHhtLrVqSsoKWL7WlpOp+mi3KXR3SVAc=;
        b=Yh1tpxS/n0B4pxvm7SiRW9RkO6ieENClp/tGlpg239gTseSMgI9D8w+AKwr5iVjk54
         L68XbZxM18/BVu1k1SSYrI72uosF7vSS+Gv9ZRvUVR7uS+XjEWp7VdS9UmYvsnowd3wx
         8YGa+e1nM8qL13JNMoF8Ospk4PNyccWAXd13kCr8RcxtJ/o2CuPaMqMTBcsNB3O5hpNH
         2MdoxPTrFcZ+tD+MGVUXV8q6u6gXUmcgXoRrDEhN1A4kl9itqtRWVOM2BEhIBac6mqlR
         RgaIxLDclawuQsu/+nzVdnva0vDEbv+PQ5Vfr5aAXA9LIta7wbZBJ2zroqowm3+DMz35
         nPCw==
X-Gm-Message-State: AOAM533QIMclbDjG4SGanwTTPSCdXDHP41I+Cdqk8MQWEbQGZ+6JSEYI
        EQ7hEoDvDmqdzwUdnVMwLf6bbHTRSmwMTNzM3Y4=
X-Google-Smtp-Source: ABdhPJxbSSqWQ84B+4JiYW9acW9DNnNENYMzz3dZj96Ct7RscmlkP4owpxPAAFbAwlIFmF9yLot/4Gnrg36cffa7UQI=
X-Received: by 2002:a05:6402:2067:: with SMTP id bd7mr19502715edb.143.1595220436121;
 Sun, 19 Jul 2020 21:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200501150833.5251-1-eajames@linux.ibm.com> <20200501150833.5251-3-eajames@linux.ibm.com>
 <20200719221302.GA78557@roeck-us.net>
In-Reply-To: <20200719221302.GA78557@roeck-us.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 20 Jul 2020 04:47:04 +0000
Message-ID: <CACPK8XdzUcb922brKkD8iDPvr4CGdDZXhUPM=mtuHSMc2j0sog@mail.gmail.com>
Subject: Re: [PATCH 2/3] fsi: occ: Add support for P10
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        devicetree <devicetree@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jeremy Kerr <jk@ozlabs.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 at 22:13, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, May 01, 2020 at 10:08:32AM -0500, Eddie James wrote:
> > The P10 OCC has a different SRAM address for the command and response
> > buffers. In addition, the SBE commands to access the SRAM have changed
> > format. Add versioning to the driver to handle these differences.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
>
> I don't recall seeing a maintainer Ack for this patch, nor any response
> at all. I'd be happy to apply the patch through hwmon, but I would need
> an Ack from a maintainer.

That would be great. I had one question before it goes in, but once
Eddie has sorted that out it can go through your tree.

>
> Thanks,
> Guenter
>
> > ---
> >  drivers/fsi/fsi-occ.c | 126 ++++++++++++++++++++++++++++++------------
> >  1 file changed, 92 insertions(+), 34 deletions(-)

> > @@ -508,6 +557,7 @@ static int occ_probe(struct platform_device *pdev)
> >       struct occ *occ;
> >       struct platform_device *hwmon_dev;
> >       struct device *dev = &pdev->dev;
> > +     const void *md =  of_device_get_match_data(dev);
> >       struct platform_device_info hwmon_dev_info = {
> >               .parent = dev,
> >               .name = "occ-hwmon",
> > @@ -517,6 +567,7 @@ static int occ_probe(struct platform_device *pdev)
> >       if (!occ)
> >               return -ENOMEM;
> >
> > +     occ->version = (enum versions)md;

The 0day bot warns about this when bulding for 64 bit architectures.

How about you drop the match data and instead match on the compatible
string to know which version to expect?

> >       occ->dev = dev;
> >       occ->sbefifo = dev->parent;
> >       mutex_init(&occ->occ_lock);
> > @@ -575,7 +626,14 @@ static int occ_remove(struct platform_device *pdev)
> >  }
> >
> >  static const struct of_device_id occ_match[] = {
> > -     { .compatible = "ibm,p9-occ" },
> > +     {
> > +             .compatible = "ibm,p9-occ",
> > +             .data = (void *)occ_p9
> > +     },
> > +     {
> > +             .compatible = "ibm,p10-occ",
> > +             .data = (void *)occ_p10
> > +     },
> >       { },
> >  };
> >
