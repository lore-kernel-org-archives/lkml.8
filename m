Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6797DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B71E2467E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gh3FccfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAWNmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:42:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37937 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727453AbgAWNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579786929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4DPy+R5bPTq7tZWsMUKnzOUpzVwlGaLd1jlg2QWm2Yw=;
        b=gh3FccfZHQbdTBEoPpkCq3Sj9YltDkHOsX4YwEVafaDaM8K1gl8yldgXSHI0M50UO2XMzs
        KiuiMsfhNZB4+L7vVpyv1edys2aBmXjal7d4pCahBjrQfT8CZ+u5F4teRxl65mXCTKGZoS
        ZuECEAOq2SDwK6M5FXBTE68fr3f6xQk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-dymhYEDpPJSf2nsddng15w-1; Thu, 23 Jan 2020 08:42:08 -0500
X-MC-Unique: dymhYEDpPJSf2nsddng15w-1
Received: by mail-lj1-f197.google.com with SMTP id r14so1078509ljc.18
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 05:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4DPy+R5bPTq7tZWsMUKnzOUpzVwlGaLd1jlg2QWm2Yw=;
        b=tLfuWpOpfdriHLAZaIm66gvU7M4DEEO9f1DV1QZuj0M2/t8yCrhxG84Nr45ODMBFdR
         4TqXgRttehWio+JBQhtQntzgzkCb5bEjLXONUdOBLk8KElgbUmtj4JafoI4ySoqs1cT0
         fXDbCy4knPTEabc8ogdGGrgegsAaNtcMKjBmNmKGxCjuZwTBNEFp6Nmp4EoTPE0nxIp5
         LqydRMv42hhxsusOHLBGaNSEU/ZNt/MkeQToaPa+nd2FZlGyq8M2xhShU4bS+ZUhPSdH
         nx9YFI+CW9qpHH4jL7jbuo913c6D/Ait7mzz5XavdPIwdk1NQknAaYGpox4IEDCbV9Mg
         dtKg==
X-Gm-Message-State: APjAAAXOMmGDxUX4U0nEg22bU+Wyt4BnXQE0L5N9Jq1MOja65/w8XdRi
        TpFQD4Ml2T2zIFGEk2FRbUko8yfbiNEGgSaVOdQocXCP4nwcs7c0DP4ywwm9zswsL5dk+IRTTU5
        TVWZenhmbLVyM/jLR/MK1GFM+
X-Received: by 2002:a19:f811:: with SMTP id a17mr4794439lff.182.1579786924713;
        Thu, 23 Jan 2020 05:42:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTmGyH6Qd2cv+F2F7Drf9s7FCX03KscxdhXqeEkXE/A8+ijDXZ9rPq2Sq7zIK+6Vbk3ftI/Q==
X-Received: by 2002:a19:f811:: with SMTP id a17mr4794418lff.182.1579786924504;
        Thu, 23 Jan 2020 05:42:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id w20sm1284895ljo.33.2020.01.23.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 05:42:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2E9961800FF; Thu, 23 Jan 2020 14:42:03 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Amol Grover <frextrite@gmail.com>
Cc:     brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] bpf: devmap: Pass lockdep expression to RCU lists
In-Reply-To: <20200123143725.036140e7@carbon>
References: <20200123120437.26506-1-frextrite@gmail.com> <20200123143725.036140e7@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 23 Jan 2020 14:42:03 +0100
Message-ID: <87a76e9tn8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Thu, 23 Jan 2020 17:34:38 +0530
> Amol Grover <frextrite@gmail.com> wrote:
>
>> head is traversed using hlist_for_each_entry_rcu outside an
>> RCU read-side critical section but under the protection
>> of dtab->index_lock.
>
> We do hold the lock in update and delete cases, but not in the lookup
> cases.  Is it then still okay to add the lockdep_is_held() annotation?

I concluded 'yes' from the comment on hlist_for_each_entry_rcu():

The lockdep condition gets passed to this:

#define __list_check_rcu(dummy, cond, extra...)				\
	({								\
	check_arg_count_one(extra);					\
	RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),		\
			 "RCU-list traversed in non-reader section!");	\
	 })


so that seems fine :)

-Toke

