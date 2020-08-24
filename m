Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993F4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 04:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBEF20774
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 04:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qRFmeTnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHXEqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 00:46:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56906 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgHXEqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 00:46:22 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07O4k6JC054420;
        Sun, 23 Aug 2020 23:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598244366;
        bh=vK5EoOoSYppfx7vwNqDt91sXFaBIWiGuXcL3ztnH1e8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qRFmeTnc+dtfUF8xbyuF+lDiqYr73b8So9jy8ejdf9aP6cHJKM+yWp1Cts2LkRDOz
         c01j8DJVNIB1WlyA2Yg72bpDf5lxfz66viWj0D3OMW3yiLV6mQnNJJRt1kaCp9PJKD
         IhqbSf5FNaqhHgQiAQXW4CLJtyNYs4zohEGwqNWQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07O4k6HV116974
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Aug 2020 23:46:06 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 23
 Aug 2020 23:46:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 23 Aug 2020 23:46:05 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07O4jxgW000332;
        Sun, 23 Aug 2020 23:46:02 -0500
Subject: Re: [GIT PULL] irqchip fixes for 5.9, take #1
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC:     John Stultz <john.stultz@linaro.org>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh@kernel.org>, Suman Anna <s-anna@ti.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>, <kernel-team@android.com>
References: <20200818151448.472216-1-maz@kernel.org>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <63e87365-7174-4438-6503-7f9895012fb3@ti.com>
Date:   Mon, 24 Aug 2020 10:15:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200818151448.472216-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/08/20 8:44 pm, Marc Zyngier wrote:
> Hi Thomas,
> 
> As -rc1 is out, here's the first batches of fixes for 5.9. The most
> important one is a fix for a typo that broke modular irqchips using
> the brand new set of macros. Oh hum...
> 
> The rest of it is what I was hinting at when I sent the original 5.9
> pull request, with a bunch of TI updates that deal with the change of
> their firmware interface. The handling of the dependencies was bad
> enough that I couldn't send it before -rc1 was out...
> 
> Please pull,

I see rc2[0] is already tagged. Any reason why this PR is not merged?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/

Thanks and regards,
Lokesh

> 
> 	M.
> 
> The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> 
>   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.9-1
> 
> for you to fetch changes up to 7828a3ef8646fb2e69ed45616c8453a037ca7867:
> 
>   irqchip: Fix probing deferal when using IRQCHIP_PLATFORM_DRIVER helpers (2020-08-17 08:06:11 +0100)
> 
> ----------------------------------------------------------------
> irqchip fixes for Linux 5.9, take #1
> 
> - Fix an embarassing typo in the new module helpers, leading
>   to the probe failing most of the time
> 
> - The promised TI firmware rework that couldn't make it into
>   the merge window due to a very badly managed set of dependency
> 
> ----------------------------------------------------------------
> Lokesh Vutla (13):
>       firmware: ti_sci: Drop the device id to resource type translation
>       firmware: ti_sci: Drop unused structure ti_sci_rm_type_map
>       firmware: ti_sci: Add support for getting resource with subtype
>       dt-bindings: irqchip: ti, sci-intr: Update bindings to drop the usage of gic as parent
>       dt-bindings: irqchip: Convert ti, sci-intr bindings to yaml
>       irqchip/ti-sci-intr: Add support for INTR being a parent to INTR
>       dt-bindings: irqchip: ti, sci-inta: Update docs to support different parent.
>       dt-bindings: irqchip: Convert ti, sci-inta bindings to yaml
>       irqchip/ti-sci-inta: Do not store TISCI device id in platform device id field
>       irqchip/ti-sci-inta: Add support for INTA directly connecting to GIC
>       arm64: dts: k3-j721e: ti-sci-inta/intr: Update to latest bindings
>       arm64: dts: k3-am65: ti-sci-inta/intr: Update to latest bindings
>       arm64: dts: k3-am65: Update the RM resource types
> 
> Marc Zyngier (1):
>       irqchip: Fix probing deferal when using IRQCHIP_PLATFORM_DRIVER helpers
> 
>  .../bindings/interrupt-controller/ti,sci-inta.txt  |  66 ---------
>  .../bindings/interrupt-controller/ti,sci-inta.yaml |  98 +++++++++++++
>  .../bindings/interrupt-controller/ti,sci-intr.txt  |  82 -----------
>  .../bindings/interrupt-controller/ti,sci-intr.yaml | 102 ++++++++++++++
>  MAINTAINERS                                        |   4 +-
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |  36 +++--
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |  12 +-
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |   8 +-
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |   4 +-
>  .../boot/dts/ti/k3-j721e-common-proc-board.dts     |  10 +-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  43 +++---
>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |  12 +-
>  drivers/firmware/ti_sci.c                          | 155 +++++++++------------
>  drivers/irqchip/irq-ti-sci-inta.c                  |  95 ++++++++++---
>  drivers/irqchip/irq-ti-sci-intr.c                  | 152 ++++++++++++--------
>  drivers/irqchip/irqchip.c                          |   2 +-
>  include/linux/soc/ti/ti_sci_protocol.h             |  13 ++
>  17 files changed, 517 insertions(+), 377 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
> 
