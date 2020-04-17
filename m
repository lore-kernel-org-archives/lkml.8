Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A800C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580C821924
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/dzyaF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgDQOmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDQOmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:42:50 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06319C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:42:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g74so2542118qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TjiV7u4brXrRJ5IxN3WtwuG8DEaXG0cd8LXnKPWpbro=;
        b=V/dzyaF7RSh5O0l2+MRpIdt2aQclbzKFlQFbwC5/yMr7oN07H4vIGVHnMxGa4dgd7d
         QizY/BYcymJDMybCmgfMzCjlgV+yXzkeHbh94lbxml7weOKMVO1EYrRaZpeAXMyreVhK
         4xH0CEY1LxbnpiIKzi+GjVZ9tI8r6eRN5kiMZVqix34UJZTiWfYE/cx3mfwkGpkNNZeo
         iI/RnYBKb6DsI06pOOZx6d1SHJCqGtY1PTsPrsE8+d5BTmU2ogqBAO6/+6PK7kUiU/8v
         Y62JFQBbg7GZwHEOzLDWr1FuKSm8XqY58io3g2w/av+QLIxgVl+FG8aKoj0NumMrNd2j
         BnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TjiV7u4brXrRJ5IxN3WtwuG8DEaXG0cd8LXnKPWpbro=;
        b=C19SIX6+NaahKrOdW5f399ldukbJe4z2jh73tnFbhrrqAyRFt/0zKmlzc9CfNumtDm
         r9EYRcuzWhOFMYDSYwJ0IUAAVW+fBzArojylIhcBVxE36E5zN9mirV1mtOzsV56OE3ea
         nl8fSQ8w5A69MynZz/KAuuuk6k9Ixi4mOCG4L7uFoLN5xFmGYn1TmmMWASnvwDmVBB81
         Q+bdrXYHfd0EOUiD4SkkruEDcp94Rk/oxdR+h60+gFFcLI7K/wy+JCBSQeRjM0OXCrtZ
         qwW2TFEk2kxgqMSj6abOpgOKP/UEGA4jSUCkzs/YC70fU5zaR2HqZ6X5Gp14ZejjIpgn
         vQsA==
X-Gm-Message-State: AGi0PuZDn8LG49PrUhiiaNu186iLAWi48JHIU3imoQl5E6k/xJsJjD7T
        W5SSsBzBTyKhlTFod5Ki8gcW5BT2Jb6X3Q==
X-Google-Smtp-Source: APiQypLOW9GOZ/kNhZgkZWEzWDniQCAXXIAAWjR9G5PdB1TGWxIQMz19Z/MQn17zBz/y7ZtOfViGmg==
X-Received: by 2002:a37:68c5:: with SMTP id d188mr3728633qkc.85.1587134566149;
        Fri, 17 Apr 2020 07:42:46 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d186sm6625026qkc.45.2020.04.17.07.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 07:42:44 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A6657409A3; Fri, 17 Apr 2020 11:42:42 -0300 (-03)
Date:   Fri, 17 Apr 2020 11:42:42 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V4 04/17] perf stat: Clear HEADER_CPU_PMU_CAPS
Message-ID: <20200417144242.GB17973@kernel.org>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
 <20200319202517.23423-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319202517.23423-5-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 19, 2020 at 01:25:04PM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The CPU PMU capabilities information is only useful for perf record with
> LBR call stack.
> 
> Clear the header for perf stat.

Ditto.
 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ec053dc1e35c..b5c8a5ab5e75 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1595,6 +1595,7 @@ static void init_features(struct perf_session *session)
>  	perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
>  	perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
>  	perf_header__clear_feat(&session->header, HEADER_AUXTRACE);
> +	perf_header__clear_feat(&session->header, HEADER_CPU_PMU_CAPS);
>  }
>  
>  static int __cmd_record(int argc, const char **argv)
> -- 
> 2.17.1
> 

-- 

- Arnaldo
