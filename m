Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA93C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D0B2073C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSUWRE60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBKWVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:21:54 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52721 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBKWVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:21:54 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep11so1981074pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tICkfgXtO+mN22GCSsV/9DcFnG7bhQ4aWltQ6wdHqlM=;
        b=CSUWRE60E4BMG/3rTWGMPItqZ19j+17RaJ6slziVt4GVEU4IaapZd2OGojsBxOa1Fq
         hjtRW4aX6c5xlsjAqDvb1wWeGwj/7PJYhHtWo+k+wLKmccG8qJJsZxHJ01c3yH9viHQd
         2sSOIIrDBsn8zg+ojsk66reKYgtrm+gsjfYMg+5AZFj5cwM7BTrdm8FQ1I9MyN2A2R7g
         AFL1AiJVapX7qfd6+X6RAdnLCErX+AgMctHeTgvXAg3uKCjCiMda35ciGRH+o8Ja1vYV
         j3p4f2Mgh1xd4EUY/kFt0shlZ0RQdlA+X3a1MWtTTdJ0TESP2F/uGbWTGkq9xHKmd7zM
         7TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tICkfgXtO+mN22GCSsV/9DcFnG7bhQ4aWltQ6wdHqlM=;
        b=kUfhPYlNnSwL489YtOdcvWetlVMtHtF0m8+ddlWk3o+Zw9ziJ5eN/y/vWDVuIpzRbP
         UOUfnXT2adT8iJ14fss6S6H5oCLVgEiuyJ2R0nBZtjjORc089M6yt4RbJo4NmBYpkseK
         RobN5/qMTrblPKzOLFhy1ClZYOBwSKPPnQOXOme+97DbvvxEuv++xx1Zpb8dMgSSXY+s
         8IqqGbx1AvsPnpqg5VXBZ7O7JlaXMBmqXnxxlUu+uF8tc/vjhoClVjnxImXzi3eu/BjA
         ZX/QKGwgLNJ3HSSn8RlTKUfA04dNEKzru3nobV99VCl/evHDQlMfwAkKd9KgsHki7wKy
         ddgw==
X-Gm-Message-State: APjAAAV8HBIqAevGCqMg6HRiVl3ouSs8CGwiGM4r9s5P2qK29123enC1
        0NUsWTrrGI6iQRK4v5JPfx38Vg0nuUWj2QABxTpirQ==
X-Google-Smtp-Source: APXvYqxH9+OCLyPIbHrlLRFo4AfE/K8IIX17XPBMeJtTqY4OnmXK66UwoksS8QSa21hHuRxJMYP4ZQDA2bqsUTXvWVo=
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr6224442pjt.131.1581459713183;
 Tue, 11 Feb 2020 14:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20200210144812.26845-1-sjpark@amazon.com> <20200210145350.28289-1-sjpark@amazon.com>
In-Reply-To: <20200210145350.28289-1-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Feb 2020 14:21:42 -0800
Message-ID: <CAFd5g46NDz90HQcKWQQqmV_XYoh7nm_AYDsR8u8F__5JidJ0Pw@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] mm/damon: Add kunit tests
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        brendan.d.gregg@gmail.com, cai@lca.pw,
        Colin King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, dwmw@amazon.com,
        jolsa@redhat.com, kirill@shutemov.name,
        Mark Rutland <mark.rutland@arm.com>, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        SeongJae Park <sj38.park@gmail.com>, vdavydov.dev@gmail.com,
        linux-mm@kvack.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 6:54 AM <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit adds kunit based unit tests for DAMON.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Cheers!
