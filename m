Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE24AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EA9207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N97BcoyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgGUSo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGUSoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 14:44:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E23C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 11:44:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g67so12346867pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ktrA6qles9txxK/VYI2vM11yWK+fPxocyvkCQAJyaOY=;
        b=N97BcoyD7bGx2yP6cuoMvwcpm0oMr+8bz013kXkloSXrP8e5sitfBTilO9XbJomnz9
         UEq8Oq9T6zUILR7FhI5SM7h4JndK/D85Nn7olc7uH1pAxgdJaIDu/6mNdbLeAX2tal2r
         E3dfGWP2DQn1Uz6B9urWB4nMoJcawyxJnAe1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ktrA6qles9txxK/VYI2vM11yWK+fPxocyvkCQAJyaOY=;
        b=NLuldRLGk1GCTHwatUwuMlTU5hvaWDZZ7HB+8JFCcDU4+QObpWQkPdraboxMbLvF99
         5vksVrnyKB7yuVnfzIo0zUOcVJ3fod2jP+bxvp5eXTiaxdx0nEjWETsGXK4Niu8o1oRf
         u86dr9rUiakhhzcJqPIB5d8GlVYJM09ZFN4SzPZwL7iZsz9R0KauzwoznlhJnkS+faL/
         WeC2bS2uf1MzwaBPz/qnfupCAr1gpyqvuBteCq91q/IqVR24SCN0a8F4kID7xe5fHq8E
         pO+jCrlHQAiCcUmsHbSYS1rgO4jVnV3xMVKXvdCTJ9J1EW5nf6ZbjXuCFz2Was8JQim+
         lMPA==
X-Gm-Message-State: AOAM531DQ3yI46OvJIKm73JKrpzof+EMBHFcl3funSFI1+WJK1paQe9l
        33M3n7jzChHMoBB5iOlhzFApwg==
X-Google-Smtp-Source: ABdhPJzJl2KXppIFt49AStz4R4Fcg+Y83tWuJ+st0V8aBSZdfzPijZrTyy6djWa8nWzYJRiXTVV2ng==
X-Received: by 2002:a62:1407:: with SMTP id 7mr23742991pfu.88.1595357095105;
        Tue, 21 Jul 2020 11:44:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7sm18429700pgh.58.2020.07.21.11.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:44:54 -0700 (PDT)
Date:   Tue, 21 Jul 2020 11:44:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
Message-ID: <202007211144.A68C31D@keescook>
References: <202006142054.C00B3E9C9@keescook>
 <20200612183450.4189588-1-keescook@chromium.org>
 <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
 <544539.1595328664@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544539.1595328664@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 11:51:04AM +0100, David Howells wrote:
> Kees Cook <keescook@chromium.org> wrote:
> 
> > > Should mm->mm_users also be replaced by refcount_t?
> > 
> > I'll say "yes". :)
> > https://lore.kernel.org/lkml/1487671124-11188-1-git-send-email-elena.reshetova@intel.com/
> > 
> > > In addition, is it better to change all variables that use
> > > atomic_dec_and_test to control the release process to refconut_t?
> > 
> > For the most part, yes. The following may find a lot of them:
> > scripts/coccinelle/api/atomic_as_refcounter.cocci
> 
> I've been gradually undoing some of the conversions as there's no equivalent
> of atomic_add_return() and atomic_dec_return() that allow me to log the
> altered refcount through a tracepoint.

Please do not _undo_ the changes; just add the API you need.

-- 
Kees Cook
