Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE07C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727D82065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595951659;
	bh=5grVaxx03r95Q3bjMQFvf8kKT48kPRH1h2aQey01AlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UTX9bbdXxAlDmnVYNs/jagjssJwFxjjeLcLB0y2ezmUV/zwJlN+64RKUBP9luL+Zr
	 y2DQ6smB1sbbll+rNeIBQC3UBbNLU2XcBKv26NbZm9qNIzPCJYC7/1ZNSZJX+XeNGG
	 cz68UD5DOayVdlSp2BFxHpVptraW3gr/F9jvRZHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbgG1PyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731164AbgG1PyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:54:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0956C2065C;
        Tue, 28 Jul 2020 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595951655;
        bh=5grVaxx03r95Q3bjMQFvf8kKT48kPRH1h2aQey01AlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bs1Pt0CJedojEUmMCvgAYJbQlOmSCtInD81H4/gIm/ln97HpzwdTcSP7vX2VsMLMO
         z1vmrMWQ+kP81aXMJJIrkJFMW30BFLuGfetAA1x5QW6p65uL5lgxpEyDJ+8QNGoeP4
         oPsF/KB5tvhAVgzN9yJ+IidiBQPrESJYN2IvGUWo=
Date:   Tue, 28 Jul 2020 17:54:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next] mei: add device type
Message-ID: <20200728155408.GB4178776@kroah.com>
References: <20200728152546.3041841-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728152546.3041841-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 06:25:46PM +0300, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> Some of the device heads are not generic and have
> specific purpose, we need to announce it to the user space
> so it can detect and correct device node via matching
> attributes.
> 
> Generic devices are marked as 'mei' while special
> purpose their own names. Currently we are adding
> 'itouch' string for Intel IPTS devices.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/hw-me.c   | 12 ++++++++++++
>  drivers/misc/mei/hw-me.h   |  5 +++++
>  drivers/misc/mei/hw-txe.c  |  1 +
>  drivers/misc/mei/main.c    | 27 +++++++++++++++++++++++++++
>  drivers/misc/mei/mei_dev.h |  4 ++++
>  drivers/misc/mei/pci-me.c  |  8 ++++----
>  6 files changed, 53 insertions(+), 4 deletions(-)

No Documentation/ABI/ update for this new sysfs file?

:(

