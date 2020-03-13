Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA66C5ACBF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F0C20637
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Und9Fuua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgCMURD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:17:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44857 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMURD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:17:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id l18so13649344wru.11;
        Fri, 13 Mar 2020 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=XOtjPzu8hP+iCuLMAjq0wZ2LsERKW6jgS14BUr9BC8A=;
        b=Und9FuuajHuhLitN++eMQwK9QvTmb8P68OQUjXzVFgaATpxXoVIguc3k8ZUUS7A+Rw
         vjuTm+yKdCQ8+JsYpyxy8sOxFG9O/ZQglUje3B0CLRtKdnYtqse0mkFWf8I4CiJGniqS
         fB8MisM+KjCABsVnA9sktAJXWI6duofnltkPjSACH3ckau9lbJlZjd44k00ZGwsRE+8V
         /YQVH+IDpfkPdWk4d1bQIqpmMV9gognIutW2ggAWd5HzY8kv2BqwVqOoefaRviMda3+C
         pa6Dag34BJHcSBw6a3I2Thtd0NY75X9CilqU0PlcdOvSuTgz9g6DfTAYJezgcUc8aNNO
         K4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=XOtjPzu8hP+iCuLMAjq0wZ2LsERKW6jgS14BUr9BC8A=;
        b=ZavcY/ynVGi5l5Vlp1bE+f+HyClg5uNP6RcX4xg8ZaaIhhGhzL7UpbGctRKrx6+1QK
         3m9ioJ3Ikj5GpI+/t85hqprGDXBxLxH3MwiUV/bADyGe2dLVgwUfRV4sHd70BKSoDMRP
         X/5x16Dl5P5AiyGsKOWUqVuNmR26OboRh1M/IMeV/c28Oms6o5h83/G4akfHI8EjZVIP
         qVbDslLRkvAy/j2fVocMy2RZdn8KcBi1ZuDXDzBSU1z60UYzlXSuOEdIinjPkV9CPez9
         a55s2RobF7S09PCxDxR8F2oXt9mVPN6rA1Z3LIXs+v51TABcUHzT3g9+R40ha6RP+SLG
         b7CQ==
X-Gm-Message-State: ANhLgQ3PmSftZoEkO0cM8AE57dZmdND1HIcTI4Kvj2AR1DbFMLxUXATp
        htKU6vtQoKcBpyeufctuPyk=
X-Google-Smtp-Source: ADFU+vtmqobzopOGR/xCwGyyqwYOTZ5kNJKM1jUat5dAtqgdVPODPmKRnf6k/UkpsN7dTOXOSBOS9g==
X-Received: by 2002:adf:b652:: with SMTP id i18mr3318672wre.310.1584130621241;
        Fri, 13 Mar 2020 13:17:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:6183:2c38:fb6d:576a])
        by smtp.gmail.com with ESMTPSA id d7sm7634380wrc.25.2020.03.13.13.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 13:17:00 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>, aarcange@redhat.com,
        yang.shi@linux.alibaba.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        brendan.d.gregg@gmail.com, brendanhiggins@google.com, cai@lca.pw,
        colin.king@canonical.com, corbet@lwn.net, dwmw@amazon.com,
        jolsa@redhat.com, kirill@shutemov.name, mark.rutland@arm.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, rdunlap@infradead.org,
        rientjes@google.com, rostedt@goodmis.org, shuah@kernel.org,
        sj38.park@gmail.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v6 02/14] mm/damon: Implement region based sampling
Date:   Fri, 13 Mar 2020 21:16:49 +0100
Message-Id: <20200313201649.26646-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313172954.00001f3c@Huawei.com> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 17:29:54 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 24 Feb 2020 13:30:35 +0100
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit implements DAMON's basic access check and region based
> > sampling mechanisms.  This change would seems make no sense, mainly
> > because it is only a part of the DAMON's logics.  Following two commits
> > will make more sense.
> > 
[...]
> 
> Came across a minor issue inline.  kthread_run calls kthread_create.
> That gives a potential sleep while atomic issue given the spin lock.
> 
> Can probably be fixed by preallocating the thread then starting it later.
> 
> Jonathan
[...]
> > +/*
> > + * Start or stop the kdamond
> > + *
> > + * Returns 0 if success, negative error code otherwise.
> > + */
> > +static int damon_turn_kdamond(struct damon_ctx *ctx, bool on)
> > +{
> > +	spin_lock(&ctx->kdamond_lock);
> > +	ctx->kdamond_stop = !on;
> > +	if (!ctx->kdamond && on) {
> > +		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond");
> 
> Can't do this under a spin lock.

Good catch!  And, agree to your suggestion.  I will fix this in that way!


Thanks,
SeongJae Park
