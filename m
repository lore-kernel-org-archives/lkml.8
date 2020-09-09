Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F94AC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D5B20936
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599632982;
	bh=rhREmvlul8Xw7KgGEYlcpWO/gk10jtWkiIJJqKDhD2I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u6e9iAJ9VeHK/643w6MllZYt4Sw3gOp2+xxC15eXV5QLwbupOeMx/HtZECQcic2rX
	 oAFeE5DQrigpZgmr6fQuRJeAfGtnrtJKaVNt4aNnlhiAyOtbvtx9si4ouqIRkdg+CH
	 4RPiZIvhfGvgdVx+QSXUl+SgYvudT1DjvePHAQGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgIIG3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgIIG3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:29:39 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49BF20936
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599632978;
        bh=rhREmvlul8Xw7KgGEYlcpWO/gk10jtWkiIJJqKDhD2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=elPHtlCW0qhn3FX48az0osgq710RIF/Ca8voVlXSBS0YLjZARlKa6VdTw3SAOu5aP
         tS11gS/tbLLLW3UZA6bNveZY6bUVZ95DTNHgeTzeTMCYDIES1zhi5q2tddxr7m+dM9
         /WyYgVELeh5kCtO98OBE0VFLTmS4zTzMYS0thND0=
Received: by mail-ej1-f51.google.com with SMTP id gr14so1900140ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 23:29:38 -0700 (PDT)
X-Gm-Message-State: AOAM533iItiOWCy5xnqQhMshIyEjsVBPYLnzR7Veti3DQJZbsddoVzml
        K6ROps4x6+yKr7Cn72DD3pMQHnA/94qGYsxxYpA=
X-Google-Smtp-Source: ABdhPJx4vB77fq3Ebnr5a5g625QyEN+A6GcGOJi31H5EEyEAFn+qLZ0JwFk8zvry5u2c+i9XYllr6c8HLNvaW22+d0g=
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr2067774ejx.215.1599632977337;
 Tue, 08 Sep 2020 23:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
 <9635eaa4ccc1141fb0dd8c3687f46da7149206ad.camel@perches.com>
 <20200826155507.GV1891694@smile.fi.intel.com> <973f4d54da796db4fcc9b643b10889cbc8839989.camel@perches.com>
In-Reply-To: <973f4d54da796db4fcc9b643b10889cbc8839989.camel@perches.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 9 Sep 2020 08:29:25 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcCAPy-v38dyY_74H_6vrgj0mmEf6KaupVKJb4E2Ha_Ug@mail.gmail.com>
Message-ID: <CAJKOXPcCAPy-v38dyY_74H_6vrgj0mmEf6KaupVKJb4E2Ha_Ug@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Annotate dev_err_probe() with __must_check
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 at 18:18, Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-08-26 at 18:55 +0300, Andy Shevchenko wrote:
> > On Wed, Aug 26, 2020 at 08:44:30AM -0700, Joe Perches wrote:
> > > On Wed, 2020-08-26 at 13:44 +0300, Andy Shevchenko wrote:
> >
> > ...
> >
> > > > -int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> > > > +int __must_check dev_err_probe(const struct device *dev, int err, const char *fmt, ...);

+Cc Stephen and Greg,

Hi Andy,

Did this patch ended up in next somehow? I am surprised because now I
got warnings for perfectly fine code:
https://lore.kernel.org/linux-next/20200909155654.76fe3bd6@canb.auug.org.au/T/#u

This creates simply false warnings instead of hints for "optimization".

Best regards,
Krzysztof
