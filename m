Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F148CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE7A2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJAzwKEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgGIHlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgGIHlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:41:47 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93379C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 00:41:47 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y2so1348007ioy.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 00:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybapX9dwUgXdpA8lRB7iW1jwbA7bfvk+OO92kUSz9So=;
        b=eJAzwKErSdND8yQvAjVbkFMN+mP21Epkm7M3ODvXiiaw/5tkwNE498gAicfbklyZA8
         ciW2LvRm7CAZmUsjNWqepJjKVyIX5eSHyZ5IpQ/F5/My63+YNeebIEtU2dFuL8K7YAtL
         bGuIAWDJ/BUm7wWRlC1FT9O0UXdkmS+2d5ycLYgiDezVXINwjjgWtVPvzSYl3VLIcrNe
         HmRw1TUxS3VSGbv3u9lbPzFAqcRO/xng98Ebm7oODcSZiew11NLhuz+eAlJNBj2oNV1O
         uY+aMSpJJTskjcQvL5i1fWv/k7TIc3DKSFjusa2+RDo7MdvzJAW3POc5/cvBJWLO+Z7v
         zFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybapX9dwUgXdpA8lRB7iW1jwbA7bfvk+OO92kUSz9So=;
        b=hZcy6ZntT1bGgtcwj4fMkBUqL690/10k1d7F5ud2akNe1Fxwnr0Xwb4AJw13Np052o
         /Cv0/KhKSI50eGcQSUc5SyJPIsOLe/CW2TUyYAX63XmPvBNGBt7aUIBZ4LztYUOZHKOk
         G8+J/LKdYLg+kcSlXea5oAI8yVgIAOlPGtdN99AkbxsFNKgTXnUKtMgG5r4qPfSfSpuy
         yz+pdLMa3WMyePkFKnssBgxLcl7WPi4NagPLr2CW0cHt9xOmBW9inOMrtBp91C07UA+l
         bb845fkNCm5wUR+rG+rQhl6zBoKxTkOvCb3vm+dTwPBR33+/P6Ag37fN1n2VLr4DX2SD
         xEwA==
X-Gm-Message-State: AOAM530ume9SuvInQkNqtHeG8bCHKdrNqFV85SeHEiiPVeI4+jb5OvDc
        VyaTTqXc2kElItsd0GdAYhi4K786dqj42Wp03Cg=
X-Google-Smtp-Source: ABdhPJznZggohMXyEmUhVJ7YSeuhvxMLrSKbinlNGmMG9HQ7dy2PuiqPDtU6kHkJzrzCvpVyi+YL4LVSW0Bs/2kOdbg=
X-Received: by 2002:a05:6602:2dd4:: with SMTP id l20mr40765009iow.13.1594280507020;
 Thu, 09 Jul 2020 00:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200709062603.18480-1-mhocko@kernel.org> <20200709062603.18480-2-mhocko@kernel.org>
In-Reply-To: <20200709062603.18480-2-mhocko@kernel.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 9 Jul 2020 15:41:11 +0800
Message-ID: <CALOAHbAezHHN58cn0unLNbOjHJyYW=zhzQxpQD8_rD4O7qmYRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc, mm: clarify /proc/<pid>/oom_score value range
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 2:26 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> From: Michal Hocko <mhocko@suse.com>
>
> The exported value includes oom_score_adj so the range is no [0, 1000]
> as described in the previous section but rather [0, 2000]. Mention that
> fact explicitly.
>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  Documentation/filesystems/proc.rst | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 8e3b5dffcfa8..78a0dec323a3 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1673,6 +1673,9 @@ requires CAP_SYS_RESOURCE.
>  3.2 /proc/<pid>/oom_score - Display current oom-killer score
>  -------------------------------------------------------------
>
> +Please note that the exported value includes oom_score_adj so it is effectively
> +in range [0,2000].
> +

[0, 2000] may be not a proper range, see my reply in another thread.[1]
As this value hasn't been documented before and nobody notices that, I
think there might be no user really care about it before.
So we should discuss the proper range if we really think the user will
care about this value.

[1]. https://lore.kernel.org/linux-mm/CALOAHbAvj-gWZMLef=PuKTfDScwfM8gPPX0evzjoref1bG=zwA@mail.gmail.com/T/#m2332c3e6b7f869383cb74ab3a0f7b6c670b3b23b

>  This file can be used to check the current score used by the oom-killer is for
>  any given <pid>. Use it together with /proc/<pid>/oom_score_adj to tune which
>  process should be killed in an out-of-memory situation.
> --
> 2.27.0
>


-- 
Thanks
Yafang
