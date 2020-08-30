Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C794CC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D67E2071B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvWUDcgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgH3S7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 14:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgH3S7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 14:59:02 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9DDC061236
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:59:01 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id o2so1894853qvk.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lUMKQLlBSJCarKsSu0GjI45SsOuLiQU3I20h0koncyY=;
        b=WvWUDcguQ3mKtncotDNXG+mBPq9NyvJv9t7WpxvwJ96ZIj6fnKG2qm6ZK8LIqVQAr+
         kYOvS0hYk8MXGbZucOJqZJKKUDQ6tj/dr5bGEaYICOO2pIbEj9Rm5xWZDJOBIS6RlOL7
         ngPuGNcAIgjrI7fWarHAncCoHq21UoDkbGfwkeQ9O6gc0SAv5oHS6N8k8kvbP7yFqKUr
         yTDkP9ELUKo9roSiT+rEP+wYlDVeVLGGSd9gE1OjCWchS1e4YlTAaiGzYqfw5lcLFFVo
         jVPIQko0qxMHSHXZeeGRkU+iV3Czu8PZydpLfptDKlw/UldaEFGp7A8VxDJV8vjirIe3
         xgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lUMKQLlBSJCarKsSu0GjI45SsOuLiQU3I20h0koncyY=;
        b=c6eFuvZa+CD/OlzIH8ta85whx86q7wk1QwUGkF2SVu58Ckn104/lvq29HFJzO11Smq
         G7053BG6jx4OQa8AKxDeYledJwOzEzBoADSeA42LmhXOuEdOGP6CQm9Okob2GiNORStR
         OKZCsPMTDqZRKnPi/LYR3vruN1tNQm5iiEoWkfLqzrOwDdZa9hW8tDN5aaMk4UxiLS/b
         OAWi+S07bUTg4FYbmMouFhwrIzd5owDDrU4EeQkISry59j3FP9LzaPDIL45z8Pu4zLeT
         PTIzFP2CbW4OD8CoFbV3vAuZITiBt3w45liWpVCdjW9loJ161/tyDlQB7rXPsyKsGC6C
         4KtQ==
X-Gm-Message-State: AOAM530aVkHSfD5msJbkKNBb8ZRGo6/r6NN2J8fK/rM/ST6kbQ63l0PT
        vTj4703fNXiaPx9qj07SGcjDBhO1Tk8RFQ==
X-Google-Smtp-Source: ABdhPJzVuLSEAXfc5i2H+uVW+pqJ7JPE9Po3NtUqrMnVy/uGx1VZFC8jdwxXC/5i+jNQ+IcThz62+A==
X-Received: by 2002:a0c:fdc4:: with SMTP id g4mr3795975qvs.30.1598813940154;
        Sun, 30 Aug 2020 11:59:00 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id c9sm265256qkg.46.2020.08.30.11.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 11:58:59 -0700 (PDT)
Date:   Sun, 30 Aug 2020 18:58:57 +0000
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        dt <devicetree@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: your mail
Message-ID: <20200830185857.GD1947@uller>
References: <CAMi1Hd3Dv_T7kgThLTk2QLtfS7LBvhJ5R=6C3seUYK0GvNV6eA@mail.gmail.com>
 <20200806223134.42748-1-konradybcio@gmail.com>
 <20200813070448.GA499758@builder.lan>
 <CAMi1Hd3j-A1Se9swD0TQ9YzTBGicPDc1nFZbf4uisVk5A+u1GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd3j-A1Se9swD0TQ9YzTBGicPDc1nFZbf4uisVk5A+u1GQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Aug 17:12 UTC 2020, Amit Pundir wrote:

> On Thu, 13 Aug 2020 at 12:38, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Thu 06 Aug 15:31 PDT 2020, Konrad Dybcio wrote:
> >
> > > Subject: Re: [PATCH v4] arm64: dts: qcom: Add support for Xiaomi Poco F1 (Beryllium)
> > >
> > > >// This removed_region is needed to boot the device
> > > >               // TODO: Find out the user of this reserved memory
> > > >               removed_region: memory@88f00000 {
> > >
> > > This region seems to belong to the Trust Zone. When Linux tries to access it, TZ bites and shuts the device down.
> > >
> >
> > This is in line with what the documentation indicates and then it would
> > be better to just bump &tz_mem to a size of 0x4900000.
> 
> Hi, so just to be sure that I got this right, you want me to extend
> &tz_mem to the size of 0x4900000 from the default size of 0x2D00000 by
> including this downstream &removed_region (of size 0x1A00000) +
> previously unreserved downstream memory region (of size 0x200000), to
> align with the starting address of &qseecom_mem?
> 

Yes

Regards,
Bjorn

> I just gave this &tz_mem change a spin and I do not see any obvious
> regression in my limited smoke testing (Boots AOSP to UI with
> v5.9-rc1. Touch/BT/WiFi works) so far, with 20+ out-of-tree patches.
> 
> Regards,
> Amit Pundir
> 
> >
> > Regards,
> > Bjorn
