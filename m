Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FB8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE7920801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TbLhWGSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCEWUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:20:19 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39866 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgCEWUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:20:19 -0500
Received: by mail-vk1-f195.google.com with SMTP id t129so69178vkg.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2AxTBoBmJUCg/vc71mp7BK/aApbrb7OsDakNbxg7J0=;
        b=TbLhWGSZmSAIAobknaUu7mIX+dWWL4Ms/xJLOdVvP8WkDDOt8BXNWLxlsDoFJQwNcX
         AP+hKWljaB6OUMDEgbTpZOauzuBKrpGPDLTemFYL162rQmh0bRh3cTIYS1y9ymU5MC/c
         3zfG1gK2xl0FfLEHW5RF7D4NU+JtfZIfNppNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2AxTBoBmJUCg/vc71mp7BK/aApbrb7OsDakNbxg7J0=;
        b=h7PFOT3D8F1HRsaLPtbO195GyhoakWId4NG2iSCHsSRhiSAyzzmNfUYcsKvQq+fNq5
         9AKyJXn/BNp4FzQZE/08LJrDSLURJ185pB0JoPDasn+z1pspryLqa7g6MI6Bt+PxBS8k
         CX4Iyu61WMItpAGheKkaa0WkGcTDqW6T3LuLtEQFJrF7DGpF+r7JGkjMt0pjsGfIYf4e
         Ghu5Akqe/w5zDXhz+aaZk55R1E/Leyx2L8RjTY3dRl9eqH5IxXs8PmLTIwZ/HoWqfV8X
         rsqowEqxBqOOw/l0wiqV9WGU/J39sbYHtMe5EPYt+thwSJRUDlNnAlE3irYUHWlRdPhX
         x3aw==
X-Gm-Message-State: ANhLgQ2i/MYWrNwcEimwGb26tbMuS0Ye8XKMkw/KWAAV4fYi2yNqDGni
        kj0Zz5a+XhiozZxuEhunIv3BmG15HvY=
X-Google-Smtp-Source: ADFU+vvzcDhSUPF6AoWprZvim6mWvJGUTtr4i7qJmLAJo3AuToItzSmz1O1uORJjF+EHPwBVLyYNLw==
X-Received: by 2002:a1f:284:: with SMTP id 126mr932404vkc.16.1583446816307;
        Thu, 05 Mar 2020 14:20:16 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id x63sm4298258vkc.33.2020.03.05.14.20.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 14:20:15 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id t20so2708891uao.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:20:14 -0800 (PST)
X-Received: by 2002:a9f:300a:: with SMTP id h10mr11953uab.91.1583446814390;
 Thu, 05 Mar 2020 14:20:14 -0800 (PST)
MIME-Version: 1.0
References: <1583238415-18686-1-git-send-email-mkshah@codeaurora.org>
 <1583238415-18686-4-git-send-email-mkshah@codeaurora.org> <CAD=FV=VG2dirykoGB93s3xCW8CKJjrGDS76koTyww_gy-jv7RQ@mail.gmail.com>
 <92bf14b7-b7ae-3060-312e-74f57c1f9a63@codeaurora.org>
In-Reply-To: <92bf14b7-b7ae-3060-312e-74f57c1f9a63@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Mar 2020 14:20:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UYpO2rSOoF-OdZd3jKfSZGKnpQJPoiE5fzH+u1uafS6g@mail.gmail.com>
Message-ID: <CAD=FV=UYpO2rSOoF-OdZd3jKfSZGKnpQJPoiE5fzH+u1uafS6g@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 5, 2020 at 3:30 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> >> +                       spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
> >> +                       return -EINVAL;
> > nit: why not add "int ret = 0" to the top of the function, then here:
> >
> > if (rpmh_flush(ctrl))
> >   ret = -EINVAL;
> >
> > ...then at the end "return ret".  It avoids the 2nd copy of the unlock?
> Done.
> >
> > Also: Why throw away the return value of rpmh_flush and replace it
> > with -EINVAL?  Trying to avoid -EBUSY?  ...oh, should you handle
> > -EBUSY?  AKA:
> >
> > if (!psci_has_osi_support()) {
> >   do {
> >     ret = rpmh_flush(ctrl);
> >   } while (ret == -EBUSY);
> > }
>
> Done, the return value from rpmh_flush() can be -EAGAIN, not -EBUSY.
>
> i will update the comment accordingly and will include below change as well in next series.
>
> https://patchwork.kernel.org/patch/11364067/
>
> this should address for caller to not handle -EAGAIN.

A few issues, I guess.

1. I _think_ it's important that you enable interrupts between
retries.  If you're on the same CPU that the interrupt is routed to
and you were waiting for 'tcs_in_use' to be cleared you'll be in
trouble otherwise.  ...I think we need to audit all of the places that
are looping based on -EAGAIN and confirm that interrupts are enabled
between retries.  Before your patch series the only looping I see was
in rpmh_invalidate() and the lock wasn't held.  After your series it's
also in rpmh_flush() which is called under spin_lock_irqsave() which
will be a problem.

2. The RPMH code uses both -EBUSY and -EAGAIN so I looked carefully at
this again.  You're right that -EBUSY seems to be exclusively returned
by things only called by rpmh_rsc_send_data() and that function
handles the retries.  ...but looking at this made me find a broken
corner case with the "zero active tcs" case (assuming you care about
this case as per your other thread).  Specifically if you have "zero
active tcs" then get_tcs_for_msg() can call rpmh_rsc_invalidate()
which can return -EAGAIN.  That will return the -EAGAIN out of
tcs_write() into rpmh_rsc_send_data().  rpmh_rsc_send_data() only
handles -EBUSY, not -EAGAIN.

-Doug
