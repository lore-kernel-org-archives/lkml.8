Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350A2C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084692076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vCq7M3Tc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCXSMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:12:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34762 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgCXSMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:12:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id 23so9732533pfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/d+L7ssZFGD9dUL+ow/dGUzskuUeNpi5SPqcS5kNRuo=;
        b=vCq7M3Tc1lLHXr9n/N862MpDzTCtytaQvIq+JmiawJy9j05bJoR2iqJNRAM1tStFY7
         P2W5/YEQ9QHDtl35ojZqvWsSn6l4gE1D/MbGTkRB1aeeTlTgZsFYJkbTHn2ln1WpODSt
         lk3xCCgJ3awYMY7rOou/PAr+QJRX5AAW5nel9mxbr5sXZveXLWYMDsBhfX0jqa6gFC6k
         OUKpH/jp6tfcgNmO9GsM2bZ7sPqeS+GuHn9OvlBg1D569qRfnJ67OWq4OVkEMQH5j7ZY
         Na6WqZ83FI6Z0RPLKZHqIRdQ4aiN1qaWVvQoqGr7CWxZCW83bXff+z6GWqauWhED9Nfx
         sXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/d+L7ssZFGD9dUL+ow/dGUzskuUeNpi5SPqcS5kNRuo=;
        b=H2l1Pn3d+soJxLUc83ZZiTZUngGPjOaiSZFwCDMx5JCg3LIPCzT2vTiy1RIeap1PQW
         mRrYYzJk/ydjmziQg34zYUb1rxCtGh+edwOQqhm9mVrXjtCcTn/3k+2JC2APFUUWEtrh
         Ier0NswF+EcqH/ppEYyDSLeLmPhTc6YwmyKeprqnPpuRIH/XVT/GHkQ6p8YvYKPgu0L1
         CdL32ZttDny71oq2Ax+a5IZsJQjtPs5bPlMz2UVgiJFPMErHyphxRPSYpdUpws3venc6
         Zjrfc5up82eqBMsNJAD+tiNav/gnENmqLgVoLfGYzaM3JVn/845g2+sxJgFyVjrSLRoG
         sxGg==
X-Gm-Message-State: ANhLgQ0dKFzJ/HoszJ45+4zByJBUWGL+y3ZhX+/A3mGSiZcsAprEbVHT
        xLQWMLuj96wHsrNErNmUsce/N/JebPy54DHMmUOM6w==
X-Google-Smtp-Source: ADFU+vvCkt/oMnQzN3IFjfQIOnsxcbtfBjZKvB+whQOCB12Ag8K7ov4Os1+7zDXZl/j+vOqCKXAOBKogHskuiE7+Kqo=
X-Received: by 2002:a63:ff59:: with SMTP id s25mr12612787pgk.159.1585073554861;
 Tue, 24 Mar 2020 11:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com> <20200319164227.87419-2-trishalfonso@google.com>
In-Reply-To: <20200319164227.87419-2-trishalfonso@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 24 Mar 2020 11:12:23 -0700
Message-ID: <CAFd5g44XDamNNib1=a2Zxm7R3WUbbAF4u0jiWZoYMSQbPKKOyw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] Add KUnit Struct to Current Task
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 9:42 AM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> In order to integrate debugging tools like KASAN into the KUnit
> framework, add KUnit struct to the current task to keep track of the
> current KUnit test.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
