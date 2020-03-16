Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B70FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3097205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8RO/kM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbgCPU7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:59:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36862 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732571AbgCPU7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:59:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so6050466plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 13:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqGyMQCkH44ncWYB9fVh87Q38XfHyDtqZOeFKJMjzzk=;
        b=O8RO/kM9S9Y/fmLtN9APDn4tOgwGV0gGBD7wxYbP4vh9xLGEyKdF5FnixinkbH7T0o
         jSb1i/vzTsRzyDaMrYxFaUbfBNjcwQIPoLoMbIpvwrw8tqUKk7lnHj9/N+2W/D4NV//H
         4yMQCNmz2M3PJ0pOkzsx68WUk1n6cwJ9iTzXapMyDOn7B3IOQ8RXotac3WdIwl6bRY+m
         rAAuclUHZSjSY9YSmQ7s5vVcEQPlYdsphKH9ya3zbatTA22jyJfggAq4ENNGw0oRL5ps
         cZwM5lHXn2lJZ89dtiyDX8iQUvkifHZtPYpW5apBtX0K14mDHzmIaOccRq5fDmnbq6JZ
         w63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqGyMQCkH44ncWYB9fVh87Q38XfHyDtqZOeFKJMjzzk=;
        b=YZSCiVTLEul+0lS4SIiz7krBfCWUWzfre2uHNFysapF2eTpfokNMnxvFvtSuSuaNf5
         2Xkymq6KRpa/fwQcJ3kJa/IFXhnGCC+QAU3TrR11ssZgdMY4VbQgPua5X026BsGZyEFD
         ExmZ9UiHTISKSO75kkaNGnJQv7wMmz7uZmCy9AfqgbNG0cVyXJYSz8uk3MXzspUGwoNY
         o9Jdr3caYBu6KI6/P82VybS4scA6kJFWkYTrlL3KC0TvqNwcMoaUq/jjOi2Nwwz4MRC6
         rCics6y9tYhAeFexS/ecCwVluamG2j/NmKYref63ysZ8DUiWxPwsl26OsGpUyygX70z6
         O9RQ==
X-Gm-Message-State: ANhLgQ19MAhs66IhOymaBvMykcUQHKS0eMBwanyBvXHMmVTS1zEXzUlv
        5xhS+hybz1T1m6mK1070D/tDkRrlxpIvXyftzaGjolGR
X-Google-Smtp-Source: ADFU+vtOhtdLPnf3QskjqwAJnfSjdwvgunRrzxYqApkMwBOXbFeTIIQoGpYLvXt2hH/0JyDgDr+9WJiX8dFOplL7YiI=
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr974318plo.179.1584392362078;
 Mon, 16 Mar 2020 13:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200316204855.15611-1-natechancellor@gmail.com>
In-Reply-To: <20200316204855.15611-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Mar 2020 13:59:09 -0700
Message-ID: <CAKwvOd=wUtvRK8LEz6Xm5qnvfRy8G5XTWbXHTdgPwWhh39N9MA@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: pdr: Avoid uninitialized use of found in pdr_indication_cb
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 1:49 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../drivers/soc/qcom/pdr_interface.c:316:2: warning: variable 'found' is
> used uninitialized whenever 'for' loop exits because its condition is
> false [-Wsometimes-uninitialized]
>         list_for_each_entry(pds, &pdr->lookups, node) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../include/linux/list.h:624:7: note: expanded from macro
> 'list_for_each_entry'
>              &pos->member != (head);
>              ^~~~~~~~~~~~~~~~~~~~~~
> ../drivers/soc/qcom/pdr_interface.c:325:7: note: uninitialized use
> occurs here
>         if (!found)
>              ^~~~~
> ../drivers/soc/qcom/pdr_interface.c:316:2: note: remove the condition if
> it is always true
>         list_for_each_entry(pds, &pdr->lookups, node) {
>         ^
> ../include/linux/list.h:624:7: note: expanded from macro
> 'list_for_each_entry'
>              &pos->member != (head);
>              ^
> ../drivers/soc/qcom/pdr_interface.c:309:12: note: initialize the
> variable 'found' to silence this warning
>         bool found;
>                   ^
>                    = 0
> 1 warning generated.
>
> Initialize found to false to fix this warning.
>
> Fixes: fbe639b44a82 ("soc: qcom: Introduce Protection Domain Restart helpers")
> Link: https://github.com/ClangBuiltLinux/linux/issues/933
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Yep, thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/soc/qcom/pdr_interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
> index 7ee088b9cc7c..17ad3b8698e1 100644
> --- a/drivers/soc/qcom/pdr_interface.c
> +++ b/drivers/soc/qcom/pdr_interface.c
> @@ -306,7 +306,7 @@ static void pdr_indication_cb(struct qmi_handle *qmi,
>         const struct servreg_state_updated_ind *ind_msg = data;
>         struct pdr_list_node *ind;
>         struct pdr_service *pds;
> -       bool found;
> +       bool found = false;
>
>         if (!ind_msg || !ind_msg->service_path[0] ||
>             strlen(ind_msg->service_path) > SERVREG_NAME_LENGTH)
> --
> 2.26.0.rc1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200316204855.15611-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
