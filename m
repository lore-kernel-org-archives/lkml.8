Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719B9C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F93C20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FtnyNGaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBKL5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:57:08 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:39822 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgBKL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:57:08 -0500
Received: by mail-qv1-f47.google.com with SMTP id y8so4825382qvk.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 03:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=NqSDjPBLt7KaMO3YE3bDtH3fJ1lzw5pAy6fF1/Y2SAI=;
        b=FtnyNGaI+FRU6+YMQYtX66IH+nESFWjMFwsNUQtmKsT+4l0ORL3wRtKES0bkktkGz3
         iEqocSU+QeHQE6OEJpPRmHgbdu05Bfuk1s8X+5nuq2n8OSlQmEgw1JJ4afgBDxCGadp7
         EoJ7/uptRDimKV3TjVFcO5ONB0rcrtrA4k4ETUBfRYUa2exXs38fG+wLEawRlOoLxk11
         PmQXPIMwXZrvE0pTwtFjjK/tbRckrFNrvYbmQn/YjouY3K5pXh2UNw26jnm2Rhkz45ka
         4+h3C+E2slzFonxbsEegrBdkXEFmiObyNAtRcDMdc5/p95CSnvudV5+dzp+qAkc6AX8R
         qkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=NqSDjPBLt7KaMO3YE3bDtH3fJ1lzw5pAy6fF1/Y2SAI=;
        b=fbl1JmYC0/AC8bBiBPfzB1A3xcDmh5O7yU5HTPk1xkqalCAeOpTtrZOQrJfHi1RPU1
         3knbwYkCFmBNxznxcs4VeIWfr6k6Dkul+mXL44EPKpup5hReb7MvPL6BONxhwGuVQJmY
         5LVyad0cU2ga6h28Qdpd3EMOe90C9MYsvdyG118lQ+ExI6TrsaIYVFHudmmCA3dQEhg+
         B/8mjl2tWPRbcj6P8pFtnFyoGePAcK8ITMZftuWtfj0VqptC7q6ckkhMdsgDDpEnTp18
         bn1jy6+kdfDf9XcE6oapVqPDM45dbB+xKl/mo3A4U3lXaYPjpjIbtd4Mj+GMKmvRQmUY
         j+qA==
X-Gm-Message-State: APjAAAUalQeblelJvTWJHeYVJkk2zgkfQmmfLOOTC9tR5PlEsNd+iTa/
        P3v2BCDxok7iy3SzTsGI1+/La10SeKHBxQ==
X-Google-Smtp-Source: APXvYqwHubfElUXdoqcFG4jW4y4VIoJ3XWlawPU5C6G+kU4oibrcmZLwN6oftaasCKmSO9scx8CnHg==
X-Received: by 2002:a0c:ab8f:: with SMTP id j15mr2451647qvb.223.1581422226683;
        Tue, 11 Feb 2020 03:57:06 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v55sm2105189qtc.1.2020.02.11.03.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 03:57:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] locking/osq_lock: annotate a data race in osq_lock
Date:   Tue, 11 Feb 2020 06:57:05 -0500
Message-Id: <295818C4-C5B8-43DF-9D5B-445EBA02FC4F@lca.pw>
References: <CANpmjNPWCu+w3O8cg++X4=viVFsWNehTXzTuqbwV8-DcXXpFng@mail.gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CANpmjNPWCu+w3O8cg++X4=viVFsWNehTXzTuqbwV8-DcXXpFng@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 11, 2020, at 5:16 AM, Marco Elver <elver@google.com> wrote:
>=20
> I have said this before: we're not just guarding against load/store
> tearing, although on their own, they make it deceptively easy to
> reason about data races.
>=20
> The case here seems to be another instance of a C-CAS, to avoid
> unnecessarily dirtying a cacheline.
>=20
> Here, the loop would make me suspicious, because a compiler could
> optimize out re-loading the value. Due to the smp_load_acquire,
> however, at the least we have 1 implied compiler barrier in this loop
> which means that will likely not happen.
>=20
> Before jumping to 'data_race()', I would ask again: how bad is the
> READ_ONCE? Is the generated code the same? If so, just use the
> READ_ONCE. Do you want to reason about all compiler optimizations? For
> this code here, I certainly don't want to.
>=20
> But in the end it's up to what maintainers prefer, and maybe there is
> a very compelling argument that I missed that makes the fact this is a
> data race always safe.

Yes, I feel like locking maintainers prefer data_race() rather than blindly a=
dding READ_ONCE() unless there is an strong evidence that the later is neede=
d.

Since I can=E2=80=99t prove it is strictly needed to prevent from which spec=
ific optimization, I had chosen the data_race() approach.=
