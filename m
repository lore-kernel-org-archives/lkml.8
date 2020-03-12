Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95469C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E62520578
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584003356;
	bh=6SJ9ezsUkboLt87ukZwiXOGJD9tIGO3OCl7CiC9dJZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=B8XXTDnAtWkDsUgcnKEAgKbw8WnleTtiAKbevdFTpsISt7aClg4McBktXduuNSLiK
	 hqROQm40uzEWS/FI/LoB51N2WG3/mrco2TUimjSCFMAwexbAQCqPyYiG6sWNPYTmHd
	 eWcaWIWDfkGn8lga7E5avLhBFGyohTVHWWaBOvO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCLIzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgCLIzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:55:54 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1230320578;
        Thu, 12 Mar 2020 08:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584003354;
        bh=6SJ9ezsUkboLt87ukZwiXOGJD9tIGO3OCl7CiC9dJZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oKP6ts5JB9e+zG8fRtj5hLtEWt+4qXnFkcCdGKxhF2OXJup1kiv/BFSa/KqWB5gJt
         P7aaB/sDNWfbHIhGSMQICdVNwkZqbMXxDaUBgFXcjJgJhXVnONJH+/cjyVqts9TRIZ
         tgHbHaVwqCffhO+xMJR/L8CYAzTNm2uYEbcYA6RE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jCJdA-00CADA-Bd; Thu, 12 Mar 2020 08:55:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Mar 2020 08:55:52 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Sunil Goutham <sgoutham@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        Robert Richter <rrichter@marvell.com>
Subject: Re: CN80xx (octeontx/thunderx) breakage from f2d8340
In-Reply-To: <CAJ+vNU0qVnCkWpG_NKNQTdYf5LJpRrgOeWX0xH=GgavKJ1QNwg@mail.gmail.com>
References: <CAJ+vNU0qVnCkWpG_NKNQTdYf5LJpRrgOeWX0xH=GgavKJ1QNwg@mail.gmail.com>
Message-ID: <0c3c16c770d21e5ad2276c83feb27ce4@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tharvey@gateworks.com, linux-kernel@vger.kernel.org, david.daney@cavium.com, sgoutham@cavium.com, jglauber@cavium.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On 2020-03-11 20:17, Tim Harvey wrote:
> Marc,
> 
> Im seeing a failure to boot on an octeontx CN80xx (thunderx) due to
> f2d8340 ("irqchip/gic-v3: Add GICv4.1 VPEID size discovery"). I'm not
> sure if something is hanging, I just get no console output from the
> kernel.

That's odd. It probably means that a SError has been taken to EL3,
and the firmware is not equipped to deal with it. Great stuff!

> Is there perhaps something in the dt that requires change? The
> board/dts I'm using is:
> https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/gw6404-linux.dts
> https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/gw640x-linux.dtsi
> https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/cn81xx-linux.dtsi
> 
> Any ideas? I've cc'd the Cavium/Marvell folk to see if they know
> what's up or can reproduce on some of their hardware.

This is most probably Cavium erratum 38539. Please give [1] a go and
let me know whether it helps by replying to the patch.

Thanks,

         M.

[1] https://lore.kernel.org/lkml/20200311115649.26060-1-maz@kernel.org/
-- 
Jazz is not dead. It just smells funny...
