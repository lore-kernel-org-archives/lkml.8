Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED69DC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B843A20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSnhzcqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgGPSAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:00:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44341 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728182AbgGPSAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594922414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34F0M1TmEQ0nEvDmEr4oZ4wh647JI+9xjTPogrh13MQ=;
        b=FSnhzcqmXhYqBkMjL7yhhEcmg0Kpv5kfWLE8lneKfjGjSSkaYS5GIuJoh7TnYSapwVd1sT
        7X7nkyK1ge16kOanZMMIR5tz/KKkJCsf7iF+Nukb7rqgnYxYJLGE7noAB5amTIqOwlDhSE
        HHV+8L1+1DhO19I7WlO3cwNPNfDPOAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-5c02RQu0Nyicx_YLFDHhcA-1; Thu, 16 Jul 2020 14:00:13 -0400
X-MC-Unique: 5c02RQu0Nyicx_YLFDHhcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45DED18A1DE7;
        Thu, 16 Jul 2020 18:00:03 +0000 (UTC)
Received: from starship (unknown [10.35.206.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6195678525;
        Thu, 16 Jul 2020 18:00:01 +0000 (UTC)
Message-ID: <43148a2ebe546fde67028d99fd7365acce1311b2.camel@redhat.com>
Subject: Re: kernel oops in 'typec_ucsi' due to commit 'drivers property:
 When no children in primary, try secondary'
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        sakari.ailus@linux.intel.com, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Date:   Thu, 16 Jul 2020 21:00:00 +0300
In-Reply-To: <20200716154721.GO3703480@smile.fi.intel.com>
References: <7affdd923186c5ce8c7dcf7cbe7b826eaa3ac8b2.camel@redhat.com>
         <20200716154721.GO3703480@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-16 at 18:47 +0300, Andy Shevchenko wrote:
> On Thu, Jul 16, 2020 at 11:17:03AM +0300, Maxim Levitsky wrote:
> > Hi!
> > 
> > Few days ago I bisected a regression on 5.8 kernel:
> > 
> > I have nvidia rtx 2070s and its USB type C port driver (which is open source)
> > started to crash on load:
> 
> ...
> 
> > Reverting the commit helped fix this oops.
> > 
> > My .config attached.
> > If any more info is needed I'll be happy to provide it,
> > and of course test patches.
> 
> Can you test below?
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

It works (no more oops)

Best regards,
	Maxim Levitsky

