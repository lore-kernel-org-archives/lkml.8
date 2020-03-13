Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE62C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5894C2074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TflqlyHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCMXgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:36:11 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37594 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCMXgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:36:11 -0400
Received: by mail-pj1-f66.google.com with SMTP id ca13so5198084pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 16:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8yb3Smk+WA2kNJUHhi0CWWEYTegjFeAzvGSfP7GO6hE=;
        b=TflqlyHTwj9HWSK9TQZowQOwFWsskqIaBoymjzHlLwmtLBJMVYPsTb+R3GWOs1v7Ti
         xlvTgLPvWJed7HLrQH8YrIMgOeF6jKFF9CIgnSc1hJ4qmjM7hSyNWEs8ClRU/KW6Y1vm
         e1Q0pVlXHRzHL8W8jn4mh54p4elTmSHBw8/VvAy7UGeulkhCyW/CaFWV2qcpiXjHwHUO
         UfKHHNJ6SknFlGqR7h2epcW8wVWlUC21bgck0h9n1j7wBEqPC0heISglpGIB6/heU2lY
         JJkeNi9Xcvu5HkXCOP4hNipZMybBhCnY/Ei6jGUFNbrgm4a3uyXJ/jZk0ftJRfrsv1tt
         kjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yb3Smk+WA2kNJUHhi0CWWEYTegjFeAzvGSfP7GO6hE=;
        b=Uo/2l4V9rXx5PaOy+7NdhOeH9Ka5ocqwvhtRvRy2Aomh+u+QxfIefnML7lWk1/Z+Gk
         JE8w0Q6rk9MRHAS/PMuM85+v05vCpcKyGv6IWhHvc5x5qbx614B5GC9PJJlUs37QLpOs
         Xj6h/jkjB302tdtBStpel922TO7emnxNXmTQ/wFSNiLIOost4Hrm56uTdOuwt+mLytLB
         lNhRbsPBfI7KP57XP3Gklm114FqN4lhEJlABGZ9vb861aftiZNV34Lte6mCwSGr2++ii
         gV5uawfVc5GGQtWFxvNDgteYqH7Gd3ZYtAnARdXR+wsD5faALzm/lmlhPcsQ/63Nbo8z
         kVdA==
X-Gm-Message-State: ANhLgQ1pfZu3M8hKVRdSCre0y69fMgUNW2qZETnFH3Bc/zWJ4vPBBfrl
        mqlmcwf1HHKhIUU641RRk7xt+NxdZouzg1sdseFWk0mlzmg=
X-Google-Smtp-Source: ADFU+vslN70O13CIstyDYtjFT6z/TCx8Q8y8naQJ4HvhFoYnijLayIc1CiIYxlFlDENFpInoZkezf8Yo91jWhTHpC3w=
X-Received: by 2002:a17:90b:d8d:: with SMTP id bg13mr11892026pjb.29.1584142567940;
 Fri, 13 Mar 2020 16:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200228191821.42412-1-davidgow@google.com>
In-Reply-To: <20200228191821.42412-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 13 Mar 2020 16:35:56 -0700
Message-ID: <CAFd5g446OxmrseU=U-n7D1bL3OdgFF=sYZmUg2utx_Sa9LEF1w@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: kunit: Make the KUnit documentation
 less UML-specific
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Frank Rowand <frank.rowand@sony.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 11:18 AM David Gow <davidgow@google.com> wrote:
>
> Remove some of the outmoded "Why KUnit" rationale, and move some
> UML-specific information to the kunit_tool page. Also update the Getting
> Started guide to mention running tests without the kunit_tool wrapper.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Frank Rowand <frank.rowand@sony.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
