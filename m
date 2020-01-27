Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA4BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5048C214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GIKMIgnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgA0PGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:06:22 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:56096 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbgA0PGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UvjYKQEomZljxw4yYS7NWvcMI7QwuePD0j2Ascrs53Y=; b=GIKMIgnLTgQ6+2t0UsJvhu9LRx
        hcRC1D95EQQ57+wINFyAWDsh9TjVnvFCYFKRqA7OgMyqB8DEh4htckxj9f6XHcCAmS8dHCFN6kRmF
        bQLaPtkJ0jLTiY+3jvakB3nTsoIK7QdxttYyzBKoYCiRShtCUwicd7gHRkCi5+smM0ek=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1iw5xu-0006rM-Jy; Mon, 27 Jan 2020 16:06:14 +0100
Date:   Mon, 27 Jan 2020 16:06:14 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?iso-8859-1?Q?J=FCrgen?= Lambrecht <j.lambrecht@televic.com>
Cc:     "Allan W. Nielsen" <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org, jiri@resnulli.us,
        ivecera@redhat.com, davem@davemloft.net, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com, anirudh.venkataramanan@intel.com,
        olteanv@gmail.com, jeffrey.t.kirsher@intel.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [RFC net-next v3 06/10] net: bridge: mrp: switchdev: Extend
 switchdev API to offload MRP
Message-ID: <20200127150614.GF13647@lunn.ch>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-7-horatiu.vultur@microchip.com>
 <20200125163504.GF18311@lunn.ch>
 <20200126132213.fmxl5mgol5qauwym@soft-dev3.microsemi.net>
 <20200126155911.GJ18311@lunn.ch>
 <20200127110418.f7443ecls6ih2fwt@lx-anielsen.microsemi.net>
 <c5733ddb-a837-b866-54bf-c631baf36c54@televic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5733ddb-a837-b866-54bf-c631baf36c54@televic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 03:26:38PM +0100, Jürgen Lambrecht wrote:
> On 1/27/20 12:04 PM, Allan W. Nielsen wrote:
> 
>             > How do you handle the 'headless chicken' scenario? User space
>             tells
>             > the port to start sending MRP_Test frames. It then dies. The
>             hardware
> 
> Andrew, I am a bit confused here - maybe I missed an email-thread, I'm sorry
> then.
> 
> In previous emails you and others talked about hardware support to send packets
> (inside the switch). But somebody also talked about data-plane and
> control-plane (about STP in-kernel being a bad idea), and that data-plane is
> in-kernel, and control plane is a mrp-daemon (in user space).
> And in my mind, the "hardware" you mention is a frame-injector and can be both
> real hardware and a driver in the kernel.
> 
> Do I see it right?

Hi Jürgen

It i still unclear where the MRP_Test frames should be generated,
forward and consumed, either in kernel, or in user space.

The userspace RSTP daemon generates and consumes all the BPDUs in
userspace. But BPDUs are never forwarded. However MRP_Test frames are
forwarded by client nodes. Are the MRP_Test frames then part of the
data plane in a client?

What i think is clear is that the state machine is in user space.

For the rest, we are still exploring possibilities.

    Andrew
