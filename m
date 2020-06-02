Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1322DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82A22072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Om1H0Oeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgFBUEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBUEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:04:43 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33693C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 13:04:42 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x22so6954067lfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwRmnpMyYSKsuBVaIf/H8HlQR4v0H9X4t/FINDNUlCo=;
        b=Om1H0Oeuuzm5pUwKfcMbsOt8vaAj1s6JaK5NLFAGjfyPxB+d2R41pm4vcvTRwOZbJw
         6t2QIqGoC2cEfXn3pIKNxqt82rqVLsvBx6eYwhSdB9Vrkz9eufuFpbZC6Aeydk8hwL1f
         e9cWaeaUDPSpFvgqJE/5wrybB8Hc2xLMOhdyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwRmnpMyYSKsuBVaIf/H8HlQR4v0H9X4t/FINDNUlCo=;
        b=bE5EC/ayiN//tdt5IA1p5/eZwA5s5uNpwuk9t7yx0fiatODbXbSIGN7DE4xkbe/9bq
         Ibl5LendqqzfFBo8VQ99im2KVuiYeWZ7ahRq+bDlsGIFvJToozyUfdNXeT+bpewx8Kp9
         5V3l/jWl960k4HUg4yt7tm+WLnIgikXcxBr+lWHad/ke76638OAi2WNeyEKKmbrNcZ2A
         ECtop3CEItv//lG/7hzexOududjcneZuceAEIAZ9SPzTXoc3K1Y7PRPhdXyuRRjbY5WE
         W4b4zGPMNEnav7Dj97r7LU190021gzvAqT4zjcgotyZftNxPFzCOT3hd40k5VmTDx17Q
         MHOQ==
X-Gm-Message-State: AOAM530tWKpldErv/VdO2tVqlNO4age6bZkRSEcdRJiPuXX5x+HLv4U1
        Khka6A1g2cyBht5FRE8VPh6u3gYLAsw=
X-Google-Smtp-Source: ABdhPJzAkJiyYkomL2OTUkG+jR9ptv9vaeAYY1MBP3CB86MrwaclR8pMDiL7UT0B/CoOn9xlqNB5kg==
X-Received: by 2002:ac2:51a7:: with SMTP id f7mr509382lfk.13.1591128279774;
        Tue, 02 Jun 2020 13:04:39 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 10sm729278ljw.134.2020.06.02.13.04.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 13:04:38 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id h188so6955625lfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:04:38 -0700 (PDT)
X-Received: by 2002:a19:c1c3:: with SMTP id r186mr509343lff.49.1591128278047;
 Tue, 02 Jun 2020 13:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200602052533.15048-1-john.stultz@linaro.org>
 <CA+ASDXMbNvbBdsC11dzUPX7RkMFYhJev2npPsRD_SnGQB+1hag@mail.gmail.com> <CALAqxLVA1ZQjwEdbX5KGbSyLnMBAzm9PoN_Ta_Z7rBf4w3GOvQ@mail.gmail.com>
In-Reply-To: <CALAqxLVA1ZQjwEdbX5KGbSyLnMBAzm9PoN_Ta_Z7rBf4w3GOvQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 2 Jun 2020 13:04:26 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPddgOvEX___unx7N2YsQctsZN+1vkwPbi8Ab_zfwFfzw@mail.gmail.com>
Message-ID: <CA+ASDXPddgOvEX___unx7N2YsQctsZN+1vkwPbi8Ab_zfwFfzw@mail.gmail.com>
Subject: Re: [PATCH] wireless: ath10k: Return early in ath10k_qmi_event_server_exit()
 to avoid hard crash on reboot
To:     John Stultz <john.stultz@linaro.org>
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

On Tue, Jun 2, 2020 at 12:40 PM John Stultz <john.stultz@linaro.org> wrote:
> On Tue, Jun 2, 2020 at 12:16 PM Brian Norris <briannorris@chromium.org> wrote:
> > On Mon, Jun 1, 2020 at 10:25 PM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > Ever since 5.7-rc1, if we call
> > > ath10k_qmi_remove_msa_permission(), the db845c hard crashes on
> > > reboot, resulting in the device getting stuck in the usb crash
> > > debug mode and not coming back up wihthout a hard power off.
> > >
> > > This hack avoids the issue by returning early in
> > > ath10k_qmi_event_server_exit().
> > >
> > > A better solution is very much desired!
> >
> > Any chance you can bisect what caused this? There are a lot of
> > non-ath10k pieces involved in this stuff.
>
> Amit had spent some work on chasing it down to the in kernel qrtr-ns
> work, and reported it here:
>   https://lists.infradead.org/pipermail/ath10k/2020-April/014970.html
>
> But that discussion seemingly stalled out, so I came up with this hack
> to workaround it for us.

If I'm reading it right, then that means we should revert this stuff
from v5.7-rc1:

0c2204a4ad71 net: qrtr: Migrate nameservice to kernel from userspace

At least, until people can resolve the tail end of that thread. New
features (ath11k, etc.) are not a reason to break existing features
(ath10k/wcn3990).

Brian
