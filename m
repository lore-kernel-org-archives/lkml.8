Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAE5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AB72073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hc1YtbB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgFKWax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgFKWaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:30:52 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8746BC03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:30:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id s28so3002783edw.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rg7eO693EDtdOfjCTCuFIoB+iVYboUKp8O8k4ul7UBk=;
        b=hc1YtbB1KCw8ErzxRUKtDHJZkwhczsMAsWwoN5vJwBBYc7bHeCQ83qNspaTSZF+T6K
         RBPy0jm3a+mM5el7SdieBOcWdOie78kUClRY/FQzU8wT8uC5za/SJw1ZBLEkgJN6lEiI
         q4GXLpIWJH6aUxPFm5fRY5r8c49KeclPBy2ZsR5waFVXeYVrfwAS+Y8A6xoq5DF2/yFW
         F1f0Xo/myHiB5IyFjPhWumgq0yAOWmwUeLxJbdYtWQEqdEnuCZt2QYsTkig7HVEDfU8L
         jFkHwMGrVWwN768UNV8b/Uqi9Ki51wjScgV07Q+BUl5w0yh0EAtdMs5FMSvCZXKnfrgT
         0oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rg7eO693EDtdOfjCTCuFIoB+iVYboUKp8O8k4ul7UBk=;
        b=kh+6R548yJO3+96ddaS+byOVkuiywSVNiP/FTJWjx3lUWJ8treF+4Fq89D8QM1ZOX+
         x5XXGMLgmlcCQfA/9WWERqWWy8TYbqwo6jEIVyhzTu5/EVTwoAQqBAJhETpJFDwQzK4J
         aw0mD3M5TftVE92NMNh5WS3XfVT9H62L79TUCt6gSV93z9YPsJmnpsqHhOxKR64vMVq3
         JPZ+UDy2ioqgit9oR88BRTazHqzOLvcwlo+5RM0D2osshZJ0Q3kN4mhyxxFU/rMXwK4A
         iGr2AM/cq5GJ8AZDKJcYmfc2NCjBTo+xBjTyvIsukcP8chl7oR6W8yOYEXquTPClDMy4
         C+3Q==
X-Gm-Message-State: AOAM530urjEhT3+6fEXw6CAm+Uur7gJAfI6ZMctYm6i1lNKRd5onsvw2
        eUA3d7NTLf8tWQvNxd+Km0Dl8cRAYmkR+MAdacNx
X-Google-Smtp-Source: ABdhPJyCkmuynUHpAQSMVkFfOa8Evij6OjD2dTCpDkfJJM/r6QoJZbdIB5kQQC6n8Dm1C5MuZCtDi7b8m4WZynUGCZY=
X-Received: by 2002:aa7:de08:: with SMTP id h8mr8704796edv.164.1591914650074;
 Thu, 11 Jun 2020 15:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200611204746.6370-1-trix@redhat.com> <20200611204746.6370-2-trix@redhat.com>
In-Reply-To: <20200611204746.6370-2-trix@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 11 Jun 2020 18:30:38 -0400
Message-ID: <CAHC9VhSyo9GZKVZ04w3d3bLV9-_61W0KznATZPmqZBYXT2J=xw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix another double free
To:     trix@redhat.com
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, weiyongjun1@huawei.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 4:48 PM <trix@redhat.com> wrote:
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this double free error
>
> security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
>         kfree(node->expr.nodes);
>         ^~~~~~~~~~~~~~~~~~~~~~~
>
> When cond_read_node fails, it calls cond_node_destroy which frees the
> node but does not poison the entry in the node list.  So when it
> returns to its caller cond_read_list, cond_read_list deletes the
> partial list.  The latest entry in the list will be deleted twice.
>
> So instead of freeing the node in cond_read_node, let list freeing in
> code_read_list handle the freeing the problem node along with all of the
> earlier nodes.
>
> Because cond_read_node no longer does any error handling, the goto's
> the error case are redundant.  Instead just return the error code.
>
> Fixes a problem was introduced by commit
>
>   selinux: convert cond_list to array
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  security/selinux/ss/conditional.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Hi Tom,

Thanks for the patch!  A few more notes, in no particular order:

* There is no need to send a cover letter for just a single patch.
Typically cover letters are reserved for large patchsets that require
some additional explanation and/or instructions beyond the individual
commit descriptions.

* Thank you for including a changelog with your patch updates, but it
would be helpful if you included them in the patch by using a "---"
delimiter in the commit description after your signoff but before the
diffstat.  Here is a recent example:
-> https://lore.kernel.org/selinux/20200611135303.19538-3-cgzones@googlemail.com

* When referencing a patch which you are "fixing", the proper syntax
is 'Fixes: <12char_commitID> ("<subject_line")'.  Look at commit
46619b44e431 in Linus' tree to see an example.

If you have any questions, let us know.

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index da94a1b4bfda..d0d6668709f0 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -392,26 +392,21 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
>
>                 rc = next_entry(buf, fp, sizeof(u32) * 2);
>                 if (rc)
> -                       goto err;
> +                       return rc;
>
>                 expr->expr_type = le32_to_cpu(buf[0]);
>                 expr->bool = le32_to_cpu(buf[1]);
>
>                 if (!expr_node_isvalid(p, expr)) {
>                         rc = -EINVAL;
> -                       goto err;
> +                       return rc;
>                 }
>         }
>
>         rc = cond_read_av_list(p, fp, &node->true_list, NULL);
>         if (rc)
> -               goto err;
> +               return rc;
>         rc = cond_read_av_list(p, fp, &node->false_list, &node->true_list);
> -       if (rc)
> -               goto err;
> -       return 0;
> -err:
> -       cond_node_destroy(node);
>         return rc;
>  }
>
> --
> 2.18.1

--
paul moore
www.paul-moore.com
