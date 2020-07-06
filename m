Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7D3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35EDD20739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB9uuie3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgGFXQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGFXQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:16:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54788C061755;
        Mon,  6 Jul 2020 16:16:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j19so12224541pgm.11;
        Mon, 06 Jul 2020 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wjnDV//qYF/ZCubL/oPxVcBFiRsZBraBEwETc9VaC00=;
        b=bB9uuie3aMELJ6i+maNmqJ8wLnlz79YpO2xoXfVk6VltMr3eACUTswNuFGnytiQZF6
         vIto6DiwMw1F9diUqW6Ar7fQKh8orUk40jmYpDfY7BszgnqHp85Gb938CH94pAjHz43k
         TcW9KrsiTBZQX2Ob7rKIMJ7Cusx1NOB/JIA2nCNLsfuz0YXNJhM8kFUgDca6gHy8xp9S
         qqXZS0iupaB5gNIscg4171g7MoBzdyKORAtWMTEsREQJyPp9OhPVIyeYXbwWOa6xLa3l
         O9A/BU3MtF/Wy8ss0enCiYI91zqnB06EaiEHmrAFqt5P3Ee+4OMqpjvh+nlEVTWJQA0F
         jsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wjnDV//qYF/ZCubL/oPxVcBFiRsZBraBEwETc9VaC00=;
        b=R9t7a1NWaXgbaVbbpfcYNhXCXjPag300avXa50J40SDEOOPv39jk35U6cpsYAQGfej
         FuheM031XUMKPj3+KA8JE+rLsZxE4OkUaEchJI7Yll8iF5vjyv3EoJKHhokxmAN7dSII
         F/OMRbejTKuO2xtQuhcyIyFMnVgvfapyt5bWux5BREXk0g/PvK1Nmx8U4hWNfQENuc6v
         K9O8K2xb09axfF9ZxKX9l/nCJt3fljRlYI8TsWuVXoUBhHKrEdM3PJ8C0K/5+bELULqm
         IVMR2keHdUdVEjuma0DKXkmWRyb7wFyovob+uerAaKTjdFV3zrnBQXOF/NbesnwPU3t1
         oCzA==
X-Gm-Message-State: AOAM5326LUnHBl0mkFPYnSj1lE5gMV9MkD5yf9mXcDhbkSpza10gCiTp
        a39oEMw2nKCJ0MVUGPNNQfo=
X-Google-Smtp-Source: ABdhPJzGtOaCws2MIogXUtYVzIz1tLZ2oSBPDjqOo8PyozNdu+Q9V1zCt3+Bgqsi7V8WFzsV8bCtVg==
X-Received: by 2002:aa7:9639:: with SMTP id r25mr39402789pfg.79.1594077395924;
        Mon, 06 Jul 2020 16:16:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c125sm7788537pfa.119.2020.07.06.16.16.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jul 2020 16:16:35 -0700 (PDT)
Date:   Mon, 6 Jul 2020 16:16:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     Kais Belgaied <belgaied@google.com>,
        Jason Ling <jasonling@google.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhongqi Li <zhongqil@google.com>
Subject: Re: [PATCH v2 1/1] hwmon:max6697: Allow max6581 to create
 tempX_offset
Message-ID: <20200706231634.GA193886@roeck-us.net>
References: <20200706221001.1996816-1-linchuyuan@google.com>
 <20200706221001.1996816-2-linchuyuan@google.com>
 <CAKCA56BUZ29ahLDPN_Atqn_PGUn5hA7FoVAC08qYnXwOzOuRwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKCA56BUZ29ahLDPN_Atqn_PGUn5hA7FoVAC08qYnXwOzOuRwg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 03:46:20PM -0700, Chu Lin wrote:
> On Mon, Jul 6, 2020 at 3:10 PM Chu Lin <linchuyuan@google.com> wrote:
> >
> > ---
> >  drivers/hwmon/max6697.c | 100 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 96 insertions(+), 4 deletions(-)
> >
[ ... ]
> >
> > +static ssize_t offset_store(struct device *dev,
> > +                           struct device_attribute *devattr, const char *buf,
> > +                           size_t count)
> > +{
> > +       long temp;
> > +       u8 val, select;
> > +       int ret, index;
> > +       struct max6697_data *data;
> > +
Where possible, use reverse christmas tree order (longer lines first)

> > +       index = to_sensor_dev_attr(devattr)->index;
> > +       data = dev_get_drvdata(dev);
> > +       select = i2c_smbus_read_byte_data(data->client,
> > +                                         MAX6581_REG_OFFSET_SELECT);
> > +       if (select < 0)
> > +               return select;
> This is always false due to its type. This error is caught by the
> kernel test robot.
> I will submit a new version to address this issue.
> 

While at it, watch out for new line length limits; the limit is now 100
characters. Line splits like the one above are no longer necessary.

Guenter
