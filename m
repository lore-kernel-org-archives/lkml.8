Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1D1C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092602146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C6AcNVIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgCERPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:15:00 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:15276 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgCEROl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583428481; x=1614964481;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5fApbeaqTcP0p/hHQ0KDa3FOcjpecfzaTtmdMnU8Cg4=;
  b=C6AcNVIgYxXMhAd+acEWJ/3LrP08LYHfFpmpLtLpyZ+6R2NXa9ihLt4J
   S41VCgOjMj7quo69lFNe2N+b4kP+q2tDI0ynQG2GPW1aneafJF9r3wkde
   ecDgTq6QiN8QoailrtC47Xo5UDEQombHTuFVnXLsuRyIb0/CBybhhHq7h
   U=;
IronPort-SDR: EtTtVXXh4nhSPq0l+1rlC6IjpDmotIhfWTqDYxh6jbBOZoG+jtgmHMuPXMXz4dXEWL2ImWfocY
 4HYs/ioX7lAg==
X-IronPort-AV: E=Sophos;i="5.70,518,1574121600"; 
   d="scan'208";a="19767269"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 05 Mar 2020 17:14:18 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id A5A5CA2090;
        Thu,  5 Mar 2020 17:14:14 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Mar 2020 17:14:13 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 5 Mar 2020 17:14:13 +0000
Received: from [10.107.3.22] (10.107.3.22) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Thu, 5 Mar 2020 17:14:08 +0000
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Subject: Re: [EXTERNAL][PATCH v4 6/6] arm64: dts: amazon: add Amazon's
 Annapurna Labs Alpine v3 support
To:     Antoine Tenart <antoine.tenart@bootlin.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <tsahee@annapurnalabs.com>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <tglx@linutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <eitan@amazon.com>
References: <20200225112926.16518-1-hhhawa@amazon.com>
 <20200225112926.16518-7-hhhawa@amazon.com> <20200304212737.GN3179@kwain>
Message-ID: <7a1c1b59-f12d-5839-beea-6af5e7998640@amazon.com>
Date:   Thu, 5 Mar 2020 19:14:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304212737.GN3179@kwain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antonie,

Thanks for reviewing,

On 3/4/2020 11:27 PM, Antoine Tenart wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> Hello,
> 
> Sorry, I'm a bit late to the party...
> 
> On Tue, Feb 25, 2020 at 01:29:26PM +0200, Hanna Hawa wrote:
>> diff --git a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
>> +     arch-timer {
> 
> Please use 'timer' instead.

Will be fixed

> 
>> +             compatible = "arm,armv8-timer";
>> +             interrupts = <GIC_PPI 0xd IRQ_TYPE_LEVEL_LOW>,
>> +                          <GIC_PPI 0xe IRQ_TYPE_LEVEL_LOW>,
>> +                          <GIC_PPI 0xb IRQ_TYPE_LEVEL_LOW>,
>> +                          <GIC_PPI 0xa IRQ_TYPE_LEVEL_LOW>;
>> +     };
> 
>> +             gic: interrupt-controller@f0000000 {
>> +                     compatible = "arm,gic-v3";
>> +                     #interrupt-cells = <3>;
>> +                     #address-cells = <0>;
> 
> No need for this.

Will be removed

> 
>> +                     interrupt-controller;
>> +                     reg = <0x0 0xf0800000 0 0x10000>,
>> +                           <0x0 0xf0a00000 0 0x200000>,
>> +                           <0x0 0xf0000000 0 0x2000>,
>> +                           <0x0 0xf0010000 0 0x1000>,
>> +                           <0x0 0xf0020000 0 0x2000>;
> 
> Please add comments here, see alpine-v2.dtsi (or other dtsi in
> arch/arm64).

Will be added.

> 
>> +                     interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +             };
>> +
>> +             msix: msix@fbe00000 {
>> +                     compatible = "al,alpine-msix";
>> +                     reg = <0x0 0xfbe00000 0x0 0x100000>;
>> +                     interrupt-controller;
>> +                     msi-controller;
>> +                     al,msi-base-spi = <160>;
>> +                     al,msi-num-spis = <800>;
>> +                     interrupt-parent = <&gic>;
>> +             };
>> +
>> +             uart0: serial@fd883000 {
> 
> Looking at the Alpine v2 dtsi, this node was put in an io-fabric bus. It
> seems to me the Alpine v3 dtsi is very similar. Would it apply as well?

V3 very similar to V2, will add to io-fabric bus and will add missing 
uart devices.

> 
>> +                     compatible = "ns16550a";
>> +                     reg = <0x0 0xfd883000 0x0 0x1000>;
>> +                     clock-frequency = <0>;
> 
> Is the frequency set to 0 on purpose? Or is it set by a firmware at boot
> time (if so please add a comment)?

It's updated by firmware, will add a comment.

> 
>> +                     interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>> +                     reg-shift = <2>;
>> +                     reg-io-width = <4>;
> 
> Since you're enabling this node explicitly in the dts, you can set it to
> disabled by default.

Ack

> 
>> +             };
>> +
>> +             pcie@fbd00000 {
> 
> Please order the nodes in increasing order.

Ack

> 
>> +                     compatible = "pci-host-ecam-generic";
>> +                     device_type = "pci";
>> +                     #size-cells = <2>;
>> +                     #address-cells = <3>;
>> +                     #interrupt-cells = <1>;
>> +                     reg = <0x0 0xfbd00000 0x0 0x100000>;
>> +                     interrupt-map-mask = <0xf800 0 0 7>;
>> +                     /* 8 x legacy interrupts for SATA only */
>> +                     interrupt-map = <0x4000 0 0 1 &gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
>> +                                     <0x4800 0 0 1 &gic 0 58 IRQ_TYPE_LEVEL_HIGH>,
>> +                                     <0x5000 0 0 1 &gic 0 59 IRQ_TYPE_LEVEL_HIGH>,
>> +                                     <0x5800 0 0 1 &gic 0 60 IRQ_TYPE_LEVEL_HIGH>,
>> +                                     <0x6000 0 0 1 &gic 0 61 IRQ_TYPE_LEVEL_HIGH>,
>> +                                     <0x6800 0 0 1 &gic 0 62 IRQ_TYPE_LEVEL_HIGH>,
>> +                                     <0x7000 0 0 1 &gic 0 63 IRQ_TYPE_LEVEL_HIGH>,
>> +                                     <0x7800 0 0 1 &gic 0 64 IRQ_TYPE_LEVEL_HIGH>;
>> +                     ranges = <0x02000000 0x0 0xfe000000 0x0 0xfe000000 0x0 0x1000000>;
>> +                     bus-range = <0x00 0x00>;
>> +                     msi-parent = <&msix>;
>> +             };
>> +     };
>> +};
> 
> The rest of the series looks good.
Thanks

Regards,
Hanna

> 
> Thanks!
> Antoine
> 
> --
> Antoine Ténart, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
