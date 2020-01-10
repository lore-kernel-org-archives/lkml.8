Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF18AC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C58C2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+ZsCj8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgAJQDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:03:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49110 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728441AbgAJQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578672183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJ0tPacTTgP9Hfh7g8sgZ29PPH+gx4wkjqk/ijnja3Y=;
        b=M+ZsCj8yzYXF30FseKkh1nHdB3M3eLRMIrxRtyiFnhAhHYQlOFgI0EsLlWsdFcgkgeztyi
        fbW9+9XumNq2rTiSHTckeiBtcecnZX4enarlSXnZ6FW/XcC7V6cT4Gu+cekNLh0FRhmFO8
        GcMn0gko6elgQa3ojlLk+k3s2/X/rKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-zXRIj1vUNSaP6qxU8ul60w-1; Fri, 10 Jan 2020 11:03:00 -0500
X-MC-Unique: zXRIj1vUNSaP6qxU8ul60w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E9CF800D41;
        Fri, 10 Jan 2020 16:02:59 +0000 (UTC)
Received: from x1.home (ovpn-116-128.phx2.redhat.com [10.3.116.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EDC75DA32;
        Fri, 10 Jan 2020 16:02:58 +0000 (UTC)
Date:   Fri, 10 Jan 2020 09:02:55 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/mdev: make create attribute static
Message-ID: <20200110090255.20c7e765@x1.home>
In-Reply-To: <20191218123119.2582802-1-ben.dooks@codethink.co.uk>
References: <20191218123119.2582802-1-ben.dooks@codethink.co.uk>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 12:31:19 +0000
"Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk> wrote:

> The create attribute is not exported, so make it
> static to avoid the following sparse warning:
> 
> drivers/vfio/mdev/mdev_sysfs.c:77:1: warning: symbol 'mdev_type_attr_create' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
> ---
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/vfio/mdev/mdev_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
> index 7570c7602ab4..8ad14e5c02bf 100644
> --- a/drivers/vfio/mdev/mdev_sysfs.c
> +++ b/drivers/vfio/mdev/mdev_sysfs.c
> @@ -74,7 +74,7 @@ static ssize_t create_store(struct kobject *kobj, struct device *dev,
>  	return count;
>  }
>  
> -MDEV_TYPE_ATTR_WO(create);
> +static MDEV_TYPE_ATTR_WO(create);
>  
>  static void mdev_type_release(struct kobject *kobj)
>  {

Applied to vfio next branch for v5.6 with Connie's R-b.  Thanks,

Alex

