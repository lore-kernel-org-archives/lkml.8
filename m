Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBBEC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 23:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9502078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 23:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P1GARF+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgDPXUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 19:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgDPXUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 19:20:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49772C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 16:20:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g2so225240plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oid4502jx5OsVv4L1q5Cd9rnzIb1+xycaGqywcIvDmc=;
        b=P1GARF+NJi/hKDeu3e7WXiqMUzJJ1TPa5ZL+H9WidK8i3Ok+u3ItGbMm8f0h7WKP8h
         VKvcDZV/uCrR72RmlTHJC2Wu2Ns8pOMvMIABo/jP57B5N0nfKzCh3eKh2zOCuYMB/8JM
         ES4CcSIF4ng+h0a+pk3r9bUXRAMWETWzdYO4QI38NLxXoEeuFbr1JiDFKWMzlbyKIkQW
         EJcsZsLkv2KnKK1fGR31Hr8XWI+PKmW9qRSoB3QdoSej0qDdHwn99ywssrxmsc+rUJtt
         KEDyymPb6uStMgTNzip2IAESB5GCJp7vdVrtw/amlJgcuU6oavtnKSCYJq1dvPve/+oJ
         W2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oid4502jx5OsVv4L1q5Cd9rnzIb1+xycaGqywcIvDmc=;
        b=rniUYrjdT3MNF5x4y8jnMOeR+IPL6DN2O4SNL5C1DCeQrpy1b6LVgLrKwIH1FS1Ynr
         EJZPxKph18pvXG6BjklsGXmmIn2tWE7pd8Ff+kDx3+6+S6v08xSoUjob9exGFX4/Dk7g
         JonncD7X8b/uazGTo9xtVUjUuI8WZLRT9uqThxMYyNGYvcPoSgwX+S+vCYCUI32nD3fd
         i3n3Zwunq0Blz9zbZk7MiHnqvmFIuYgozWuTLTD2FiAMwthenIU6IiZ5gDBBRt6UU7CA
         10FIT175i6QMNyeqkn/glzC26o0sCz102ipAclmwmYeS+5g3Ex1d3BAShNiQa+TpJgzx
         qE1A==
X-Gm-Message-State: AGi0PuapL3j2Z+zQl4MDIZJRqmyunSjUF9TQr3/X0+sH1wJ6gd7Uog+1
        OqhBitCOZE/dA2SjCsSsJYzwaDRCjTjSAgS2Qjp9SA==
X-Google-Smtp-Source: APiQypL1gv9lxNUxpuv/LgpCAKGRZAyBFLkc8zFH07ZvjhxVjxDqpX/VBKMtcVsZYhDRPwusjIukR+LAefhB2ibng7M=
X-Received: by 2002:a17:90a:e28e:: with SMTP id d14mr881656pjz.29.1587079242348;
 Thu, 16 Apr 2020 16:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200414233753.94978-1-vitor@massaru.org>
In-Reply-To: <20200414233753.94978-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 16 Apr 2020 16:20:31 -0700
Message-ID: <CAFd5g442ka0c+D+qs7--_ERqn=Bqc3V4AHuER8FLsJi1oesirQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: use KUnit defconfig by default
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 4:37 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> To improve the usability of KUnit, defconfig is used
> by default if no kunitconfig is present.
>
>  * https://bugzilla.kernel.org/show_bug.cgi?id=205259
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
