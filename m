Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC79C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DB3214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M5Y0a9Fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390686AbgAXRh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:37:29 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53186 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390354AbgAXRhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=G86FZTcHn/oMBBx6RFTrYjvwIujQU9r6hS03SoZfBwo=; b=M5Y0a9FlG3s9A65UDLSA37oMrU
        5OSxplA+d5tB2I9cPTXxf/H2YGVTlo57j7O0zrEwh4TO895FvN0iap+f+SzG4//k6a5/ja0C+SOCp
        bhIsBgBE/uEtql9FTUEgbedwsEv02gYoNPr/yYmt+GspdMF59mfpAmOKtLJijIPUq7tQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1iv2tS-0003SZ-5F; Fri, 24 Jan 2020 18:37:18 +0100
Date:   Fri, 24 Jan 2020 18:37:18 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org, jiri@resnulli.us,
        ivecera@redhat.com, davem@davemloft.net, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com, anirudh.venkataramanan@intel.com,
        olteanv@gmail.com, jeffrey.t.kirsher@intel.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [RFC net-next v3 02/10] net: bridge: mrp: Expose function
 br_mrp_port_open
Message-ID: <20200124173718.GB13647@lunn.ch>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124161828.12206-3-horatiu.vultur@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 05:18:20PM +0100, Horatiu Vultur wrote:
> In case the HW is capable to detect when the MRP ring is open or closed. It is
> expected that the network driver will notify the bridge that the ring is open or
> closed.
> 
> The function br_mrp_port_open is used to notify the kernel that one of the ports
> stopped receiving MRP_Test frames. The argument 'loc' has a value of '1' when
> the port stopped receiving MRP_Test and '0' when it started to receive MRP_Test.

Hi Horatiu

Given the name of the function, br_mrp_port_open(), how about replacing
loc with a bool with the name open?

    Andrew
