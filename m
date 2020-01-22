Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BBEC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C827E24673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vdbmKD+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgAVV3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 16:29:20 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44233 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgAVV3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:29:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id q8so680553ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 13:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IWzoSHaF7JN7KzmRnEKXue37+ElHpTL6tvjAuEiiiE=;
        b=vdbmKD+yNje7jhxOhco/lhYmf+3Q1q+XjGe74FJCrmQXQ5t6WJS+kdh6i9Krkm3ZTB
         zeqWO82x5b2dbahES4hr2RG0xoDgGanxYKm5yUIzlxfqnQXUOlyeGElCDg9Y2F956m+q
         7kLbk3H8VsgEX4YrYWvAKFyp0xFcpC5Fr974FOn9rnivaLGIufkBpu/uJeqfZEuV1WFE
         eABuXY7Ss5Si7RevcqYhdcQvJRfuH38hsWHMgIpSxxvws5XSUZZim12h+5uAeW2p966k
         3WcllzOlzMcPtleAH4Pm/M/kBtjWAsBD+u3/IbIpQgJo0Ocqw42SsFkzXbUoEtD7rVvM
         CRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IWzoSHaF7JN7KzmRnEKXue37+ElHpTL6tvjAuEiiiE=;
        b=KpR0Aein2TzjHNtO96xWjh2toWkFLOu2JpuA188vsj+szTDIO3tbySTv1goWnppCPC
         L5kTHe0f06jgvSbr/0EZqkBlk3axov8ITbrYyD0F7YhnEQbPHGB43EP03nSdQv8X0kur
         3hlJgwGFqDngJIDxtxr/lW1MbU59rci2Af9a7M4iDgRdOghQTiiGc5QJ//0XZoQbb83N
         3G8LI4tGTLoWZAUSZYiWiwwYN+ap8Ir4BjVivJM9DMrhTWtcn+1u7jmY41qKOaugCoEx
         5DUl5bQScS+JjiuakcYsM/0ubzl0/mc7YC/reUSPIBX/Sn0d1KIr5lpV/GY7fOpssgxe
         PP1A==
X-Gm-Message-State: APjAAAV7vGN8MJKbx7urAL10OJ4vTCtsVcLsb4zaIfcnyh74KElHq2GT
        uK2sBW/k9Mrwj8e9XjufxR1SrpUWAmytVmBVNdqA
X-Google-Smtp-Source: APXvYqyJPHhr26PhrZ+pA9b8pTPEHYf1WFuy5Ob3gcESY7hxuJ6vYnDhzK5W1Ro4odt+SPVTOx5x/cd75TN9sGtuTYo=
X-Received: by 2002:a2e:5357:: with SMTP id t23mr21086243ljd.227.1579728556739;
 Wed, 22 Jan 2020 13:29:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <cfbb80a08fc770dd0dcf6dac6ff307a80d877c3f.1577736799.git.rgb@redhat.com>
In-Reply-To: <cfbb80a08fc770dd0dcf6dac6ff307a80d877c3f.1577736799.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Jan 2020 16:29:05 -0500
Message-ID: <CAHC9VhT1+mx_tVzyXD=UBqagqYgAFjZ=X1A6oBiMvjVCn8=V-w@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 12/16] audit: contid check descendancy and nesting
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 2:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Require the target task to be a descendant of the container
> orchestrator/engine.
>
> You would only change the audit container ID from one set or inherited
> value to another if you were nesting containers.
>
> If changing the contid, the container orchestrator/engine must be a
> descendant and not same orchestrator as the one that set it so it is not
> possible to change the contid of another orchestrator's container.
>
> Since the task_is_descendant() function is used in YAMA and in audit,
> remove the duplication and pull the function into kernel/core/sched.c
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/sched.h    |  3 +++
>  kernel/audit.c           | 44 ++++++++++++++++++++++++++++++++++++--------
>  kernel/sched/core.c      | 33 +++++++++++++++++++++++++++++++++
>  security/yama/yama_lsm.c | 33 ---------------------------------
>  4 files changed, 72 insertions(+), 41 deletions(-)

...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index f7a8d3288ca0..ef8e07524c46 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2603,22 +2610,43 @@ int audit_set_contid(struct task_struct *task, u64 contid)
>         oldcontid = audit_get_contid(task);
>         read_lock(&tasklist_lock);
>         /* Don't allow the contid to be unset */
> -       if (!audit_contid_valid(contid))
> +       if (!audit_contid_valid(contid)) {
>                 rc = -EINVAL;
> +               goto unlock;
> +       }
>         /* Don't allow the contid to be set to the same value again */
> -       else if (contid == oldcontid) {
> +       if (contid == oldcontid) {
>                 rc = -EADDRINUSE;
> +               goto unlock;
> +       }
>         /* if we don't have caps, reject */
> -       else if (!capable(CAP_AUDIT_CONTROL))
> +       if (!capable(CAP_AUDIT_CONTROL)) {
>                 rc = -EPERM;
> -       /* if task has children or is not single-threaded, deny */
> -       else if (!list_empty(&task->children))
> +               goto unlock;
> +       }
> +       /* if task has children, deny */
> +       if (!list_empty(&task->children)) {
>                 rc = -EBUSY;
> -       else if (!(thread_group_leader(task) && thread_group_empty(task)))
> +               goto unlock;
> +       }
> +       /* if task is not single-threaded, deny */
> +       if (!(thread_group_leader(task) && thread_group_empty(task))) {
>                 rc = -EALREADY;
> -       /* if contid is already set, deny */
> -       else if (audit_contid_set(task))
> +               goto unlock;
> +       }

It seems like the if/else-if conversion above should be part of an
earlier patchset.

> +       /* if task is not descendant, block */
> +       if (task == current) {
> +               rc = -EBADSLT;
> +               goto unlock;
> +       }
> +       if (!task_is_descendant(current, task)) {
> +               rc = -EXDEV;
> +               goto unlock;
> +       }

I understand you are trying to provide a unique error code for each
failure case, but this is getting silly.  Let's group the descendent
checks under the same error code.

> +       /* only allow contid setting again if nesting */
> +       if (audit_contid_set(task) && audit_contid_isowner(task))
>                 rc = -ECHILD;

Should that be "!audit_contid_isowner()"?

--
paul moore
www.paul-moore.com
