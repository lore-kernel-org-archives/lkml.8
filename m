Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83391C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A20421919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599635313;
	bh=6ctIdj1JKPdC6u7FCrti5Jj/1OKztUwr9e2Ne0IjYFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IcuygaGTBIV+AmQRMoWHNKU70KVSkqXhjByfu/B2q1QQR8/LRymcfnY5f/Zst0EKC
	 dGG5s9Fvg+Zx+LXIS0NDB9jp1wOBan3MQ1X4NFH0yOdqpCHgOshtWTYigeQBdGqGgE
	 pAH+9hvYa+TYOua9VLenrgyJKrI8kTyplS5CZYEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIIHI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgIIHI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:08:28 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DBE821D7F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599635307;
        bh=6ctIdj1JKPdC6u7FCrti5Jj/1OKztUwr9e2Ne0IjYFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AakcNNs6EXawnDgTUjWi4myGNB/+xYkhGOpwpu7VoKGEDyTVhbx7VdJpaQa1rpxul
         8mcH7EvGLk4Q4l8foFLqkjx5VT+R5mJhIIv5DHBqofTjXNqWs4bG7xCAHLa+JxqjCg
         tLNKSWvAu9rcnCZT4ZO8DtHPVqXeqkCVV2qql2CQ=
Received: by mail-ej1-f44.google.com with SMTP id q13so1973786ejo.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 00:08:27 -0700 (PDT)
X-Gm-Message-State: AOAM5320FqIJDEPLXWy15obZmj1s2uaKIkAiJ5rDIlSOqvIwKwzFhNF2
        KFl2B7A4K1oGVsreQf0kFD+VN551+vz9PBtULP4=
X-Google-Smtp-Source: ABdhPJzlHWBFPUOqL4Da6iSu7m22b0hvyeBdFoiTJ2FO7v79JDXFknzAz9LRVhRRzppJhLuxSnQE72wKC/BprZMcztw=
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr2180768ejx.215.1599635305980;
 Wed, 09 Sep 2020 00:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
 <9635eaa4ccc1141fb0dd8c3687f46da7149206ad.camel@perches.com>
 <20200826155507.GV1891694@smile.fi.intel.com> <973f4d54da796db4fcc9b643b10889cbc8839989.camel@perches.com>
 <CAJKOXPcCAPy-v38dyY_74H_6vrgj0mmEf6KaupVKJb4E2Ha_Ug@mail.gmail.com> <20200909070244.GC311356@kroah.com>
In-Reply-To: <20200909070244.GC311356@kroah.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 9 Sep 2020 09:08:14 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd=TfCNfHPdsQZ42VEcUZOFZroXg7xmA82zSA=AbADxKw@mail.gmail.com>
Message-ID: <CAJKOXPd=TfCNfHPdsQZ42VEcUZOFZroXg7xmA82zSA=AbADxKw@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Annotate dev_err_probe() with __must_check
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020 at 09:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 09, 2020 at 08:29:25AM +0200, Krzysztof Kozlowski wrote:
> > On Wed, 26 Aug 2020 at 18:18, Joe Perches <joe@perches.com> wrote:
> > >
> > > On Wed, 2020-08-26 at 18:55 +0300, Andy Shevchenko wrote:
> > > > On Wed, Aug 26, 2020 at 08:44:30AM -0700, Joe Perches wrote:
> > > > > On Wed, 2020-08-26 at 13:44 +0300, Andy Shevchenko wrote:
> > > >
> > > > ...
> > > >
> > > > > > -int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> > > > > > +int __must_check dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> >
> > +Cc Stephen and Greg,
> >
> > Hi Andy,
> >
> > Did this patch ended up in next somehow? I am surprised because now I
> > got warnings for perfectly fine code:
> > https://lore.kernel.org/linux-next/20200909155654.76fe3bd6@canb.auug.org.au/T/#u
> >
> > This creates simply false warnings instead of hints for "optimization".
>
> Yes, it got merged into m y driver core tree.
>
> I'll fix up the tty build warning, should be easy enough, the patch is
> below.

Yes, this fix suppresses the warning but the question is whether we
really want the warning?
Such fixes mean additional code which the compiler might not optimize
(unless it inlines the dev_err_probe()). This additional code is
purely for suppressing the warning, without any meaning on its own.
Actually it might be even confusing for someone to see:
if (ret)
  ret = dev_err_probe(ret);

warn_unused_result should point errors, not "optimization
opportunities". If you want to have opportunity, add a coccinelle
rule. Or a checkpatch rule. Not a compiler warning.

Best regards,
Krzysztof
