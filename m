Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526C9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E60B206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBMlDNwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgETJOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:14:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29897 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbgETJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589966090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTNW2Odgu4ScH3HKgo9G9zShqsDjgwB0JmSMhzXEj+4=;
        b=PBMlDNwJAEizn19Dn9oAWcFplAvAQrUYwjOIFNk7KrFdNjjdMUSuXBKI9hExAYRaW9HflN
        eTK/e/NefdbXYXb31E6sAUM9Vg9e1S9EEZl1oKmYWfYmflzFNS8NpuirNpTbVYfx9RGTym
        WY3ljGwBcdNFx+urNtLH1ApsfLRKhT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-ZHWyfhhfNHqF41LTeCUsgQ-1; Wed, 20 May 2020 05:14:48 -0400
X-MC-Unique: ZHWyfhhfNHqF41LTeCUsgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F5178005AA;
        Wed, 20 May 2020 09:14:47 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-148.pek2.redhat.com [10.72.12.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99A6360BEC;
        Wed, 20 May 2020 09:14:44 +0000 (UTC)
Date:   Wed, 20 May 2020 17:14:40 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kexec@lists.infradead.org, vgoyal@redhat.com
Subject: Re: [PATCH] MAINTAINERS: add files related to kdump
Message-ID: <20200520091440.GA5052@dhcp-128-65.nay.redhat.com>
References: <20200520080557.13260-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520080557.13260-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,
On 05/20/20 at 04:05pm, Baoquan He wrote:
> Kdump is implemented based on kexec, however some files are only
> related to crash dumping and missing, add them to KDUMP entry.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 83cf5c43242a..2f9eefd33114 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9251,6 +9251,11 @@ L:	kexec@lists.infradead.org
>  S:	Maintained
>  W:	http://lse.sourceforge.net/kdump/
>  F:	Documentation/admin-guide/kdump/
> +F:	fs/proc/vmcore.c
> +F:	include/linux/crash_core.h
> +F:	include/linux/crash_dump.h
> +F:	include/uapi/linux/vmcore.h
> +F:	kernel/crash.*

ls kernel/crash.*
ls: cannot access 'kernel/crash.*': No such file or directory

But ls kernel/crash*
kernel/crash_core.c  kernel/crash_dump.c

Thanks
Dave

