Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B3BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E9220C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qMZpuCyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIJR1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgIJRYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:24:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A713EC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:24:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d9so5024546pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/DxpxIJfXdy7C8opyI8o+XkWeSXniE6Oz2qu6dzaF4=;
        b=qMZpuCyYWD6jZb+YzEyDAHOq9S96Dlc35zPEjydyxNKaUZLI+nsnTqKBltm7I7VQby
         HADCCTM9PWgXBnh/yMcjkuvxmRlsT5UNJXub/kYzv20GW2EKNQChlxY6p1hDrhjikVEM
         Y+KdEXPqXZ38Ol+OaDahwozrZuq1MEwyZ2pzintGUyw4fpxqp9GWD0eGlWbL4iCvW9Bj
         ofC7YnNgP7EgwY2vyDqqmL5l163B1x17PQenBv/kPXwJ3NQU2iMK+zB/IWAXaj3bZoaW
         oayGFBuGysrV56Qz+yWBWg7vkmwI0lExK3a6Cqh86+l2SoKA3YHsQx5QxJRwY1D4m3Gs
         hNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/DxpxIJfXdy7C8opyI8o+XkWeSXniE6Oz2qu6dzaF4=;
        b=mY4ztM6Egr/eEU3RZODjQiNNMg9b+zW7Fb/rbhWPWZpCSFOj+UbLtky6AGibwIf2Lp
         9RXpJDKTS8LExZlGH5tRuKwnrGeBG9MvbVDU1ZZVg6spUtvz6ziZf7i2h1pv3E9iN8Ck
         955tCH/Xft0N249Mx1Id6kcLDjFJRS2QbUxPmOcgqVoo/eckRS9LiwWzg4HgCPHirqTn
         Ye0jeNATg0FbmaVa+YGdsZ5LmC2sLFc5EefoZ85QpkNf9Ur6q7zAhFYwK56E9FDmOLhd
         mdkGXqIT21ADEmmULd58iJhscWMVmviGntgNuXiwWGTGp1Wmo237fRoFwHykjE5R0NCY
         EBsA==
X-Gm-Message-State: AOAM533mjTxGKZDRWTSMgE8Yk1oWobD0H1wfpDbkn4u031itGpwWBbSR
        XMeMBscj41jYVwDI/dS3cA6mpP6BzzRIElAWDyaswUph4PA=
X-Google-Smtp-Source: ABdhPJy84r1DwOSmKuO14ubUxn/70iTZvTReoqQc3tEIf4yVSD6MRkGs/ON+GUp+U07oYBFP6qROw9QwQ7dzGR8qvH4=
X-Received: by 2002:a62:8349:: with SMTP id h70mr6667701pfe.47.1599758684979;
 Thu, 10 Sep 2020 10:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200908221638.2782778-1-masahiroy@kernel.org>
In-Reply-To: <20200908221638.2782778-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Sep 2020 10:24:33 -0700
Message-ID: <CAKwvOdnP7UmpRPL8XjzoMPjgQb9Di8OXk9UEX8NWaa35A01Q3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: qconf: use delete[] instead of delete to
 free array (again)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 3:17 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit c9b09a9249e6 ("kconfig: qconf: use delete[] instead of delete
> to free array") fixed two lines, but there is one more.
> (cppcheck does not report it for some reason...)
>
> This was detected by Clang.
>
> "make HOSTCXX=clang++ xconfig" reports the following:
>
> scripts/kconfig/qconf.cc:1279:2: warning: 'delete' applied to a pointer that was allocated with 'new[]'; did you mean 'delete[]'? [-Wmismatched-new-delete]
>         delete data;
>         ^
>               []
> scripts/kconfig/qconf.cc:1239:15: note: allocated with 'new[]' here
>         char *data = new char[count + 1];
>                      ^
>
> Fixes: c4f7398bee9c ("kconfig: qconf: make debug links work again")
> Fixes: c9b09a9249e6 ("kconfig: qconf: use delete[] instead of delete to free array")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/kconfig/qconf.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
> index 8638785328a7..c7216b9110fc 100644
> --- a/scripts/kconfig/qconf.cc
> +++ b/scripts/kconfig/qconf.cc
> @@ -1276,7 +1276,7 @@ void ConfigInfoView::clicked(const QUrl &url)
>         }
>
>         free(result);
> -       delete data;
> +       delete[] data;
>  }
>
>  void ConfigInfoView::contextMenuEvent(QContextMenuEvent *event)
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
