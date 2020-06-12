Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA2D207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mu3f/M9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgFLHvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:51:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50145 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726292AbgFLHvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591948273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=grI6nWGxdFYR+2gV7YLo+XnBrhioxqL+q5cJAP/VrB0=;
        b=Mu3f/M9wI9c14HqlbEernXoFW7BF4k3rF+z8T3FVIV4hUQEeXtboe+flopNUoY8oMg9uUr
        0j0i1ciEoAWs6fIxLtkZVQkeEnQ+PvU05ZwkoWIsVb3G2+yvx+el+85oPxAcXQmKoFnhch
        AkmR8bx1mCK8JCpeZ2FRSVMn25Qj+CA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-LWlbpJu_MDO1yjPO16AIKA-1; Fri, 12 Jun 2020 03:51:12 -0400
X-MC-Unique: LWlbpJu_MDO1yjPO16AIKA-1
Received: by mail-lf1-f71.google.com with SMTP id r10so587592lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grI6nWGxdFYR+2gV7YLo+XnBrhioxqL+q5cJAP/VrB0=;
        b=MxKFsHMu30vgVCLvqtT6qpF+myBE7zutPqf4l23MAOhPwwlug8zTgFnyifLBa1RALI
         h+I0f1dgI9fQf8MEDbRPFRwROuyh3ldjJTn5bWhK9WHlGGEqEP3m/XMFECABixjGdjV5
         A7i7e00RYHNjlEaNIMhQib8maARvotldbYCcop8I/di8/mW04+WyFdUGxeti/AU1txue
         zmuQRKsJTsGgAnomKb3EO0+eyLlQhRPrhCIyPoyUCdhjuwogjRhBSNG/v5AihYg3dcT/
         q6bpZJtRSPMJ08pSReYeR/q1kNQlARN75rvI0c79AFR3vN/AxLBK1BqtdWnm9GGdRVgb
         EsYw==
X-Gm-Message-State: AOAM533Y0VND9OXk/uRxFBEukvrNxc2wW1JP+av6bHqsQ022AyHfN3aQ
        j7Jm2MWvXCEjK0KAITXo3dqervqXVkKnBBLOi/ClS6VfDNILlRcCu5UtH9c7Hiv4cdZ3aK39wYs
        VJd25j/cj2Br+qZKMmZ2WOmwHIYLLq7pVmsAnRHLK
X-Received: by 2002:a2e:8043:: with SMTP id p3mr5738708ljg.217.1591948270565;
        Fri, 12 Jun 2020 00:51:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/JTMFBvXt7O/Z7+cVdAL/GN/g5rs1TwU0pWF+CTjhP0DJ/WkTYI5gqq+1wX2k1E3Ja6CWJfdhKIJ8JTvzSiA=
X-Received: by 2002:a2e:8043:: with SMTP id p3mr5738696ljg.217.1591948270330;
 Fri, 12 Jun 2020 00:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200611204746.6370-1-trix@redhat.com> <20200611204746.6370-2-trix@redhat.com>
In-Reply-To: <20200611204746.6370-2-trix@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 12 Jun 2020 09:51:00 +0200
Message-ID: <CAFqZXNtPjzh2OPaLkMfV_b=-=uU7Z0887-sWUjSG2YJ8e1ucfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix another double free
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

On Thu, Jun 11, 2020 at 10:48 PM <trix@redhat.com> wrote:
[...]
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

Sorry for more nitpicking... This can be further simplified to just
"return -EINVAL;" and the braces can be removed.

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

Also here you can skip the rc assignment:

return cond_read_av_list(p, fp, &node->false_list, &node->true_list);

>  }
>
> --
> 2.18.1

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

