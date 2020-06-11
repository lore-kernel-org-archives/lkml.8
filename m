Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC86C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE4120792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAYIVxUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgFKRNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:13:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31093 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726706AbgFKRND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591895582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2lc4GWkEgMW9G8vaWxd2JwQUtHL+Yw8/GWAwvra2v9I=;
        b=cAYIVxUcG/UtDI/oR8PXHEINIm7+IClhjBsNX8baR/B/FgXY84JMuRNhbdJhZDFx2/B1yR
        GWqyh10gSX/lPlNCE8MHtwN2/Wg0E5PrpHcH+Y54TRLKT+HDvcLIMPv11ZTRQo/fz2IYwt
        25EEneWtJN/sqlCqXeQ2nHqnn96fJWo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-elP6mpaWNPqVjBSEdWCzmA-1; Thu, 11 Jun 2020 13:13:01 -0400
X-MC-Unique: elP6mpaWNPqVjBSEdWCzmA-1
Received: by mail-lf1-f69.google.com with SMTP id a10so1746176lfo.23
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lc4GWkEgMW9G8vaWxd2JwQUtHL+Yw8/GWAwvra2v9I=;
        b=T/wTCCNDBTDEXfevADrObQ/+Kp6UNaW6cRkouayNvVM2UQY3/KsOgs6QoBiJXTCNKz
         ob0NJIK+wnsgmlVhO3kNX+TuKA5efj9dUc3xwQoSXGORP8wsc0wFeq7aUrcTkJYEIfWi
         EPuo/zFEqgTx66USguF0zya9y+1u+kGzpZFQXaYgw9VYbXsgg3z6Rt9wKrH31dNGZAp4
         qIfixmESXU/E3paFqnl4HVBLoizd+8TAd6HjBEvYIJBkZX6Sz+YOeEhp/ZchgDmV4Sjh
         oDc6Vgaxq4zvtYe3Hpy8iU4BPmXIMln5B2/ofpJYiD05ToPHuhjfFo2ETCh+13iCap1y
         l0+A==
X-Gm-Message-State: AOAM533+NrD3cCrBV8WVWxqH9RM4f9H2inHnZBvfjYUS+g7ev87dKec0
        VsqOUNdcPGLa6ezQp30cLHqeCs23awXsW5BsIDyNcNeJw/+6yv1H+z9mgbiBtBxWSIwqN/cigV/
        4GFDFOJ6F0Yp3g75SiNAixEgnWXTjMiWINhs4Svcn
X-Received: by 2002:a2e:960b:: with SMTP id v11mr4937663ljh.77.1591895579089;
        Thu, 11 Jun 2020 10:12:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywE09hDV2mOUCgj2h/z3bNYfRdprO2vQxtXhOlYbylBXyf3+ZwcppUGRcbmVCXizn5mdZaOTYbSLou8xQgFrI=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr4937654ljh.77.1591895578882;
 Thu, 11 Jun 2020 10:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200611155830.8941-1-trix@redhat.com>
In-Reply-To: <20200611155830.8941-1-trix@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 11 Jun 2020 19:12:47 +0200
Message-ID: <CAFqZXNvHpWygX16EgFa5fc2oFkRfn-RaPpqbw-JvitpDNaAWUA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix another double free
To:     Tom Rix <trix@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Thu, Jun 11, 2020 at 5:58 PM <trix@redhat.com> wrote:
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
> code_read_list handle the freeing the problem node along with all of the the

There is an extra "the" before "freeing".

> earlier nodes.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  security/selinux/ss/conditional.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index da94a1b4bfda..ffb31af22f4f 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -411,7 +411,6 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
>                 goto err;
>         return 0;
>  err:
> -       cond_node_destroy(node);
>         return rc;

Since there is now just "return rc" in the error path, can you please
replace all the gotos with plain return statements? And please also
add a Fixes: tag pointing to the commit that introduced the bug (see
Stephen's reply).

Thanks,

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

