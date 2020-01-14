Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B42C33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2016321556
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQvzCTBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgANBKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:10:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43074 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgANBKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:10:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id k197so5557174pga.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 17:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MuIq//wCZduhaibSe5/7hJSdzVgRZqtQMOj1BjJPoMI=;
        b=SQvzCTBn4LLS8Q9CzT8sA1qDOJ8VkKjMfUwbVDNSUA0tX3hZrm0WkpV/WhqdmjAHPD
         brbBybX4G9nflXxIIEAeoUxh5cWc5hbsn7sPNyXTeTgGiibchfrwdufAZRtYC5VFFUZ6
         cQbhcCGEZyeGCEKBK6hnZZxW5ngpun0A8PvTgqCgArxzzgDhEjkIWSzwnVSKnSYBW5Uo
         pba2KL34YtVeP783g46fUUVCefzyytk+Xq0/rRz2AukRa04uGt/tOXd59NqRh6esJsnK
         +q5+guqlvIgYo/J20T8aqnyQF8xGgSXuQEk5vDN1q+taj0OApxeRz8a6uBShVF2KtM8Z
         ezqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuIq//wCZduhaibSe5/7hJSdzVgRZqtQMOj1BjJPoMI=;
        b=r3kfRS1vee9078c0iSD1xkjDYelekTbjHe25GxqaoBCHNZp+mlZlm9DGhPb62utaTb
         FM2QM1V37heyeMG7NGFRQzzNhixj9G38WjtLW6fTBOC4f73lSr95H5IULRj1uRAyCuyD
         ZEo3ECQAJGuy5RgUvSc0JY+AD2pNyzga453i9rUtpzk5gZz1uBMyyTjRWj11olbJlJ7V
         DAtYuihV2U5hQ9UkurGbUXhgI8ITKgrE/SHzft6JpU8sJBu9AMBWszzHGonZY9ObIs+1
         d3QYy+aGBfGD8Cw9PqxIX0qy65TO1NWlg3bzHM6t2ATr56GYpm4Lvau3rd94VNBa+ksA
         p75g==
X-Gm-Message-State: APjAAAUwJlBbiM/DqyYAEPHS1OfWbfzF4t2ft/VUoWSnvSoQRHx6Ts/3
        sFUsN7uh3JNHzbjj5/Q09lgvOf+2i9M4IuiMY8wb5g==
X-Google-Smtp-Source: APXvYqxTzPsgCrp/FhpOnGVwtu5xXbBt+F5nJ89uUP7Tfv62ZdI+z61Ccr6Na7E1+73rp1o09IfvgjZk9cycnSFTC44=
X-Received: by 2002:a63:597:: with SMTP id 145mr23090242pgf.384.1578964214716;
 Mon, 13 Jan 2020 17:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20200113181457.209ab4a5@canb.auug.org.au> <eddaa93c-3bde-a9ed-5ee7-766f3cd51a43@infradead.org>
 <20200114104049.5244f612@canb.auug.org.au>
In-Reply-To: <20200114104049.5244f612@canb.auug.org.au>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 13 Jan 2020 17:10:03 -0800
Message-ID: <CAFd5g454Xgb-tnG-rBQ3fkCe2bsO7M8_dauOTpG3bxDjnxOX9A@mail.gmail.com>
Subject: Re: linux-next: Tree for Jan 13 (drivers/base/test/property-entry-test.o)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        KUnit Development <kunit-dev@googlegroups.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+KUnit Development
+open list:KERNEL SELFTEST FRAMEWORK

On Mon, Jan 13, 2020 at 3:40 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Randy,
>
> On Mon, 13 Jan 2020 14:59:54 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > on i386:
> >
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/base/test/property-entry-test.o
> > see include/linux/module.h for more information
>
> Sorry, I missed that yesterday.
>
> Caused by commit
>
>   c032ace71c29 ("software node: add basic tests for property entries")
>
> from the pm tree interacting with commit
>
>   9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
>
> from the kunit-next tree.

Yes, the problem seems to be that the property-entry-test is turned on
when CONFIG_KUNIT is y or m.

From drivers/base/test/Makefile:
...
obj-$(CONFIG_KUNIT) += property-entry-test.o

It seems we can fix it just by adding the missing MODULE_LICENSE, but
I think there is a bigger question of whether we should let people do
this. Do we want to just let people have their tests run whenever
CONFIG_KUNIT is enabled? I am inclined to think no. It should be
possible for people to run their test and their test only.
