Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02CBC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC9A20740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585157640;
	bh=3fg2Yohv9dythB7jKJDFlSo727WVCnU7vtMwI65RnbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FCXUWStCveoMN1io35dyPK0/xu9jMDD/QpwHYeHJ6fqvk+RqeQTY3vAOXwYoMTMpF
	 M70IQ6tBlxmps5lCPfeH0CWFJ5IHqDpdPgO2xBbZptYLebbmMtButABxgo2ia7S5Jx
	 RfUL1Nq4Lg17/5CAPPMZoSg3l9jnCA0adgXwLKUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgCYRd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:33:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45259 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCYRd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:33:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id v4so2488321lfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WD9sJ7e0VtDn+ggzAl5BJdUvSH4xHuF+tQFUtVO3ypE=;
        b=WGZT23GW3l1IUkI7B+xGcDt5rMqhhi90Mt39Ps79pv2c3a8o2pdcaPJk3WEzm7iMag
         4GyBo7pyJ0/uI2VvnGfWdYXgj4wXPU+3x6UoAr4UZYQKI8253uLtZshqu0KsCeSb0lQU
         0fQ5OqX98L/OxmrWufaXldfncoyLhcc3w3DhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WD9sJ7e0VtDn+ggzAl5BJdUvSH4xHuF+tQFUtVO3ypE=;
        b=iiivyq54gSTtj/VuRkcNzz04lwcbAySw6KKWJwDFi3HTQFdOOu1zPkPHPAndK/9dYf
         wZvIkL4CZAV+yvjeRQstJt3tac8BUTonfycTCZNlVrb706UZwCw9dkLEj8uGyDoMAm9/
         zgfQqYhz/i0vl3PYWuV/RexBy6I+MZ+tVu+UpIq/i6oJUkbt5wGidrArV7hg5QnjGWlH
         8t5X/FXMRgJeiQUkhLF+0mcB+hTDcnP9dproKN6cKJ1c8dZAustGoNUvdRc8+fy8F4vJ
         J9PcR9lG4rbgVqb1oBSGqRApncuakSKGJN6KTl+JDorv1UkTzfqfU4aDI3SyM75cgWQK
         9AmA==
X-Gm-Message-State: ANhLgQ2QfYfxF7VlV11Jf6TGP+tMZ6LLPI+JpJWhygnhcrr4oRbZcoFG
        tov+kIbV+uz6ut+LbtemEwbZMElnzwE=
X-Google-Smtp-Source: ADFU+vsvthX6324bFaZ9ii+Rtyi6YWeLk3UX1dkjCJk3JbZigVGshIOkUj5Ro5M7gO8EZuoDmf1Y/w==
X-Received: by 2002:a19:2203:: with SMTP id i3mr2968145lfi.120.1585157636544;
        Wed, 25 Mar 2020 10:33:56 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id g5sm9083023lfd.66.2020.03.25.10.33.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 10:33:55 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id k21so3424386ljh.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 10:33:55 -0700 (PDT)
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr2579577ljp.204.1585157635185;
 Wed, 25 Mar 2020 10:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200325111347.32553-1-will@kernel.org>
In-Reply-To: <20200325111347.32553-1-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Mar 2020 10:33:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgymj+aXjTwjRkhA0j0u7t1-74fLUmp1pW7Jntf=Q+eOw@mail.gmail.com>
Message-ID: <CAHk-=wgymj+aXjTwjRkhA0j0u7t1-74fLUmp1pW7Jntf=Q+eOw@mail.gmail.com>
Subject: Re: [PATCH] mm/mremap: Add comment explaining the untagging behaviour
 of mremap()
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Android Kernel Team <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 4:13 AM Will Deacon <will@kernel.org> wrote:
>
> Add a comment justifying the untagging behaviour in mremap().

Ack. This makes that odd "do it on one address, not the other" thing clear.

Otherwise I bet somebody would come along in a few years and go "Oh,
people missed that other case".

             Linus
