Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1BFC33CB6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 13:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9837524699
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 13:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WgOpWoDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgARNfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 08:35:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36126 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgARNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 08:35:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so10321223wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 05:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4hcChVlh2NTB+J9TajvHQFod1mYK/8qvcaZx/KVPww=;
        b=WgOpWoDsUFi+t6oIKOLerTjgdRcFzr0CSjp1eXnLilPlzS3hlcoFW6mmln/ZzjmiZM
         dsVcR7pQ8lnefiCk44p2s24wEfme3C+0dXmTWel4GV83DFjB3Df+ancuXUz/GR09XvDy
         fPZ2JVY0d9b1f0HCYudCPZjMGi2kVsAPTcI+UqUX3fHnODCcokUvDUJd24j8suA8bgTq
         /aymsnnkbtfTFhrTOFgnXusv2GxORzhZDCB5HvKDFPJ9nmN1Fi76bKwgAjKfRqIP8m59
         isrj25fEjee+I9OwhLCCut/AS0krpp9zdYfBEjoE98SDzP5J0Xh0CmQJJLpLYs2OJfNg
         XxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4hcChVlh2NTB+J9TajvHQFod1mYK/8qvcaZx/KVPww=;
        b=cwtxOMuRb0NhbVQjnHoqSTmuPadXQHt2RyxoZfmbOh5hlczpJkyR+umVocOhX+GhOX
         KIkWXOpUysAXoNCMYblqKRVTy1kYmFXks7MIh1ht/RiUu3bYtaOvWyXafvps+9KR2We2
         ADVe/MuXlkwTmc1DkqSXy8WoRmaCw4UgLlXeKap5rsBaFd7rU058N6jd6TjiITLv1Yo0
         H8BL8MqtapglmzYNb+20n9SJLV/blAT4mIxp/+fiF4LtfDYesn69qGhAMYOZ4afm2oYU
         Dm3tI4M2VPCfuoT6y/0ytGdEMlMm/urDvWyz5jhUWJgm1OGlxnFyzRr/2qZJY+cpzrPo
         ACTA==
X-Gm-Message-State: APjAAAXjgVkshSNOEcKAAY9ZCr2Z5p4KJBkaOYtEA/wL045mGE6il6oL
        jRxZlOT5EOb6fiCTQfrGCP3YBDyuIWtPmjyJLe36XQ==
X-Google-Smtp-Source: APXvYqyaoy2vU3Qze84uWGDV1JxToGEVTuxW8nks5DiBJxtsMUOnFnAPiE5XvI3fBz+4/RH6sm4kz+HQlWa4We4ckhQ=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr10152522wmf.133.1579354507256;
 Sat, 18 Jan 2020 05:35:07 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu8WBSsG2e8bVpARcwNBrGtMLzUA+bbikHymrZsNQE6wvw@mail.gmail.com>
 <934E6F23-96FE-4C59-9387-9ABA2959DBBB@lca.pw>
In-Reply-To: <934E6F23-96FE-4C59-9387-9ABA2959DBBB@lca.pw>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 18 Jan 2020 14:34:55 +0100
Message-ID: <CAKv+Gu9PfAHP4_Xaj3_PHFGQCsZRk2oXGbh8oTt22y3aCJBFTg@mail.gmail.com>
Subject: Re: [PATCH -next] x86/efi_64: fix a user-memory-access in runtime
To:     Qian Cai <cai@lca.pw>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2020 at 12:04, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Jan 18, 2020, at 3:00 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > Can't we just use READ_ONCE_NOCHECK() instead?
>
> My understanding is that KASAN actually want to make sure there is a no dereference of user memory because it has security implications. Does that make no sense here?

Not really. This code runs extremely early in the boot, with a
temporary 1:1 memory mapping installed so that the EFI firmware can
transition into virtually remapped mode.

Furthermore, the same issue exists for mixed mode, so we'll need to
fix that as well. I'll spin a patch and credit you as the reporter.
