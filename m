Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293DAC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6432080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgBJQfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:35:38 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:33485 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgBJQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:35:38 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MGi6k-1jEzXu1hEg-00Dqpm; Mon, 10 Feb 2020 17:35:36 +0100
Received: by mail-qk1-f171.google.com with SMTP id v2so2187528qkj.2;
        Mon, 10 Feb 2020 08:35:36 -0800 (PST)
X-Gm-Message-State: APjAAAVVx0J8A10B02bxeCUpWUP5XdIx6hHAQsY7iviRMyonrgZoj7lI
        5rLAp4d2UYUBq/ihuLzWQgNW74oTx1bIMMV92f4=
X-Google-Smtp-Source: APXvYqzwsmadsnYEYT4Ek1X+K2TCw5F0cgvsuN+fGPdnvrDqGEuNOwdA27X52ZmPPjeq150xVoqs1ywlchc9VsQt1FA=
X-Received: by 2002:a37:e409:: with SMTP id y9mr2224481qkf.352.1581352535220;
 Mon, 10 Feb 2020 08:35:35 -0800 (PST)
MIME-Version: 1.0
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com> <1579123790-6894-7-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1579123790-6894-7-git-send-email-eajames@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 10 Feb 2020 17:35:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3HsdpLz0aDGem1BrQsNo2mEJOnOsLcKFcLjaERx9dhGg@mail.gmail.com>
Message-ID: <CAK8P3a3HsdpLz0aDGem1BrQsNo2mEJOnOsLcKFcLjaERx9dhGg@mail.gmail.com>
Subject: Re: [PATCH v6 06/12] soc: aspeed: Add XDMA Engine Driver
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:KgmaCXhhi62tw/qrUQ2htx/WJKvvMAHgg9nLtHPVn3jhIkucDc2
 gNZq30+E2/tsO80jCn7Yn/lR6QX0oc0lX2izkSQv72eom6vFE+fFQY3vUnOIIiqwgi8J/6u
 wkQ6EY2V2G0QuNfIapa2AQqoj60eVS2LCRPTZNnm7nmyOD7da/TjLJ2l2dLvZzMLPmO6NL4
 QsVOi2oPC0HhiiDBg+UWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+WPvPvM77DQ=:WC04ClHZb9hN7ms7ilSGHT
 Ol5vmqQbjtPokUdWAEiRkeGq/c79ZrWJOk2dgwUqpPoh91yRnRNJmeFxo+gD2lhphpAsmFYSD
 2ym6tpnSJwhOQwqY0SB+NXsuZ5ZlgUhLIjdnqis5wqdZhk5SaM20Y+tMSSo923b1FlNPEh3Bq
 zMQO38Un5mAsK36QJ3qgftN+o738/jQ7HsedTxVc2KWJ8Wm//CIwWTD1mkNnuttvXO7auqfVg
 zTcdfWGRBTLYi3U7E/evyOCSO/fdiiIh8xUlKJYcL2UU2Da52sY9F/bm8D49UcG7CtGqYBXmn
 67oDqPhBqid8SOI6hrXKTXo4tsBjDZDKuS9/JU95iHsS1wGgT9jGDcN/W1KaLBXYfsQErUe5F
 45zAuBPxP2elzwcpksUcpY38O9J//7CaI6fISVFHaJStdXzRuW3mCSqSyTJvmgZNtA1MKpYG8
 cv6lNXMXGPhKroXIgDjp/I6A797//llb/zbdt17eu1gos9/JIyTaiJf7X02mrpf0zAxHWSgZk
 jEbYL1iOXiFo/qdzTO9t3g/rDvSBrn+u3dDuVBcO32iaIcAasQ9VgMNWW4Ge1kZ5VV5Z5IZJR
 AMHmACk7jA+StdkMUoNlYtg7/9V2e2Jw0mIxYc+6m8AJoqJyC6mALaud47sfwavcHqKq122Ri
 gY+LEw4Dyzw0fNzvA1n8ogrfZAjLDDsLDYELomJmq1wQjbxdYftKJvY5kHiOotuSkNjL4OMMA
 os7m3U1Zuw+zZPd2dOiyDOsZsKigTBSX5n7OmdyUzYKJCyTBqHTw8qtpNF/TEETa+92HdQWYW
 IkA7gDTldfMis/m/nvIhhfKTj6ivQLWh3EgOgznaTtBTuGkUp8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 10:31 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> The XDMA engine embedded in the AST2500 and AST2600 SOCs performs PCI
> DMA operations between the SOC (acting as a BMC) and a host processor
> in a server.
>
> This commit adds a driver to control the XDMA engine and adds functions
> to initialize the hardware and memory and start DMA operations.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Hi Eddie,

I'm missing the bigger picture in the description here, how does this fit into
the PCIe endpoint framework and the dmaengine subsystem?

Does the AST2500 show up as a PCIe device in the host, or do you just
inject DMAs into the host and hope that bypasses the IOMMU?
If it shows up as an endpoint, how does the endpoint driver link into the
dma driver?

     Arnd
