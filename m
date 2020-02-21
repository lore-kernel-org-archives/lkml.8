Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF02DC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33DF206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEmaDPGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgBUP4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:56:10 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38361 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgBUP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:56:10 -0500
Received: by mail-oi1-f194.google.com with SMTP id r137so2022209oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKBghbRAKP9QhobnCOoAGO7u3NjOVcuitpAQvo+uhIs=;
        b=AEmaDPGs2OGz7X5CmVOGuMK/00V1LDIKZ5E7Jint2UWSzny4NtyvrYAvc5CsL7jgJL
         f9Cc/q+fo0+Lbz77gebQUW2htgU8OrFm9JcH5yzuhvbrqff5sPoT1SiModPTXzbMLgLQ
         KhVrnH0VRmJFbs+BxccjkCC1D3MU+apbgcAlh45e9FCqKOIJs+zNV/gjAV4z2MViAUaC
         wtTne6QZdfSJACLyAotREx+e8yENsBw6cCI1QSB0o/BUxskuL0RmE9+7cPS0bWpCCFIo
         HrW+FGyxbyM4rPZuWWwxxyhcs+xcQCTeWTYeZMJ5Wimm6XJX25lYgF6h5t9c4PxD4dtI
         ylCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKBghbRAKP9QhobnCOoAGO7u3NjOVcuitpAQvo+uhIs=;
        b=aZ3hkAujh5wSdj+SQofkYf84v1l+TOPA14ZgbiRMzOXs1SoIB5MygvqVN41aw80hbN
         y1MCCtM4IkFDKUMT408JoMIIoLibDfWzHZTJ7tK0swrHOJUuPBQDMdGABZ0R6/QJ5Gu5
         ykgPCiU+9hKeFCkNeeB2oUI1pvxjd88fYGdyRx9jKbM80oG/IP/M1Q1aXoGGSssnTzZr
         oF9+gWDCZEyvxjipcc/HPbDeJTnyUiFk4iV3Pfg59kjNKjBtFGiNcrJJlX1U1VAK0PQC
         ItcoJGkU6tDFaO5pcX4oYq4QdTBv+6/Iq3YC+s0QOVUIRmyxF5tWi4zBBJVG9OcXDB6E
         uH1w==
X-Gm-Message-State: APjAAAUUQGKjEoxlTKVa6EOuMgBBgNZ/Bn7RxLq4w5eP7Kw/IxCydbrs
        DTromwc/AUFQXCaLFl3GKG+88LkoStN6f6Sl8HRL0w==
X-Google-Smtp-Source: APXvYqxTqByRXFGjZ428h8ZQHUjIgqjgq9ayO9zBZH9w6my5xzz105rNyl4IkAW/GMziP566XI8PObQu1ptnWIcWiyE=
X-Received: by 2002:aca:b187:: with SMTP id a129mr2523890oif.175.1582300568793;
 Fri, 21 Feb 2020 07:56:08 -0800 (PST)
MIME-Version: 1.0
References: <20200221115542.GL14493@shao2-debian>
In-Reply-To: <20200221115542.GL14493@shao2-debian>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 21 Feb 2020 16:55:42 +0100
Message-ID: <CAG48ez0N9rTEtrA1TrL07r5Om_yK-10XO2XtsWOn3Nde0PXsZA@mail.gmail.com>
Subject: Re: [kernel] 247f5d7caa: will-it-scale.per_process_ops 9.6% improvement
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Will Deacon <will@kernel.org>,
        Maddie Stone <maddiestone@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:56 PM kernel test robot
<rong.a.chen@intel.com> wrote:
> FYI, we noticed a 9.6% improvement of will-it-scale.per_process_ops due to commit:
>
>
> commit: 247f5d7caa443d0ea5f1992aeda875e679e9bd35 ("kernel-hacking: Make DEBUG_{LIST,PLIST,SG,NOTIFIERS} non-debug options")
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git debug-list

I'm guessing this might mean that the test bot had the DEBUG_LIST
stuff enabled in its Kconfig, whereas after the rename, the default is
used, which is off?

This seems a bit problematic if people had DEBUG_LIST enabled in their
old kernel config and then try to reuse that config for a new kernel.
I wonder whether it'd be acceptable to keep the options under their
old names and let them "select" the new ones, or whether we have to
choose between "keep the old bad name" and "discard people's old
config flags".
