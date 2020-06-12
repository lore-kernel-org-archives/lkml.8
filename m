Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D378BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87FB206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F61cC8Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgFLAee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFLAed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:34:33 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBD7C03E96F;
        Thu, 11 Jun 2020 17:34:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id o5so8446475iow.8;
        Thu, 11 Jun 2020 17:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqAXLZX8TTyfYw2OboHQenLiZ8rdFnWo4aB6MdUN6iU=;
        b=F61cC8UcxjV48CcghdFLkde51ipu99aJTlc097t1fSE8p9YHX9CB8jpC64s1W+ps4V
         HT8GjqcHyIvGaiHE7H6rjSxWNZyQdKqJnBQHearjAtI4yogdfPzQjsAVE/kMULDQtb/G
         4NV9gcn47T2J70hJoC+em/Dv9VqPmCP7EFjTFGuvI14wziI298U9Rw+W17Zx1Oyp7UeK
         NcfhlKKRYeoDSnNfiJDFdQf/H2FbqB8F69bZRNU5GW02RlXd7Dckj4KdYBc1udCHUXLt
         1duD8AY3vBNRKGoyEryJOgGoLtpWYSb32p24H+FwUP6SjsdmM0msoxg7tZz31di2J5Ud
         tppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqAXLZX8TTyfYw2OboHQenLiZ8rdFnWo4aB6MdUN6iU=;
        b=ZkgktWR+3dKqoEf6IVAa9hbUK9S94qki0FudTY8thI/IIShPUXkohhUD8qFf4WM/sc
         N6KGZKkM5Od3eINud3C7ziI4hDtSRLt+t7ikim5bPCOXrEY55T/RcPF/wmbEqEH3OJLH
         gSIYqJ+0JgAsdt1TmbL/MHrDegpDfxBqlXw/pUc0ailEraK5rqV+i+7OhLXrU2VAF9s0
         N3oZKGQA1XBUTIzSQ9uGA+Vd1cdO3WqN2JvieIIjva7OFhWKAfFKzqrJh1yXOOLkMgN1
         ba8eDfLpoPWXpeFwYjR5/U5o21w5bkvR4pZWIh5zzJ/h6QcXucydryodi6QqoAFrI8fL
         2IJw==
X-Gm-Message-State: AOAM531CvR/apPVBPQeN0QL22qW/XgZ19CzkhaYKqtGzuoZHp2+6yWjP
        1g0QgaxIUhq7hhjt01BQdm3F+Ja9l+qd1pqhAeg=
X-Google-Smtp-Source: ABdhPJxnE06UePPNmfs3VQ+1tcmElRjZgtBMF5m6+O2osNGMQK9HxZMo05YiqzSr/fTz95+5ChTNvLuenG4Fv4EN0WU=
X-Received: by 2002:a6b:b515:: with SMTP id e21mr11198076iof.53.1591922071349;
 Thu, 11 Jun 2020 17:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200529040758.kneg2j4n3gxh2rfv@vireshk-i7> <20200603180435.GB23722@bogus>
 <CABb+yY0cW1GZHVmwEr19JRdJTmsAxw9uq83QV_aq-tdPJO5_Fg@mail.gmail.com>
 <20200604092052.GD8814@bogus> <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
 <20200605045645.GD12397@bogus> <CABb+yY2YZ99NjHYNi0=KLGFDsVUeJmqiJD3E25Chwk-THJV4iw@mail.gmail.com>
 <20200605085830.GA32372@bogus> <CABb+yY2TR7tuMx6u8yah6mO2GwZ5SWYOO80EQRL-i=ybgn=Wog@mail.gmail.com>
 <20200610093334.yznxl2esv5ht27ns@vireshk-i7> <20200611100027.GB18781@bogus>
In-Reply-To: <20200611100027.GB18781@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 11 Jun 2020 19:34:20 -0500
Message-ID: <CABb+yY1OwVB+uk+0w+D-4Xy46iYn8tPZYBZ0qjrzQFLA6SaTvw@mail.gmail.com>
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

On Thu, Jun 11, 2020 at 5:00 AM Sudeep Holla <sudeep.holla@arm.com> wrote:

> >
> > > Interesting logs !  The time taken to complete _successful_ requests
> > > are arguably better in bad_trace ... there are many <10usec responses
> > > in bad_trace, while the fastest response in good_trace is  53usec.
> >
> > Indeed this is interesting. It may be worth looking (separately) into
> > why don't we see those 3 us long requests anymore, or maybe they were
> > just not there in the logs.
> >
>
> As I mentioned in another thread that non-dvfs requests may be prioritised
> lower when there are parallel request to the remote. The so called bad
> trace doesn't have such scenario with single channel and all requests
> from OS being serialised. The good trace has 2 channels and requests to
> remote happen in parallel and hence it is fair to see slightly higher
> latencies for lower priority requests.
>
In the first post in this thread, Viresh lamented that mailbox
introduces "a few ms" delay in the scheduler path.
Your own tests show that is certainly not the case -- average is the
same as proposed virtual channels 50-100us, the best case is 3us vs
53us for virtual channels.

-#define SCMI_MAX_POLL_TO_NS (100 * NSEC_PER_USEC)
+#define SCMI_MAX_POLL_TO_NS (30 * 1000 * NSEC_PER_USEC)

The above simple fix (not a hack or workaround) avoids the need of
virtual channels' implementation, as per tests you conducted.

It might have been silly to not implement virtual channels originally,
but it would be just as silly now to implement if we can reuse the
code.
So I welcome new tests.

thanks.
