Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31837C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009D120870
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584966122;
	bh=Q6UWJ6CTMLxIdDC18ljrZ1TmH7PiRKcFcEA8DiZf0os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hf2zKxIRYWE+J15wRRucejroE1JdsDHO1/aCB3YUPdhkcV0dokCCjQdCBSdSNn/jH
	 A/qWIV01rgbViShC+Yms0SZiK42FHn8+CYUyaGcqu30baFika1sFuC/DHKzNcqkhsy
	 P1geNri6AkqfxPBWz3VVPhIZDYeVGudMeXEtV4M4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgCWMWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbgCWMWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:22:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE26220637;
        Mon, 23 Mar 2020 12:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584966120;
        bh=Q6UWJ6CTMLxIdDC18ljrZ1TmH7PiRKcFcEA8DiZf0os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XwTG6U8lgG7fX9ExmzfknEd8tI4N7M6X3Z8LIsRWjn9z+jg3NShSw0hGd/d96d/KV
         ghILVin2zzwR1GleB8xK2PChlCQk0DXv4BdsNDOy7Zn44jHZLds8rD3fgzXRXFS5Gm
         pK/pE1jKHZBQPW4n+1AjQIVZFq6eGUjEflYpz6DI=
Date:   Mon, 23 Mar 2020 13:21:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: soundwire updates for v5.7-rc1
Message-ID: <20200323122146.GA862622@kroah.com>
References: <20200323121151.GI72691@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323121151.GI72691@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 05:41:51PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> Here are the changes for this cycle. Bunch of stream related and pm
> related changes to core and Intel drivers. Few changes to QC driver too
> Please pull.
> 
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> 
>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.7-rc1

Pulled and pushed out, thanks.

greg k-h
