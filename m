Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA81C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290F22074B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584147073;
	bh=tlCJtAe3msJiqNgtKRj65iWpE19bpZNu0eyGfsjoQ5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BQtcvV3wHotI+IsftsneUmQg2dkJL6ZQj8QmwMZ51pkPQJNPji+TJPVtFM0sGmTtU
	 irBZIm+jCUl4IwRln/du4Kz5txG01Sy7VKPH2Ewk+rDTQyxjUZE+HD2T3JhS4+VnhD
	 23IfNZt5v/7mAoisFEMgwYnSROoaHJb+AqFQxMH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgCNAvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 20:51:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37747 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCNAvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:51:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so9361623lfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5w4U+mOCcTiVuYDq+MXzMGJDsYiXTEA/liBKIfgsNo=;
        b=CuZ6m+O8ocHYyKfETYioICJSPSG6jO2l5sVNRexToIRXGGlWfI0a1s0ftc+276o4kL
         +uJLTjdL3K3G1tQ4MaaU3TpK73x5dELWgmEQvjyRbEV+XaVWnseYbRydLcyLf9Ta4Gzj
         hdHX62pz+h52pKbzWGSD8FI7QHQkc8een7N4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5w4U+mOCcTiVuYDq+MXzMGJDsYiXTEA/liBKIfgsNo=;
        b=Eye2JxuLP/Wy87T6Xjhx49nUavSPm7bf/DHvu6fSUZ2IujnNqA/mhRMwmvYUU8Ta5w
         ySN3NCIERCKJwB0u72HCpb/ZidsOMcYnQcitf59IutuF/Q2u7d3EZC7igRz7ji2m7dyZ
         M+RgSXB/+p2RI18nWr/J0lWHRfNVF8HjXfS2vSrdo3A/vnEjADb3ageSCix5WC8ahXZG
         /2Ves5umJoWgHmlWiRb8utmOCGsi1QzhZp9RrFf+T8BOBjzUje/3BUj58JL9m4cXeDdB
         jWgTaRvO1OE8Wcc3C0o+W/3nLxHMmSZikg0PVpCHgCeVuzbfh2qw7yLt4KAvhyQDqOwM
         z7zA==
X-Gm-Message-State: ANhLgQ2PpojmcpNuy3WMiyHtJzncfv2zvM9j70cD2Gm/BUZSsIwl52tg
        Oh5tvb5nop2s+pdwkxcfjUCFbYzcAns=
X-Google-Smtp-Source: ADFU+vvClD5X8m7RSAw6MTWi1dWzO50aznYA+oqzNVTwpRoNlKVT+Ee7g0kIhvet/NJ0XzrQCe8xXQ==
X-Received: by 2002:a19:fc1d:: with SMTP id a29mr10179994lfi.209.1584147068271;
        Fri, 13 Mar 2020 17:51:08 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id f9sm10249481ljo.73.2020.03.13.17.51.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:51:07 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 19so12519309ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:51:07 -0700 (PDT)
X-Received: by 2002:a05:651c:555:: with SMTP id q21mr9713597ljp.241.1584147066920;
 Fri, 13 Mar 2020 17:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200301215125.GA873525@ZenIV.linux.org.uk>
 <20200313235303.GP23230@ZenIV.linux.org.uk>
In-Reply-To: <20200313235303.GP23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 17:50:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whainTcvgF01vsSmN+y7s7U1qMA-QbM5qFQ3s4xQHwaJw@mail.gmail.com>
Message-ID: <CAHk-=whainTcvgF01vsSmN+y7s7U1qMA-QbM5qFQ3s4xQHwaJw@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v4)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 4:53 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Review and testing would be _very_ welcome;

I didn't notice anythign else than the few things I sent out to
individual patches.

But I have to say, 69 patches is too long of a series to review. I
think you could send them out as multiple series (you describe them
that way anyway - parts 1-7) with a day in between.

Because my eyes were starting to glaze over about halfway in the series.

But don't do it for this version. If you do a #5. But it would be good
to be in -next regardless of whether you do a #5 or not.

                 Linus
