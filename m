Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC3DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B5420897
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YXMKuMLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFQUFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgFQUFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:05:52 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD9DC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:05:52 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dp18so3904914ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=c1leZWIvOJKvKSJTXkMVRFdWNmCI6clPq41eJTdSrJk=;
        b=YXMKuMLE1JpdALxeeof28M0jSsXSlZJB/X7nG8d63WHAHFTe8u1CnBkRsSjI11tzRW
         xy75g8vx014t3N6fAb55aghc6xGPVZvlMmf3IWTAVLOIzOa9U3LnI8tIdOZ9WUnmfmHZ
         gWFcSAggvlSEqIeMhI+RQHM1pg8IWXRIR2fyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c1leZWIvOJKvKSJTXkMVRFdWNmCI6clPq41eJTdSrJk=;
        b=I5Hzd2MmcTe/ZG+zrCN7imNIZyJX5tTMJrG7FE9BF9c6mjxDX0YSxLIkhVxcnal1U6
         Vj+WxFQgEDkfVk9SAKsQtKbi8Dvvsa+U+AJCsbC9IhLXY+icchnGxjzPTd/eQ72Gr3Yz
         4wbYxhbpJzcv/jYkeTs/dU69Ky6lmJ4k8h5l0L9hRttEr4aPUzPFVDxcwSXPKPwIGuHS
         B6APUygSz9vE1LNkx+ksb6pucK2Ky00e2lq6mjXo0dvTiVZ68ycvnS2zLE8k5cU793ZH
         2GDUSBivbF/rSLIz+dHjOhcxYVCS8GDKmK+61AYKxNqHGgI4c71CCrAw6Jr8rhTIEmV0
         r+YA==
X-Gm-Message-State: AOAM531EJYQZqtMDYOF5L/i/uh+L/EhY1ngknd+HWQrBxMkJ1QhzGdfu
        O5p5yGlqbTiJPDI7C+ou9UEtjJ8mi7QnnA==
X-Google-Smtp-Source: ABdhPJy2hphN+MmJJKLybt5Oa3cdP1lH+zUdT2EUOUqVnv8LdHF76O8QR5XiDiZnahfqVCcfhyaYPg==
X-Received: by 2002:a17:906:22cc:: with SMTP id q12mr797135eja.485.1592424350833;
        Wed, 17 Jun 2020 13:05:50 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-112-31.cgn.fibianet.dk. [5.186.112.31])
        by smtp.gmail.com with ESMTPSA id dn17sm424011edb.26.2020.06.17.13.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 13:05:50 -0700 (PDT)
Subject: Re: [PATCH v3 00/21] dynamic_debug cleanups, query features, export
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, akpm@linuxfoundation.org,
        gregkh@linuxfoundation.org
References: <20200617162536.611386-1-jim.cromie@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9d0900db-5480-cdc9-88e1-92035259fc43@rasmusvillemoes.dk>
Date:   Wed, 17 Jun 2020 22:05:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2020 18.25, Jim Cromie wrote:
> this is v3, changes from previous:
>  - moved non-controversial commits up front, refactors to help this.
>  - a few more minor cleanups
>  - left out the WIP patches
>  - export ddebug_exec_queries()
>  - accept file=foo:func only, not module:foo
>  - varname changes
>  
> v2: https://lore.kernel.org/lkml/20200613155738.2249399-1-jim.cromie@gmail.com/
> v1: https://lore.kernel.org/lkml/20200605162645.289174-1-jim.cromie@gmail.com/
> 
> Patchset starts with 11 cleanups;
>  - change section name from vague "__verbose" to "__dyndbg"
>  - cleaner docs, drop obsolete comment & useless debug prints,
>    refine verbosity, fix a BUG_ON, ram reporting miscounts. etc..

So I haven't been following too closely, but I'm also a bit skeptical
about the new custom flag thing. OTOH, I'd really like to see those
first cleanups go in soon, especially patch 6 - which not only makes the
ram use a bit more accurate, it also avoids ~10000 calls of strlen() on
cache-cold memory during boot.

So, FWIW, you have my Acked-by for patches 1 through 11, and I hope
those can be picked up before the next merge window. But the remaining
ones seem to still require some discussion.

Rasmus
