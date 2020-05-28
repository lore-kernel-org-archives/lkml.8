Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EDFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFBB2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590691422;
	bh=LYXtWfNqWbRlHIsJLxFEA9ZSQ83RZwJtt6Vuc/kRjK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DDP5kQsaDBZ7Ey/My1l3ocdiaP7DMas6nD5LjQGQfY6uuJol4vem+QZuvgJZFjwVg
	 +GPqKdEkXmr67F6OQhKAPROb7ISjguyEpZrjO0ckkXRK1fXu4j4X7A7Nh/QK560JFT
	 Ri92acHFmgPyqg99AhQ0VMI05N28GtM8+JpAn2Ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391512AbgE1Snj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391498AbgE1Snd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:43:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC6CC08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:43:33 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x22so17178797lfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9I7snvnyR6f67pT5aVMg4qxsNA0F9Vag9hIROGL8vg=;
        b=P8nw8P71cxagqSPVUA9Kzi2wkC951thaYnOwz/e4kiPGKd2Zew+YultOwwJeyFp5h7
         zM7l8zOFEFg42p7pHhMVJLHi7CpftdQASS+eM/OM/B4nVtTeHsdqVgzMglyZy3GmUpst
         EXyW/r86HANnDshbNT+Vi8bmm9fl991ACFIhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9I7snvnyR6f67pT5aVMg4qxsNA0F9Vag9hIROGL8vg=;
        b=rFJ/qk7ZVYh83IqrbLT4f4Nd301YydKnarTmsBfAe/r3BHg9l54dSvSl6HzeRaUw4G
         fKzC7osteptnFVdVrEtGgAaeieSuEwCzCM93QsYlK9XfWhkC8AF+MWBclwi40GTS2gzR
         LypYBtzcWP1iCqn011iyJfW9NI1dUMN41To0KKs4Ssu4P3mRoukeaqRKfxP/8wYXYrAD
         jZh71tnIocN5+rQPC7Bafb18L9TCQyMCIN3QmV3CD7wYNCTa5QDi2Bk9LUARovzrjb//
         4xhTvJQlpbRrDSu8n0E+LuiUUNWij7SoZF/zFqaxRhFnMf7tcKYYgbWc3kudx5ZaUhV6
         BKLw==
X-Gm-Message-State: AOAM53066EFWvrz14J1Pkxl/AiD73uYPq6Sd3MU0Jb5sCqgLPZYfe2lZ
        nH7kamyNGecukQAwPjZOyx3y0EWHnZc=
X-Google-Smtp-Source: ABdhPJxcSZItA9+PNzQ2+JaMIDpZswfpQManRYZlXKd67d0T1iPHTm4qMhYNK9DG0iogspDE+eIc9A==
X-Received: by 2002:ac2:599e:: with SMTP id w30mr2315212lfn.188.1590691410839;
        Thu, 28 May 2020 11:43:30 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r197sm1777994lff.5.2020.05.28.11.43.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 11:43:29 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id z13so25023655ljn.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:43:29 -0700 (PDT)
X-Received: by 2002:a2e:b16e:: with SMTP id a14mr2040017ljm.70.1590691409213;
 Thu, 28 May 2020 11:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200528054043.621510-1-hch@lst.de> <20200528054043.621510-10-hch@lst.de>
In-Reply-To: <20200528054043.621510-10-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 11:43:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpnR9sBeie_z0xA3mYzG50Oiw1jZjyHt0eLX6p45ARvQ@mail.gmail.com>
Message-ID: <CAHk-=wgpnR9sBeie_z0xA3mYzG50Oiw1jZjyHt0eLX6p45ARvQ@mail.gmail.com>
Subject: Re: [PATCH 09/14] fs: don't change the address limit for ->write_iter
 in __kernel_write
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> -ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
> +ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
> +               loff_t *pos)

Please don't do these kinds of pointless whitespace changes.

If you have an actual 80x25 vt100 sitting in a corner, it's not really
conducive to kernel development any more.

Yes, yes, we'd like to have shorter lines for new code, but no, don't
do silly line breaks that just makes old code look and grep worse.

             Linus
