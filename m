Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00420C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22BF20890
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590599100;
	bh=QrRQgXxxJ63vZq31dxWJOpXXtjXrN47jMut59lAdhhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uA0oz8H8oGopT+WOGQSAMx9noTfzVwTCpBVnmmTh91tsDMSyQP+2IYh1F+bbrovCe
	 zVrBOFH/rvibi24JGvC2Q94g+0tNje7ds8NMQDFvqUsgylKAns7sjvJsNt46FghpMn
	 2H9g158KnN6iYg2TGYJ5Z01DqhDkntxFyebIlK7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgE0RFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbgE0RE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:04:59 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64C4220890;
        Wed, 27 May 2020 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590599099;
        bh=QrRQgXxxJ63vZq31dxWJOpXXtjXrN47jMut59lAdhhE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZELDOLFfWjUSMiPpsOIL+bfRkPqpUhd1RzHpynSc+IqAYV3B4TQzhBDh/hjNHlaER
         zSCxTfrx+M48Wvhl+b1XI7Jog4/rPMJsw/8sd/+murItayBJzaSvAhIBcoezdlHEZV
         bVZInSDO/RWrUu6s2ZDx2C3LmOn4xuoLQftDGM4s=
Received: by mail-ot1-f42.google.com with SMTP id u23so100715otq.10;
        Wed, 27 May 2020 10:04:59 -0700 (PDT)
X-Gm-Message-State: AOAM531c5WLvn9nied//CGS5+x5A38pcl61X+eOrRkSrHgYQ6LjfZ09u
        UxEf2MoJvUlLehWC/nVDQD702AqZhl+9gcAZIg==
X-Google-Smtp-Source: ABdhPJxhrJavKUHM5x9pqsCda+ALmNJDjhk8EtNPXvR0b64+JsptO0YtuOMTTuRXh5oLXhzzBNvT36fiDwmer89Ghu0=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr5433914ots.192.1590599098693;
 Wed, 27 May 2020 10:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200511111128.16210-1-nikitos.tr@gmail.com> <20200518221435.GA6734@bogus>
 <20200525105236.GB27989@amd>
In-Reply-To: <20200525105236.GB27989@amd>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 May 2020 11:04:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJOMzjO_caip6-eXGWoPOWhPcyqfEpBXd2PLyH2OO7RAw@mail.gmail.com>
Message-ID: <CAL_JsqJOMzjO_caip6-eXGWoPOWhPcyqfEpBXd2PLyH2OO7RAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Shanghai Awinic
 Technology Co., Ltd.
To:     Pavel Machek <pavel@ucw.cz>
Cc:     nikitos.tr@gmail.com, Dan Murphy <dmurphy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 4:52 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Mon 2020-05-18 16:14:35, Rob Herring wrote:
> > On Mon, 11 May 2020 16:11:26 +0500,  wrote:
> > > From: Nikita Travkin <nikitos.tr@gmail.com>
> > >
> > > Add the "awinic" vendor prefix for Shanghai Awinic Technology Co., Ltd.
> > > Website: https://www.awinic.com/
> > >
> > > Signed-off-by: Nikita Travkin <nikitos.tr@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> I can take 2/ and 3/ of the series, but I believe we'll get conflicts
> if I change vendor-prefixes.yaml in the LED tree. Can you take this
> one?

Okay, applied.

Rob
