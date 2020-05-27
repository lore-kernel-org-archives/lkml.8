Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCF7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927452073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DEzyQE9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgE0WgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgE0WgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:36:12 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7753C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:36:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d3so10727535pln.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=27xzDD7MQheStU2mF5b3O3BiG54P1Ixq8NQFeL10ATM=;
        b=DEzyQE9c7rQdCLZKQCpkYYBnDAsdqwKqf1eBWy1DRFq/j1IBJfoMrmAZNfFp6DjpkA
         syMi6dijlPoXcvQ/Q/KRwjLfs6YfkrRjHcc0UBr8Km0NAqO+UJLWXVjV4xKNTtXKpsbg
         wqPi54CeJomWUGA2zuD5GY2OP5n7TJIDPTTso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=27xzDD7MQheStU2mF5b3O3BiG54P1Ixq8NQFeL10ATM=;
        b=EioiljdJF6MhjK/KGtjqmH7UBSTtmlkYQu7K6OS1lwlUW2rbPi0H1Uy4WeSFxPGSJd
         3db5Ogr8RKcw+MKTjrqX5ztZzmvIu21jEhL18G6QtpxWhPPHm9jmbwtzeAYp7SpRbUWz
         HjDvqnr5q8xtvNKT4Egw6k2i7vqZM1iojF0fpDCrMLQoXF8oSZcv1VRYtG/mPgQkxSQC
         zcQ28D4MbwSZSYqtiqZbHN76hHwdaj0izzRdfRGWyl9Sioj5WQ3WsXl9dhLIyYzL4lSC
         wazl4mOPx7C35EXodx+2vLvri/NGD0amKzPr7X0XGuVnQrvKBA3IEcBADNjenC+nGvuN
         RRdA==
X-Gm-Message-State: AOAM530NZxT/rkFG7BwUDWrVM/pecIfP29mf+Pg7u7g5FweiytDelPB3
        R1YvKj7z7Evx0eQm/NMUnVR5bw==
X-Google-Smtp-Source: ABdhPJw5MQFlvjCy4FGXk/PvQ6biVoTAs2Y6Iew881eQ3U24cbP8gGhO4PbI0Rf4QDRArReBxlDhaA==
X-Received: by 2002:a17:902:bb85:: with SMTP id m5mr555940pls.23.1590618971351;
        Wed, 27 May 2020 15:36:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d195sm2958959pfd.52.2020.05.27.15.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 15:36:10 -0700 (PDT)
Date:   Wed, 27 May 2020 15:36:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <202005271457.CF4BBB47@keescook>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <202005271408.58F806514@keescook>
 <20200527215203.GE4153131@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527215203.GE4153131@cisco>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 03:52:03PM -0600, Tycho Andersen wrote:
> On Wed, May 27, 2020 at 02:43:49PM -0700, Kees Cook wrote:
> > (While I'm here -- why can there be only one listener per task? The
> > notifications are filter-specific, not task-specific?)
> 
> Not sure what you mean here?

tatic struct file *init_listener(struct seccomp_filter *filter)
{
        struct file *ret = ERR_PTR(-EBUSY);
        struct seccomp_filter *cur;

        for (cur = current->seccomp.filter; cur; cur = cur->prev) {
                if (cur->notif)
                        goto out;
        }

...

        /* Installing a second listener in the chain should EBUSY */
        EXPECT_EQ(user_trap_syscall(__NR_getpid,
                                    SECCOMP_FILTER_FLAG_NEW_LISTENER),
                  -1);
        EXPECT_EQ(errno, EBUSY);


Why does this limit exist? Since the fd is tied to a specific filter,
I don't see conflicts about having multiple USER_NOTIF filters on one
task -- the monitor's response will either fake it or continue it, so
there is no "composition" needed? I must be missing something.

> Maybe it's best to decouple them entirely, and have usage go back to
> just being the number of tasks, and introduce a new counter for
> notification fds.

But isn't that already tracked by the VFS? i.e. there is a one-to-one
mapping from the "struct file *" returned by "anon_inode_getfile()" and
the "struct filter" (though we do not presently save it in the filter)
and the VFS tracks how many userspace fds are attached to that struct
file via ->f_count (i.e. f_count reaching zero is what triggers calling
seccomp_notify_release()).

In trying to write up an example patch for this, though, yeah, I don't
see how to do the locking. There is the "file" part, which is effectively
held by both any task's fd table and by the seccomp filter.

I suspect the issue is that the private_data can't be the
seccomp_filter. The "validity" of the mapping between kernel and user
needs to be tracked externally:

struct seccomp_notification_pipe
{
	struct filter *filter;
	struct file *file;
};

But I still can't see where to put the lock or refcount....

-- 
Kees Cook
