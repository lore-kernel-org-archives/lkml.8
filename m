Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480B3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F85B208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFQKz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:55:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45835 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgFQKzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:55:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id i27so2248001ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 03:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JrfBwovCMQQXE4o8ZBM0HxvtHwg6l4AForm5G8s9pCg=;
        b=NKn4QDR4IzHTrUMKWeNQgYfDoRSCBgnRJMR9DgZi1UsfOev0HOYufFh+TeZ65dYvFW
         Xf2cSdIgKOafdNQBbXwljpvt8KcvZYQlXSDQuUACzIeHftqUK9N+n8dWU2gvSIl5SBkx
         LtcpfjxBvYa+IEfCnHMgTmvgwjaNijp8EJ9T619Ky/u8UsQEjEC9ENnVR5RxBFEuC6J5
         vf5eBB+IYrD/jCmiqnSjD877x+L82Rph4nB8NcEcwiNlTDnxUVZyePmN/zWIrqwjZZRr
         aWQcney8OxHYoReZ+9XjzyGwTXU/cctLxMhdDpOITJ/kJHqY/WNBrfyKKCrmSnjXy84e
         /NhA==
X-Gm-Message-State: AOAM532PJvO9Zxlr+8PzFf1y3BqS/9VKA8eNiZzh5OfEam4Eh7KxMmJO
        xTKf1nEeJ8He5dlBLevLGI5Ut9BSWD4=
X-Google-Smtp-Source: ABdhPJzw+JPNRIjYitELAZZrisc7CZ1wM0Dw3qwAL4cyh/xmfanSmJ0Ob5Tyxuz1oAPlXi0SoxuVBg==
X-Received: by 2002:a2e:3218:: with SMTP id y24mr3789133ljy.97.1592391349781;
        Wed, 17 Jun 2020 03:55:49 -0700 (PDT)
Received: from [192.168.1.8] ([213.87.137.195])
        by smtp.gmail.com with ESMTPSA id i8sm5917681lfo.62.2020.06.17.03.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 03:55:49 -0700 (PDT)
To:     "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
References: <20200615102045.4558-1-efremov@linux.com>
 <202006151123.3C2CB7782@keescook>
 <a28543e5-4f93-bf16-930b-42d7b24ab902@linux.com>
 <4dd9c371-0c37-a4bb-e957-3848cb1a13ff@embeddedor.com>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
Message-ID: <e34b7e26-6f07-19b6-39ad-e3bc939551fc@linux.com>
Date:   Wed, 17 Jun 2020 13:55:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4dd9c371-0c37-a4bb-e957-3848cb1a13ff@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Awesome! I'll take a look into this. :)
> 
Here is another script for your #83 ticket.
Currently, it issues 598 warnings.

// SPDX-License-Identifier: GPL-2.0-only
///
/// Check for missing overflow checks in allocation functions.
/// Low confidence because it's pointless to check for overflow
/// relatively small allocations.
///
// Confidence: Low
// Copyright: (C) 2020 Denis Efremov ISPRAS
// Options: --no-includes --include-headers

virtual patch
virtual context
virtual org
virtual report

@depends on patch@
expression E1, E2, E3, E4, size;
@@

(
- size = E1 * E2;
+ size = array_size(E1, E2);
|
- size = E1 * E2 * E3;
+ size = array3_size(E1, E2, E3);
|
- size = E1 * E2 + E3;
+ size = struct_size(E1, E2, E3);
)
  ... when != size = E4
      when != size += E4
      when != size -= E4
      when != size *= E4
      when != &size
  \(kmalloc\|krealloc\|kzalloc\|kzalloc_node\|
    vmalloc\|vzalloc\|vzalloc_node\|
    kvmalloc\|kvzalloc\|kvzalloc_node\|
    sock_kmalloc\|
    f2fs_kmalloc\|f2fs_kzalloc\|f2fs_kvmalloc\|f2fs_kvzalloc\|
    devm_kmalloc\|devm_kzalloc\)
  (..., size, ...)

@r depends on !patch@
expression E1, E2, E3, E4, size;
position p;
@@

(
* size = E1 * E2;@p
|
* size = E1 * E2 * E3;@p
|
* size = E1 * E2 + E3;@p
)
  ... when != size = E4
      when != size += E4
      when != size -= E4
      when != size *= E4
      when != &size
* \(kmalloc\|krealloc\|kzalloc\|kzalloc_node\|
    vmalloc\|vzalloc\|vzalloc_node\|
    kvmalloc\|kvzalloc\|kvzalloc_node\|
    sock_kmalloc\|
    f2fs_kmalloc\|f2fs_kzalloc\|f2fs_kvmalloc\|f2fs_kvzalloc\|
    devm_kmalloc\|devm_kzalloc\)
  (..., size, ...)

@script:python depends on report@
p << r.p;
@@

coccilib.report.print_report(p[0], "WARNING: missing overflow check")

@script:python depends on org@
p << r.p;
@@

coccilib.org.print_todo(p[0], "WARNING: missing overflow check")
