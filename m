Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EF8C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F98520724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4Fvifoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgCRMOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:14:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43385 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbgCRMOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584533669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fyo+3W2bign2DaLLTkf6yvivecH8/qfxol2hfF/3zJs=;
        b=M4Fvifoo7llxtE/r56pV4yGCH/WbVagr42nl/tkvigTouZx4Vd55OAYgIAGFn1gWc5k1qN
        XB+c7zbpu7zAGRu5FMkJlCZunH+C3B5RgkV4cR/EZeR7a8eWE28L1/nvtJGgwi9ATt+gAY
        iR7UoZ3lHab0T3QfrFPl1Wbfw3sRoec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-oUVjAongNGOre3og2zMZSw-1; Wed, 18 Mar 2020 08:14:28 -0400
X-MC-Unique: oUVjAongNGOre3og2zMZSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA6B11088380;
        Wed, 18 Mar 2020 12:14:25 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F1705D9C5;
        Wed, 18 Mar 2020 12:14:20 +0000 (UTC)
Date:   Wed, 18 Mar 2020 13:14:17 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V3 10/17] perf tools: Save previous sample for LBR
 stitching approach
Message-ID: <20200318121417.GB849721@krava>
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
 <20200313183319.17739-11-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313183319.17739-11-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 11:33:12AM -0700, kan.liang@linux.intel.com wrote:

SNIP

> +	struct lbr_stitch	*lbr_stitch;
>  };
>  
>  struct machine;
> @@ -145,4 +151,14 @@ static inline bool thread__is_filtered(struct thread *thread)
>  	return false;
>  }
>  
> +static inline void thread__free_stitch_list(struct thread *thread)
> +{
> +	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
> +
> +	if (!lbr_stitch)
> +		return;
> +
> +	free(thread->lbr_stitch);
> +}

free(thread->lbr_stitch) should be enough

jirka

> +
>  #endif	/* __PERF_THREAD_H */
> -- 
> 2.17.1
> 

