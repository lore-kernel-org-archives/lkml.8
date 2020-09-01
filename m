Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D30DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF5C206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pat1YOLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIAKE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIAKEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:04:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A599C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 03:04:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e11so783382ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 03:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uAA3vppKz35+iasup+iTPe2COzoTe++NhtknlN0MtRU=;
        b=pat1YOLrY1lkERA0Ub/Qf+YQaTpUjdzjz8pLR5aYIhmJEiT4Tl0786IT8sqhce0Giz
         XFQLM8QBHAh8Gmg+/bJd7pLfnufGUuYRutbTsT+DCmTy2ucSs/rlILHvGt0VOzztqtEm
         k7P2KW9cTAlfScwsDLCl0wbezuGVvKE7zMCco1q42ikNxgDbUj5A6sZEmyXxdLVGBQTC
         /m1CYU2/Tu3IfNgEt7XFWqBKmyR+uXIgLWACjqE+1+3BKVNpjkGZTYvFumqT6mJnZ41b
         HQhKPRTPyD6JubiRzSk0rjEQ0oEn0vOLa/uHxU0ehin4LLe9TbjABDJgBZavh01VrpyG
         AUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uAA3vppKz35+iasup+iTPe2COzoTe++NhtknlN0MtRU=;
        b=eeEBy12F/EGqC69P/5MlIEc5fGYiFCI6NVipKylbLuqFfBK+6EtL7BtAgQVyRsoTIS
         +IY+NONgNQ8J1LHYKWDA9KBbtquT11i9MdmfVAAoN+8qhpuZLCjr0E0eHlAHPK42RW42
         SP2pVCgjuabmKcoys3OcvndsCwiznvYueoUQ5yP9vVGL4jxqJC86hBZnPKJFVC5c2XRe
         QWsutrhpnao/QSx+ounakQXw+H1f6zo/5cPzREilXi9q44geXOZ4aq7msO+6ampXEb5j
         BHUfY202VjvGHpwuDBk4OeIdtO9ZMMAFx+CugSI4+tDi4aY5ozFDubU5GsvC2yv3ik8f
         EUBA==
X-Gm-Message-State: AOAM530VwTIZhRwUNU0DrbSSWhUkoyG3Tdu+wqe9wjDH8MhTOiC95LmE
        tC+N0Ffqlx1uIJEtLkV6Ig2FtcGxs3l4lw==
X-Google-Smtp-Source: ABdhPJxfDoTndIovjkFvluSlbk1E1TRsuPCAaVYmQSADr+P6D+DeGJZYUqIeAYi63RudGId91yq9Yg==
X-Received: by 2002:a2e:8593:: with SMTP id b19mr185956lji.290.1598954691797;
        Tue, 01 Sep 2020 03:04:51 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id n8sm173775ljj.69.2020.09.01.03.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:04:51 -0700 (PDT)
Date:   Tue, 1 Sep 2020 12:04:49 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     rdunlap@infradead.org, sumit.garg@linaro.org,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        ricardo@foundries.io
Subject: Re: [PATCHv2] drivers: optee: fix i2c build issue
Message-ID: <20200901100449.GA3255765@jade>
References: <20200831161102.14735-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200831161102.14735-1-jorge@foundries.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 06:11:02PM +0200, Jorge Ramirez-Ortiz wrote:
> When the optee driver is compiled into the kernel while the i2c core
> is configured as a module, the i2c symbols are not available.
> 
> This commit addresses the situation by disabling the i2c support for
> this use case while allowing it in all other scenarios:
> 
>  i2c=y, optee=y
>  i2c=m, optee=m
>  i2c=y, optee=m
>  i2c=m, optee=y (not supported)
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>   v2: uses IS_REACHABLE instead of macro combination
> 
>   This patch applies on top of
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git/tag/?h=optee-i2c-for-v5.10 
> 
>  drivers/tee/optee/rpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks for the prompt fix, I'm picking this up.

Cheers,
Jens
