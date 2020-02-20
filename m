Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEF8C11D25
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D6E20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b12pI/w6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgBTXb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:31:26 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43889 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:31:26 -0500
Received: by mail-oi1-f195.google.com with SMTP id p125so161095oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 15:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cX+db5U8CtEgxjRtXzK2hbSPInTYpvJEKTM3HshbINU=;
        b=b12pI/w6/WlkF8IEQZyJGbw01kpouWxdzknoAlzX9xfdHWAj92OFUvxZPB8xnaeSrZ
         /rqdoZucH20EUAraAl7Xbb26kN3I3rk/EDsFyoQiinCW2lIl52SQ3dNl5PZx+C/sQyO+
         cmWmNTXuvXUb+DGIEcKJGdNYN4/KV3HLo1eGpUxg8odniE6dfC3a8fhT6IPkVeKpuxmW
         NtjFobDSIoBdKDmrplV9s0eF+m0SOI5WJN//JS1QIsrQ1ZVUF3aEoCojp/lLzFZkIk4U
         JWfoOChIrDqOAz1X6al3LGnSs5WYtrearJVjjVy8GCf9q8y5YDU7iBSVAHD3CXUGWdtE
         5qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cX+db5U8CtEgxjRtXzK2hbSPInTYpvJEKTM3HshbINU=;
        b=be3F7jC/WPD0zUaFCHDLufFlYCa24CRJr0LOf2r7L4FFqIps+1Bvs6dv9rTn84pwk/
         DJ4Ecxyo0bocKOwE64rc8t9Vk03MzmVEdch1wTdQD9tk9n6v4WaNP0DtsSbZLD2XtvpK
         Rse4LFN6DLdlbdYMSEfvzeT9vjZdBZiKOnS98WJUvSQ9O+ezdRXYF6mRciCnlk2avcxe
         Y3nIOA/mggQx1yp2KOxE6zvTrqDP2PBfUOr8GBJrgo96eE/B29IHYCWRCCDf1785I2FX
         IOBvPFxWxVwX6OJDcEI7LkB2uiO/WgC9g+cOJ13ERa8ppbs1xu0yEdPzB3YCQlQ/1mwH
         2wrA==
X-Gm-Message-State: APjAAAU71vZwnR37th50JOpBhUtP/1IAu3FKZx9QxIQAGYFA4bJSC5o1
        CGgedglmIipnF/8L28grJZrZ+dd8KTsNdJCQIcHEQC/e
X-Google-Smtp-Source: APXvYqymRB2V+MyO0KyAEPT7mJxa7dCtj/3y+lnMklL2vrd2c6CSsFGHoO/m6Vc2EVGb333n3Shtlvn1zenKunK7V9E=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr4020121oig.172.1582241485487;
 Thu, 20 Feb 2020 15:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20200220055250.196456-1-saravanak@google.com> <CANcMJZBQe5F=gbj6V2ybF-dK=kRsGZT2BX9CBJiBFoK=5Hg-kA@mail.gmail.com>
In-Reply-To: <CANcMJZBQe5F=gbj6V2ybF-dK=kRsGZT2BX9CBJiBFoK=5Hg-kA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 20 Feb 2020 15:30:49 -0800
Message-ID: <CAGETcx88H+aFTt=Vp8Q1KVOZYEaD3D6=i5WN8tWmnBAs1YdY1g@mail.gmail.com>
Subject: Re: [PATCH v1] of: property: Add device link support for
 power-domains and hwlocks
To:     John Stultz <john.stultz@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 3:26 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Feb 19, 2020 at 9:53 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Add support for creating device links out of more DT properties.
> >
> > To: lkml <linux-kernel@vger.kernel.org>
> > To: John Stultz <john.stultz@linaro.org>
> > To: Rob Herring <robh@kernel.org>
>
> Just as a heads up, git-send-email doesn't seem to pick up these To:
> lines, so I had to dig this out of an archive.

Weird! Left out the main person who'd care about this patch.

>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/property.c | 4 ++++
> >  1 file changed, 4 insertions(+)
>
> This does seem to work for me, allowing various clk drivers to be used
> as modules! This removes the functional need for my recent driver core
> patch series around the deferred_probe_timeout (though the cleanup
> bits in there may still be worth while).
>
> Tested-by: John Stultz <john.stultz@linaro.org>
>
> Thanks for sending it out!

Thanks for the Tested-by!

Rob,

Can you pick this up for the next rc?

-Saravana
