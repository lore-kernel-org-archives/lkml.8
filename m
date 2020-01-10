Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B486C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFB52082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBFbzPy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgAJQDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:03:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55136 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728485AbgAJQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578672190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYO3IdV4XjqPTQ/KIF6IAurxizcacvK4nlGDeJn6JL4=;
        b=IBFbzPy+WYjcyvjdWwnOVQjRcXlkRG24hqnmiMURtEf88S+AJV+R6sVeCJuduZqGrSlmtO
        sHWCPr3kbEHfGw6hVXxUyCkaZsp/9b4KiLoy3oPXmzW+2UF1LjsUYP5vJsAusoRCh3hxkE
        hN0ErPL7NP2lGs+CbyBgRQFOX3lKRY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-w25tIFdOOsqY_JmDpotDGQ-1; Fri, 10 Jan 2020 11:03:07 -0500
X-MC-Unique: w25tIFdOOsqY_JmDpotDGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C390A1800D71;
        Fri, 10 Jan 2020 16:03:05 +0000 (UTC)
Received: from x1.home (ovpn-116-128.phx2.redhat.com [10.3.116.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7171E19C4F;
        Fri, 10 Jan 2020 16:03:02 +0000 (UTC)
Date:   Fri, 10 Jan 2020 09:02:59 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     Eric Auger <eric.auger@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Allison Randal <allison@lohutok.net>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: platform: fix __iomem in vfio_platform_amdxgbe.c
Message-ID: <20200110090259.3ab06f7c@x1.home>
In-Reply-To: <20191218133525.2608583-1-ben.dooks@codethink.co.uk>
References: <20191218133525.2608583-1-ben.dooks@codethink.co.uk>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 13:35:25 +0000
"Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk> wrote:

> The ioaddr should have __iomem marker on it, so add that to fix
> the following sparse warnings:
> 
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:33:44: warning: incorrect type in argument 2 (different address spaces)
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:33:44:    expected void volatile [noderef] <asn:2> *addr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:33:44:    got void *
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:34:33: warning: incorrect type in argument 1 (different address spaces)
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:34:33:    expected void const volatile [noderef] <asn:2> *addr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:34:33:    got void *
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:44:44: warning: incorrect type in argument 2 (different address spaces)
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:44:44:    expected void volatile [noderef] <asn:2> *addr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:44:44:    got void *
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:45:33: warning: incorrect type in argument 2 (different address spaces)
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:45:33:    expected void volatile [noderef] <asn:2> *addr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:45:33:    got void *
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:69:41: warning: incorrect type in argument 1 (different address spaces)
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:69:41:    expected void *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:69:41:    got void [noderef] <asn:2> *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:71:30: warning: incorrect type in argument 1 (different address spaces)
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:71:30:    expected void *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:71:30:    got void [noderef] <asn:2> *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:76:49: warning: incorrect type in argument 1 (different address spaces)
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:76:49:    expected void *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:76:49:    got void [noderef] <asn:2> *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:85:37: warning: incorrect type in argument 1 (different address spaces)
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:85:37:    expected void *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:85:37:    got void [noderef] <asn:2> *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:87:30: warning: incorrect type in argument 1 (different address spaces)
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:87:30:    expected void *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:87:30:    got void [noderef] <asn:2> *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:90:30: warning: incorrect type in argument 1 (different address spaces)
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:90:30:    expected void *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:90:30:    got void [noderef] <asn:2> *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:93:30: warning: incorrect type in argument 1 (different address spaces)
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:93:30:    expected void *ioaddr
> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:93:30:    got void [noderef] <asn:2> *ioaddr
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
> ---
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/vfio/platform/reset/vfio_platform_amdxgbe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> index 2d2babe21b2f..ecfc908de30f 100644
> --- a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> +++ b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> @@ -24,7 +24,7 @@
>  #define MDIO_AN_INT		0x8002
>  #define MDIO_AN_INTMASK		0x8001
>  
> -static unsigned int xmdio_read(void *ioaddr, unsigned int mmd,
> +static unsigned int xmdio_read(void __iomem *ioaddr, unsigned int mmd,
>  			       unsigned int reg)
>  {
>  	unsigned int mmd_address, value;
> @@ -35,7 +35,7 @@ static unsigned int xmdio_read(void *ioaddr, unsigned int mmd,
>  	return value;
>  }
>  
> -static void xmdio_write(void *ioaddr, unsigned int mmd,
> +static void xmdio_write(void __iomem *ioaddr, unsigned int mmd,
>  			unsigned int reg, unsigned int value)
>  {
>  	unsigned int mmd_address;

Applied to vfio next branch for v5.6 with Eric's Ack.  Thanks,

Alex

