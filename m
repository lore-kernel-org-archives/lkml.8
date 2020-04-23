Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747EDC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52FF120728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587668647;
	bh=kK26GXQzMiTMyy878qmRigiVH41QBiVzVuRwlrhitlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NEjYhjd+eARXcTA06p45BycalArk/LSZqY52dGFhlG+lLOL0JXDXTQisrY9SmLYgt
	 q7ZrE8zuqHgHTnuMN299EF52gji6+bRhWZb+tuIyFoCRJlBlCDHbHeZz5WtcZP55BV
	 gT1Jz10hSRPN7osLb8/bBke3SWSni3mI+TNtHizY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgDWTEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgDWTEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:04:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1932E20776;
        Thu, 23 Apr 2020 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587668644;
        bh=kK26GXQzMiTMyy878qmRigiVH41QBiVzVuRwlrhitlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMZUScWq/xw/C+CsdAxpXGW06eYrEOyX1XDuViZd0V+5wSZ5QVhpU3OdYhT1GZcOi
         q5RIV+HWdHCf6LMJD9DvRyR2UlMfrIbh/PVKhhdTHIuhIJZsNarZWGOMa6L6sIyAQ4
         OCMPzFgo6xPJQ5XLKykLQj5KFka/92VzIRl1yzbA=
Date:   Thu, 23 Apr 2020 21:04:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Richard Yeh <rcy@google.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add rcy@google.com as maintainer for
 drivers/staging/gasket
Message-ID: <20200423190402.GB80479@kroah.com>
References: <20200423185052.143975-1-rcy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423185052.143975-1-rcy@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 02:50:52PM -0400, Richard Yeh wrote:
> From: Richard C Yeh <rcy@google.com>
> 
> After consultation with Todd Poynor and Jesse Barnes, I am
> adding myself as a maintainer for drivers/staging/gasket
> 
> Signed-off-by: Richard C Yeh <rcy@google.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

I need confirmation from them as well, any reason you didn't cc: them on
this patch?

Please fix that up and resend.

thanks,

greg k-h
