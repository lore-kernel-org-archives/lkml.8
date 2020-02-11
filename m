Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4438CC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB6520870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Anc5d4NC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgBKV7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:59:06 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38232 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgBKV7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:59:06 -0500
Received: by mail-pj1-f68.google.com with SMTP id j17so1850924pjz.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 13:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9h+gOqZrb8Pn305OGBZnfCQEnWlX+64gaRdYC8Jwu1Q=;
        b=Anc5d4NC7yWC0HGeNdu3IE+cBqyU0n/LqZ/shNqTFnlbUUdq+f9z+8Xhzizqi/bCMk
         VDwmu/x0oMOoOabwwPHDJhvcARSDl5DinZpMsZEizCXt6BTbfTgFEkEro5cJiM1BjsNi
         RO38o5Hvuv2rPdSGpQ1LrArrpGZgGKeEsa22JtcLkZimJo2rhVap/XLefeOe0w2FeTB3
         FCBTZxr11dDCRRTV/7W+gB1d2Ekd9eN6jECksOv5APNWiTkpiKJNeYSPH6ssMlL2FkVd
         IsAwr+mJKcHMJ6RB2Yg0HWm41xeBbRvcx0cMeIAM2Gv8SzZyycFBmuUEqX8ztpcN0XJw
         2gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9h+gOqZrb8Pn305OGBZnfCQEnWlX+64gaRdYC8Jwu1Q=;
        b=I6gjoWj5Hwv2pkPEmHFmVp8erGqBfm2GfCeZf0oP0M2A+O7nf3blFbol+bFnrqoMuM
         1SxeSmNkEOCeXEAsEEe+8e9iS22xBePaDaIHN9eRBA3/eYPaEmDTpxicd1iL41cyDrAe
         V60JE1NNe6TZQ1ENOoIrW5Mltfretfeg/EuHHT7dcKqxHMwJpuajvwU9FOuA+tH/XTb8
         q+yYbwv4yfp09RPKP7EiEp47q60FqAWP7Di0KNOgGxLsayWsr7PmGUpJTdKUfyVnK4+T
         GmRxW8ZkSK4RNAlPonU5W0UPQmF+B6Y2kaxYbvgxOXwsqKy8g1xBnBig5wL4lqgbJpdE
         NN9g==
X-Gm-Message-State: APjAAAVIYtFButAkjMnu1SxjYTK/PYbPU26e/HxFAwq5jZEz2hWb8/fm
        8XrtiNrPaao94chnVY6Pa2eglxoqJQY3/4PiG9w6nQ==
X-Google-Smtp-Source: APXvYqw93yT/Zf/7Z/6tsFK4ftr1310/hXB9PY5roG+jTUuwtIqIs15h+U7Uz6XTE1kiaSa4rkmGOd8h8SXG302Ebzk=
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr6020385pjn.117.1581458345368;
 Tue, 11 Feb 2020 13:59:05 -0800 (PST)
MIME-Version: 1.0
References: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com> <1581094694-6513-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1581094694-6513-2-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Feb 2020 13:58:54 -0800
Message-ID: <CAFd5g458oX0mEqg3xvTnonr3ztNd=HUBy3vhLSKgkKUsyRuycw@mail.gmail.com>
Subject: Re: [PATCH v3 kunit-next 1/2] kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results
 display
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

On Fri, Feb 7, 2020 at 8:58 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> add debugfs support for displaying kunit test suite results; this is
> especially useful for module-loaded tests to allow disentangling of
> test result display from other dmesg events.
>
> As well as printk()ing messages, we append them to a per-test log.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
