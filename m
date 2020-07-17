Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB72C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930042173E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnE98u9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgGQOFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:05:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28829 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726675AbgGQOFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594994731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/lQ3vRdbtpZD9qapzymRha97VMv2A/d7HdoKx/dG3o=;
        b=UnE98u9hbf3+YtVBfKUJOugoMgoJjIN748Yj9mcBh6kO8Sv3ZhwKPtpk/boR/Iz7Y/mDGK
        c3KZ+TW/br4D4ZasJ2nT3i3L0QhsrZwiSe4tJ3sERBnB5IrTniSovLmwf7ByHYxUuQREbA
        u0WzpnHzeSs+q8GdG7FPGhBWot6r/Pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-rydC_LwtPriSHU_3ZM-HHg-1; Fri, 17 Jul 2020 10:05:29 -0400
X-MC-Unique: rydC_LwtPriSHU_3ZM-HHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63AFF18A1DE1;
        Fri, 17 Jul 2020 14:05:28 +0000 (UTC)
Received: from starship (unknown [10.35.206.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEA551002397;
        Fri, 17 Jul 2020 14:05:26 +0000 (UTC)
Message-ID: <681fa44e57531c81bef628f8a16a14098abdf2c2.camel@redhat.com>
Subject: Re: [PATCH v1] device property: Avoid NULL pointer dereference in
 device_get_next_child_node()
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Jul 2020 17:05:25 +0300
In-Reply-To: <20200716182747.54929-1-andriy.shevchenko@linux.intel.com>
References: <20200716182747.54929-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-16 at 21:27 +0300, Andy Shevchenko wrote:
> When we have no primary fwnode or when it's a software node, we may end up
> in the situation when fwnode is a NULL pointer. There is no point to look for
> secondary fwnode in such case. Add a necessary check to a condition.
> 
> Fixes: 114dbb4fa7c4 ("drivers property: When no children in primary, try secondary")
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tested-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

> ---
>  drivers/base/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 1e6d75e65938..d58aa98fe964 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -721,7 +721,7 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
>  		return next;
>  
>  	/* When no more children in primary, continue with secondary */
> -	if (!IS_ERR_OR_NULL(fwnode->secondary))
> +	if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
>  		next = fwnode_get_next_child_node(fwnode->secondary, child);
>  
>  	return next;


