Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206BBC33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 19:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED996206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 19:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="xc1aDSVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgASTiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 14:38:20 -0500
Received: from the.earth.li ([46.43.34.31]:37740 "EHLO the.earth.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgASTiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 14:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ppj9LMtNCeV2J3j303cgKBSHum8gMjnB9xEbdvnn2/8=; b=xc1aDSVCgywFQ4hFGNEm9nOsQe
        Xn85YtEyufN7RDXzN5wyMnm77JDbwKocEdBXC2oRhbUGr+JIdU9iTT4rkqVhCIYbY3BjqjHOIRJaU
        81eHYUOPmlj6UgwlL21BZpb3Su7y2sL36d2oK3lpRqG8d+U/1jlKprbjELrjjrJNburJ0G4lVB4lF
        nBxkpgwH41dyntQFd1AGUqQl3n8QOMAy9ttBUyV1TtExoid7z5R6sizHXhSn6z6KagtaCmfJbiMvE
        3cE76pUA0j2NdGWjb5SOBlgoLfWy2ToXW9rcE5eQD6sVBRg5SwVcu24A3JiUZWZeO52xGPjx2qcAS
        WqYTHFRg==;
Received: from noodles by the.earth.li with local (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1itGOn-0005Ah-I1; Sun, 19 Jan 2020 19:38:17 +0000
Date:   Sun, 19 Jan 2020 19:38:17 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ken Moffat <zarniwhoop73@googlemail.com>
Subject: Re: [PATCH v2 0/5] hwmon: k10temp driver improvements
Message-ID: <20200119193817.GM15976@earth.li>
References: <20200119101855.GA15446@earth.li>
 <f9bb13a7-60ba-37f1-9e22-3237e35cf4e5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9bb13a7-60ba-37f1-9e22-3237e35cf4e5@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 07:46:11AM -0800, Guenter Roeck wrote:
> On 1/19/20 2:18 AM, Jonathan McDowell wrote:
> > 
> > In article <20200118172615.26329-1-linux@roeck-us.net> (earth.lists.linux-kernel) you wrote:
> > > This patch series implements various improvements for the k10temp driver.
> > ...
> > > The voltage and current information is limited to Ryzen CPUs. Voltage
> > > and current reporting on Threadripper and EPYC CPUs is different, and the
> > > reported information is either incomplete or wrong. Exclude it for the time
> > > being; it can always be added if/when more information becomes available.
> > 
> > > Tested with the following Ryzen CPUs:
> > 
> > Tested-By: Jonathan McDowell <noodles@earth.li>
> > 
> Thanks!
> 
> > Tested on a Ryzen 7 2700 (patched on top of 5.4.13):
> > 
> > | k10temp-pci-00c3
> > | Adapter: PCI adapter
> > | Vcore:        +0.80 V
> > | Vsoc:         +0.81 V
> > | Tdie:         +37.0°C
> > | Tctl:         +37.0°C
> > | Icore:        +8.31 A
> > | Isoc:         +6.86 A
> > 
> > Like the 1300X case I see a discrepancy compared to what the nct6779
> > driver says Vcore is:
> > 
> > | nct6779-isa-0290
> > | Adapter: ISA adapter
> > | Vcore:                  +0.33 V  (min =  +0.00 V, max =  +1.74 V)
> 
> I see that on all of my boards as well (3900X, different boards and board vendors),
> with temperatures reported by the Super-IO chip sometimes as low as 0.18V (!).
> Yet, there is a clear correlation of that voltage with CPU load.
> I suspect the measurement by the Super-IO chip is a different voltage.
> 
> I don't think there is anything we can do about that without access to more
> information.
...
> The problem with Ken's board is that idle current and voltage are very high.
> The idle voltage claims to be higher than the voltage under load, which
> doesn't really make sense. This is only reflected in the voltage and current
> reported by the CPU, but not by the voltage reported by the Super-IO chip.

I see clear correlation between load/Vcore/Icore/Tdie from your patched
k10temp driver which leads me to believe these numbers are valid for the
2700. Vsoc is fairly consistent and Isoc doesn't vary much either
(6.3-8.1A range over the past 8 hours).

J.

-- 
... "f u cn rd ths, u cn gt a gd jb n cmptr prgrmmng." -- Simon Cozens,
    ox.os.linux
