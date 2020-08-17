Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C953AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A2A2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i26RPy8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgHQJGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgHQJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:06:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03740C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:06:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so14182582wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsQytDv8/dEfj1bA849jKRxwXtyWvhBDr+drAJKXEGw=;
        b=i26RPy8i3hnvmfRyR1lD5hiwhraNpLuRUaRjs3kujKm4DkFX40kTG0Ds329YiooroF
         gN+RLEm+N0PULjiMhdFdDUb9dyWNdrdjeQJvnK5R85q5o1Zbr/nmyCa0BkWnt+ZLkfbC
         ms65YmWWeOu45eJKHPVDj7BYkHfU5QqxQlj0lk+nYeZSt5EV+HKJD5g7R6ZiWQs6TqgL
         p3AX1uhUoNegDdXS4sOyW1ZCdc6pwa34IbLvz4HGd8jd+BVrcfCih5RBPSCQ1AUcIrgu
         o/R88boP0/lv6Rw1mtvvmulfUNnt7mJIkvbSnWTk5/WX/RUD7InnegT0ag2Ipjzi7Biw
         9S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsQytDv8/dEfj1bA849jKRxwXtyWvhBDr+drAJKXEGw=;
        b=UJ3DbExEGRrm7idbRCfxNBTAHgC/9OFtscZmjUeKl5NRukf/DFbkg2rbne5+jWzjHc
         Y93+/+fvsr/LFXrz3PSVitCCVXx1H/x6Y/4UlltVwT3NkvcjiERZ9kNr1vDQOiq69LHx
         DnYyP4QWzO6rjYej9aMsn3wbD4Lyz48BEsC7kXWBEct8e85qZzd0jFi62po/Nra8sPFC
         GZPo7ggpRGdcZeoWtgmFGQzrz9govUYArT0rQKRrm1TiV9F/hvHMVIF7XnVJkyto+VCi
         84p2iBZEQr4/0bB0nUM/Q36uaxGYpgrBInjfOCYIeeqNwUqwiAulU/YcexEgH6k9atWz
         gymA==
X-Gm-Message-State: AOAM531sCarLsEEPlCMZX+cuTBJXn1K01D9fFovAFfIen5IbGRFNvSy6
        SYfvhd//A7IZJk3rxzF1crNp7fag/HTDmmA9AaU9nosx64iKew==
X-Google-Smtp-Source: ABdhPJzdXvTcKOGOWwX7yjxrGOhoE4DIBZJT+lMxkzKP2Lj4yJJ/2SrXl5dv5UCJEh4tAFqRifKePzPB8VKsJRfHEus=
X-Received: by 2002:adf:d84f:: with SMTP id k15mr13770882wrl.176.1597655205704;
 Mon, 17 Aug 2020 02:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200602052533.15048-1-john.stultz@linaro.org>
 <CA+ASDXMbNvbBdsC11dzUPX7RkMFYhJev2npPsRD_SnGQB+1hag@mail.gmail.com>
 <CALAqxLVA1ZQjwEdbX5KGbSyLnMBAzm9PoN_Ta_Z7rBf4w3GOvQ@mail.gmail.com>
 <CA+ASDXPddgOvEX___unx7N2YsQctsZN+1vkwPbi8Ab_zfwFfzw@mail.gmail.com>
 <20200603002715.GA5349@Mani-XPS-13-9360> <87zh9diyam.fsf@codeaurora.org>
In-Reply-To: <87zh9diyam.fsf@codeaurora.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Mon, 17 Aug 2020 14:36:09 +0530
Message-ID: <CAMi1Hd3FBRrwysMX6NLhKzjDukm-YPooR7LX64i=HJHDD8_Dvw@mail.gmail.com>
Subject: Re: [PATCH] wireless: ath10k: Return early in ath10k_qmi_event_server_exit()
 to avoid hard crash on reboot
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Govind Singh <govinds@codeaurora.org>,
        Rakesh Pillai <pillair@qti.qualcomm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020 at 17:07, Kalle Valo <kvalo@codeaurora.org> wrote:
> > I don't agree with this. If you read through the replies to the bug report,
> > it is clear that NS migration uncovered a corner case or even a bug. So we
> > should try to fix that indeed.
>
> I'm with Mani, we should try to fix ath10k instead. Hopefully we can
> find a fix soon.

Hi Team,

Any updates on this? I can reproduce this hard crash on v5.9-rc1 as well.

It is not a blocker for us because we switched to a userspace
workaround, where we do not wait for modem to shutdown gracefully and
SIGKILL it instead, during the shutdown/reboot process. But I'm happy
to take a swing at any intermediate/in-progress solution available.

Regards,
Amit Pundir

>
> Forcing QCA6390 users to use the userspace qrtr-ns would be bad user
> experience, I really would want to avoid that.
>
> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
