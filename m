Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27171C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35C8206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaWOyASn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbgEVWfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgEVWfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:35:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECBCC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:35:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q8so5856054pfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6S4JNYMJWRAwO/i7PXs3hCIkg0U+E9CuPFrfo6fBoo=;
        b=jaWOyASn27zgR8XbAGwLWXsStS+E4f55phNrI7PCbknABMvSIQwrLoglZtD1+GwC4m
         JJU6/Z8yVQYKvkKmWGAH4N4lJKhEthUDt6ht/BfxrP66LCHgaPn/GTSYhCdwI8zg5POT
         ZQqIwVGUV46lAWvZlZlGX0kbzBReDr4j9rNxNmftvcte3GF0dhnr/sIu3e+QAGRtaJYa
         Bgezz0PsR1fakDp/Of5CuXKqpfjbt5yE6MhAvMzSj8/7e4QV4WoD2xX+oBpI6Jv2975L
         W1M2WNocPL+CJULkztSjY/xeL2uAdK0fnD2lH5YlkyqoXirE92ANf3mSWY+V0amlg5sf
         AVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6S4JNYMJWRAwO/i7PXs3hCIkg0U+E9CuPFrfo6fBoo=;
        b=cqDaxd1ZDXVvP8yzL+MJ+3MpqZ3P8OnVfzs/rC4CI+HPk9kaN9jUg1MltWKAnwlV/b
         Me5VU/mCemslh/Ft+sUykuDHvF6+ojYj1dqVME+jLKYld0kq2h1GDrsfNWNqhKAap6I+
         j8zVAEeJ46gwjlHwZ4JoCgVXoBsXZAUP5P89QGjEI48/LENAk6JdRgawzbgwYo60UZIL
         1O0046C9MR0M4Kdnf7XH3EA7XZOyuLmtI/Lb/2s2M40Si/OOm2AY6vBsdIZddIilLmp2
         uMh2tRG0buuzjOJNPuEBCz2lA0liV/5MIg+iT6C+MWQRMNeZc9Vhl9XL6gBrKRLc4kOe
         LwhA==
X-Gm-Message-State: AOAM533GuTdwbfX/ns9anG1sTD5DSiDPHD+xboQtsFXyNWAz3iZxVem9
        M72M/YCE1nCycRsJ6dPuSNNMXt6PI3QzrvD+fKc=
X-Google-Smtp-Source: ABdhPJyg5RUevHsGRTxGQ2U4Uy3JBWUfYrLcfXGTdfqNZfhjZfYLYu6K5/NtZux+J297Fu5Vas2ZcsLAsXie/cSO9Qg=
X-Received: by 2002:a63:6e8a:: with SMTP id j132mr13824373pgc.301.1590186945084;
 Fri, 22 May 2020 15:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200522214153.30163-1-jcmvbkbc@gmail.com> <20200522215814.GW23230@ZenIV.linux.org.uk>
In-Reply-To: <20200522215814.GW23230@ZenIV.linux.org.uk>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 22 May 2020 15:35:34 -0700
Message-ID: <CAMo8BfJrxt2_Zr4w2=ebfEhsXeZbJ0yUb+i57ELSjnZd=7383g@mail.gmail.com>
Subject: Re: [PATCH 0/3] xtensa: clean up __user annotations in asm/uaccess.h
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 2:58 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, May 22, 2020 at 02:41:50PM -0700, Max Filippov wrote:
> Useful test:
>
> void __user *f(void __user * __user *p)
> {
>         void __user *q;
>         (void)get_user(q, p);
>         return q;
> }

I think this change passes this test, i.e. originally reported warning
does not show up.
There's other kind of warning that it triggers:  'Using plain integer
as NULL pointer',
I'll post an updated version that fixes that as well.

-- 
Thanks.
-- Max
