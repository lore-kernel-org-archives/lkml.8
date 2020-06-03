Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50323C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37964207DA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxXwEKx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFCScy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:32:54 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E10C08C5C0;
        Wed,  3 Jun 2020 11:32:54 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h3so3486182ilh.13;
        Wed, 03 Jun 2020 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dl45jHmMxgIYOcAGoeBLy9mbq13KTVnNRYfglexjaaE=;
        b=sxXwEKx+yE5ycmbktRFVRkyspOiSKTBYdrt42Z5TdrxKcSSvFIH361s1G69YU+n8bQ
         ujfYu74W0cDNv2/HVUn2SJL5Bc2tSjTTBv0U82vJ819S6ftPhZzu4m/9+jBuKzPU3UbB
         hkUXIX5ib3KEAK15lR4SFmg705G+ulluROvVRJtNd9IkVB2Kxxbj4eOXQRD3elGKt6f/
         3/E4X55YRd8+XFFLDmMETziBFzcQrshe+Z10j/G4HOYQhG/W9EEaggbeP+4/eeA4tqlt
         Oq2eI4Ch2ZLWpteLW+HARxVKk4q9gQTk82JEyQpb6vr5uXwKXfXJno4Kp/8zY1WEi8vp
         UzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dl45jHmMxgIYOcAGoeBLy9mbq13KTVnNRYfglexjaaE=;
        b=Qy7gQJ1OZ+8fKMO0y6+JIxRtikUPw9Ub2RcmMReEBRotCEYRQ+D/meMvMwmhFZ63y9
         wo48AvCFuecCCDrY0CSEbw2CR7N6Hz0AtdCc1mduDukT15oc40OJ1eI5c1JejOr7yUKH
         bmC6kGHnuGNpbE8klaqFh8CWrJDekTRRzOWcEcjPWyW1iGNZw0rjy3X4SXPbZ/by4f4n
         93a9xzNuhPeTegF+dfWi/XZ7xNKut1DtOJt3vC8fDIjYuuL6lRamvjSW9S67blWMADLm
         NRJ3ud/JYj3RamLNOth6UBouy4ig+c1/9mQiF8njNZSKlhnND8xvrF5sspTh8dtGyha1
         Oc7g==
X-Gm-Message-State: AOAM5314WLsIC7R7KfpICo2/aaexUWPheX+BvvLUnVMgRAPR95lAsB2N
        iCrY914J4vkQiv/pozfw98UIxKRVXSjQINYV8DY=
X-Google-Smtp-Source: ABdhPJzkVnkLgrwPfjugAq9hYe7HzuqLCdobQSiGG9ylo5BRV+8Cw2y7ecfxP1pak8MUWB2wjEYMRDNxI/VWlkYFcsU=
X-Received: by 2002:a92:5e52:: with SMTP id s79mr752338ilb.33.1591209173348;
 Wed, 03 Jun 2020 11:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200528192005.GA494874@bogus> <20200529040758.kneg2j4n3gxh2rfv@vireshk-i7> <20200603180435.GB23722@bogus>
In-Reply-To: <20200603180435.GB23722@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 3 Jun 2020 13:32:42 -0500
Message-ID: <CABb+yY0cW1GZHVmwEr19JRdJTmsAxw9uq83QV_aq-tdPJO5_Fg@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 1:04 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, May 29, 2020 at 09:37:58AM +0530, Viresh Kumar wrote:
> > On 28-05-20, 13:20, Rob Herring wrote:
> > > Whether Linux
> > > requires serializing mailbox accesses is a separate issue. On that side,
> > > it seems silly to not allow driving the h/w in the most efficient way
> > > possible.
> >
> > That's exactly what we are trying to say. The hardware allows us to
> > write all 32 bits in parallel, without any hardware issues, why
> > shouldn't we do that ? The delay (which Sudeep will find out, he is
> > facing issues with hardware access because of lockdown right now)
>
> OK, I was able to access the setup today. I couldn't reach a point
> where I can do measurements as the system just became unusable with
> one physical channel instead of 2 virtual channels as in my patches.
>
> My test was simple. Switch to schedutil and read sensors periodically
> via sysfs.
>
>  arm-scmi firmware:scmi: message for 1 is not expected!
>
This sounds like you are not serialising requests on a shared channel.
Can you please also share the patch?

Thanks.
