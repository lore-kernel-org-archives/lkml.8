Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D104DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC28208A9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHZIM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:12:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40047 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgHZIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:12:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id 185so1299019ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 01:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=72bxPu2qgb+boTSMMXTu0lwksF6qBFYOp8FbwrUctMM=;
        b=mqgjBs+PC7QocsM7RolFe8ABcBstkskcOvk3YlDTPuuVZzQ0d047Z6cZEt71kxjfMS
         V6eU5qVf/0lnKeeVMKn8wToED1lFPVXQpo0Yqe+KGL/8yOQ1WhQBIk/U9kcQWpSH77uf
         37An27UO1AUMMkyUPRaDrPHQSEtEgCms7jJ2tzwfiZSonhEGBi/905bQ8ACbd5Bajo5q
         1jpT8kr9/mC2+H3evdz4G1vRYQH0jYk+7vyPHJpaPR/mVvjp4f9okNJ32+6Y6o0lkk3B
         GOmnGcVx9W/Si+BqshNuZV6LoogP+2wlL+sr20fF9a+VN99TZSRVewbKMkiuZaI96B5r
         DJvg==
X-Gm-Message-State: AOAM531uiqd1kYZBJ6JOn/qngg7cKpaj04wdBECFFhXcU/eyOKx9PtIA
        w0qx5YkePEfyxbv1oXWDBf/rrNc0Blc=
X-Google-Smtp-Source: ABdhPJxIXuKDO6EfPMe5sP3QVOnaj2F0qBAJA5rXqGOvHPthnMbFKRqZFIrhaGa+bYjUNKqILH+JBw==
X-Received: by 2002:a2e:8999:: with SMTP id c25mr6927638lji.430.1598429572333;
        Wed, 26 Aug 2020 01:12:52 -0700 (PDT)
