Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4645DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A2B20888
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0n0ifLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgETJsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:48:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33996 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbgETJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589968119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wpd1XgqS+on5KAHh5sZLVRwtFA9YQca65tKtlXZA2os=;
        b=I0n0ifLzvIxBZbCwwmRz6SiGAz5z6m0GrcA1JJkbxPglZCAtKisZHc5ttj3HyCmtmtG3zt
        /WZyAI+LGZldYJcBVEJjSON8eoTL82XCaLJ2zKssHdaJM3Rmr9mka8JCxK6ex2ul4Fr7CE
        lgwK24NWw13M7P+hJSXgVIuurm5Zb64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-xkI0fkMXN5ObdsgU6-QH9A-1; Wed, 20 May 2020 05:48:37 -0400
X-MC-Unique: xkI0fkMXN5ObdsgU6-QH9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10832474;
        Wed, 20 May 2020 09:48:36 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-148.pek2.redhat.com [10.72.12.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98BED5D9CA;
        Wed, 20 May 2020 09:48:33 +0000 (UTC)
Date:   Wed, 20 May 2020 17:48:29 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, vgoyal@redhat.com
Subject: Re: [PATCH] MAINTAINERS: add files related to kdump
Message-ID: <20200520094829.GA21486@dhcp-128-65.nay.redhat.com>
References: <20200520080557.13260-1-bhe@redhat.com>
 <20200520091440.GA5052@dhcp-128-65.nay.redhat.com>
 <20200520094359.GV5029@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520094359.GV5029@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/20/20 at 05:43pm, Baoquan He wrote:
> On 05/20/20 at 05:14pm, Dave Young wrote:
> > Hi Baoquan,
> > On 05/20/20 at 04:05pm, Baoquan He wrote:
> > > Kdump is implemented based on kexec, however some files are only
> > > related to crash dumping and missing, add them to KDUMP entry.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  MAINTAINERS | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 83cf5c43242a..2f9eefd33114 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9251,6 +9251,11 @@ L:	kexec@lists.infradead.org
> > >  S:	Maintained
> > >  W:	http://lse.sourceforge.net/kdump/
> > >  F:	Documentation/admin-guide/kdump/
> > > +F:	fs/proc/vmcore.c
> > > +F:	include/linux/crash_core.h
> > > +F:	include/linux/crash_dump.h
> > > +F:	include/uapi/linux/vmcore.h
> > > +F:	kernel/crash.*
> > 
> > ls kernel/crash.*
> > ls: cannot access 'kernel/crash.*': No such file or directory
> > 
> > But ls kernel/crash*
> > kernel/crash_core.c  kernel/crash_dump.c
> 
> Is below patten ok? Surely kernel/crash* is also OK to me. Thanks.
> 
> F:	kernel/crash_*.c

Yes, looks good, thanks!

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

