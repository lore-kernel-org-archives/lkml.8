Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A90C2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A75120936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G4q9KXso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgIHUuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbgIHUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:49:57 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5E6C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 13:49:57 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a65so395524otc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoSQAwVM8O1hGcY9QbkiTZZ+wX5qFR4tgBBCr4zK6gc=;
        b=G4q9KXsoVWjFo1yfWah0XOvDMKKhbO6/pYmh3TuTkdj2y3H0X2x9mToCv9vPUQEMzi
         +yX6E5wgORsLlIgUM+Hlv916qks9eP6hUwYTwsb1oyDvxDdxz1qQEcItmYY95XZkQx0Y
         oz91YkTKLsUW4S2+hZdvRZJqyZWtRTachOcyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoSQAwVM8O1hGcY9QbkiTZZ+wX5qFR4tgBBCr4zK6gc=;
        b=HrZ59Ixw6IkkCVDpPti00/lxlWjsT3wI1r+4bFVJH0u1Eg/ueQK9slIPB4kmlmOu97
         ET5OycZyswlAGYqDexJ/dBztlpn2wMU0ZLnZHOLyAj99c3xlSUUxnP2suWohT1IMZ55T
         0c41H4XIM8mux7gr7UtcsQrBAFuEjXblYa4QATFFwPYUUnyt10rvTBL9DFallJdjPHWv
         JnYnc0d1NZ5o0/paJxXQEjqhTuHuIM8XcNIuzce5aaXJhSvcyUjqukdRASQQQ51ZUNZA
         61pinAiR53SBmUCEw0HxFOMTa+cvKy4n62cPb1UbXeS2qf1mLXJkTOcxvKQxzqz5lbOI
         L7tQ==
X-Gm-Message-State: AOAM531VEuLgxEOC9+n+xgPHjOAjSUpBaYTGOOZNB4oRU0zlvwnGHIky
        del4zzhTz5p5N7whNYLXvm79PcZ+BQpZL9cZd/mkYBke5BQ=
X-Google-Smtp-Source: ABdhPJyJt9Rt0B4lyD0AkxF+1Ro4wJ/4KYHDHCEMfBW/IpC3QiRIiciKIY9vSc/SBpKtIDWuU/abMl9huChAFCRJMTc=
X-Received: by 2002:a9d:908:: with SMTP id 8mr671619otp.356.1599598196384;
 Tue, 08 Sep 2020 13:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200908152221.082184905@linuxfoundation.org> <20200908152222.792503974@linuxfoundation.org>
 <20200908194723.GB6758@duo.ucw.cz>
In-Reply-To: <20200908194723.GB6758@duo.ucw.cz>
From:   Edwin Peer <edwin.peer@broadcom.com>
Date:   Tue, 8 Sep 2020 13:49:20 -0700
Message-ID: <CAKOOJTzmLvd15tbRd+hzkWnmU3MyWyLTuOoB8-x9j7RLC51KfA@mail.gmail.com>
Subject: Re: [PATCH 4.19 34/88] bnxt_en: fix HWRM error when querying VF temperature
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Marc Smith <msmith626@gmail.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 12:47 PM Pavel Machek <pavel@denx.de> wrote:

> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -6836,16 +6836,19 @@ static ssize_t bnxt_show_temp(struct device *dev,
> ...
> > -     return sprintf(buf, "%u\n", temp);
> > +     if (len)
> > +             return len;
> > +
> > +     return sprintf(buf, "unknown\n");
> >  }
>
> We normally just do return -EIO (or other error code) in such cases.

That does seem more appropriate. I will fix it, thank you.

Regards,
Edwin Peer