Received: from [10.68.32.147] (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.gmail.com with ESMTPSA id 10sm337358ljn.22.2020.08.26.01.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 01:12:51 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH] coccinelle: api: update kzfree script to kfree_sensitive
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20200604140805.111613-1-efremov@linux.com>
 <20200811074953.73994-1-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 mQINBFsJUXwBEADDnzbOGE/X5ZdHqpK/kNmR7AY39b/rR+2Wm/VbQHV+jpGk8ZL07iOWnVe1
 ZInSp3Ze+scB4ZK+y48z0YDvKUU3L85Nb31UASB2bgWIV+8tmW4kV8a2PosqIc4wp4/Qa2A/
 Ip6q+bWurxOOjyJkfzt51p6Th4FTUsuoxINKRMjHrs/0y5oEc7Wt/1qk2ljmnSocg3fMxo8+
 y6IxmXt5tYvt+FfBqx/1XwXuOSd0WOku+/jscYmBPwyrLdk/pMSnnld6a2Fp1zxWIKz+4VJm
 QEIlCTe5SO3h5sozpXeWS916VwwCuf8oov6706yC4MlmAqsQpBdoihQEA7zgh+pk10sCvviX
 FYM4gIcoMkKRex/NSqmeh3VmvQunEv6P+hNMKnIlZ2eJGQpz/ezwqNtV/przO95FSMOQxvQY
 11TbyNxudW4FBx6K3fzKjw5dY2PrAUGfHbpI3wtVUNxSjcE6iaJHWUA+8R6FLnTXyEObRzTS
 fAjfiqcta+iLPdGGkYtmW1muy/v0juldH9uLfD9OfYODsWia2Ve79RB9cHSgRv4nZcGhQmP2
 wFpLqskh+qlibhAAqT3RQLRsGabiTjzUkdzO1gaNlwufwqMXjZNkLYu1KpTNUegx3MNEi2p9
 CmmDxWMBSMFofgrcy8PJ0jUnn9vWmtn3gz10FgTgqC7B3UvARQARAQABtCFEZW5pcyBFZnJl
 bW92IDxlZnJlbW92QGxpbnV4LmNvbT6JAlcEEwEIAEECGwMFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4ACGQEWIQR2VAM2ApQN8ZIP5AO1IpWwM1AwHwUCXsQtuwUJB31DPwAKCRC1IpWwM1Aw
 H3dQD/9E/hFd2yPwWA5cJ5jmBeQt4lBi5wUXd2+9Y0mBIn40F17Xrjebo+D8E5y6S/wqfImW
 nSDYaMfIIljdjmUUanR9R7Cxd/Z548Qaa4F1AtB4XN3W1L49q21h942iu0yxSLZtq9ayeja6
 flCB7a+gKjHMWFDB4nRi4gEJvZN897wdJp2tAtUfErXvvxR2/ymKsIf5L0FZBnIaGpqRbfgG
 Slu2RSpCkvxqlLaYGeYwGODs0QR7X2i70QGeEzznN1w1MGKLOFYw6lLeO8WPi05fHzpm5pK6
 mTKkpZ53YsRfWL/HY3kLZPWm1cfAxa/rKvlhom+2V8cO4UoLYOzZLNW9HCFnNxo7zHoJ1shR
 gYcCq8XgiJBF6jfM2RZYkOAJd6E3mVUxctosNq6av3NOdsp1Au0CYdQ6Whi13azZ81pDlJQu
 Hdb0ZpDzysJKhORsf0Hr0PSlYKOdHuhl8fXKYOGQxpYrWpOnjrlEORl7NHILknXDfd8mccnf
 4boKIZP7FbqSLw1RSaeoCnqH4/b+ntsIGvY3oJjzbQVq7iEpIhIoQLxeklFl1xvJAOuSQwII
 I9S0MsOm1uoT/mwq+wCYux4wQhALxSote/EcoUxK7DIW9ra4fCCo0bzaX7XJ+dJXBWb0Ixxm
 yLl39M+7gnhvZyU+wkTYERp1qBe9ngjd0QTZNVi7MbkCDQRbCVF8ARAA3ITFo8OvvzQJT2cY
 nPR718Npm+UL6uckm0Jr0IAFdstRZ3ZLW/R9e24nfF3A8Qga3VxJdhdEOzZKBbl1nadZ9kKU
 nq87te0eBJu+EbcuMv6+njT4CBdwCzJnBZ7ApFpvM8CxIUyFAvaz4EZZxkfEpxaPAivR1Sa2
 2x7OMWH/78laB6KsPgwxV7fir45VjQEyJZ5ac5ydG9xndFmb76upD7HhV7fnygwf/uIPOzNZ
 YVElGVnqTBqisFRWg9w3Bqvqb/W6prJsoh7F0/THzCzp6PwbAnXDedN388RIuHtXJ+wTsPA0
 oL0H4jQ+4XuAWvghD/+RXJI5wcsAHx7QkDcbTddrhhGdGcd06qbXe2hNVgdCtaoAgpCEetW8
 /a8H+lEBBD4/iD2La39sfE+dt100cKgUP9MukDvOF2fT6GimdQ8TeEd1+RjYyG9SEJpVIxj6
 H3CyGjFwtIwodfediU/ygmYfKXJIDmVpVQi598apSoWYT/ltv+NXTALjyNIVvh5cLRz8YxoF
 sFI2VpZ5PMrr1qo+DB1AbH00b0l2W7HGetSH8gcgpc7q3kCObmDSa3aTGTkawNHzbceEJrL6
 mRD6GbjU4GPD06/dTRIhQatKgE4ekv5wnxBK6v9CVKViqpn7vIxiTI9/VtTKndzdnKE6C72+
 jTwSYVa1vMxJABtOSg8AEQEAAYkCPAQYAQgAJgIbDBYhBHZUAzYClA3xkg/kA7UilbAzUDAf
 BQJexC4MBQkHfUOQAAoJELUilbAzUDAfPYoQAJdBGd9WZIid10FCoI30QXA82SHmxWe0Xy7h
 r4bbZobDPc7GbTHeDIYmUF24jI15NZ/Xy9ADAL0TpEg3fNVad2eslhCwiQViWfKOGOLLMe7v
 zod9dwxYdGXnNRlW+YOCdFNVPMvPDr08zgzXaZ2+QJjp44HSyzxgONmHAroFcqCFUlfAqUDO
 T30gV5bQ8BHqvfWyEhJT+CS3JJyP8BmmSgPa0Adlp6Do+pRsOO1YNNO78SYABhMi3fEa7X37
 WxL31TrNCPnIauTgZtf/KCFQJpKaakC3ffEkPhyTjEl7oOE9xccNjccZraadi+2uHV0ULA1m
 ycHhb817A03n1I00QwLf2wOkckdqTqRbFFI/ik69hF9hemK/BmAHpShI+z1JsYT9cSs8D7wb
 aF/jQVy4URensgAPkgXsRiboqOj/rTz9F5mpd/gPU/IOUPFEMoo4TInt/+dEVECHioU3RRrW
 EahrGMfRngbdp/mKs9aBR56ECMfFFUPyI3VJsNbgpcIJjV/0N+JdJKQpJ/4uQ2zNm0wH/RU8
 CRJvEwtKemX6fp/zLI36Gvz8zJIjSBIEqCb7vdgvWarksrhmi6/Jay5zRZ03+k6YwiqgX8t7
 ANwvYa1h1dQ36OiTqm1cIxRCGl4wrypOVGx3OjCar7sBLD+NkwO4RaqFvdv0xuuy4x01VnOF
