Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD24C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6778521569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAMPNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:13:37 -0500
Received: from foss.arm.com ([217.140.110.172]:40620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728688AbgAMPNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:13:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7625C11B3;
        Mon, 13 Jan 2020 07:13:32 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B01393F68E;
        Mon, 13 Jan 2020 07:13:30 -0800 (PST)
Date:   Mon, 13 Jan 2020 15:13:24 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rajan Vaja <RAJANV@xilinx.com>
Cc:     Jolly Shah <JOLLYS@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>
Subject: Re: [PATCH 0/2] arch: arm64: xilinx: Make zynqmp_firmware driver
 optional
Message-ID: <20200113151324.GA8647@bogus>
References: <1578596764-29351-1-git-send-email-jolly.shah@xilinx.com>
 <20200110115415.GC39451@bogus>
 <BYAPR02MB4055B8A5ED27C2F23A28D8D0B7350@BYAPR02MB4055.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB4055B8A5ED27C2F23A28D8D0B7350@BYAPR02MB4055.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 06:46:52AM +0000, Rajan Vaja wrote:
> Hi Sudeep,
> 
> Thanks for the reviewing patch.
> 
> > -----Original Message-----
> > From: Sudeep Holla <sudeep.holla@arm.com>
> > Sent: 10 January 2020 05:24 PM
> > To: Jolly Shah <JOLLYS@xilinx.com>
> > Cc: ard.biesheuvel@linaro.org; mingo@kernel.org; gregkh@linuxfoundation.org;
> > matt@codeblueprint.co.uk; hkallweit1@gmail.com; keescook@chromium.org;
> > dmitry.torokhov@gmail.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Sudeep Holla <sudeep.holla@arm.com>; Tejas Patel
> > <TEJASP@xilinx.com>
> > Subject: Re: [PATCH 0/2] arch: arm64: xilinx: Make zynqmp_firmware driver
> > optional
> > 
> > EXTERNAL EMAIL
> > 
> > On Thu, Jan 09, 2020 at 11:06:02AM -0800, Jolly Shah wrote:
> > > From: Tejas Patel <tejas.patel@xilinx.com>
> > >
> > > Zynqmp firmware driver requires firmware to be present in system.
> > > Zynqmp firmware driver will crash if firmware is not present in system.
> > > For example single arch QEMU, may not have firmware, with such setup
> > > Linux booting fails.
> > >
> > > So make zynqmp_firmware driver as optional to disable it if user don't
> > > have firmware in system.
> > >
> > 
> > Why can't it be detected runtime ? How do you handle single binary if you
> > make this compile time option ?
> [Rajan] There is PMU register which indicates if firmware is present or not,
> but in case of single arch QEMU that register will not be available so
> there is no way to detect if firmware is present or not from Linux.

I am still not that convinced yet.

> Linux firmware crashes while arm_smccc_smc() call for firmware, but before
> this call there is no way  to identify if firmware is present or not. So we
> are just giving user an option if they want to use it on single arch

So IIUC this platform used SMC as transport for EEMI communication. And
PSCI will act as bypass and send the command to PMU. If so why can't
platform PSCI implementation send error to OSPM if it is not implemented.

> Platform they can disable firmware driver.
>

Not an option. With this enable, single binary should work fine on both
QEMU and your platform with this EEMI firmware support. You need to find
a way to detect it dynamically.

--
Regards,
Sudeep
