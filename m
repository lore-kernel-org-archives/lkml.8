Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4CEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D93722074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wctvwvbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgFEWBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgFEWBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:01:32 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAFDC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 15:01:31 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id i74so9531360oib.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1cuZ3dzo56RdjEfW6iqD1ChG7OM1Jr7mC+hansXCwI=;
        b=wctvwvbpWO1A1HCjf/NHUA3VKLb5qBQsLSG6vVcEV3AWM99wCt/t8bgr2xsa6Hk7Pw
         FoUbstWwodSnAdG3c+eMacQJQvEmMP2TY2QIiwIVwBj+0OQsu24EpdyuKKSmzX6b9i/o
         loX3DhQ/9MJ7SYog2deugw3Ml2q7CcwOz8YQ9lCObg7BJt+Tpn+wPMEqHbE/Wb9tIHWV
         CygJCr4VBKseGwmlIAftZcoidaNeP7NUK6HkBoA76D0NjGAnICxM+rueoHJcEsVxx07T
         TTh/6DhSDCJv/tT3Hc2nhaal8XJTYm0Mu9AmOeRjJXT0VQ8jnm0Cb1WMvkuDiRg6anOA
         FdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1cuZ3dzo56RdjEfW6iqD1ChG7OM1Jr7mC+hansXCwI=;
        b=tjgb+e490H+TRyDskQ4uYK2wFc8ADVqpD9DvbtCK7yzm3zmzFPQEcL5mIE6m1yf/WA
         VNpt4L84+4aWxPjKy7GgnxX8P2BYZjP0dyjjh4r9c++eRm008EQ15ICq+Wel7kbCOD0i
         LPGq1bJdpUQiYTj/VeFYCfs8kpZhKUI0r06JkCKxUF2v7ok5fvuV7O2qngLvuWw1gjSo
         99MsLSpMqAscZVL/RHuwf5SK3acWMWhQ1QK0/NFO/JxDGTburONuFm6ZJzdKKrIvHr8c
         IjrvjkCShJtNUUVEG113v6u1XE/tiRk80nFPIw2Hwom2Caty9+YBZO8ri3MbXwEIbtB+
         zEow==
X-Gm-Message-State: AOAM533gQtUE+32QJZPWfants8WP6IP8gNPcBgW8VSD6IsCYH4EHS07d
        y+T72sIL1FGbquJHbWQB3AazyQHYA6cNJtdrFg4/YieM
X-Google-Smtp-Source: ABdhPJwi5IpaSvy3MP1LOrYYG2rZ0azcMzKLT8zxF9+F5mK4G2RYc0gGq16RDrvuQQ1nT4XJ8KX9okz2nfXdGIYijBc=
X-Received: by 2002:aca:48d7:: with SMTP id v206mr3279211oia.97.1591394491145;
 Fri, 05 Jun 2020 15:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200605211925.87873-1-john.stultz@linaro.org> <CAGETcx_-ZknGcGJQMesLFWAwUyidK00-6bqF6ZZPbyyYtSPcew@mail.gmail.com>
In-Reply-To: <CAGETcx_-ZknGcGJQMesLFWAwUyidK00-6bqF6ZZPbyyYtSPcew@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 5 Jun 2020 15:01:20 -0700
Message-ID: <CALAqxLWRXNVTYU4m58mOjb1F2gFHLDbabpqT-BvuHK4Hw1FcdQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] slimbus: core: Set fwnode for a device when setting of_node
To:     Saravana Kannan <saravanak@google.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 2:44 PM Saravana Kannan <saravanak@google.com> wrote:
> On Fri, Jun 5, 2020 at 2:19 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > From: Saravana Kannan <saravanak@google.com>
> >
> > When setting the of_node for a newly created device, also set the
> > fwnode. This allows fw_devlink to work for slimbus devices.
> >
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Cc: alsa-devel@alsa-project.org
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
>
> I thought Srinivas already picked this up and sent it to Greg.
> https://lore.kernel.org/lkml/20200511151334.362-1-srinivas.kandagatla@linaro.org/
>

Oh! I'm sorry, I missed that! That's great to hear!

thanks
-john
