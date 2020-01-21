Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AABC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF0F24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="XrBNnqp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAUU3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:29:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34734 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgAUU3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:29:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id s144so42984wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 12:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4v06OcVu6AWGAgREkUN+nJOIVq296IIoZLXUePQ8oZc=;
        b=XrBNnqp79Hr/DOZDtYgis7af+OtRIktTWNbtDXG8Y3/Qb8GRB3slWN5aPD9R7pTrKH
         JBnhybcpF1QDwrQadEzEW2ochphAXfVTSrRSEQouPnd0SbFrgughr7vA4JaBSnGSvqHG
         ICHqKKYVbqVzzNqFxuuHSutNnHmbBzCGww49E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4v06OcVu6AWGAgREkUN+nJOIVq296IIoZLXUePQ8oZc=;
        b=gLx2Q+fAg3GZyO+XpEAFSjOf9q4JYIC8iL+8OmXW72g2tXj0BW2EKQnky7TzBH0Ynv
         QB9ymznt5EK+cfaapFtNBP7LeoheeejpEqM7PzKpi5EQVmK/xIovlgvscXFlYyr/cqur
         rbHnyqDFBbdh9I4L80EoIsgPBer95Kvb68yVFlF2gOQB7A8+EiRKSG4fSQYiGIYmQkzt
         /EoyxHx2CzTZKcKCmaHNkPTWizvV8+msyd7eLzCo4jqXv5KJLH8MrMNT6qXsoZXYNG+d
         5GJaBpCp3YZGJUASBNeJ7N0FK3UKMY0yOXR+jP2Tkam4L6wxetYav3QvFGYesY0mysY8
         Elkg==
X-Gm-Message-State: APjAAAVA1B+89A2AvFlG6qoTawJl65QD1KA51YSM67uqkxauOQ4QXx18
        9uvYKdvoZRnBeYWJwMd+pVppRw==
X-Google-Smtp-Source: APXvYqzXKlscNyzgyDBzjygHPG9zXc5qiNK6Ib4TKhvYN1HXHb/DAgBd7X6W185JcEtce4e4RPF1Ow==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr193695wmg.92.1579638557788;
        Tue, 21 Jan 2020 12:29:17 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:db6c])
        by smtp.gmail.com with ESMTPSA id z187sm775841wme.16.2020.01.21.12.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 12:29:17 -0800 (PST)
Date:   Tue, 21 Jan 2020 20:29:16 +0000
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
Message-ID: <20200121202916.GA204956@chrisdown.name>
References: <20200121150431.GA240246@chrisdown.name>
 <CAEf4BzZj4PEamHktYLHqHrau0_pkr_q-J85MPCzFbe7mtLQ_+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzZj4PEamHktYLHqHrau0_pkr_q-J85MPCzFbe7mtLQ_+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrii Nakryiko writes:
>> --- a/scripts/link-vmlinux.sh
>> +++ b/scripts/link-vmlinux.sh
>> @@ -108,13 +108,15 @@ gen_btf()
>>         local bin_arch
>>
>>         if ! [ -x "$(command -v ${PAHOLE})" ]; then
>> -               info "BTF" "${1}: pahole (${PAHOLE}) is not available"
>> +               printf 'BTF: %s: pahole (%s) is not available\n' \
>> +                       "${1}" "${PAHOLE}" >&2
>
>any reason not to use echo instead of printf? would be more minimal change

I generally avoid using echo because it has a bunch of portability gotchas 
which printf mostly doesn't have. If you'd prefer echo, that's fine though, 
just let me know and I can send v2.
