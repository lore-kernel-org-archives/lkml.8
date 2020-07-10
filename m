Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2672C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88462065C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QK7mXTa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgGJD0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgGJD0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:26:06 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F243C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 20:26:06 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id t11so1987249qvk.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 20:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=eFy7G8MFh5j0dWXgNTfhYT55Z/WQldbqa04KvJF1NIk=;
        b=QK7mXTa+VJP3XCY/WLX/zRxgMT0Ii7iOBVxRxjXH1puvNbSdonlAYLgfylTKR/h69b
         ZS0KjOAejKEYw9VVZWy1xRSR2L+6xIdQiUbEK+8GwTUvf/qTyxPPgj5+eV9bgQoDoGe+
         hzJb4L62Ysd18Fam+KcjOm8SxE3S3qqRinec+dFfiJhZp0QbSj6PdaYyQZibjI637Aad
         e0MrJaRDenfU0H4k4Vf7RqoGSILBdjSfSkTW+rWdY0c/fT9sBh/ZpaSTZNUr5RVpSzrI
         gzF6w0XY6tjfvLbU3qopm4SdEiOpVDuMtYLzJ9N4JY1331WI0Zfefknn3QrRDvwulK0H
         kpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=eFy7G8MFh5j0dWXgNTfhYT55Z/WQldbqa04KvJF1NIk=;
        b=PN1mOnFbXkUWdXkd60ZE/wzWDs375Gxiod9D6lhAYpIdc0/ebTKzvxKCwYDBNdVKC/
         NOJ3GuZhgYmiwJkX/AW4V8CNwzadqqNSLwBb+HwtahCCjVKF9Sk0SNzGMCsy+GpF5mpI
         phXpMWdNDStQ4eg/x0V2wN9+/KoOQyQKlEUaGP1LaFDqOhjnXz1eyOkax6NIW0YdnL3e
         /iHtRgq3he4zgmX4O0ZW/w+eTIf7o1czCe+CtWrD7P9+HdHeCCb2N4f64TtRKMjwFCRo
         PGR4gylqvwCByZx6sVPCyxILobfJu+pdZws1a+Mv3ntdQETMJ6hzrHRUUhTlQLOJasv8
         8C5g==
X-Gm-Message-State: AOAM532T849w/1dFGxSpzzBpk9xr3fMxNFRezegTEBKT6DDtsiGc4n3i
        qMUjFEThD7mgFjAu628NKgIV8w==
X-Google-Smtp-Source: ABdhPJySjIDUPTcCvWRvsyo70Q3CiQUo/bQVf3SzYv2WKDHX2B7fNAAUwB/k5mRHSOAN2A1xkCYYxg==
X-Received: by 2002:a0c:bd88:: with SMTP id n8mr67662598qvg.194.1594351563883;
        Thu, 09 Jul 2020 20:26:03 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u20sm6442583qtj.39.2020.07.09.20.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 20:26:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Date:   Thu, 9 Jul 2020 23:26:02 -0400
Message-Id: <6F39E573-C325-4D94-ABBE-E869E146B05E@lca.pw>
References: <20200710013852.GB81727@shbuild999.sh.intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, tim.c.chen@intel.com,
        dave.hansen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
In-Reply-To: <20200710013852.GB81727@shbuild999.sh.intel.com>
To:     Feng Tang <feng.tang@intel.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 9, 2020, at 9:38 PM, Feng Tang <feng.tang@intel.com> wrote:
>=20
> Give it a second thought, my previous way has more indents and lines,
> but it is easier to be understood that we have special handling for
> 'write' case. So I would prefer using it.=20
>=20
> Thoughts?

I don=E2=80=99t feel it is easier to understand. I generally prefer to bail o=
ut early if possible to also make code a bit more solid for future extension=
s (once the indentation reached 3+ levels, we will need to rework it).

But, I realize that I have spent too much time debugging than actually writi=
ng code those days, so my taste is probably not all that good. Thus, feel fr=
ee to submit what style you prefer, so other people have more experience cod=
ing could review them more.=
