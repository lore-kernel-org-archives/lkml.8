Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB133C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79D0206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzENPptp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgFBU2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:28:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8708C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 13:28:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r10so47341pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4s8ELkDI44C3t1msJoEfHdf1WqgoBLz+UoYOg97UZw=;
        b=WzENPptpkYq02HZSRlZAcNZXcu5Qn9AmIlB8wIVNgRHDFlGlrJu3S5Xh9l2aPtmvGD
         ZAvm6PSICZsDx1Fpdqwh2gJhlTKWtn9ZYiOCwAtlcHiUBuG8OQbwheTw3zApkEcA6rG2
         PxdC9fCRnPi83/Pkl5iqN9QT/QZ8Levr1SxCdULavUJqWpK927pkRpOjV9f8iF+qAXVD
         c/iZxDSrvRO0wCuzhZASKnCbwEjrRNvASdOShB7/dJtSE32qq+yflkPF047mcnqyUkqV
         +l50HgySnppbzMy2+Ue85UODRiJ6AdNKHAC1bl/nIq3X/plkl9HII7YDjhh+JPJ6wvm9
         SVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4s8ELkDI44C3t1msJoEfHdf1WqgoBLz+UoYOg97UZw=;
        b=ZSAyrRhuEvkFe2gVObntsSYCdUR4fhHIp16I10KAjPbp/f57n+3xbynY88SqbkUXly
         gJrN/pQ2W/L/WcYNIrlxNFBcf51KLuYTaaVPJF0rVuGttPGphZ4p+owxyVMwUr02FZCr
         TAz41sf8cYvu7oUYF1KqTU/ICAiB6KNnILXg+QjLM9Pg4bKI+m1yiMc2XNOaaH8HPgng
         9IlA0gL+7BbWm/+bWQF38JoTUHpDiQnPmwxmAnyWC8Z46lNmmMejSQePXTH0FN0lXHd1
         MuyFvLC0gUZm32MwK/vEV7aL/QgxyS2vOVqDoA3kQLbF3GLWIf6PJ9SrclFjfOSdgKlm
         6nNA==
X-Gm-Message-State: AOAM53207KhMnpNnCOqMy5YpQ/aI9V4/u71QSfw+Jy5tJ0I3WbVvvnAv
        vCt/RA3+6JzrcNKdPOiWtkikfeEt8C/BvYtzGXxyKw==
X-Google-Smtp-Source: ABdhPJz2NSXepY/bxd9qMnQmNxaRNsuzQ7rmW7BzRrqROrvVq8b7ZKziCEBrT8C2w3f9uBmP1qrwHCnLNi+VE274Ipk=
X-Received: by 2002:a17:90a:3321:: with SMTP id m30mr1094446pjb.20.1591129693958;
 Tue, 02 Jun 2020 13:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200602130125.20467-1-sjpark@amazon.com> <20200602131549.23617-1-sjpark@amazon.com>
In-Reply-To: <20200602131549.23617-1-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 2 Jun 2020 13:28:03 -0700
Message-ID: <CAFd5g447MLhQ5F2MeizMEM+V1kSUY7Cqjp-1XxrfdLvEzxXFEg@mail.gmail.com>
Subject: Re: [PATCH v14 13/15] mm/damon-test: Add a kunit test for recording setup
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        brendan.d.gregg@gmail.com, cai@lca.pw,
        Colin King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, dwmw@amazon.com,
        foersleo@amazon.de, Ian Rogers <irogers@google.com>,
        jolsa@redhat.com, kirill@shutemov.name,
        Mark Rutland <mark.rutland@arm.com>, mgorman@suse.de,
        minchan@kernel.org, Ingo Molnar <mingo@redhat.com>,
        namhyung@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, riel@surriel.com,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, sblbir@amazon.com,
        Shakeel Butt <shakeelb@google.com>, shuah <shuah@kernel.org>,
        SeongJae Park <sj38.park@gmail.com>, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, linux-damon@amazon.com, linux-mm@kvack.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 6:16 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit adds another unit test case for the recording setup.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
