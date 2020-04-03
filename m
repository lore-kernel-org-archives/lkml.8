Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE75C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1BE2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cvWoAx8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390762AbgDCODg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:03:36 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:32937 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgDCODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:03:35 -0400
Received: by mail-ed1-f53.google.com with SMTP id z65so9433321ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/2/QnZrdfNzMUl7V0Zc2Muz5P3vIO5snfNmGYbh3nU=;
        b=cvWoAx8DIGxqk2ohI3cG9gBv4PW2fm2j9s1Ie5nEs+t+rfv4Jr2fL02E8a7QMdqMED
         2jaj0tPh0VrTxG6HLMOeySAEoj23W6PVcN9kngcGZ2IBWuzowL5cfhVwAN30vTx4kJIC
         FG49YOebDsuFw4HN/DP/8HlFi6s77WYc6dqr6v01ZXwaigPIs5alMKdgYvi2sN2iuYR4
         91fLA7Hnk23dQBPWUuwkSgUITL5wiDZnM8rDt+fVqpLcWF/V2sVFRT+4eTO5lQhkB8jV
         QTehIuJICbkk3AbMfzZ+RURXeEQ1dGPw3AcB84Mpdfpww1l1JyFi+3xXAK+nnqDm3qCo
         3V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/2/QnZrdfNzMUl7V0Zc2Muz5P3vIO5snfNmGYbh3nU=;
        b=qmp/tn2JnqvX9hprlRiEDdmGc6eOKZ0o7ZrRQkCzg1ehOvDbul8ICraw2kG9VPo5oK
         yMQ3+thrZfYXTH/ILIGYykRufLHWo7fBUel63FRvdMla9t3n7ZYJsjkSyImHyrZsjS04
         4H07UPp2kH1bkxE6R9H8O901mdxzIitRW/hUrHTtX4XY3AirNVEJFlZnqxvh9Crlckwo
         IPjV+aXrp8cX1MfWqBF7iDPvZUfa1jLuABFPi+mXtwzRpzYLo9j7S1pELFEUBOS9Zj6v
         rgg7nogOCziatZkwztnFMBXJB42cjr24Hmpz59rtxT0f/WGjPDocSGOLQST8XMw/5R8K
         ygdA==
X-Gm-Message-State: AGi0PuZuSruML/ZPF1emwMf3GFN0OKdwOGvuTvtVZmkdFEyCMyJ3PYhY
        tTZZHfthYf2BIbgDx7Lk+cv2yk3YKF1Ak7jw9Y1mxQ==
X-Google-Smtp-Source: APiQypIF92A9lz0LkN0P3yMzNLaE8dz28LXcse7vIzHNDR2ihHENs0X8Yg6tXBNEVCEDP1dDBCKgJLxHRBY9zYCJ79g=
X-Received: by 2002:a50:f0d5:: with SMTP id a21mr1214123edm.85.1585922613877;
 Fri, 03 Apr 2020 07:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200403133549.14338-1-pasha.tatashin@soleen.com>
 <20200403133549.14338-4-pasha.tatashin@soleen.com> <20200403134439.li6i635dnur5jdha@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20200403134439.li6i635dnur5jdha@ca-dmjordan1.us.oracle.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 3 Apr 2020 10:03:23 -0400
Message-ID: <CA+CK2bDkh4ZzvsoaFAi=NZs4sxtfZgHFoWJ-uiw+BRKkNN6BHA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm: call cond_resched() from deferred_init_memmap()
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        David Hildenbrand <david@redhat.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you meant cond_resched()?
>
> With that,
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Thank you Of course, I will re-submit quickly!

Pasha
