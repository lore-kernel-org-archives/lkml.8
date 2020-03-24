Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859F2C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6278020714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585074300;
	bh=BRk1zWa2KIAD8ZVBGXTm/WReYp6lXgOaW2wcIaRZ5RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UsSkZKHYpiOiM93jkVXtPza6uVAozpNEL8ByWcF4PeRFHW1ukBIIsfWFR1BW82DpN
	 OCK/s7kF0oSbbp1JeNAAaCCBnGzECx6VzJ2WfiOt/kcXaQn+y1sfZJw4GyAxGWCT6/
	 KidK9OUdeE5RdHT3Rz9kwnuirWAYA1xHEbpxsevk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgCXSY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:24:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33809 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgCXSY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:24:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id i6so11253878qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RconwbLGvobrkQrLA8HZT5QCPO0hEEsGfTPRzr6x1ls=;
        b=qWQ0JOE3fCDg+RdT+hVndA3MY+mCBruUcX/KRXX1erbOlMR8BmWY+rmW0XC5KEltTK
         Esqctl8cGeg6M5mbdM8kJg6O7WkZBUw3rNFBdmELweVdBaRROiXkV4Idm8F4A2Xw8FGn
         codkCjZJZWnEcuySG4NFSH1GOpywlWqjp/ZObBdqDN8LWcvTkIpYJySbrrlqjHUJVnMK
         6B1SmqHfjnjazYbnBSmOXN1FZ9FQHMPPeavkMV5IlGpVuubHIlf9/n0dhUS8aE/UTp9h
         ykQLr1yTU0sskkIulH6GAJcxxy6mDya6Pta2xnH7x6y56Jqqh4TVShb+eO9r1Ar3lO9I
         awnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RconwbLGvobrkQrLA8HZT5QCPO0hEEsGfTPRzr6x1ls=;
        b=L91GKKCz53WW+mDRrymWsYG/yI8iHBvmbY6B0JCaTNT03Py6/RtVpSAcRAQQtC66Nc
         blHXOfE088xs2N7bMoidaLX+IA/1jDXngFGnJvpYpUG7hX22nIMb8RiaPlpxq/ah5Nni
         Eg1g5d6+VTWwUcRRQgA8uo2EdSVphI9MhJfIfIMo6/QPgdFNy/UkKfiKDWIuYV9UToDZ
         6yRwRZKwvBNya3XXq4bp+hOkdRSrkPSQ/IkdhQRGsSX4X0AjXMzV2WGMKUMngMJRU23A
         eyAMs17ulXz1ABIAwT7pur/uxDcO6WVsKLOS1c8XNBrlYBxB9YKCIWWJC3BoUvscFtrf
         T7XQ==
X-Gm-Message-State: ANhLgQ1AB78tbm0MhkirD/6xhu7KLLDqEd9oTbtHZOdDg0TBto/SGU9g
        miGEL3cOpf+msi2UI9DCZww=
X-Google-Smtp-Source: ADFU+vtqLe2wnw4h8YDpEepGFhKK7We9Rhe1ZxfEVlqXh61lSnV6dWCn407Z4KLJK4FVGOuzufntxQ==
X-Received: by 2002:a37:91c3:: with SMTP id t186mr26109176qkd.239.1585074296754;
        Tue, 24 Mar 2020 11:24:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::19c2])
        by smtp.gmail.com with ESMTPSA id h5sm13514266qkc.118.2020.03.24.11.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:24:56 -0700 (PDT)
Date:   Tue, 24 Mar 2020 14:24:54 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        mike.kravetz@oracle.com, rientjes@google.com
Subject: Re: [PATCH -next] hugetlb_cgroup: fix illegal access to memory
Message-ID: <20200324182454.GE162390@mtj.duckdns.org>
References: <20200313223920.124230-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313223920.124230-1-almasrymina@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 03:39:20PM -0700, Mina Almasry wrote:
> This appears to be a mistake in commit faced7e0806cf ("mm: hugetlb
> controller for cgroups v2"). Essentially that commit does
> a hugetlb_cgroup_from_counter assuming that page_counter_try_charge has
> initialized counter, but if page_counter_try_charge has failed then it
> seems it does not initialize counter, so
> hugetlb_cgroup_from_counter(counter) ends up pointing to random memory,
> causing kasan to complain.
> 
> Solution, simply use h_cg, instead of
> hugetlb_cgroup_from_counter(counter), since that is a reference to the
> hugetlb_cgroup anyway. After this change kasan ceases to complain.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reported-by: syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com
> Fixes: commit faced7e0806cf ("mm: hugetlb controller for cgroups v2")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Giuseppe Scrivano <gscrivan@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: mike.kravetz@oracle.com
> Cc: rientjes@google.com

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
