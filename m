Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E7C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194F520409
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPRW99hA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCQWdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:33:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34966 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgCQWdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:33:47 -0400
Received: by mail-io1-f66.google.com with SMTP id h8so22887508iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvAdYw4fS600A+JVAE7LKPXcNd9T31jIcg4Py5krm8Y=;
        b=TPRW99hAnWE2ZGh2vmb9HTczhiq9tUQTqVf+sC5gMSeQsLZMFwNEJ0pR4+3TgaO3v7
         XdD4oH3K4ujfB8WRxvraLywLrKvh135aAWiJJW6TASkZY4zn+EheNAnWb1nb47pynNRn
         yOC7v/wQXx+TBPbhPEMmBdMyWCmVqOJf+JmfBVIcmIYPJEZyav+ED/xQlUsOTCLA/OYp
         YzJNymWevujGb/qDCCvrrn0b/WWjVaX7G4ZEyZEO/oPXngBPSGyNybe+1kt6cTg4TwGD
         bd9I4S2beWK0J5/5KoS7Cou36/XlHtlmRmrNryTGqPW5PxNMS0mc0+w0BrmvRo0dwnM7
         KvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvAdYw4fS600A+JVAE7LKPXcNd9T31jIcg4Py5krm8Y=;
        b=lVsSHFA5zwSunbL0FsMwapJ6zLm5icMEJ3WoAP6fOfQsD676s86nuskqdDL1fBIQO0
         8Cx4up6msfA7k8UJCJlyvjDMBWtFt63pQyQ68p/0oGOSoDzGUAHU6h4mPVzCYO0o7yRo
         dAoM4BfcnBhD3ArULSwkli3R+piT7KNL2Zfcso3KraVrHKDx5QESkEemBw+3qH1oQwFI
         2XxOp+yC0cwSUHelJ4oHb/0ja5DzDSRg5FNSXCX3cKOmcWySfBiLkaRRFtSzVI2iOblD
         AdlVr/88XuFMjP4Y8UJnJgE4Vt+IoQbbnAFYu6c1gLZh8hyCcRtyrRqTJKBeztTOn9FE
         MJDw==
X-Gm-Message-State: ANhLgQ3vOmAto0YMjNCc3AsI9VB5G2wtqJKTmX+BpdrJMDcI4TBRFxNZ
        ATb3KffXTedCSFqODh21SkcfKv5Igljixasd6uc=
X-Google-Smtp-Source: ADFU+vvlF5toJI/zhtnaIq6lXpuTA5F/A4opcD1BwMtyA0nytsNRJyZcOxOMGLkC0gc1fnlWiibOQo0iltl5EAmBbEU=
X-Received: by 2002:a5e:990f:: with SMTP id t15mr985272ioj.153.1584484425016;
 Tue, 17 Mar 2020 15:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <1584343103-13896-1-git-send-email-hqjagain@gmail.com> <20200317170243.GR2363188@phenom.ffwll.local>
In-Reply-To: <20200317170243.GR2363188@phenom.ffwll.local>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Wed, 18 Mar 2020 06:33:34 +0800
Message-ID: <CAJRQjofSWYR--4V_4zmp6K9WVtqShdzpGuH1VFBPvHpViGYH5g@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/lease: fix potential race in fill_object_idr
To:     Qiujun Huang <hqjagain@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 1:02 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Mar 16, 2020 at 03:18:23PM +0800, Qiujun Huang wrote:
> > We should hold idr_mutex for idr_alloc.
> >
> > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
>
> I've not seen the first version of this anywhere in my inbox, not sure
> where that got lost.
>
> Anyway, this seems like a false positive - I'm assuming this was caught
> with KCSAN. The commit message really should mention that.
>
> fill_object_idr creates the idr, which yes is only access later on under
> the idr_mutex. But here it's not yet visible to any other thread, and
> hence lockless access is safe and correct.

Agree that.
Thanks.

>
> No idea what the KCSAN complains about safe access like this best practice
> is.
> -Daniel
>
