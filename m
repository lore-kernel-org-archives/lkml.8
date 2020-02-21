Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F1CC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853F9206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582313722;
	bh=RAQqm7CaxhuTbtZbZDZkDpQ8OwM+wHi06SXgFd+lrg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H5J0qLQn9361/8HoWIshnR1ff4ZRgpDlNb/hcwKVKwRCi1g0g8QZl3ya5JJnuBX9L
	 V3QLag2XOCDOungdmdlQp/YVFaAfZyT2sAxUHoNR7cpaB7XP4beoMCNhae+QYhuDDt
	 7AAMt9jA60fyXbUup0EKx7FxjMBuBk9SjcbMohx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBUTc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:32:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41676 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgBUTc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:32:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so3366156ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U68GDVY1KdzbrGrjoZTqOzYk2yQbO7PvSyDl1XnOe7M=;
        b=QdRWKTV8/0rGRlPB9hVxGyAJMrNhgHy8ONjGP9VHRWspnZm/PK9TuKMCKKxnfycqBS
         cLW67Fnaxdk/sVszEjMNzilHnrYN2TR3xTMielOouX327gps8wlgAmUeF1hixpdaBuZg
         Khc0xJrvsl05EHVwLH3oZQSjoldKEDdDGf58s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U68GDVY1KdzbrGrjoZTqOzYk2yQbO7PvSyDl1XnOe7M=;
        b=o5jJZ7pQnwrFCfWRH68vdnFBzsaVq3QVSi+7IcITbT6ipvDEOemo/VlA3eTuh+9yPC
         cNDgQHfweoGi6Qrv1C4x5YIbFNXUGoWXlch/BObPPug+2mYrQoRbEf6pQqKqMtdRYaPf
         gv6zCnB+BDtvcB5pGt7S8seAODZjZx3HVjWHVbTRsEJPocVCkTsn8bTGV5qHXscZGpTI
         +OQhvFw9/JX6vWncy+UUd5X7gpCofm+Oo0hx1q+DEu3H18QD6CFtUSvHG2/IY/yR64JT
         zGVUtYsZQTGc5sWy3MnuooqmnQuuLvUP3oIXUIL8+Jt6vxkTzy0hVe5E8sa3TMBvpMRo
         /N+w==
X-Gm-Message-State: APjAAAUA4P1NvSiWaKtyX4Sy62QP0G41vAJpXYW7oTHdkcK/yWn5S7sU
        DLV1++DO+WBekk+Qv2VAwFkCuJWbOQE=
X-Google-Smtp-Source: APXvYqzC9rgztJHU94LR4357ApKdnclRiTWjhLPcSQwIT02AMZYtnqEHZIVXVeISr2w7OLqj9wPR+g==
X-Received: by 2002:a2e:8916:: with SMTP id d22mr3571362lji.19.1582313574714;
        Fri, 21 Feb 2020 11:32:54 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id o69sm2139338lff.14.2020.02.21.11.32.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 11:32:53 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id s23so2288829lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:32:53 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr20690967lfb.31.1582313572704;
 Fri, 21 Feb 2020 11:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20200220155353.8676-1-peterx@redhat.com>
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Feb 2020 11:32:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjboPc5diXRfhgMQbDOxfJAW=8XyVmAVhAjx3Ha3W+u0Q@mail.gmail.com>
Message-ID: <CAHk-=wjboPc5diXRfhgMQbDOxfJAW=8XyVmAVhAjx3Ha3W+u0Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 00/16] mm: Page fault enhancements
To:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>, Hugh Dickins <hughd@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 7:54 AM Peter Xu <peterx@redhat.com> wrote:
>
> This is v6 of the series.  It is majorly a rebase to 5.6-rc2, nothing
> else to be expected (plus some tests after the rebase).  Instead of
> rewrite the cover letter I decided to use what we have for v5.

I continue to think this is the right thing to do, and the series
looks good to me.

I'd love for it to get more testing, but realistically I suspect that
being in linux-next will be the right thing.

I've been assuming this will go through Andrew. He's not explicitly
cc'd, though (although maybe he does read all of linux-mm and has seen
this several times as a result).

               Linus
