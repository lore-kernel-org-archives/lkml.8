Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1ECC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D817024655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="bTd9UkGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAUXtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:49:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33706 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgAUXtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:49:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so5413692wrq.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 15:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tK7af4Yj21EpvGAZIaTRTJBlx41+rY2B9mDlWdbfbi8=;
        b=bTd9UkGog9xWCbHsbf0wHxECfn6qCYjmBs2H9GP/J+PfVO7g2dIAVALlh0QDr048GE
         aD0eafCfACbl+CDgL/jt7fkiQsb83EbB9QtXGcbbIGPR3RZ8Z/6d1Zu9dq19gNO0lvEa
         2vGvHLvS3XqTTA7qvK/yi9a1C7j7Zb2rxoMzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tK7af4Yj21EpvGAZIaTRTJBlx41+rY2B9mDlWdbfbi8=;
        b=R8BFTVUbk4tcySGeJi3bWQoqvuuHAQMR1/nlAyfcfHKh6MlrYgcMq+JCSs+J2qPfXH
         ot9nf4scfbSAiSxuQ0lqM0E0qRhXBLpOYlfRFDIhLom+RUrvd4exegsKuWtVyYhMcJ7w
         wSV/pyBQAxMJ8/nP5I2iFSqzh5xNQ/zZ08qW0vIMwtXvtBawnTeGav04uo+vES5hJJXI
         UtG6DhM1EcjVs0DZs1sW15K5MvYBi74nqvEv4CKYSrXH5lYTzsKtx0RgyeJUPyGOBFlU
         MQIcpCMWWMCm7LKLmUZUHCRqoq2VbEJN7hMATyoPO3XLWbLL239MbqbTWDsc5sbN1FNC
         YuNg==
X-Gm-Message-State: APjAAAUt/jSRiv02Jhi/M6IIayLDVZN+GKYwf6uQLr42OcPuwiv3JOc3
        32FtrjWmLNV2VUZkpVX1rTZ3gw==
X-Google-Smtp-Source: APXvYqwoGBU6WnXPqYPEDv/r4bHvegGsbO7skJxxBVcEi/7SH5NMS2jak/GYVfHybnuWj7SYgBZ9Tw==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr7679388wrn.5.1579650560374;
        Tue, 21 Jan 2020 15:49:20 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:58ec])
        by smtp.gmail.com with ESMTPSA id x11sm56093615wre.68.2020.01.21.15.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:49:19 -0800 (PST)
Date:   Tue, 21 Jan 2020 23:49:19 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] bpf: btf: Always output invariant hit in pahole DWARF to
 BTF transform
Message-ID: <20200121234919.GA309703@chrisdown.name>
References: <20200121150431.GA240246@chrisdown.name>
 <CAEf4BzZj4PEamHktYLHqHrau0_pkr_q-J85MPCzFbe7mtLQ_+Q@mail.gmail.com>
 <20200121202916.GA204956@chrisdown.name>
 <CAEf4BzZ5wR_jTEbwYVU-z3ZBP+06p9ZTOeF_DNxqe_nQW493CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ5wR_jTEbwYVU-z3ZBP+06p9ZTOeF_DNxqe_nQW493CA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrii Nakryiko writes:
>On Tue, Jan 21, 2020 at 12:29 PM Chris Down <chris@chrisdown.name> wrote:
>>
>> Andrii Nakryiko writes:
>> >> --- a/scripts/link-vmlinux.sh
>> >> +++ b/scripts/link-vmlinux.sh
>> >> @@ -108,13 +108,15 @@ gen_btf()
>> >>         local bin_arch
>> >>
>> >>         if ! [ -x "$(command -v ${PAHOLE})" ]; then
>> >> -               info "BTF" "${1}: pahole (${PAHOLE}) is not available"
>> >> +               printf 'BTF: %s: pahole (%s) is not available\n' \
>> >> +                       "${1}" "${PAHOLE}" >&2
>> >
>> >any reason not to use echo instead of printf? would be more minimal change
>>
>> I generally avoid using echo because it has a bunch of portability gotchas
>> which printf mostly doesn't have. If you'd prefer echo, that's fine though,
>> just let me know and I can send v2.
>
>The rest of the script is using echo for errors, so let's stick to it
>for consistency. Thanks!

Sure thing, I'll send v2. Thanks! :-)
