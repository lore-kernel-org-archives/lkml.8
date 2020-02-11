Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C51C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1EE2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwXVHgHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBKWBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:01:43 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39806 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBKWBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:01:43 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so1851029pjr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKZr9Nn9oPrGK2xfIwGCJXtf9vPWAVskjBr9vetGONI=;
        b=XwXVHgHM2emkQEfI9tLsLCP17GoUihqbxlKF04GFa8syindlYGF6luInOgl9iJ2/SS
         FCuP2FrjYOa4vYDvAKkApoQt3tqw6v27yFnaUuo2FZbWbsxUebIyTZ2SyvQ4blQ4P6Nd
         UDpbPF+Wn1yRm86qcHQQwE6Lhzm+GtV71YILUdaQnD9ureO5q821PnZ0+zmp9zc3LZM3
         Rl0HV9kXJOEEufifX8Qk/vnKBPpl6jH5Llf/BZF2IMH12MtUkmEjhOsOIFZjWwU+R70J
         nqBpfeVFkLB0LoDPlHVHH5/WNPsNNYqslHgKeXp+o8ICblmT8PwZpaWNxgxO50IuLpnX
         tsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKZr9Nn9oPrGK2xfIwGCJXtf9vPWAVskjBr9vetGONI=;
        b=Vdb/NJNlqKvu5ubxRcZCVUWku6eXUiHLaodVmXIXxxYoJJscO0/+HZ0SID0GL81Bzt
         SMuhHc+yTiyG+Y29e3S0NrlEPhiVj0HSs1Ya3iTze7F9mUtt93iTYzZjQYBkH1Z9Bcim
         z2sYUyp1ZxSDVrE58AqW3ZKu11H2aN+FfxG2k9sH08xSkIbZU59iYYooNnfvaAuqfZNT
         j4WS7SlDI7Fv4H1Q0uf7tXy1jyB1ZK4y7Yn2z2zOc5QeaMW/f5ziVzUxE8TBgG3xnA+N
         lLOs1crA406ag2zs2Q0XSdIM4K4/qYhhFw8celHIwdooghj6tY4ttMxJ+tVddmBFcR7c
         zGgg==
X-Gm-Message-State: APjAAAWD3lTXUi/KiwM3ZWcfkT5Ivjf4W6EQ7kHvxuuSd3YCVxQU5IJI
        WgWHDuNVeimqpHiOzU3SJt90ndL+niMO004vkWAB4w==
X-Google-Smtp-Source: APXvYqxiyp8ZPewy/3SdNtAOX/zkfxDTYqfVAUM5KyHWCmZSU/tv3ddASBVflxRQ8siqw0nVjWdgoYsNWCnV2WD8RNs=
X-Received: by 2002:a17:90a:6c26:: with SMTP id x35mr5717606pjj.84.1581458502683;
 Tue, 11 Feb 2020 14:01:42 -0800 (PST)
MIME-Version: 1.0
References: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com> <1581094694-6513-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1581094694-6513-3-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Feb 2020 14:01:31 -0800
Message-ID: <CAFd5g471GgE=Ebb5QMnWZz0Gjswu5mfTJe=e8kDcLudTG2rcRQ@mail.gmail.com>
Subject: Re: [PATCH v3 kunit-next 2/2] kunit: update documentation to describe
 debugfs representation
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 8:59 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Documentation should describe debugfs layout and semantics.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
