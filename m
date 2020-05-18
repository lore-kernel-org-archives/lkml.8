Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DA5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A09207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTMYUfv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgERQcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgERQcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:32:42 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB78C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:32:42 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 69so4008222otv.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEH7JHR8Qb3duOaucOU5YLOgOXF0CphuFUPP+1XhkR8=;
        b=mTMYUfv5am96J+UIsuYVITSQWEihRgzgjffFupaTD3mAfSqragjccLZ1w6KSEaE0ao
         AVn1L7BxBBkdplfXGtCk37yXl2uFaTGKCN2UHxT8PqrK3GqUbIgqOBV4gguQvq0vug1F
         eniZuOCwagIDcTg2ZvhUDzV4UAkt46yEdq6RaEYJs1EVaYHcIGNoWAZn5ChfQyZOMF5B
         Q5Lr6gjB6JnTTsZg3bjuwQFklmc0uqpPBsXgwQCMeECP/IfjrKgzU8VGMPafUsnfWE9P
         c/LJ4yqOdhDfBpn3XIEAqkVQU3+tElsFNd2B/ivchf70+zzZtvCYFXmJLi1SdtZm9b/q
         9IMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEH7JHR8Qb3duOaucOU5YLOgOXF0CphuFUPP+1XhkR8=;
        b=h+gHuMgtOzop0V8LnqXiRJB9/7bbO6nfaukAcx0It2PmEulUyMYCFruiZJbFqcc54o
         f8L/Ik88LqHPKy7JX9EjzBaDkhGO9sx6rDVT+KFEE0HXSE6mqhragT8wR4pfs3MG14Xn
         4Gh1HQPrUPlfclhTfu7jr5W06U5uueKwZfdoKDIVqicRIQ80NUlwIJPYO0gATRzUKuja
         HQ3TDvBz0ayScabtj6zGKPFrPcA/eAeQ6jUBu1LikXnDBwOOxIXXQHVIWDs33Nc1NejL
         qySK8Z44kTVx4bWq3b4j7PPCKKYpZsgKvuscdYCnJlwHNtzG+vOn15ENF7lxP+cucx7a
         vrRA==
X-Gm-Message-State: AOAM531kdPLQ9aD01SjIIrYcOK1dhmgFH7+F4pAeAfCadjd58vf4F07u
        QZT+mjT5ozbZMgLNDZ71xgYnkFnHWRxrosm2onb0PxyV
X-Google-Smtp-Source: ABdhPJx6tPmam+uNRo2CNpq1TA2yF0LzT0SfnVMKUU0P2eH7XxP9gBdLE5a9UY6EjNsm069lrs7Gq6GRw+86ioPQBfQ=
X-Received: by 2002:a05:6830:1d69:: with SMTP id l9mr8587784oti.127.1589819561468;
 Mon, 18 May 2020 09:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200517001245.361762-1-jhubbard@nvidia.com> <20200517001245.361762-2-jhubbard@nvidia.com>
In-Reply-To: <20200517001245.361762-2-jhubbard@nvidia.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 18 May 2020 09:32:30 -0700
Message-ID: <CAHS8izNWgqCbiK359wj-sAq5U1rWUQC+ekxmC1YhEW6_6Mf=Vw@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/vm/write_to_hugetlbfs.c: fix unused
 variable warning
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 5:12 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> Remove unused variable "i", which was triggering a compiler warning.
>
> Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/vm/write_to_hugetlbfs.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/testing/selftests/vm/write_to_hugetlbfs.c
> index 110bc4e4015d..6a2caba19ee1 100644
> --- a/tools/testing/selftests/vm/write_to_hugetlbfs.c
> +++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
> @@ -74,8 +74,6 @@ int main(int argc, char **argv)
>         int write = 0;
>         int reserve = 1;
>
> -       unsigned long i;
> -
>         if (signal(SIGINT, sig_handler) == SIG_ERR)
>                 err(1, "\ncan't catch SIGINT\n");
>
> --
> 2.26.2
>

Thanks John!

Reviewed-By: Mina Almasry <almasrymina@google.com>
