Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15527C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 19:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E777D2137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 19:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Jq0gyM+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgEATdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 15:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgEATdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 15:33:35 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC76AC061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 12:33:34 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so3602497ljl.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 12:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbgIzQF7PGrW8iZRTdusJ7sWvtSgO8I59OYVHO8ilyI=;
        b=Jq0gyM+DbVcz/JPpoz7PFl9wWIqqXst6dmmpqHr251cQCf/affWv5tyeNPC1NxFtrs
         rHVkw7afU4AU1kptcgxMzMXJjmsiX7beJ/TAJdVzf58jzxrlTAZ+7IHLV49avIIVfSlK
         M+L7q9oDIZySdc0nW2uOazr29HUEziuOVlXQ3kJgqx0FjmaxI9gIzQL5hnp9rXG7DAjN
         OxQlOM04vRcm7nKkWJImhMUI0hcrMP8UUN3sArAh3/4zJCd6d0mPiMqw2e5S/0znzY3V
         kN//NemPzGZf2L/F/3rxqZn+lqpGDTVlWMYloWT2POlqwyBopkwYrasqt4D8YBM1nZfC
         WEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbgIzQF7PGrW8iZRTdusJ7sWvtSgO8I59OYVHO8ilyI=;
        b=VC/YGKhx7EvDaeBimCsaAIsdDdpXi5JRu27GfGYxwi+PL9SkeBHClmgWmyymI+z6sX
         9PQRBqWy73/vqM/haGoicgv+291HUPWCL+nzQO/8qWvqhI97na2NUh4D3pRFKbNVjewf
         FQVeJtP3MScB20onI5KDtwbPq+Rpc6sog/mjuku8SLv6d+dL+4bFkOwgw+dG1qLo4C0h
         YtD3BgcFv2zXZtx8+DxtM8UM90oP72QyOewPswCx2Fmi4I4hbBHriAG/u4x4/dhHc+4a
         og1kURqovf8ZRn3F27bvUkMVQ/ZO4kmX7JAimFffJ6r9qvQCv5EMajxWz6YpHftq1Uk7
         IOBA==
X-Gm-Message-State: AGi0Pub+tzec+05sGYwD8TXSTT1ARu7qeNMHGRcMpzP4Cale4Ee7QXvj
        W2BRPL5jh9ZRpq9CCQDnroMVYY+BsL7hO677gQCBJw==
X-Google-Smtp-Source: APiQypI5FzFKZQUnrmYo7NPbtZgUKeFqJ22lMs6ihVyKaw+XsL4/3vntaEYBwQ6F+HJ9B6Kgj9Npto2TP85IVCC7TR8=
X-Received: by 2002:a2e:864f:: with SMTP id i15mr3431858ljj.179.1588361612920;
 Fri, 01 May 2020 12:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-5-maco@android.com>
 <20200501173032.GD22792@lst.de>
In-Reply-To: <20200501173032.GD22792@lst.de>
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 1 May 2020 21:33:23 +0200
Message-ID: <CAB0TPYFJT5A-+T-B6tD1O0X8GGK_LFOpBDZv+fFc7LqDyN_aAg@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] loop: Refactor loop_set_status() size calculation
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 7:30 PM Christoph Hellwig <hch@lst.de> wrote:
>
> For some reason this fails to apply for me against both
> Jens' for-5.8/block and Linus' current tree.
>
> What is the baseline for this series?

This was based on Linus' tree from a week or two ago or so, but I
think you're most likely missing this one?

https://lkml.org/lkml/2020/3/31/755

(I mentioned it in the cover letter, but can make it a part of this
series if you prefer).
