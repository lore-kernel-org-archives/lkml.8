Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA56C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AA120792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eetM67RL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgFLMHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:07:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60083 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725791AbgFLMHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591963626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=naLbiu6HsX+Z2d/q/OU86dDzWk8INFro9FYGhNZfqd8=;
        b=eetM67RLrETyT3K6iYouoMEJhdvi5QScB0BihcsfHyU2GyuHhUDpcSf71A7Nw+CN9/5oS0
        KM5degyB+4c9vf07BK99Jn5N8qsHSjastfGMJshy7wV7GQn0U1BRS09HAs7k1lIMyn2TXi
        w+/TddjcbYDEU8JUTPua6t0iNCKGsCU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-nx0SCqPJOY6-_Cyy0KwhKw-1; Fri, 12 Jun 2020 08:06:54 -0400
X-MC-Unique: nx0SCqPJOY6-_Cyy0KwhKw-1
Received: by mail-ej1-f72.google.com with SMTP id ch1so4074215ejb.18
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 05:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=naLbiu6HsX+Z2d/q/OU86dDzWk8INFro9FYGhNZfqd8=;
        b=PxY4Wdud57DnexnkVs+mnlZak1Ty39spUCMIWWi7ideJnEE9b8PldMNScTyIoA+KQp
         HTQUX9dhcxu6bSURBf5fTxri2YiJ41zOpUhyIBiAFdEN62UNktJH9uRzkY9+5GjF9niI
         73OvC/IDo0ReokxxTq5YPHwRhr7bDYOEVQAfomeLhQoVoX585uj7AiasWFTMUSxCIlnf
         SAJ5Ln34TanVXS1+BkePJJzsx7DaQU5k8ApjnwYVIFMe3VF5f8WHwkaE7i7ILCwoioXC
         /nnVBLCjbDAigEp2BjMMyWY1MpnxRjfoCpyJYuuYfPBnE8YglL4jEo2wlbgJdIWm+0TW
         vmyg==
X-Gm-Message-State: AOAM530D9Vu2UAhsMBf0hndDeNQqiJ8G+x6GjGTYOicJpJUqZG2vMcIO
        RcwL8/r9CCfgHawJ0Mk0eFUtXu6ViJoCAjjAimqj1w6RyWVM+ocoyWBZtF3l+giiPtRxfLyl78h
        /g0dab1kMPyVxEQ9SsMahgP+1
X-Received: by 2002:aa7:dad6:: with SMTP id x22mr11558433eds.265.1591963612878;
        Fri, 12 Jun 2020 05:06:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4lVEfRjPxrT+5Z6RjJUpxaAxzdwF0uc8y38f8DYIg6oQjP4TWeq6YjE5s/j2es2+1PRLT3Q==
X-Received: by 2002:aa7:dad6:: with SMTP id x22mr11558414eds.265.1591963612639;
        Fri, 12 Jun 2020 05:06:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o90sm634231edb.60.2020.06.12.05.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 05:06:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 69A291804F0; Fri, 12 Jun 2020 14:06:50 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joe Perches <joe@perches.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Gaurav Singh <gaurav1086@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        "open list\:XDP \(eXpress Data Path\)" <netdev@vger.kernel.org>,
        "open list\:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xdp_rxq_info_user: Replace malloc/memset w/calloc
In-Reply-To: <427be84b1154978342ef861f1f4634c914d03a94.camel@perches.com>
References: <20200611150221.15665-1-gaurav1086@gmail.com> <20200612003640.16248-1-gaurav1086@gmail.com> <20200612084244.4ab4f6c6@carbon> <427be84b1154978342ef861f1f4634c914d03a94.camel@perches.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 12 Jun 2020 14:06:50 +0200
Message-ID: <8736705vz9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Fri, 2020-06-12 at 08:42 +0200, Jesper Dangaard Brouer wrote:
>> On Thu, 11 Jun 2020 20:36:40 -0400
>> Gaurav Singh <gaurav1086@gmail.com> wrote:
>> 
>> > Replace malloc/memset with calloc
>> > 
>> > Fixes: 0fca931a6f21 ("samples/bpf: program demonstrating access to xdp_rxq_info")
>> > Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
>> 
>> Above is the correct use of Fixes + Signed-off-by.
>> 
>> Now you need to update/improve the description, to also
>> mention/describe that this also solves the bug you found.
>
> This is not a fix, it's a conversion of one
> correct code to a shorter one.

No it isn't - the original code memset()s before it checks the return
from malloc(), so it's a potential NULL-pointer reference... Which the
commit message should explain, obviously :)

-Toke

