Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9C5C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD352087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IirgN5uP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgEGALD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 20:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgEGALD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 20:11:03 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD115C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 17:11:02 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e10so2237547vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 17:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqsJ4w8SiNdYvs9i1O1oWTJDswwPt7gmDaN1Zm1BZ0o=;
        b=IirgN5uPNEkXVYW+TZDoNzKiLHCgEcf/Gvpo4Jq41Gwh+NhrB/yfrnGR3HodSUIUhd
         QZKBk14ylHtCo38AykpM4c/IUhnD2P4qVASnG0qtJtZwgUG2jSKcxJ7k5fsG4OSchZbg
         PKxQo8IGYwFPa5xgd73MGzlBnay+Myfz0dQKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqsJ4w8SiNdYvs9i1O1oWTJDswwPt7gmDaN1Zm1BZ0o=;
        b=rnvDrK3GRs7LmbJRPtCztQ9ybICMSQ+pQo9am2SUbwyoXbKp9B4YbByeqm0dMknkBR
         XIPD1KCQnWBvmFGk9iMx+3MCxPpd4q22j0Sj0uA8fdj8QUS57X8C8GL+HCSbofgGzjLq
         oT9i1pkzqvysLyvfiQksBgJPP8pbSaIB912BUqvlzkiVbh6wpbsbaTRsn4BHYDrGNL8i
         L+iQNGmFjC8Zw9pGG2+Gh+HBZgD/jbY1SQ892o/8PReijMy/SlI2dxBLxu03ETdWqlR/
         mAuEWv9GNo9nRzychh5/+mrxJII0zPGvEy7Q+AyOP8GunfpmLtrmIWXLMPNlC+0kjhkH
         SQmA==
X-Gm-Message-State: AGi0PubZCxrx4W2523QJPLVojlsHJT8LUW5aushveq9Sa/3n1fsj+h9T
        C5Ei1hB7TY2rnkhXJtfpr3qNci3W69s=
X-Google-Smtp-Source: APiQypKpx56xydPVXqq+QE/wn9d6xBZIbYC8t9n4P6ff8IY5uaW3WJndgf0ln0u88oEcK2akV+SuGQ==
X-Received: by 2002:a67:80d1:: with SMTP id b200mr9993580vsd.76.1588810261612;
        Wed, 06 May 2020 17:11:01 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id g13sm1787347vkm.52.2020.05.06.17.11.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 17:11:00 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id b14so1027513vkk.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 17:11:00 -0700 (PDT)
X-Received: by 2002:a1f:9605:: with SMTP id y5mr9318997vkd.75.1588810260347;
 Wed, 06 May 2020 17:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200423095531.9868-1-saiprakash.ranjan@codeaurora.org> <CAD=FV=W=d=KrTwgMOO-ukFc7ZhkE92qGYumUEDrtjmhQOpdWbg@mail.gmail.com>
In-Reply-To: <CAD=FV=W=d=KrTwgMOO-ukFc7ZhkE92qGYumUEDrtjmhQOpdWbg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 May 2020 17:10:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U0Hhae3D1-P8kbcZafHeuqng11BNAbOb2YWPx+M7X5Gw@mail.gmail.com>
Message-ID: <CAD=FV=U0Hhae3D1-P8kbcZafHeuqng11BNAbOb2YWPx+M7X5Gw@mail.gmail.com>
Subject: Re: [PATCHv2] iommu/arm-smmu: Make remove callback message more informative
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 23, 2020 at 7:35 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 23, 2020 at 2:55 AM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
> >
> > Currently on reboot/shutdown, the following messages are
> > displayed on the console as error messages before the
> > system reboots/shutdown as part of remove callback.
> >
> > On SC7180:
> >
> >   arm-smmu 15000000.iommu: removing device with active domains!
> >   arm-smmu 5040000.iommu: removing device with active domains!
> >
> > Make this error message more informative and less scary.
> >
> > Reported-by: Douglas Anderson <dianders@chromium.org>
> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > ---
> >  drivers/iommu/arm-smmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Is this patch waiting on anything in particular now?  Do we need
reviews from Robin and/or Will?

-Doug
