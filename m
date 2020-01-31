Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3740C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A686214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com header.i=@solid-run-com.20150623.gappssmtp.com header.b="zM91B167"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgAaPPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:15:33 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41846 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgAaPPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:15:32 -0500
Received: by mail-yw1-f67.google.com with SMTP id l22so4977803ywc.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 07:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKqqlpA+EkYjXixe2TS2xK7+DyD3uNKJKEB0gcN7Kss=;
        b=zM91B1671UUjUt7B4XhWH0jKv4TzeL2OGkjsxZr6YetTM6KnFw900Ukel/cRquX0U6
         /s2JfZpPbKUq/hyBOchczdnZP5oy6LHCnqrOZHmBiurBK22nhFbHBa0kNR9a7mmo7Ooy
         uXyyJl8Sw6q2bVInAbUXGqW1AXzLWuOuP7wcwOH0a406Qljft7LX0O9wfukjwAudPtZP
         NXoNfOkGncX1sLCF6A2cABmwx2anxLMJJj+k5cQQtCy9BdKCV+MVJFeKCh5ER4Mc2zJz
         wa+9WuxuAWSoLKZimoK3BKKytP0yZHM7LdE34XG08cOSXqyxkEWSXLPQyK9sCOJc/9ct
         zBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKqqlpA+EkYjXixe2TS2xK7+DyD3uNKJKEB0gcN7Kss=;
        b=qXgidPDyLfuA+5PI6wzoi8bdtZR0dXpCZaks3mNl7+Wj22itf+FhGjt9/rcsAJpeaS
         MJ/lCJGV9Y9nFP5LvSeGzXjt5lEZKaET84C6JuHlCQvKDuaEG5gBX6HfPAhE9jw4aBoZ
         mRZAS+qlycpmrk/gVQxvZsKVLq0JReLdvVnt3fuyctS5jR4tVn21LI69STBCCPUXFHmY
         B25qhMkWd84PRnPBSnaqM3ReqbIenK9QC5rmLrSSP8N8n3XplyHdQcXSqvV7Gk/f1VBq
         gu7ypes2yuleB2R2lGOdR6jFpIALedaNwJQHFZh0hbAOZj/Le8yC7YhfDk7Pza8jsFXf
         Nr3Q==
X-Gm-Message-State: APjAAAVULXTuH+v21vLNiy/apRxq8w6EyClNzWeLNL8YyvzQaEBA8jmQ
        Hemd/Df97TRDnFEJtdfAWak/wffIRBUYhBMzjA8dzw==
X-Google-Smtp-Source: APXvYqwsAGpGy6tic5rDdkc84xGCO6z1ubMWeOs7PNuXCUuhqHHO+HdXDIU+E2oTbdCyqF+X9ln5AxdumM3moQc/u34=
X-Received: by 2002:a25:e790:: with SMTP id e138mr822292ybh.120.1580483731154;
 Fri, 31 Jan 2020 07:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20200128110916.GA491@e121166-lin.cambridge.arm.com>
 <DB8PR04MB7164DDF48480956F05886DABEB070@DB8PR04MB7164.eurprd04.prod.outlook.com>
 <12531d6c569c7e14dffe8e288d9f4a0b@kernel.org> <CAKv+Gu8uaJBmy5wDgk=uzcmC4vkEyOjW=JRvhpjfsdh-HcOCLg@mail.gmail.com>
 <CABdtJHsu9R9g4mn25=9EW3jkCMhnej_rfkiRzo3OCX4cv4hpUQ@mail.gmail.com>
 <0680c2ce-cff0-d163-6bd9-1eb39be06eee@arm.com> <CABdtJHuLZeNd9bQZ-cmQi00WnObYPvM=BdWNw4EMpOFHjRd70w@mail.gmail.com>
 <b136adc4-be48-82df-0592-97b4ba11dd79@arm.com> <20200131142906.GG9639@lunn.ch>
 <20200131144737.GA4948@willie-the-truck> <20200131150929.GB13902@lunn.ch>
In-Reply-To: <20200131150929.GB13902@lunn.ch>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Fri, 31 Jan 2020 16:14:55 +0100
Message-ID: <CABdtJHs5zdS=unviHX3=Gsbf=q9ooS0sYMUAbtvaZT0D0ORNkw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] bus: fsl-mc: Add ACPI support for fsl-mc
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Calvin Johnson <calvin.johnson@nxp.com>, stuyoder@gmail.com,
        nleeder@codeaurora.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andy Wang <Andy.Wang@arm.com>, Varun Sethi <V.Sethi@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Paul Yang <Paul.Yang@arm.com>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 4:09 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Devicetree to the rescue!
>
> Yes, exactly. We have good, standardised descriptions for most of this
> in device tree. And phylink can handle SFP and SFP+. Nobody has worked
> on QSFP yet, since phylink has mostly been pushed by the embedded
> world and 40G is not yet popular in the embedded world.
>
> > Entertaining the use of ACPI without any firmware abstraction for this
> > hardware really feels like a square peg / round hole situation, so I'm
> > assuming somebody's telling you that you need it "FOAR ENTAPRYZE". Who
> > is it and can you tell them to bog off?
>
> The issues here is that SFPs are appearing in more and more server
> systems, replacing plain old copper Ethernet. If the boxes use off the
> shelf Mellanox or Intel PCIe cards, it is not an issue. But silicon
> vendors are integrating this into the SoC in the ARM way of doing
> things, memory mapped, spread over a number of controllers, not a
> single PCIe device.
>
> Maybe we need hybrid systems. Plain, old, simple, boring things like
> CPUs, serial ports, SATA, PCIe busses are described in ACPI. Complex
> interesting things are in DT. The hard thing is the interface between
> the two. DT having a phandle to an ACPI object, e.g a GPIO, interrupt
> or an i2c bus.
>
>    Andrew

Just as a review reference, I have found an old attempted
implementation documented here.
https://github.com/CumulusNetworks/apd-tools/wiki

-Jon
