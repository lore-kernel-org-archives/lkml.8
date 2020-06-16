Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B0FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C0C20882
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5Vs4PyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbgFPP72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:59:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54443 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733059AbgFPP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592323162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Gc0Dg29WyIqBxMjGZGdoDeYitc04zw+8Uk/3lb0oUU=;
        b=V5Vs4PyXpbdsRVxmf1xJlkr7RMs258mWsXbhL4IZc8wiLgOytxlqs/ytaKu5Y9zHaWtK7x
        lk4l1t2a3rKgh1097PbMNvWJGj531cHF91F1SM4e91cCFstBdiDuutOrJ8QaAu89hs84gx
        d38LQhRTydvyURfz5d8Oq8h3wOT83ZM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-Ydg-R64OOJSvgKoAD65adw-1; Tue, 16 Jun 2020 11:59:18 -0400
X-MC-Unique: Ydg-R64OOJSvgKoAD65adw-1
Received: by mail-qk1-f200.google.com with SMTP id q82so2474855qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 08:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Gc0Dg29WyIqBxMjGZGdoDeYitc04zw+8Uk/3lb0oUU=;
        b=ncIrsoJgtcReaQH7PWCCuwsZCG3RQVlsnHkVjYijD80zscR+0bdZjH0/4cM55k7Rcl
         Yiw5V/zNYpj5WRV3cByi169i2YVpWMg7kN7uoLSMk+tT4GHOe6cekJaIQrEuhxqS2kSD
         Ok8P1IVGxJWFylWCYGOQbRjYDX2pBG7SWRB4FeVHemdfF7om0iZ/mWyqLQV1mP/JMQGd
         tKXgmB4U1IfsU7/69fGy8VXorUsKvxOOOVGLyfQsgqM58iNUygPSRW+dekQRrK5+WtHN
         QhnQPhi+lRzSnWIN4FaXfgYdD2RVtYX475WQJrhgP/8DZJcEqQv84d2DEbTTlMsHkz0f
         VHAQ==
X-Gm-Message-State: AOAM533PgT/8ZIjgrc4Cdo4wIZKeuof7b3MzhMDBLavhEKaJl+S27O7J
        GbV7OlAQrHjNJBqpg125L6Z8KJIUe5feOpIO+lcV1iUmkjv695sktayloDB9LHp3Ec1hiQZg2ns
        bFArCd7tNhACYtczeLliynuSf
X-Received: by 2002:a37:6f02:: with SMTP id k2mr20702247qkc.129.1592323157178;
        Tue, 16 Jun 2020 08:59:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+CJxAHuYkrcTeCwjCPlS1h0Nvk5LsJIDdZuRwaKtc+dpfMVU5ZGkZ12CkR4olUnzdv9Abeg==
X-Received: by 2002:a37:6f02:: with SMTP id k2mr20702225qkc.129.1592323156891;
        Tue, 16 Jun 2020 08:59:16 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 123sm154267qkj.56.2020.06.16.08.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 08:59:15 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:59:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/25] mm/arm64: Use mm_fault_accounting()
Message-ID: <20200616155914.GB11838@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-7-peterx@redhat.com>
 <20200616074307.GA1637@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616074307.GA1637@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Will,

On Tue, Jun 16, 2020 at 08:43:08AM +0100, Will Deacon wrote:
> Please can you explain why it's ok to move the PERF_COUNT_SW_PAGE_FAULTS
> update like this? Seems like a user-visible change to me, so some
> justification would really help.

Indeed this could be a functional change for PERF_COUNT_SW_PAGE_FAULTS on some
archs, e.g., for arm64, PERF_COUNT_SW_PAGE_FAULTS previously will also contain
accounting of severe errors where we go into the "no_context" path.  However if
you see the other archs, it's not always true, for example, the xtensa arch
only accounts the correctly handled faults (arch/xtensa/mm/fault.c).

After I thought about this, I don't think it's extremely useful (or please
correct me if I missed something important) to use PERF_COUNT_SW_PAGE_FAULTS
for fatal error accountings among all those correct ones.  After all they are
really extremely rare cases, and even if we got a sigbus for a process, we'll
normally got something dumped in dmesg so if we really want to capture the
error cases there should always be a better way (because by following things
like dmesg we can not only know how many error faults triggered, but also on
the details of the errors).

IOW, my understanding of users of PERF_COUNT_SW_PAGE_FAULTS is that they want
to trap normal/correct page faults, not really care about rare errors.

Then when I went back to think PERF_COUNT_SW_PAGE_FAULTS, it's really about:

  A=PERF_COUNT_SW_PAGE_FAULTS 
  B=PERF_COUNT_SW_PAGE_FAULTS_MAJ
  C=PERF_COUNT_SW_PAGE_FAULTS_MIN

And:

  A=B+C

If that's the case (which is simple and clear), it's really helpful too that we
unify this definition across all the architectures, then it'll also be easier
for us to provide some helper like mm_fault_accounting() so that the accounting
can be managed in the general code rather than in arch-specific ways.

Thanks,

-- 
Peter Xu

