Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A5AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B790F206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCwkbeqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgFBTko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgFBTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:40:43 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C1C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:40:42 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id n31so4803ooi.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j41qRERVmEnkxgberq7H033Q0Z1/UAOYwaQZWgqzAJ4=;
        b=iCwkbeqxlME3by8M0AWWiEa2NfnYmgUVW+2dhKbcgFfwD6fYkQHekNM9vC8F7e9C2Y
         TlMvIBcp99ZJ/+DdztWI3TVhLNKROlrIKGuWIS5haWhblnHshEdJEeEqQqr4vQ3Yz8Nr
         FpXUdBRB7Wbjme0y4/ok8n3J6WCbF31wgBPwOridjSntrocUVoyT2jWoW58+86b3Ntiy
         UXXJfftBNVBqmmA0FJWh7lSY8wM6AbQpe+o5DfgPQSGlOSd/+fe/4dkM3QfrKOU63Scy
         k44lZrrM2DOKXDBMhOdlcCqPM6TK1DdYcwb93d00pBnX6uKaWui/ZgUs4DxEZwXprs2z
         L/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j41qRERVmEnkxgberq7H033Q0Z1/UAOYwaQZWgqzAJ4=;
        b=EHlDfwSo+SaG+iteqOJ7Rjp6sGker+18kTDyC8aHlqfo2nbLk9gXuUMyIviofsnoS/
         vacLx1ZF2XvsJfwSpKaz0sATnFj25K1fe5dh8n9ZE8mzIFZ6RJPHU5ux5IXwTiwAnwVD
         8ytcP3kzYkYT+dK+AfWEt6gFEvEWT5g+qTZp0mRymaIRcJlgZ2g+7AJrOekkoc8EKKkm
         GNqV3SSGzGwqGmHKu6Aftf9gSwIBNO7tPvxD+1RMB7+4nQFZ+iuNPbnMHC4E8SAALKPq
         VVLNK6qnGBruuZVszyxriEGlmXYwToNOmoCFEKNykZJlVJf6aBmBD+8mQW5VOWcLj5D0
         W/Ug==
X-Gm-Message-State: AOAM531flYnAMzoUZs4j6B2+uQhpS2hmBAQTO9u8D/WbuOCUmvug2Zr/
        zetmlK95dZfIoIZBetUtuNpODXER4KelQ49e+wQ4ig==
X-Google-Smtp-Source: ABdhPJwl8Dv5pM/yCDtM36J8Y7/4B7NKAHZuFPlWnYchxfk/7+mvKVTRdGg8LnCdHNPQys50XsLIyHmztTMpaBCrEzo=
X-Received: by 2002:a4a:94d1:: with SMTP id l17mr5960738ooi.88.1591126841669;
 Tue, 02 Jun 2020 12:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200602052533.15048-1-john.stultz@linaro.org> <CA+ASDXMbNvbBdsC11dzUPX7RkMFYhJev2npPsRD_SnGQB+1hag@mail.gmail.com>
In-Reply-To: <CA+ASDXMbNvbBdsC11dzUPX7RkMFYhJev2npPsRD_SnGQB+1hag@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 2 Jun 2020 12:40:29 -0700
Message-ID: <CALAqxLVA1ZQjwEdbX5KGbSyLnMBAzm9PoN_Ta_Z7rBf4w3GOvQ@mail.gmail.com>
Subject: Re: [PATCH] wireless: ath10k: Return early in ath10k_qmi_event_server_exit()
 to avoid hard crash on reboot
To:     Brian Norris <briannorris@chromium.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rakesh Pillai <pillair@qti.qualcomm.com>,
        Govind Singh <govinds@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 12:16 PM Brian Norris <briannorris@chromium.org> wrote:
>
> + Sibi
>
> On Mon, Jun 1, 2020 at 10:25 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > Ever since 5.7-rc1, if we call
> > ath10k_qmi_remove_msa_permission(), the db845c hard crashes on
> > reboot, resulting in the device getting stuck in the usb crash
> > debug mode and not coming back up wihthout a hard power off.
> >
> > This hack avoids the issue by returning early in
> > ath10k_qmi_event_server_exit().
> >
> > A better solution is very much desired!
>
> Any chance you can bisect what caused this? There are a lot of
> non-ath10k pieces involved in this stuff.

Amit had spent some work on chasing it down to the in kernel qrtr-ns
work, and reported it here:
  https://lists.infradead.org/pipermail/ath10k/2020-April/014970.html

But that discussion seemingly stalled out, so I came up with this hack
to workaround it for us.

thanks
-john
