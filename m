Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9C7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D102073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595361563;
	bh=gGb8g+UjwDX3j/bDtdfbUK7CDgRFPOiHWmMZoe62cyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EyctqGOu87abo5ZecUBvQIQJYgblqWIwL9+YQseoYhUllFzsHyZWnzS6SjzjkkLX8
	 mxHh0s4EZeYkc3Ojq3Mncoh6zqDTljwpaanUOtaimbD7cScz2SkOyv3Ytoqnp4WtDi
	 CzkEsjdIL0qyJrgszebOD9VHinjiGtR2MAChqr0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgGUT7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgGUT7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:59:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D424A2072E;
        Tue, 21 Jul 2020 19:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595361562;
        bh=gGb8g+UjwDX3j/bDtdfbUK7CDgRFPOiHWmMZoe62cyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=laRS/bbq7IgIVRlG0PhI2fEtI/3uizRIhXywei56/svMY0xMUoaerbVaRbi7GQPgU
         S9xMDWZqGlHaPe/Udeqw6g2IcEgKiRp+bFfKJZHZQn2izhkvmoq4icB0aCn9XyZ5Z9
         z53z61S47BooFAMTBRAciOTaXN/8gAp6ml1ek8Zw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C70C3404B1; Tue, 21 Jul 2020 16:59:19 -0300 (-03)
Date:   Tue, 21 Jul 2020 16:59:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 03/15] tools/libperf: avoid counting of nonfilterable
 fdarray fds
Message-ID: <20200721195919.GH77866@kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
 <b5ab0d2c-b742-0032-e8d3-c8e2eb423c42@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ab0d2c-b742-0032-e8d3-c8e2eb423c42@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 17, 2020 at 10:00:15AM +0300, Alexey Budankov escreveu:
> 
> Avoid counting of struct pollfd *entries objects with
> fdarray_flag__nonfilterable flag by fdarray__filter().
> Nonfilterable objects are still processed if requested
> revents have been signaled for them.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/api/fd/array.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 01b3b89f9797..5e6cb9debe37 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -109,7 +109,8 @@ int fdarray__filter(struct fdarray *fda, short revents,
>  			continue;
>  		}
>  
> -		++nr;
> +		if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable))
> +			++nr;
>  	}
>  
>  	return nr;
> -- 
> 2.24.1
> 
> 

-- 

- Arnaldo
