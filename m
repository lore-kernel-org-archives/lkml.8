Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C63C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE572084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586462350;
	bh=alskl+e9BMD4RDI+Or/4Rmd1b3+XcDvKyuPYegzAamc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=agq0OfKMEq6LNWog3VEvoebWRLQGpSZu06WWJ5l1nggTZ5M8C4KzT1Vat6aB2hplT
	 o3FhkaKp7XhbY/LFLL+Y8Ou01nXV/ePZS5ei3CVd5Z1fQZAxg4V/54aT4rS2rC9Od5
	 bY/kBBXVGncteOfVUpLJMOXiHELXRF+wYih1Qq1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgDIT7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:59:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40999 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgDIT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:59:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id n17so1012105lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4fG+Q/ma8Lqz46C5CfYIn7oaq9O50DFVxfEDlCbZQo=;
        b=F5hqRQRlOtq6SmwQg3cq0UstTlU2uH97ZT1KB9fiJOqxxQELGJWYuPPZlDF9X4I6ma
         xpjRrQIi7LnhOH7WK8zWGoV8aZUDlFjCXzMsv6gUGztUBsi6119Bcy9o0lMF7DEFU+l6
         V5++7wbYL65JlLfRscbUIG8vBqf/pbo36C+6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4fG+Q/ma8Lqz46C5CfYIn7oaq9O50DFVxfEDlCbZQo=;
        b=sduXjUwrNHH6nhdvL2pkiLbwEQaPyqpcxZwlu3NHEwkdSEy55x/nlHIdngwZKYQ+iD
         Z0k30Ky5Ka4nxebaAPJXKtG253wD1TM7Cv5GIID1eTlLPEGwbNTxwPHMG5FautHojCGH
         wWSwegF/IyQoQqUGk89tLNsBnPbbkYQoSd5qdcyRH1UgFAZ6NWSaJwsS5OFnz1HZNjuF
         Pq7uRdJjxfiLYkOmrmcazRG06a73OFNYy7e2qcX6X1BZZwP1yGseW1JM6HLcoq5vAp9A
         BLX2H4KQ4t1u9bLOG18EOu+LyI7ZiMBbEi8cYi/kwrDTOdfryoYhbl6GG0U7ncY4bsRr
         LkpQ==
X-Gm-Message-State: AGi0PuYes7hRDZqrqzNO53ijSks4Bkq1903KPmI821w421A8i5Uo6pa0
        ekfwZrMxDkhtyNYvbw69b0v6F+XkXeU=
X-Google-Smtp-Source: APiQypJSdazRT9Cqu6UhHsRjKYe6prDWhPC0m0GvuAdNSh3GdZsGzQp7UjAHCv3AalFiPVG7N8H+ZQ==
X-Received: by 2002:a05:651c:20d:: with SMTP id y13mr955123ljn.112.1586462346104;
        Thu, 09 Apr 2020 12:59:06 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id a3sm46768lfi.5.2020.04.09.12.59.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 12:59:05 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id r17so620321lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 12:59:04 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr584858lfk.30.1586462344549;
 Thu, 09 Apr 2020 12:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200408014010.80428-1-peterx@redhat.com> <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <20200409114940.GT21484@bombadil.infradead.org> <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
 <20200409111604.c778ff091c00fab5db095e48@linux-foundation.org>
 <CAHk-=wiU77DeNxQsU4XrDCk59asyTs=Hn+mnTx6-SHB1_fA2NQ@mail.gmail.com>
 <20200409121250.d6bba6965b86c8dfcf325fbc@linux-foundation.org>
 <CAHk-=wgy3XRiyRP7vdfF6bHwWGaB1RwyWJmyphh+Q3qYk6w27w@mail.gmail.com> <20200409195633.GZ21484@bombadil.infradead.org>
In-Reply-To: <20200409195633.GZ21484@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 12:58:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi50jKXOFpsRkxrqu4upNnEKm1oRZ_SG1yJB9QVh=VJZQ@mail.gmail.com>
Message-ID: <CAHk-=wi50jKXOFpsRkxrqu4upNnEKm1oRZ_SG1yJB9QVh=VJZQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 12:56 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> We should probably give Stephen a cc here ...

Heh. I already did, but then that got broken because Andrew had lost
that part of the thread and the discussion re-started.

So Stephen was already cc'd for my original request to have linux-next
kick things out aggressively.

            Linus
