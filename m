Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF130C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC81E2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OynqUYlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgIHVXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgIHVXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:23:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53626C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 14:23:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr14so508227ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=br7kqX/EdOL7Dtz4xbsGL/PqgcQRS1tChb51PYcN8dE=;
        b=OynqUYlbUs7iBeqSmkGzesj47qaR8oT14XhnS7OUMJ8ajmWM6PyfFHscblZlW8coxp
         gusIhiL4efHs5JVE1NoJTZVljm3SPUoWS14ie7DFYGj1mb9rZ2nAe36PaSY0JTCZf/No
         Y+awcP6yavDk5i99+yoIn9LGQcWj606RFY3pzc2hlVH6e+m1CsNU7n2ajDLCgcUGwSm2
         5kja8Q74WbHcBLAqdE/RJi/nBeyDwd7eLXb1kJvFb8QR7QSRYft0FNWZmChgQ/hYLWQf
         eA8xAaAx6fkB5F2/o1J2+c+LxWW98Ye0c3ibHpjqrkeCTkZb7P+gXpcL6qQMU7dqN9bm
         UalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=br7kqX/EdOL7Dtz4xbsGL/PqgcQRS1tChb51PYcN8dE=;
        b=OKrJA68lhqOI8VlfefLUojk3MENxiDIcjKL5dVVx1Je0erwf2QQozetgb79wrMNeiv
         UeyShh6J35r+Na8jH0LEzqrVHv75togJ0vIa8wWcTV0u4j2biTQPMV1Oniqw4PsE5soP
         5zKBcvSZ9qvT2w/5Lavwos7kpOJZXOFyCI/QrNYeJzDAEXjsrFvLziCCICAIKcEC6y/6
         ibzDfZKp7CENQAWF2NgOGPo3tmleqbCEka2g4FtX45CBbtuOatjivXAxPT8glj+ibBlg
         6s0Eb0qYXQRIC0km+LI9+BiGt0AxwSgkDCcKokGqu0Ut6W2mbgaexKvcnj4N5NuZg8NH
         CXPA==
X-Gm-Message-State: AOAM533TlS3Wv/B+3eaa8E+Qd/T7abfk0IODLs7nz8eNn2U4Eu8Zd4X5
        pYXWt7Zls2FD7mllDFnfxp6z40FkhdTbhwHQ56DJ
X-Google-Smtp-Source: ABdhPJw0uILieaMH3Md5pDW6MLvdTIEjLkaUHI8McMxvysOSsWSpCu7dFxVboDb/ZbuayzuGCaPRAGD9wnbbUoyVsfI=
X-Received: by 2002:a17:906:8c8:: with SMTP id o8mr419310eje.91.1599600213831;
 Tue, 08 Sep 2020 14:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200908140543.25514-1-wanghai38@huawei.com>
In-Reply-To: <20200908140543.25514-1-wanghai38@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Sep 2020 17:23:22 -0400
Message-ID: <CAHC9VhRGzWd+SSQvMqapzLwo3dAJGShJOq-3Wyx0SNZ+TvmjqQ@mail.gmail.com>
Subject: Re: [PATCH net-next] netlabel: Fix some kernel-doc warnings
To:     Wang Hai <wanghai38@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 10:09 AM Wang Hai <wanghai38@huawei.com> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
> net/netlabel/netlabel_calipso.c:438: warning: Excess function parameter 'audit_secid' description in 'calipso_doi_remove'
> net/netlabel/netlabel_calipso.c:605: warning: Excess function parameter 'reg' description in 'calipso_req_delattr'
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  net/netlabel/netlabel_calipso.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good to me, thanks.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_calipso.c
> index 249da67d50a2..1a98247ab148 100644
> --- a/net/netlabel/netlabel_calipso.c
> +++ b/net/netlabel/netlabel_calipso.c
> @@ -426,7 +426,7 @@ void calipso_doi_free(struct calipso_doi *doi_def)
>  /**
>   * calipso_doi_remove - Remove an existing DOI from the CALIPSO protocol engine
>   * @doi: the DOI value
> - * @audit_secid: the LSM secid to use in the audit message
> + * @audit_info: NetLabel audit information
>   *
>   * Description:
>   * Removes a DOI definition from the CALIPSO engine.  The NetLabel routines will
> @@ -595,7 +595,7 @@ int calipso_req_setattr(struct request_sock *req,
>
>  /**
>   * calipso_req_delattr - Delete the CALIPSO option from a request socket
> - * @reg: the request socket
> + * @req: the request socket
>   *
>   * Description:
>   * Removes the CALIPSO option from a request socket, if present.
> --
> 2.17.1
>


-- 
paul moore
www.paul-moore.com
