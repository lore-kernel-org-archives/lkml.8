Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BD9C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B234206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598462171;
	bh=EMOJffRwZPF3AeHmgi5ktCtpsS8eGv5RpN5pqcaYHUM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VkqF5UwQbRN7E7fZc9gB25V1PAkvEYAmXbk/hYBumtPRPsTM4amQ/f43Oj0oiIXUY
	 1vael3DJKoMwzW30koKxGDzKp44uYW7MJjP5Fpaz33TjdX5NZNX3wyErkChtizMYJu
	 QR4DEZIyi6QkWkqVOBcHfm0F9apavOXkA64N7+B4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHZRQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgHZRQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:16:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57122C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:16:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so3243952ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYDNjsWuANyuBcj1SPsmNo6ddbFkMTYQnNwN8I83N48=;
        b=JGeqnKz66cr/PGvxK95byYWGqp6m3jFBDNw2exQc8Tiv2/3rV7oeitqRF49c0TPmWt
         PfYOAUYDCFroSYr73H96pWaoUr7kushnS2cp61vwd6oqVPJ6ijM/SJNcl+K99LhgYPeW
         UrUvVlTKWW3lYTcZZ3AV3q2bwaalwx4rI+U2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYDNjsWuANyuBcj1SPsmNo6ddbFkMTYQnNwN8I83N48=;
        b=SefDj6TOCSB4GzIbvFmkm+V2XX15xCJiUVoQ3qG3BvJShyIhLuWVNCYotKKVcathbd
         KKlwRYZlmOcB9OWgj+UTuwpNtXM4fM1AhHs3LrKNw6zNzNtp2HMW4CjVPwEhqxl0OlNG
         wSdpu+IS4Zk7oqti1P3MBLa8ezhAIK/IqDx9nfAz+18N1xVsAaKv6L8kuRurWnIFsvfG
         EPf3uHFMSr041vIr8YWo5uGP8FlTtnehlvQ9sTGzipPWjA1XuovpGMrTMBiH8tIRNrs+
         GuyfWovdNTdO1m8v1N1f0gDUMt3kPPLjjGIacmQt2Vb5iSePhqiwxEK08FVi7ICqvcKD
         Nx8Q==
X-Gm-Message-State: AOAM530RlzgFlKJaYAm+ADhMqVEyPxDUisK6VttJg4UCtYMouXQc8oKC
        H7gWK9/EZ16U+d7BVymE/xg4ezQsR0a9eQ==
X-Google-Smtp-Source: ABdhPJxKeMjS0/Eh9jrktOKFvpKQZD/ZSwhR0BVTmJBvYV5bgAb6nqzZ5G3G7Kvsk0ax5srN+wS1Ag==
X-Received: by 2002:a2e:8510:: with SMTP id j16mr7442242lji.196.1598462160282;
        Wed, 26 Aug 2020 10:16:00 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id d15sm631605ljl.32.2020.08.26.10.15.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 10:15:59 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y26so1414759lfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:15:59 -0700 (PDT)
X-Received: by 2002:ac2:522b:: with SMTP id i11mr7933692lfl.30.1598462158792;
 Wed, 26 Aug 2020 10:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151448.3404695-1-jannh@google.com>
In-Reply-To: <20200826151448.3404695-1-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Aug 2020 10:15:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgedMxgfNPccK9Fgm0JQ=UX91HCndOnO1qAiUOoCOJi5w@mail.gmail.com>
Message-ID: <CAHk-=wgedMxgfNPccK9Fgm0JQ=UX91HCndOnO1qAiUOoCOJi5w@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Fix ELF / FDPIC ELF core dumping, and use
 mmap_lock properly in there
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 8:15 AM Jann Horn <jannh@google.com> wrote:
>
> After this series has landed, we should be able to rip out
> mmget_still_valid().

I think you should just add that to the series, since it's kind of the
point of it all.

But ack on this, it now looks saner than what we used to have regardless.

I do wonder if we should possibly just limit the number of vma's we
dump based on core size ulimit too, but that, I think, might be a
"further improvement" rather than base cleanup.

                 Linus
