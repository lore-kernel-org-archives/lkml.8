Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D914FC35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D4220838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIVoYpqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBGUiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:38:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39505 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgBGUit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:38:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so4195482wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSg7JMFRzPtoE945qQnjffCeXnLroF1u5VJV3uyBQCE=;
        b=TIVoYpqKWPU4FbaHxrhBJ1Bwm+O6hvlv52zIi5d26xjDUTZ4yMC+K1iis5YbHTIZVl
         9dHFuS4jNiXqxsq3FgyR0QBYCDDX0K20dUQm3BjtPvApP9txtUUaqU1OO0GhGh3Nep+F
         BPgz1uHXGrOg8F5sRqAfUFY9p4EvycZiJalM+RzKSVOw2pxxJOS10UZf+ODEOwWn1KTt
         ZqDzRMDMRWAmKXYblY7qJmxgBJymQDI6UbiK7qjXtkJzZqMTb1XCaabdFiCYMXNc+Ehz
         aCcOFiv0DV4rUQziYOvUisKifEZCM89iODF4OZ09LVnQd9aS0sQtw75L6vLrgV6rGOTX
         LtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSg7JMFRzPtoE945qQnjffCeXnLroF1u5VJV3uyBQCE=;
        b=Xkh2GcP2jwDP6XqmUW3a7g73OxXRtzKeOIWyjXi1y0dyPmveBZ+xonemW46fQ3rlES
         ejVdlTyDrgiJ3hOUHVfW4gSZ4tDfoDPT2GRvoMC9j4hB+HaVeA4yx7a1fyiJm/8ijBXa
         xZ0aVfGzzjbeymR7J3ahHlMYpB492SgFOItEVst/uVM6pn9rjN+5ZZGRPGSEjgYDI/qi
         N7ifR3oAv8JP+3YZjl/qJlLBeo/VzXuqEuN+KakxT/QOXeDE14ToO2dxpQ9p8qjgHrRs
         1NEbT0TvIhlQ1qiKd2jmBVYr50LnsYb8m+71K95RXHqWEExZkLhiiR8aU+Jf92Of0Wzq
         wviA==
X-Gm-Message-State: APjAAAVg3muRmEzOEFMXQ+CdKu2bCOaonKddW6z5GcfHV7yfBB8asCen
        u+kBEMSUKD9xGdaGJ+xiI0Uk1LPX5ZIKdXFUoho=
X-Google-Smtp-Source: APXvYqydjzIv13caN2xryirukeMzD0uzG2GhLc51HcLRq8k2qIGBrJQP/yUUcBKY5ND3CTEXOXO+aNgXuI7aWIVoDew=
X-Received: by 2002:a1c:488a:: with SMTP id v132mr81301wma.153.1581107927512;
 Fri, 07 Feb 2020 12:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20200120074344.504-1-dja@axtens.net> <20200120074344.504-6-dja@axtens.net>
In-Reply-To: <20200120074344.504-6-dja@axtens.net>
From:   Daniel Micay <danielmicay@gmail.com>
Date:   Fri, 7 Feb 2020 15:38:22 -0500
Message-ID: <CA+DvKQJ6jRHZeZteqY7q-9sU8v3xacSPj65uac3PQfst4cKiMA@mail.gmail.com>
Subject: Re: [PATCH 5/5] [RFC] mm: annotate memory allocation functions with
 their sizes
To:     Daniel Axtens <dja@axtens.net>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some uses of ksize in the kernel making use of the real
usable size of memory allocations rather than only the requested
amount. It's incorrect when mixed with alloc_size markers, since if a
number like 14 is passed that's used as the upper bound, rather than a
rounded size like 16 returned by ksize. It's unlikely to trigger any
issues with only CONFIG_FORTIFY_SOURCE, but it becomes more likely
with -fsanitize=object-size or other library-based usage of
__builtin_object_size.
