Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DDF207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6BRilkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGVFDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVFDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 01:03:25 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEAAC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:03:25 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id x2so176250oog.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxgnxLZth5AlOay7AH6dscxuaOg+rKinWvDSlFd8kJ8=;
        b=R6BRilkOut7JttbU2bRmlzrHWrGXTfGi5C6+OAV1GwOT5YjBgfNKl5X2DTibn7fTj/
         PaqRZqItZMviAulp8nQ31nJyD8Ow29GxmyEJcyrzWRgrZnhRV4hPKMUWQlX8cVnSHpQQ
         DxnWOhRnFsRKLuDuHBwFwWIw3SoTVx6jAeGs+CDa4sBnDbX08a1I1eEEB6/cBRuxh7Ea
         F2jWbW4pn+ejMUe348PyaBHv9xUBd3RbNBipZc2P7MqHXb4WGNAS2EZ6AMdyON3LG68X
         DSOLPr7LuqXL+bJ8yQHh4oFKPaxoa33p8vqc3czIzIrrCIjRfWfKBjEtKDKIj1j31UyO
         OMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxgnxLZth5AlOay7AH6dscxuaOg+rKinWvDSlFd8kJ8=;
        b=e+PHozEgAH39csAhsDj9bGW76n66w8p27+XGmZMWUV0v5a2OLE4pcsPq0vp97RZ1PS
         IRExKOnDnxYeH4NbN+HBm6JuCD/ik8fFHvRgD8y6v57CqfJm1Y+6UUC9//thUITy3Lpy
         hCkWZFLSLRqKpjpxwParnsdwD+ibLHel1Vl3eXvVOAmcfnZ7zLAmaHbPwBDBq+64m5YP
         yn1WmCSCgx4f0DAj3F4I49tQYKkzfL+vhZltZynk5RSXn+f6vhVMRcu+AN98Dg+i/qf7
         XX2aiSgOXop/8oozPy/fpuWEPF19Fg668juXILecn3kp4hFfzni1pl5HfIAJMzJ2IU2C
         ysiw==
X-Gm-Message-State: AOAM533Vxsa7CUYSYq4BhM/SEvjaNvOQYBM/6I9wMKCCD2cz1iZ9CG7n
        OQWhCuNdxbCJaB0tTsFNOE76Rh1vVbBCSzSy6GQ=
X-Google-Smtp-Source: ABdhPJwsOf9tigI7Wqr3y57tfv9uSVOghJ1Yo/sPCmwKu/3cN6pj74/MBhBnn/dGUvvHRZJgu/Gp7mIMcKmRB5AOSRk=
X-Received: by 2002:a4a:d63d:: with SMTP id n29mr26998771oon.74.1595394204713;
 Tue, 21 Jul 2020 22:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <1594299795-39394-1-git-send-email-qianjun.kernel@gmail.com>
In-Reply-To: <1594299795-39394-1-git-send-email-qianjun.kernel@gmail.com>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Wed, 22 Jul 2020 13:03:13 +0800
Message-ID: <CAKc596JQUqKsAUQ_=dqzkHYmQxeN95261=25t5XSOWzBV25ewg@mail.gmail.com>
Subject: Re: [PATCH] perf-c2c: Fix the wrong description.
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, qianjun <qianjun@didiglobal.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 9:07 PM qianjun <qianjun.kernel@gmail.com> wrote:
>
> From: qianjun <qianjun@didiglobal.com>
>
> Use L1Miss to replace L1Hit to describe the correct scene
>
> Signed-off-by: qianjun <qianjun@didiglobal.com>
> ---
>  tools/perf/Documentation/perf-c2c.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> index 98efdab..083e99a 100644
> --- a/tools/perf/Documentation/perf-c2c.txt
> +++ b/tools/perf/Documentation/perf-c2c.txt
> @@ -186,7 +186,7 @@ For each cacheline in the 1) list we display following data:
>    Store Reference - Total, L1Hit, L1Miss
>      Total - all store accesses
>      L1Hit - store accesses that hit L1
> -    L1Hit - store accesses that missed L1
> +    L1Miss - store accesses that missed L1
>
>    Load Dram
>    - count of local and remote DRAM accesses
> --
> 1.8.3.1
>

hi man

I think it's a problem :)
