Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CEEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95868206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwDhT0K2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgFCHSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:18:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5B7C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 00:18:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n11so1175241qkn.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upUYfRAA3OB+55Uid8yeg7Ykm1ooNkzjA3YEgCJr99I=;
        b=IwDhT0K292/Bw6J/zj0jh9gBcuBIJl5QMCTXZQwICBLE9l8ck8ixucykHzavVL170l
         GwGcTb8RqvvbWSXOotRntL7qZtuSKCnHcnb+XjMrfVo0ZmWQPH3G0o7IQjNuZIsCFgpT
         KBsy+6Ha+U1JN5ac6VzHaGuSaXiEm/rX8praMgfXOlSkWVRMBTHLhTUv2WDgv1AyuQOg
         M7x0krg0Ab0VmHJZPlaUbvwNxY1sMI43Sx4ovBjHRLtqp6ioG/I/Nos+mdKwzmmLrJp0
         kAm6wrY8i+NcozOWXiE+PkLWhn1nGFisvrcLZgOLMCZsWDxz8Dl4tHopSzHo0XlfEIZz
         8vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upUYfRAA3OB+55Uid8yeg7Ykm1ooNkzjA3YEgCJr99I=;
        b=i3MBDsVHjSP2miBaGIOVdV3UXSQ7dnavmhQEwkpUZy4JxmUvebMAQQj2V0gJWmBJlL
         jIXjvQAxoey0rmrOJpnTO6XT8ThxK7Tw1DXIU7xATKjTf6zzo1Ewyt3wxDhWIy7VPqPh
         FF8z4Pcw487flhOEXbORLYhRx4uZqLmclALof85gjUR5CpA+0zXli+6tcNktiT6AWKuc
         iBN6GdIFx1p8YZNgrvXhLLRII1o8Mcom8TMkkU+p2boaZFF8CYR3HND28ie5sO26HE6z
         JpFqf/1AggxiKqJ9Pr+Jmu7suoT6SJmw4Vg9rUDVPJ5jTjqxDpKlICFp0woYCxNNH1cc
         ewbA==
X-Gm-Message-State: AOAM5304gjFeN/5XoTAa3QJeyknIxigxYKDX85PAoQz9+87wt7aIuHSS
        W64fWJaQFvsbsg53YnjmC1vT4TWdD+7eSHirMUA=
X-Google-Smtp-Source: ABdhPJw8caa0RkmT/kcE/lPlKwmQw7I0GVvEKAwuuSomY0LIBhKDbsb5isrygm8OpzPqI144baZWIiqEMdxh87QEAYo=
X-Received: by 2002:a05:620a:15f4:: with SMTP id p20mr26731572qkm.283.1591168720536;
 Wed, 03 Jun 2020 00:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200529033809.113516-1-lizhe67@huawei.com>
In-Reply-To: <20200529033809.113516-1-lizhe67@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 3 Jun 2020 09:18:29 +0200
Message-ID: <CAFLxGvzkMp3JJHiE3g3LrxVJUgh2Fj6tbGFPSdv-1W2PiYqGjQ@mail.gmail.com>
Subject: Re: [PATCH] jffs2: fix nothing output for "ls" command
To:     Zhe Li <lizhe67@huawei.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 5:38 AM Zhe Li <lizhe67@huawei.com> wrote:
>
> Recently I find a bug that I get nothing with shell
> command "ls". The test steps are listed below.
> 1. cd $JFFS2_MOUNT_DIR
> 2. touch file
> 3. ls
>
> Finally I find that when command "ls" going into
> function jffs2_readdir(), it get non-zero return
> value from function dir_emit(). So I get nothing
> from "ls", absolutely.
>
> After checking my file system image, I find a raw
> dirent node with nsize = 0. The full_scan mounting
> process do not check nsize and the return value
> of strnlen(rd->name, rd->nsize) carefully, which
> causes function jffs2_readdir pass 0 to parameter
> namelen of function dir_emit when we use command
> "ls".
>
> Of course it should never happened to find a raw
> dirent with nsize = 0. In my opinion, this abnormal
> phenomenon maybe cause by bad driver or bad medium.
> But for rebustness reason, jffs2 should handle it.

Well, if driver or medium are bad, the filesystem will die and lose
data. Instead of papering over the issue and delaying the inevitable
loss of data, please address the root cause.

-- 
Thanks,
//richard
