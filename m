Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11314C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA506207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgGVIhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:37:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57473 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGVIhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:37:18 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <paolo.pisati@canonical.com>)
        id 1jyAFX-0005xF-Rd
        for linux-kernel@vger.kernel.org; Wed, 22 Jul 2020 08:37:15 +0000
Received: by mail-vs1-f71.google.com with SMTP id l189so103320vsc.19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+bYSyuCUZFAkGtII1RmdIT7fMN+AO1fhPK7l1587qY=;
        b=Q5pUqzuG17ZzCpxaMf0qsjNs+Z+Q80qJMo7YOp4BVcNoMCRgyBK++7ipseYOUe7s2w
         BOlgU8JlBp1hvMO8CZgIG39KR85fISY8l8vs1efxrF5HWbdx1NuJVGnUsXOadBj0ToEq
         RVO1ZYbOx6mdWYIXlOREGob0/sbP5cPukxUkjcKx4DyhmcW0KY8NGK5Y2FPddZzX6Mo+
         nKi6qsKN6HYDMUIW8OzMEuVO9rjKe/vu8mA5H5Htr6e+bZ+5L8EzG/faTGYfwvSMz8Ut
         Ic42UPAtbsRdF5Mxl7Ipk1lSr4SyBmfZDEeoLD7/tsUwD3O1i3b6dzK3W2cWSkPHC7AK
         4yXQ==
X-Gm-Message-State: AOAM532N5Ile1PCIBiD6sCIVukvQbRJat1ptbaVS95PM6VcRTzBEDGC1
        5X4Hhs+3Ak1ysOrcV3IZJ3FoRbnQbylfjQ4BdByB8moZlabsgsJt1rvdlI79mybOs+ucrcMgybQ
        Jy2vi7/saVH7RtorqRj4Av98Vi9iktdtQupaEKl0EPjTgoswqBiqBjOa0jw==
X-Received: by 2002:a67:1105:: with SMTP id 5mr24340543vsr.174.1595407034588;
        Wed, 22 Jul 2020 01:37:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHhx8M1zvoxC/SgvLXUeJNSlv9KoZs9SK1CB828zfYcRVOHt6JU+7hR5X5KsNVtgCDY7YsQoWp9nuI8gUSZfk=
X-Received: by 2002:a67:1105:: with SMTP id 5mr24340530vsr.174.1595407034362;
 Wed, 22 Jul 2020 01:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FuTSeN8SONXySGys8b2EtTqJmHDKw1XVoDte0vzUPg=yuH5g@mail.gmail.com>
 <20200721161710.80797-1-paolo.pisati@canonical.com> <CA+FuTSe1-ZEC5xEXXbT=cbN6eAK1NXXKJ3f2Gz_v3gQyh2SkjA@mail.gmail.com>
In-Reply-To: <CA+FuTSe1-ZEC5xEXXbT=cbN6eAK1NXXKJ3f2Gz_v3gQyh2SkjA@mail.gmail.com>
From:   Paolo Pisati <paolo.pisati@canonical.com>
Date:   Wed, 22 Jul 2020 10:37:03 +0200
Message-ID: <CAMsH0TTQnPGrXci3WvjM+8sdJdxOjR9MnwFvv4DS6=crMCAt4A@mail.gmail.com>
Subject: Re: [PATCH v2] selftest: txtimestamp: fix net ns entry logic
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jian Yang <jianyang@google.com>,
        Network Development <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 6:26 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Fixes: cda261f421ba ("selftests: add txtimestamp kselftest")
>
> Acked-by: Willem de Bruijn <willemb@google.com>

Besides, is it just me or this test fails frequently? I've been
running it on 5.4.x, 5.7.x and 5.8-rcX and it often fails:

...
    USR: 1595405084 s 947366 us (seq=0, len=0)
    SND: 1595405084 s 948686 us (seq=9, len=10)  (USR +1319 us)
ERROR: 6542 us expected between 6000 and 6500
    ACK: 1595405084 s 953908 us (seq=9, len=10)  (USR +6541 us)
    USR: 1595405084 s 997979 us (seq=0, len=0)
    SND: 1595405084 s 999101 us (seq=19, len=10)  (USR +1121 us)
    ACK: 1595405085 s 4438 us (seq=19, len=10)  (USR +6458 us)
    USR: 1595405085 s 49317 us (seq=0, len=0)
    SND: 1595405085 s 50680 us (seq=29, len=10)  (USR +1363 us)
ERROR: 6661 us expected between 6000 and 6500
    ACK: 1595405085 s 55978 us (seq=29, len=10)  (USR +6661 us)
    USR: 1595405085 s 101049 us (seq=0, len=0)
    SND: 1595405085 s 102342 us (seq=39, len=10)  (USR +1293 us)
ERROR: 6578 us expected between 6000 and 6500
    ACK: 1595405085 s 107627 us (seq=39, len=10)  (USR +6577 us)
    USR-SND: count=4, avg=1274 us, min=1121 us, max=1363 us
    USR-ACK: count=4, avg=6559 us, min=6458 us, max=6661 us


In particular, "run_test_v4v6 ${args}       # tcp" is the most
susceptible to failures (though i've seen the udp variant fail too).
-- 
bye,
p.
