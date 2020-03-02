Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80314C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AF2214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhLRf+jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCBPJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:09:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38063 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727070AbgCBPJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583161762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KN1fqfQyEbwXImklW+2ThcI2BflCcy0zp7lyoZJOx4k=;
        b=PhLRf+jp5XK2F3uLRpWmFRiCXsqdl3YeL9bsb36eGqig+KHyFT80v5PxTzsRqWbBjzqG0q
        SktH0VrLyRppA3Z3W91QYVDRSBiafyfPUFxQ9iCJtNtwJ8xDNIl9RL0fgmrqsGJJzer0hO
        aA3hsUFpaSOdBqO6OQs0EWboOqlwNNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-3hkzKmMsNLKPX4c2s3YGhg-1; Mon, 02 Mar 2020 10:09:18 -0500
X-MC-Unique: 3hkzKmMsNLKPX4c2s3YGhg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39933801E76;
        Mon,  2 Mar 2020 15:09:15 +0000 (UTC)
Received: from krava (ovpn-205-46.brq.redhat.com [10.40.205.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D4F39CA3;
        Mon,  2 Mar 2020 15:09:06 +0000 (UTC)
Date:   Mon, 2 Mar 2020 16:09:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v3 6/8] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Message-ID: <20200302150903.GC259142@krava>
References: <20200229094159.25573-1-kjain@linux.ibm.com>
 <20200229094159.25573-7-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229094159.25573-7-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 03:11:57PM +0530, Kajol Jain wrote:

SNIP

> +					*dst++ = paramval[i++];
> +				free(paramval);
> +			}
> +		}
>  		else
>  			*dst++ = *str;
>  		str++;
> @@ -72,8 +86,8 @@ number		[0-9]+
>  
>  sch		[-,=]
>  spec		\\{sch}
> -sym		[0-9a-zA-Z_\.:@]+
> -symbol		{spec}*{sym}*{spec}*{sym}*
> +sym            [0-9a-zA-Z_\.:@?]+
> +symbol         {spec}*{sym}*{spec}*{sym}*{spec}*{sym}
>  
>  %%
>  	{
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 4720cbe79357..0f3ef0f37bf4 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -38,6 +38,8 @@
>  %type <num> expr if_expr
>  
>  %{
> +int expr__runtimeparam;

we don't like global variables.. could this be part of the
contaxt struct?

jirka

