Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D246C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0243B20732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587018633;
	bh=Uc+wglkfcFcnujcwTpEjeJ1Iv8qtEzNgyuqAg5SvGZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X13oO2RVcCQlDzfz1zqt8KXcml5VRVxmWB5dn/qIQrb+98vTbvTdPReTHNbZSyk4u
	 2UqbdomhzMK2O68N1SrZWqSfHXgJo+d5I+ncBVc7RtSbHLOfOtrAN6Xdj3r8VdUuPd
	 XvrCsPx5cdLIZ4xp9heHQAziuMJP9GNzRfK/XkWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407961AbgDPGab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408110AbgDPGaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:30:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC6020732;
        Thu, 16 Apr 2020 06:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587018606;
        bh=Uc+wglkfcFcnujcwTpEjeJ1Iv8qtEzNgyuqAg5SvGZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qP6kH0D4GuAzSBLnpw9Ff8LwjKagJaYPK1ss5GiN8vEpT320p2mSdWhNo8ApFQrjY
         GYzmBaaMEV0qBpaNaH7K8xZ1FZWyqIgiY+PRGhBX1dU3kRqegeZh79fvm6B0nj7h0n
         TLy1250+GBD/brVAq+llty5TgDa9Vw2UWqh7rrXs=
Date:   Thu, 16 Apr 2020 08:30:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Scott Wood <oss@buserror.net>
Cc:     Wang Wenhu <wenhu.wang@vivo.com>, linux-kernel@vger.kernel.org,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        kernel@vivo.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2,5/5] drivers: uio: new driver for fsl_85xx_cache_sram
Message-ID: <20200416063002.GA299193@kroah.com>
References: <20200415124929.GA3265842@kroah.com>
 <20200415152442.122873-1-wenhu.wang@vivo.com>
 <20200415152442.122873-6-wenhu.wang@vivo.com>
 <ef9f59f98f6bcf81891de87fd9cd0b5973bbd468.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef9f59f98f6bcf81891de87fd9cd0b5973bbd468.camel@buserror.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:26:55PM -0500, Scott Wood wrote:
> Instead, have module parameters that take the sizes and alignments you'd like
> to allocate and expose to userspace.  Better still would be some sort of
> dynamic allocation (e.g. open a fd, ioctl to set the requested size/alignment,
> if it succeeds you can mmap it, and when the fd is closed the region is
> freed).

No module parameters please, this is not the 1990's.

Use device tree, that is what it is there for.

thanks,

greg k-h
