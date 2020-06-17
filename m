Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC17C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968A7212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PGJ54IIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgFQUpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:45:19 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD37C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:45:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l12so4032350ejn.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oj0P5buG5a1bC8JEmblF7aFxCNxNLKAs2Jf9eLodu5c=;
        b=PGJ54IIMItYvU8BgzV4do1AgGvK3kMUwpbfp+HE/gBOUTTGdTI3sG4A7GSR/3muroP
         OHtnWvg/vtswpOB8tiD10WVHmMzr5+gY+QARHljXpqpbltEZVqRuCieZSlhZvatxf0A6
         2tyh/4GYXrVwW7iKj+n0eiKo2nBI+CF0igqfCqL/UfmAR5O/9/JaeLi4uverQ5M3DijR
         TGaueSiQ2oNc4wNJOI6Seh5+5JrFL3lEyNrZoEK0fP/I39Wbo6g33SVPLiZC+g5tYTJH
         dqCjljUG0EFbeBpOlVH7o9dk6vcjP33Rr+8UhY1RNjSpSvxf+1Y8q4TDp0BcnWkIKZ+s
         EK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oj0P5buG5a1bC8JEmblF7aFxCNxNLKAs2Jf9eLodu5c=;
        b=jhArRQkIdmLlUP8Z2ekaGxj3HbsrV5292YuxH12MM1RWsBnqI/cvMT452Xkepndz9w
         t/Ve8PhigpyAqY/yZhNT/p1VzuW/bZII2kHJI1648XEXT1/vHFzJVOO3ZRa255aO6jJ6
         O4/njlopFGvev81gN/8nGcDfpyszNjV53t85ECiiZKyMjC9KRk4Pi+6x7NvBDJiG+XFP
         YvL9k7Uzm7VUfXfXBJqPBEdRuPdTCMu7rNcMg+prnGRKVjO9Fs4vj1oWb/J27OwIgZsV
         48jUzYFp/Hy49vI0jrM7A2ktvLK8gdqTbT3BenO2kbdSqpjrc1g0IbURxqhws/Wll9r7
         L2QA==
X-Gm-Message-State: AOAM530EMRPc3TN+KQcWjz8JZ5r3n/E19E4Tv46w451PzYLexmft4Dq7
        Xq7wzYJTRFoPig6xe4FK0iw301Mt6+GxZl0ZqLKoC9g=
X-Google-Smtp-Source: ABdhPJzw32d9FudDP8frZbB2vJBeBaF2R0077RjX1lAaOHcpgPSX6JRBm4RBGrfBH6KBQ91p8p6btsutMwMNtJFCSSc=
X-Received: by 2002:a17:906:ecef:: with SMTP id qt15mr908152ejb.91.1592426717104;
 Wed, 17 Jun 2020 13:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200524205238.GA17576@embeddedor> <CAHC9VhRcpqs6TGoqK_soTz8Jo5BCDfhq1kqKGGJeJpbXhWZRsg@mail.gmail.com>
In-Reply-To: <CAHC9VhRcpqs6TGoqK_soTz8Jo5BCDfhq1kqKGGJeJpbXhWZRsg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Jun 2020 16:45:05 -0400
Message-ID: <CAHC9VhSP6-eMHzZ3=-EX12fACMCSCddP9hN+58DuKNiOXMP-aw@mail.gmail.com>
Subject: Re: [PATCH] audit: Use struct_size() helper in alloc_chunk
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 11:36 AM Paul Moore <paul@paul-moore.com> wrote:
> On Sun, May 24, 2020 at 4:47 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> > One of the more common cases of allocation size calculations is finding
> > the size of a structure that has a zero-sized array at the end, along
> > with memory for some number of elements for that array. For example:
> >
> > struct audit_chunk {
> >         ...
> >         struct node {
> >                 struct list_head list;
> >                 struct audit_tree *owner;
> >                 unsigned index;         /* index; upper bit indicates 'will prune' */
> >         } owners[];
> > };
> >
> > Make use of the struct_size() helper instead of an open-coded version
> > in order to avoid any potential type mistakes.
> >
> > So, replace the following form:
> >
> > offsetof(struct audit_chunk, owners) + count * sizeof(struct node);
> >
> > with:
> >
> > struct_size(chunk, owners, count)
> >
> > This code was detected with the help of Coccinelle.
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  kernel/audit_tree.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
>
> Thanks, this looks reasonable to me, but it came in too late for the
> v5.8 merge window (I dislike taking changes past -rc5/6 unless
> critical).  Once the merge window closes I'll merge this into
> audit/next.

FYI, I just merged this into audit/next.  Thanks!

-- 
paul moore
www.paul-moore.com
