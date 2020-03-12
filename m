Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662FBC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E880206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584032813;
	bh=i19pXWfIJrErPIUaGBpjjMyXKvEVe7YfNpNTEyjZ6xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iCYIsdpJ4YFsQLnzQOTfcpGrGFu1W+V/pf7Ju9Loh4S+AXUjakUgtcxNTfu6MqWaG
	 niZOtd75NPxQ5pdbAD+kcc+xSYP3dmujZnjElW0kk+bNVTy+Jk6jnyQlCvRYQ1L4H9
	 Q72EegsI9Yz4kuR7PYzkzYaiXkIRuwOoZNonue30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgCLRGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCLRGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:06:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37485206F1;
        Thu, 12 Mar 2020 17:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584032811;
        bh=i19pXWfIJrErPIUaGBpjjMyXKvEVe7YfNpNTEyjZ6xs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zgbesH/t3cVJGL5Wrmzif2fHU4iqiLuPt6QGsuKbNsJzp5VWN2wcpCNr3OZWbX4/d
         BSU8T6I6Z9diLmT2ZCFyIV+qhSE77k+yUzV93sBDkVxWPEDMJeo2LWYIG8bauOtH/f
         CTDC99k9XBJIbcXNnMJS9q0COH3NYg0jDtIUtHzM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jCRIH-00CH4t-I4; Thu, 12 Mar 2020 17:06:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Mar 2020 17:06:49 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     catalin.marinas@arm.com, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, msalter@redhat.com,
        rrichter@marvell.com, tglx@linutronix.de
Subject: Re: [PATCH] irqchip/gic-v3: Workaround Cavium erratum 38539 when
 reading GICD_TYPER2
In-Reply-To: <CAJ+vNU3Rc1xf_vVVEONgExfpGCXC97zKZZq70iE6L2L4VKf4ZQ@mail.gmail.com>
References: <CAJ+vNU3Rc1xf_vVVEONgExfpGCXC97zKZZq70iE6L2L4VKf4ZQ@mail.gmail.com>
Message-ID: <f7be65a9e3fe4f6aa9e99f3a625da8ee@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tharvey@gateworks.com, catalin.marinas@arm.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org, msalter@redhat.com, rrichter@marvell.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

On 2020-03-12 16:56, Tim Harvey wrote:
> This resolves failure to boot on OcteonTX (TX1).
> 
> Fixes: f2d8340 ("irqchip/gic-v3: Add GICv4.1 VPEID size discovery")

I disagree here. There's nothing wrong with that initial patch,
and the bug is squarely with the hardware.

> Tested-by: Tim Harvey <tharvey@gateworks.com>

Thanks for that. I'll try and send a pull request tomorrow.

         M.
-- 
Jazz is not dead. It just smells funny...
