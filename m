Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45F6C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723EB20675
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwhrlK2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgCCN6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:58:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36985 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgCCN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:58:19 -0500
Received: by mail-ot1-f67.google.com with SMTP id b3so3066476otp.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 05:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbcRkVBxSbJptVd45Z925xp04oFQnSe/xFiehp4Z2HY=;
        b=DwhrlK2SAnNEc310PFtb/wtiEb9o2QG+UHkXx02enw/+bZgoV6Vd5k8t+bCxIS1KL0
         CiIHCR8bIHYIzYgCbotrzwPNaxWcGCBo6bso4emMvUjLbFuXSSHRESWkUWD1Uu5k7FRM
         4Vp1SoFKTD3zxA2iouOs+1gHuAxgPAHCjdmx9y3Z64VomIGs1W9TJARAEn9XvapU495J
         4uzCui4iWa676vBWfxjW4CTO6BjHIQ1Lckvx+aAJsinjy77isJjFM9chRYG35xDZGopB
         KL5XmcSMPD2RhSW0TpDuMNH3knppvSaAvflJgJyYCfpOQQnkPBwctXg5GgtAQnOfAh4L
         8qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbcRkVBxSbJptVd45Z925xp04oFQnSe/xFiehp4Z2HY=;
        b=dmEXVxKIWDxDZlviGRYJBvLgJZjTZlLrSPusJ0XtFrJa4CyYagwJSyZrbyoml6CZ0c
         MQ/2pkUcbjla95VAmkcva60DwoXzW6PC/q9L3L4a1X24E5yV1Tl675HFuji1xvVwCA/n
         /xYRjkEDrjhQWoQIKHgA0ceEYAHueeEt6TOurScPHIvpnEBReEOore0ORA1BnN0GPi1D
         ZzfLLHYWvlewD6kry1bpczskvhUIc6H2hxxMkZUCKLSyJXLeEGzCJE+d0uzpQ0GS8BQf
         QdKwcwBFm7V6BP1M2PVD6I9T74xZFTg3is3gKmHXZJ4GOLYlf0rBJBebgofkOoblq5iz
         SVbw==
X-Gm-Message-State: ANhLgQ2ZJ2ZCXoXFeK4wj/0gqDxiratcATcFqd3RfAvSkGB3G5xrrpTG
        bd4pi83EQyjrkTOpGkVSVhDj5SSGFQGV21bAJ6el+Q==
X-Google-Smtp-Source: ADFU+vsOF73UPQUHQMvLyMi287mQvulbkayIZkhYFakbOdqU0mvsrMAl1bBqLrnm9Y8XjItDIaCeUz4e0WfTPYOhbTA=
X-Received: by 2002:a05:6830:11a:: with SMTP id i26mr3553549otp.180.1583243886992;
 Tue, 03 Mar 2020 05:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20200303105427.260620-1-jannh@google.com> <CAKv+Gu82eEpZFz5Qto+BnKifM4duv8sBTx3YhLXU8ZPPsND+Rg@mail.gmail.com>
In-Reply-To: <CAKv+Gu82eEpZFz5Qto+BnKifM4duv8sBTx3YhLXU8ZPPsND+Rg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 3 Mar 2020 14:57:40 +0100
Message-ID: <CAG48ez1u-CB8dW4iaH8zpdaUxb-kY4VDPVWPAoNOQKhnhsZkkg@mail.gmail.com>
Subject: Re: [PATCH v2] lib/refcount: Document interaction with PID_MAX_LIMIT
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 2:07 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On Tue, 3 Mar 2020 at 11:54, Jann Horn <jannh@google.com> wrote:
> >
> > Document the circumstances under which refcount_t's saturation mechanism
> > works deterministically.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> I /think/ the main point of Kees's suggestion was that FUTEX_TID_MASK
> is UAPI, so unlikely to change.

Yeah, but it has already changed three times in git history:

76b81e2b0e224 ("[PATCH] lightweight robust futexes updates 2"):
0x1fffffff -> 0x3fffffff
d0aa7a70bf03b ("futex_requeue_pi optimization"): 0x3fffffff -> 0x0fffffff
bd197234b0a6 ("Revert "futex_requeue_pi optimization""): 0x0fffffff ->
0x3fffffff

I just sent a patch to fix up a comment that still claimed the mask
was 0x1fffffff... so I didn't want to explicitly write the new value
here.

While making the value *bigger* would probably be a bit hard (and
unnecessary), making it smaller would be fairly easy here - the field
is populated by userspace, so even though the mask is 0x3fffffff,
userspace will never set the upper bits, so they're effectively
reserved bits with value 0.
