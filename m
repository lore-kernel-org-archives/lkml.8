Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E048DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA452073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrFcD0qS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgGAH6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:58:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24974 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728258AbgGAH6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593590298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/9ea6fJxVtoEvnHHWW6/ImbAY8mnV4ITQuO1snX5ok=;
        b=FrFcD0qSnd6AxGPSUYerMyZLrYQR7MfPW2OOIHzkC9ohXKlmfrgtsfYUDJ1OkviPwTHDAD
        Qy79xwcTICzWv1BOyXFnpZQf2mGtLLeYLcTD+aPkGwBLCWrbAYD54kQXviU9R/c65BJSte
        ksE+zxv6T5UvV4ELyyfiE1RYPkXg4zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-oTkEfWhLOxGA6cikhjiriQ-1; Wed, 01 Jul 2020 03:58:11 -0400
X-MC-Unique: oTkEfWhLOxGA6cikhjiriQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F4158804001;
        Wed,  1 Jul 2020 07:58:09 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-207.pek2.redhat.com [10.72.12.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F047D741A2;
        Wed,  1 Jul 2020 07:58:06 +0000 (UTC)
Date:   Wed, 1 Jul 2020 15:58:03 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     bhe@redhat.com, vgoyal@redhat.com, corbet@lwn.net,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: kdump
Message-ID: <20200701075803.GB3878@dhcp-128-65.nay.redhat.com>
References: <20200627103151.71942-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627103151.71942-1-grandmaster@al2klimov.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/20 at 12:31pm, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  Documentation/admin-guide/kdump/kdump.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 2da65fef2a1c..8cfa35f777f5 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -65,20 +65,20 @@ Install kexec-tools
>  
>  2) Download the kexec-tools user-space package from the following URL:
>  
> -http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
> +https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
>  
>  This is a symlink to the latest version.
>  
>  The latest kexec-tools git tree is available at:
>  
>  - git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> -- http://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> +- https://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>  
>  There is also a gitweb interface available at
> -http://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
> +https://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
>  
>  More information about kexec-tools can be found at
> -http://horms.net/projects/kexec/
> +https://horms.net/projects/kexec/
>  
>  3) Unpack the tarball with the tar command, as follows::
>  
> @@ -511,7 +511,7 @@ dump kernel.
>  You can also use the Crash utility to analyze dump files in Kdump
>  format. Crash is available on Dave Anderson's site at the following URL:
>  
> -   http://people.redhat.com/~anderson/
> +   https://people.redhat.com/~anderson/

Would you mind to update above url as well?

Dave have moved it to below url instead:
https://crash-utility.github.io/

Thanks
Dave

