Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF8AC34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 04:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8F920801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 04:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JpYIm6no"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgBRD7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:59:50 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:37100 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgBRD7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:59:49 -0500
Received: by mail-qt1-f173.google.com with SMTP id w47so13585408qtk.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 19:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eBMrYVnG2e5g/Olgnu0zX3IFSEXk/cmu6kxT75NqeqA=;
        b=JpYIm6no20JunYFfGQ6pzuZbzD2WRbnkWP1hg/qTdVzHRtjRYxC92TSVuhoLX9icGX
         iN99sE8PdtIRmp5HZjWlZQVsNGTA5lyzMXYOxC1GLOU8ZLJTSIaQ55MvUPfaTnhB98L3
         rbPBW/nK7iatec/qFcbHwKRisVLgMqnSdKZIDBnOCFSLV4nJO/ByGhhRFr/3YE3ZGsMi
         trCxl2bEoh35CBDK++uZvePlXI4Stv0iQaqS3qMYUGwgxJLHX9jEy4AR/aQKx9LjeeJg
         GvqOgurooT+8bBWebuYs7ILegYts4y6vwTFBs6Ee1RfyPryd2iVDeFlGZWasrM2sVUOX
         siLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eBMrYVnG2e5g/Olgnu0zX3IFSEXk/cmu6kxT75NqeqA=;
        b=ByKeCWYkSnvW1rl7V66bofgWvRVZk0kjKgnTbbiJLn8t4Mc2vhyi1m0B3v0oujycwm
         xAI3HG9vvtWm8kMdTFrVMVamLxxFaTztUu0Ix/xb9oCo2pGNoHy59X8QzIsF0KM+IDG6
         8M2heKeKmrfmi7wvg8xacWvMzo8I17v5G0tNl6b+R4kEj4vrbnj1pOKc0p/FtYr1i4fo
         bJonkQ/8gKrYhHP7ETimQDRg5O9kk7VhBtzpOwWQfIboQPPXbm+7wTOgAOgM+9FitYy0
         yWKOxo2aQ6ygMTr/8ouyxudHMzUYuRecB2SUvTpFq2KmcyiNRcWeJ5FZt7TU8HskOmqd
         wzvw==
X-Gm-Message-State: APjAAAXc4SNe7L1mnoj7v6Ugfl+O4a2wVwiyrySuRZNEytF3XMh9+cfe
        7BXxlrVqRDHlRhWuzj9QuRlJ6Q==
X-Google-Smtp-Source: APXvYqy2/meLKdlopF9ZhXy9TAFlMv+cxtpUhf2YbSbGrZI9L0zGsb5QSVWG/WVyf8pzIhEHuJRj/A==
X-Received: by 2002:ac8:6f27:: with SMTP id i7mr15597893qtv.253.1581998388654;
        Mon, 17 Feb 2020 19:59:48 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v10sm1287993qtj.26.2020.02.17.19.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 19:59:48 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH -next] fork: annotate a data race in vm_area_dup()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200217223138.doaph66iwprbwhw5@box>
Date:   Mon, 17 Feb 2020 22:59:47 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>, elver@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EAD6E54D-8A57-4494-94F2-2EEEC3265560@lca.pw>
References: <20200217223138.doaph66iwprbwhw5@box>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 17, 2020, at 5:31 PM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>=20
> I'm confused. AFAICS both sides hold mmap_sem on write:
>=20
> - vm_mmap_pgoff() takes mmap_sem for the write on the write side
>=20
> - do_mprotect_pkey() takes mmap_sem for the write on the read side
>=20
>=20
> What do I miss?

Ah, good catch. I missed the locking for the read there. This is =
interesting because Marco
did confirmed that the concurrency could happen,

https://lore.kernel.org/lkml/20191025173511.181416-1-elver@google.com/

If that means KCSAN is not at fault, then I could think of two things,

1) someone downgrades the lock.

I don=E2=80=99t think that a case here. Only __do_munmap() will do that =
but I did not see how
it will affect us here.

2) the reader and writer are two different processes.

So, they held a different mmap_sem, but I can=E2=80=99t see how could =
two processes shared
the same vm_area_struct. Also, file->f_mapping->i_mmap was also stored =
in the
writer, but I can=E2=80=99t see how it was also loaded in the reader.

Any ideas?=
