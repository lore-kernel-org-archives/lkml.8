Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7616C2D0ED
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD22B20787
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnIrRA8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgC2JVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:21:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40603 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgC2JVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:21:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so17746581wmf.5;
        Sun, 29 Mar 2020 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x53chI72Z4A5z3wT784xdPISVx+MMGzvobvSOBptE6g=;
        b=FnIrRA8BoFYj2RWpJ93LBznjfYgaBi8gS487V11zI073uv6ZjT6fmm2u9BwonL5VUY
         1lGpxYjz+TIxyNeexabK4v9UKbHKki3PAxlmGGSGPym4tXG6GL1sgKoUPvHghFBMX7JM
         cPrLvxLtKm6Jm6ODZv4owOGZOISVkpaMaKg4C3KjcC4DVJl04WBoljGuF7CgjTWMSWjm
         mzddCajS+9G3olNXVUMPSs0AN5m2ylu5FhOkM1Bj843r3zZQ6Z/oswLxMm66QsiRVlKF
         dpKQiYNzboWBbY2lPXnN7hqU3YhEoeBT8TojL85NRefvN2VUSAQgdxyNfcC5t8nG+zIy
         m1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x53chI72Z4A5z3wT784xdPISVx+MMGzvobvSOBptE6g=;
        b=nsjCtmXJCbl4qZnj/tMwA19oBYjXUTGILpxk0uLmubew96RrR5KLoYtzKR0Y7t3lzE
         7+OUw6vmBz/YlK5u0eli9dBN0gz48Oz2wNx7ivGvXsDoBlg2hAhMiVXExqAiUXOLOy3v
         OAb8rZBIUbC8RHsb5HLlDXUA/Si0Jpi1Rq8paa+6yJJAfk3PpumovTtcKlcPvTY2ZFsJ
         Q+AjxdtmouSu4TwXUfBgr+Ff0ZU5ZgNmZjMGpTvVgaqd18RS5L7ul62LzPnwW9OWAf+F
         SC1fkuSGKupiunfpKtXkYDitbS11zlWARwT86A9Lp3C0l9EZbxKw6KGVbIFvD+D+0xV0
         G25Q==
X-Gm-Message-State: ANhLgQ1XD17eded0dJFoNeFB0fEXVLpQJDcJpN9cym+osPf56t++SA/p
        dfHqqhueFlQ2CGGj7CI8b4o=
X-Google-Smtp-Source: ADFU+vtjvZzrvTpz+nRmLxc2pCZraCHS4XlmLXYuXqI1Tsm2DenOisGvZgfCT5iEiIBT6h0G/5Oq0g==
X-Received: by 2002:a1c:b7c2:: with SMTP id h185mr7752149wmf.67.1585473673928;
        Sun, 29 Mar 2020 02:21:13 -0700 (PDT)
Received: from eichest-laptop (77-57-203-148.dclient.hispeed.ch. [77.57.203.148])
        by smtp.gmail.com with ESMTPSA id x1sm9392665wmj.24.2020.03.29.02.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 02:21:13 -0700 (PDT)
Date:   Sun, 29 Mar 2020 11:20:33 +0200
From:   Stefan Eichenberger <eichest@gmail.com>
To:     Rabeeh Khoury <rabeeh@solid-run.com>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] arm64: dts: clearfog-gt-8k: fix ge phy reset pin
Message-ID: <20200329092032.GA4620@eichest-laptop>
References: <20200328212115.12477-1-eichest@gmail.com>
 <877dz3el4k.fsf@tarshish>
 <CA+j0otmO9QEKuYGk54wO_su0Kyzdxaf9ZB34SMBXQEih+46qRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+j0otmO9QEKuYGk54wO_su0Kyzdxaf9ZB34SMBXQEih+46qRw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rabeeh and Baruch

On Sun, Mar 29, 2020 at 11:42:35AM +0300, Rabeeh Khoury wrote:
> On Sun, Mar 29, 2020 at 9:22 AM Baruch Siach <baruch@tkos.co.il> wrote:
> >
> > Hi Stefan,
> >
> > On Sun, Mar 29 2020, eichest@gmail.com wrote:
> > > From: Stefan Eichenberger <eichest@gmail.com>
> > >
> > > According to the ClearFog-GT-8K-rev-1_1-Simplified-Schematic the reset
> > > pin for the gigabit phy is MPP62 and not MPP43.
> >
> > Have you tested that on real hardware?
> >
> > The 1Gb PHY reset on my Clearfog GT-8K is connected to MPP43. Russell's
> > commit 46f94c7818e7 ("arm64: dts: clearfog-gt-8k: set gigabit PHY reset
> > deassert delay") indicates that this is the case on his board as well.
> >
> > In case there was a hardware change between board revisions, we need
> > another dtb for that revision.
> 
> It's a bug in the simplified schematics since that schematics is based
> on rev 1.0 and not rev 1.1 as claimed.
> 
> In rev 1.0; the 1Gbps phy reset was connected to MPP62; but that MPP
> is not functional as a GPIO when selecting MPP[56:61] as SD card.
> Due to that we manually rewired ALL rev 1.0 PCBs 1Gbps phy to be
> connected to MPP43 via R8038 pads.
> 
> Rev 1.1 fixes this by that by disconnecting 1Gbps phy reset from MPP62
> and wiring it to MPP43.
> So basically rev 1.0 and rev 1.1 are compatible software wise. We will
> fix the schematics.

Ahh now I see, I didn't enable the phy driver when I did the test with
the default devicetree and then when I changed the devicetree I also
enabled the driver, that's my fault.

Sorry for the confusion... I can confirm that it works with MPP43.
Thanks for the clarification!

Regards,
Stefan
