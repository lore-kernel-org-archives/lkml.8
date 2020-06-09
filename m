Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA07C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFB7206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUTUaWX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbgFIT7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFIT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:59:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C1CC03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:59:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s88so1862929pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JYzHVam3aoxA7E3Nf+mPqLW8Cnq9QYwGHyougBUIUM=;
        b=AUTUaWX5mOdyWQvV9aN3Fs0Fise7Hqja4tWkV/PiRtUIxNvqLKLYiphFbWB7b/O6aO
         uTR5rgofmlKNCQOkMsJaV6qZKZ2Gp+SxhXIoDMZPSsdV235fIHAuLEULkHuqXXrY1a17
         msFy9ZV9xEoWbKlBjUrq75XEbUgFscR2TyaC9FxQUDaJC+dDXdbPUGxnWd+UTif5RKF1
         8kwGGgfPh7GOQCiHqMDZd6KdYBbJWbibjNxQGA8YcQKBG7yjZdqz3GVDh61izcnneGGz
         EEcoQys1jUziFulDUbSmEfzY5XN054YMd5xR2VOnw9mB/ddLUI0nPhhAv/TI0tbUZ20P
         LteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JYzHVam3aoxA7E3Nf+mPqLW8Cnq9QYwGHyougBUIUM=;
        b=pbnhCrAcQoAS7HSunC/sIS5LHJ39EASww3oCFoJ2y0JnbJfPgLFv5dRjkQ/02AIO0D
         UGGrdEThh7zYOwrXVSzGHxgP3wpLVoBS9YY3iYSK2B0v9Rzq8ioeryVSa9cYhZaljhHq
         5shhDYenufV1/H43HKByW6ho8Z1WsAyIWDJTuK96LzgLsKxYKBFM8WNx9ADLwHdcuieg
         0wjSsUSA7H9VkpkM+EUpfUkLexJ07/jXj64R/+EHvRUmZp93i170aiP8ql3EfS2PsjGj
         lEde6Rz0WKQtQw5PuyGCfTAABpQd227hupLLFjlaXEZpGLyRU1UYL0v4clRfr/L8xcGg
         oAVg==
X-Gm-Message-State: AOAM530xk5kITD7QPmMpbmBZnargQzzB2BFJTXXfehgvpBgkAhfpoPKe
        lEfyhCBRqz/0XWnGs21/BJXI81AHl6WqJnR//342yg==
X-Google-Smtp-Source: ABdhPJyhIu51fF1v8j4WHe7KZoGUQ+bTlaj2cYc7LVrH9vXLcLmlmmjSgAmDDa08jaWlaEbvPxkacC+s+dNbo9o8Qt4=
X-Received: by 2002:a17:902:8d97:: with SMTP id v23mr12174plo.297.1591732746497;
 Tue, 09 Jun 2020 12:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200607215715.90981-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200607215715.90981-1-rikard.falkeborn@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 9 Jun 2020 12:58:55 -0700
Message-ID: <CAFd5g44csNR6=-YcVNOPa-vshEC+=nd+OY95BMveRsifCXf+Vw@mail.gmail.com>
Subject: Re: [PATCH] kunit: kunit_config: Fix parsing of CONFIG options with space
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 7, 2020 at 2:57 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Commit 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is
> updated") introduced a new CONFIG option CONFIG_CC_VERSION_TEXT. On my
> system, this is set to "gcc (GCC) 10.1.0" which breaks KUnit config
> parsing which did not like the spaces in the string.
>
> Fix this by updating the regex to allow strings containing spaces.
>
> Fixes: 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is updated")
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for the patch! I had been meaning to send out a fix for this
for a while, but never got around to it. :-)
