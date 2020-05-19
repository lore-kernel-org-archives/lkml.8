Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2440A20578
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbM0FV51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgESAyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 20:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgESAyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:54:09 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D6CC061A0C;
        Mon, 18 May 2020 17:54:07 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id o67so7149762ila.0;
        Mon, 18 May 2020 17:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnlqiv3s9r+x7AGOyXDQ7LCMC4713kFG+83RL+Dc+6E=;
        b=XbM0FV51uwjGuwCvfPJ3DtOjj761r2uSKGvL8CQsQEiNIpIeVtHyinNTVL+R5yOr5H
         3Wf+6utEDu4WuO85gmBKOquLvBXBXZfvJomKt4W45+5J8grRJvo4gBaqCu6Jm3BLskTz
         sJYZGobiqz4KwPxrGfk8FqIEar/iuTozpPDNRlpb9SQkq3vxm1z2xM/RexOSEoakc1gJ
         ZkyVqYIera9PQubjhF3XMXr6PLDeEXi/rDbbCoWvr1Wd0Brvb1wiCvciyIRfXS2vVmIN
         V+QIrj894yWOkex1o9y/WFPIbeWbLAvh4d3RFgEA3XkYn77OnLClN0rvBZq8RH+HCFm7
         ijmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnlqiv3s9r+x7AGOyXDQ7LCMC4713kFG+83RL+Dc+6E=;
        b=gRaG1HLtYH1mqhzORpUTNPI+Y8J8tStLwL5+w/8pMq4MFmB1QuqJYQmHqwVWEE27xa
         JCRfxK9DCSFQadUivLpHNAUAnix6ZFNjMZmDKUOPRndMeSnXVIu8MZ59mbC4F+XiNsuJ
         VFFk+mS0xf1qju8jxs0UOfWnq5qpW4aKNdzd0QFp5JBWh5jp1EDs5y+eDdlu7MFN2wtE
         v+HHLyKAqCmWvvhsmcm1shrvaJjF3Sa8l9pjBUwV+udT39UFSDhu64esWooZjsoI5RJ/
         A9U8YLnzJphxLEg1UtYALCDcM00vd4LYNDSvjPFDEepfuCGW4W99YuAqEDb/ItMJcx5p
         M+6g==
X-Gm-Message-State: AOAM530yLRzoYxmyevfQ4SxTX8kJ9Etfi9/qoiS4E0StUwmy7c3F8mCV
        C3TJN5Ztqqoahf42ziCtiGU4PnIiXcy6J1a1uww=
X-Google-Smtp-Source: ABdhPJw+LVAblyqh5WEGkNus4/r02SgA3wpg9ey4+8hSP/xiyYYVwyAG0ahKnzbyqCdSipzburJirP+tAG5rdObJwfA=
X-Received: by 2002:a92:d40a:: with SMTP id q10mr19896762ilm.87.1589849645488;
 Mon, 18 May 2020 17:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <CABb+yY1wJMzakpz0h6ZxAh4Z3OB718f+Wq3RP0R4NZ_U=vRMkw@mail.gmail.com> <20200518073514.tjodf6qxg3wjzyb4@vireshk-i7>
In-Reply-To: <20200518073514.tjodf6qxg3wjzyb4@vireshk-i7>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 18 May 2020 19:53:54 -0500
Message-ID: <CABb+yY0vihfQSi=067AUNZd8sHACJ_4CKvFvsoCfweVuL=RD0g@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 2:42 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 15-05-20, 11:46, Jassi Brar wrote:
> > As I asked you yesterday over the call, it may help if you could share
> > some numbers to back up the doomsday scenario.
>
> Yes, I have already asked Sudeep to get some numbers for this. He will
> get back to us.
>
Thanks, current bottleneck numbers and the patch/changes to improve
that, would help.

> > > - With the current approach it isn't possible to assign different bits
> > >   (or doorbell numbers) to clients from DT and the only way of doing
> > >   that without adding new bindings is by extending #mbox-cells to accept
> > >   a value of 2 as done in this patch.
> > >
> > I am afraid you are confused. You can use bit/doorbell-6 by passing
> > 0x40 to mhu as the data to send.
>
> That's how the code will do it, right I agree. What I was asking was
> the way this information is passed from DT.
>
That is a client/protocol property and has nothing to do with the
controller dt node.

cheers!
