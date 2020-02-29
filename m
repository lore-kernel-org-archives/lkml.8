Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6591BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360F920866
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l9EQuuIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgB2QkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:40:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgB2QkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=QKxTCrWTi/nBnxdSjd5RMFTXvxgyun4TFo8efZJ13XI=; b=l9EQuuIWGaVP/vj9Z3i5+dLoQE
        jRJJbU2s4kedO8kne+4uf9LmU4mCuv/g4cAe3tYmuBZiQvDx9JE9OfEzkjnx2AzzFAiXu3E3FR3wV
        Gp6k64adhxHt7sQCPnRTtyLYaWoTxTKdMUilUrEDcedpPMy61uAmB1Ba1EU0XRxXt3m4QFwpbKiHi
        l/J548t1HmGN3dGhn6rgUQOpsrFUWYRJ/z5JlIvB6idG5DPnsAfHvUE01wafuWkPgQtnvPUCg8uvp
        TgjRgn3gcKVU48nh9CNxPAxJykzsOTJ8YcwXykExObluInnr9x0k2j+FVNIGx+VRDdi/o79JOFA1r
        zDnHaPVQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j859x-0001b0-N1; Sat, 29 Feb 2020 16:40:13 +0000
Subject: Re: [PATCH 0/7] parport: Use generic kernel logging styles
To:     Joe Perches <joe@perches.com>, linux-parisc@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org
References: <69fb1d36-b6cf-7c46-96d1-9403de6ab47a@infradead.org>
 <cover.1582878393.git.joe@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d03d6ce4-f40e-2905-1641-089a82720383@infradead.org>
Date:   Sat, 29 Feb 2020 08:40:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cover.1582878393.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 12:32 AM, Joe Perches wrote:
> Well, if the parport logging is getting some generic fixing,
> here's some more generic logging fixing...
> 
> Joe Perches (7):
>   parport: Convert printk(KERN_<LEVEL> to pr_<level>(
>   parport: Use more comon logging styles
>   parport: daisy: Convert DPRINTK to pr_debug
>   parport_amiga: Convert DPRINTK to pr_debug
>   parport_mfc3: Convert DPRINTK to pr_debug
>   parport_pc: Convert DPRINTK to pr_debug
>   parport: Standardize use of printmode

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, Joe.

>  drivers/parport/daisy.c          |  29 +---
>  drivers/parport/ieee1284.c       |   4 +-
>  drivers/parport/ieee1284_ops.c   |   3 +-
>  drivers/parport/parport_amiga.c  |  22 +--
>  drivers/parport/parport_atari.c  |   2 +-
>  drivers/parport/parport_cs.c     |   6 +-
>  drivers/parport/parport_gsc.c    |  25 +--
>  drivers/parport/parport_gsc.h    |  21 ++-
>  drivers/parport/parport_ip32.c   | 117 +++++++-------
>  drivers/parport/parport_mfc3.c   |  21 +--
>  drivers/parport/parport_pc.c     | 263 +++++++++++++------------------
>  drivers/parport/parport_sunbpp.c |   2 +-
>  drivers/parport/probe.c          |  34 ++--
>  drivers/parport/procfs.c         |   6 +-
>  drivers/parport/share.c          |  37 +++--
>  15 files changed, 261 insertions(+), 331 deletions(-)
> 


-- 
~Randy

