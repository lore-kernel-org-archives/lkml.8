Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06266C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD1C207BC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RJN0Fr/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgFODzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 23:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgFODzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 23:55:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D42C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 20:55:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so6972pgk.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 20:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b3r1b0ogG8RFYmtciXwkUKZ4Alfe4K9lVMAfswnI+sI=;
        b=RJN0Fr/nvvnc1RU8+2/LOsn7FwyS0zS4HfmgrxoTwqWN8HEGW3mlq/thkvx9ltRO4l
         bDj8uwg3w8tO7j81cWcRdTyyLtL9JdLm5JIIpV1SoqKweNUqkwS3sKIzhoQHCmG8kaYy
         cB6nSOOnDDwLWmwRRyQodsA7dSxhJP39i75Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b3r1b0ogG8RFYmtciXwkUKZ4Alfe4K9lVMAfswnI+sI=;
        b=Q82v1LsXpBY3EDB9vpKTe4+Zi7v71/KpPvasCh3zqQ5OoywqDXz1zhm0r7Bynv5gJ/
         6fckS92UaOchQNUGcNIMUCUu1qNemRhPqRhsMrWnbDsGZc1g9fzv8FBjYqtzxkZ8G+E4
         3zkiJt3j/rsvejYiHEQEieIR/9wMzT8ULRsN5S7klSSZHnAs1lrpABJUdpSKa7qy4N2G
         4hMmksgqxMMKYPEvfYddqEokPTuFoV0Dp85mmMmy4XTMBcqfrFevmRKrK2Yjii1xZjjR
         4jLiI5Kp8/SQC2SETCzjB+zNn8EY7KbHI/fsgeuz/fW6wYQOkjOpupyHKEbGFoyRSe2Z
         80Wg==
X-Gm-Message-State: AOAM532EmHM2tLMq9/mccOxxB/FPN3pIZ27Xv9dh2Tlm/cU10kyP85Df
        31xRujl27b/1FuvzMJUgmRNlKw==
X-Google-Smtp-Source: ABdhPJwLI4wae6IRMj+xuDnzaonSUOrt8BBSl10BIfHCMSHNM+4hY3EfPSgj3EXUhYZ+LP/nnVptQA==
X-Received: by 2002:a63:480d:: with SMTP id v13mr20580425pga.286.1592193351115;
        Sun, 14 Jun 2020 20:55:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fv7sm10891472pjb.41.2020.06.14.20.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 20:55:50 -0700 (PDT)
Date:   Sun, 14 Jun 2020 20:55:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, David Howells <dhowells@redhat.com>,
        shakeelb@google.com, James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
Message-ID: <202006142054.C00B3E9C9@keescook>
References: <20200612183450.4189588-1-keescook@chromium.org>
 <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:10:08AM +0800, Xiaoming Ni wrote:
> On 2020/6/13 2:34, Kees Cook wrote:
> > This series was never applied[1], and was recently pointed out as
> > missing[2]. If someone has a tree for this, please take it. Otherwise,
> > please Ack and I'll send it to Linus.
> > 
> > Thanks!
> > 
> > -Kees
> > 
> > [1] https://lore.kernel.org/lkml/20190306110549.7628-1-elena.reshetova@intel.com/
> > [2] https://lore.kernel.org/lkml/1591957695-118312-1-git-send-email-nixiaoming@huawei.com/
> > 
> > Elena Reshetova (3):
> >    nsproxy: convert nsproxy.count to refcount_t
> >    groups: convert group_info.usage to refcount_t
> >    creds: convert cred.usage to refcount_t
> > 
> >   include/linux/cred.h    | 15 +++++++-------
> >   include/linux/nsproxy.h |  7 +++----
> >   kernel/cred.c           | 44 ++++++++++++++++++++---------------------
> >   kernel/groups.c         |  2 +-
> >   kernel/nsproxy.c        |  6 +++---
> >   net/sunrpc/auth.c       |  2 +-
> >   6 files changed, 38 insertions(+), 38 deletions(-)
> > 
> 
> Should mm->mm_users also be replaced by refcount_t?

I'll say "yes". :)
https://lore.kernel.org/lkml/1487671124-11188-1-git-send-email-elena.reshetova@intel.com/

> In addition, is it better to change all variables that use
> atomic_dec_and_test to control the release process to refconut_t?

For the most part, yes. The following may find a lot of them:
scripts/coccinelle/api/atomic_as_refcounter.cocci

If you can go through that and double check for prior series from Elena,
we can get through all the rest of them.

Thanks for bringing this topic back up!

-- 
Kees Cook