Message-ID: <3da343e9-bf5f-abe4-8b43-af98bd72e131@linux.com>
Date:   Wed, 26 Aug 2020 11:12:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811074953.73994-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On 8/11/20 10:49 AM, Denis Efremov wrote:
> Commit 453431a54934 ("mm, treewide: rename kzfree() to kfree_sensitive()")
> renames kzfree to kfree_sensitive and uses memzero_explicit(...) instead of
> memset(..., 0, ...) internally. Update cocci script to reflect these
> changes.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Julia, I think you can squash this commit with original script, or I can
> resend the whole script since it's not merged to the mainline.
> 
>  .../{kzfree.cocci => kfree_sensitive.cocci}   | 29 +++++++++----------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>  rename scripts/coccinelle/api/{kzfree.cocci => kfree_sensitive.cocci} (70%)
> 
> diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kfree_sensitive.cocci
> similarity index 70%
> rename from scripts/coccinelle/api/kzfree.cocci
> rename to scripts/coccinelle/api/kfree_sensitive.cocci
> index 33625bd7cec9..e4a066a0b77d 100644
> --- a/scripts/coccinelle/api/kzfree.cocci
> +++ b/scripts/coccinelle/api/kfree_sensitive.cocci
> @@ -1,13 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  ///
> -/// Use kzfree, kvfree_sensitive rather than memset or
> -/// memzero_explicit followed by kfree
> +/// Use kfree_sensitive, kvfree_sensitive rather than memset or
> +/// memzero_explicit followed by kfree.
>  ///
>  // Confidence: High
>  // Copyright: (C) 2020 Denis Efremov ISPRAS
>  // Options: --no-includes --include-headers
>  //
> -// Keywords: kzfree, kvfree_sensitive
> +// Keywords: kfree_sensitive, kvfree_sensitive
>  //
>  
>  virtual context
> @@ -18,7 +18,8 @@ virtual report
>  @initialize:python@
>  @@
>  # kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
> -filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
> +filter = frozenset(['kmalloc_oob_in_memset',
> +		    'kfree_sensitive', 'kvfree_sensitive'])
>  
>  def relevant(p):
>      return not (filter & {el.current_element for el in p})
> @@ -56,17 +57,13 @@ type T;
>  - memzero_explicit@m((T)E, size);
>    ... when != E
>        when strict
> -// TODO: uncomment when kfree_sensitive will be merged.
> -// Only this case is commented out because developers
> -// may not like patches like this since kzfree uses memset
> -// internally (not memzero_explicit).
> -//(
> -//- kfree(E)@p;
> -//+ kfree_sensitive(E);
> -//|
> +(
> +- kfree(E)@p;
> ++ kfree_sensitive(E);
> +|
>  - \(vfree\|kvfree\)(E)@p;
>  + kvfree_sensitive(E, size);
> -//)
> +)
>  
>  @rp_memset depends on patch@
>  expression E, size;
> @@ -80,7 +77,7 @@ type T;
>        when strict
>  (
>  - kfree(E)@p;
> -+ kzfree(E);
> ++ kfree_sensitive(E);
>  |
>  - \(vfree\|kvfree\)(E)@p;
>  + kvfree_sensitive(E, size);
> @@ -91,11 +88,11 @@ p << r.p;
>  @@
>  
>  coccilib.report.print_report(p[0],
> -  "WARNING: opportunity for kzfree/kvfree_sensitive")
> +  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
>  
>  @script:python depends on org@
>  p << r.p;
>  @@
>  
>  coccilib.org.print_todo(p[0],
> -  "WARNING: opportunity for kzfree/kvfree_sensitive")
> +  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
> 
