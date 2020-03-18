Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FF5C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609AD20724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfpA1v9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCRCrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 22:47:39 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:34071 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgCRCrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 22:47:39 -0400
Received: by mail-lf1-f48.google.com with SMTP id f3so8789263lfc.1;
        Tue, 17 Mar 2020 19:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+4NUWZR9n4+H9VOG36R2FnEsYCl9QO/Z2irsj8TMuY=;
        b=TfpA1v9+IFo+nvdmYx5W4F+Rkhaeh0hE3hLOSa0d6lDHyJM8zbqY+1sVqaPWLiYLR9
         6wkqCYr5/tlEDljN4TK+iU39tKubnIPYaCJ7iLChzUpyt8Gv6kbgwcAS6bl5hy12eqcB
         npRrKFFq+okbm2w6TAF1B2HbRtg75fwA/zcKS38lyA34+QNLiP+FaYuTilqtoqOdCFa6
         8oge0vSPjkUXp1qBu6rEFxIA2CxG3YlWwTHFNkG2LbF/hAZrnLPlAJI+BBTIxMrA6x3e
         BAXV5m5QTpZ1QDxJwEdiNA2anFqmLqiw9GQXriFNeWoZUc8M26bWDOQjxkB+8UMv9Hl7
         r4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+4NUWZR9n4+H9VOG36R2FnEsYCl9QO/Z2irsj8TMuY=;
        b=scez8qwl/DbfHWl679e/A5IDz+7GgDnBEYZokO5n4xRwViTyt0+59ML6P4z+3Rgikk
         lEwAJ2FawZHHwcfvUxmTOtwuZbKWFciL4RRl4v8KyGJgPctDLBXUbva1EnGjSUH0opr0
         ImgLZs8zcNQIn1ZWnVQtYr4mfQ59kLWHw+kKIlfQbBHn6tD02838Umd5fQ54lZR9coam
         t6cf96OBMM8YodV2Y/Q9sxzTLad+HtBNR/Y45O9kDl9iPsGAhzhVJ7/8wHYbHPvPu7VC
         lSvbL1NiNWIvQehI69jTU4oFVQH4SB2p1muZ+Exa4mhckPKdnv6Kd8lnUk6o06FKDUEe
         Fl2g==
X-Gm-Message-State: ANhLgQ18xvuJzvbKSNKaoYN491V7MOGHZA9LS0j1/+BuGUd2RZKtXH3X
        Vu0Bftwem6/bGsveEs8QjPma29MGyyduEKtm5Cg=
X-Google-Smtp-Source: ADFU+vuC+GAiuLlKc2ZHzuRFwQtGPBS2O7mnSZSR1EJfI7E9MFQ2dHOCbkH1RAEpF0FnhRkIpBPRNZvipOHaREzoFqU=
X-Received: by 2002:a19:550c:: with SMTP id n12mr1451958lfe.11.1584499656637;
 Tue, 17 Mar 2020 19:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <1583589765-19344-1-git-send-email-hexiaolong2008@gmail.com> <8613a6fb-1f3f-81e9-54c9-7356ce99cf87@kernel.org>
In-Reply-To: <8613a6fb-1f3f-81e9-54c9-7356ce99cf87@kernel.org>
From:   xiaolong he <hexiaolong2008@gmail.com>
Date:   Wed, 18 Mar 2020 10:47:15 +0800
Message-ID: <CAN9aa7rj_UwPdeZGrdZzWDE=mR5z77dKHMfOC=c4LNJXXuiByw@mail.gmail.com>
Subject: Re: [v2] dma-buf: heaps: bugfix for selftest failure
To:     shuah <shuah@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, Leon He <leon.he@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Shuah:

> > @@ -357,7 +357,7 @@ static int test_alloc_errors(char *heap_name)
> >       if (heap_fd >= 0)
> >               close(heap_fd);
> >
> > -     return ret;
> > +     return !ret;
>
> This change doesn't make sense. Initializing ret to 0 is a better
> way to go.
>

I don't agree with you about this comment. Initializing ret to 0 can
not solve this problem.
Because the ret value will be override by the following
dmabuf_heap_alloc() calls.

static int test_alloc_errors(char *heap_name)
{
        int ret;

        ret = dmabuf_heap_alloc(...);
        ...
        ret = dmabuf_heap_alloc(...);
        ...
        ret = dmabuf_heap_alloc_fdflags(...);
        ...

        return ret;
}

The purpose for test_alloc_errors() is to pass some invalid parameters
to dmabuf_heap_alloc()
and wish it return some errors. So -1 is what we expect from
test_alloc_errors(). But the code
in main() will break the loop when the ret value is -1. So I reversed
the return value in test_alloc_errors().

int main(void)
{
        while(...) {
                ...
                ret = test_alloc_errors(dir->d_name);
                if (ret)
                        break;
        }
}

thanks,
-- Leon
