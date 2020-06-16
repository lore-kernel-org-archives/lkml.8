Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C56C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FB320767
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Js/NziVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFPJPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPJPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:15:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5668C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 02:15:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j198so1810941wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 02:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nVaWRPrf0mAzD8+tr5PPB0PlTWZXK7ba3LZmv7ojqx0=;
        b=Js/NziVDAPwa/1WlNLLxgyV8X3ds34QZFp+R3+d5XJdgUG5yEbXCjLIZng3b4L8SZl
         bEbVZj/bpo4ny36XCa9JqO88hmkhMisBX+hleuh9lKjuXeD61LrIZ0Zl5sm3mBqTuJJt
         liZWq9iayE+ols9putsgcE424tLLs9pVuHglzuQ828ngSGj64sEl7AB/Wdy/TbBRc52d
         wADMHuv9SbmC6QlkjQ4hmkPlf4b0u+tEaKSd3wvfyVkJsOYRqTgGepO1A4XFcCaT1bS+
         Tqo4AuTNLHBcRdVXYsjGwTq/yAHsxwm97xz3pUVQu9ubl0tO9uOPumrvcO8wSZOTV8+z
         WGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nVaWRPrf0mAzD8+tr5PPB0PlTWZXK7ba3LZmv7ojqx0=;
        b=QZ+pwdXJBMgi8PbLPBQJkbA0wSTEPkrwNTLmBbMBfd22nUZqyTWG0WmOj0A17SXjuf
         a/injbYmqD290568Q8HXvhowW+AT5mHg97Ouxn0Yjnm7q/ichvmq6Z2D0XLEc8whXG04
         yW+M2sef88E8BDhanJahgMEQPvuFFVU77tr2xGaCRnfO0Cmq7Q1ytD4ZLobThUsHa+EX
         IH6gxYhmQPm8e6cSkJyD507K2sio2Wq2Zc1tL/MCtSLNYaFRdJFnJXBPLGrsl51/aSQk
         cbKnC4eXWIbUSehmJgFYGvpm4OKoCfHvGATCUdiHENX8W7UsfgtN8tXmdJNE7tlsWD9v
         a9ug==
X-Gm-Message-State: AOAM533Dc8v568sdiBNy6ntSQIoRBmG5aTO6at6UCKV/na1rC7tN7nsG
        3CChy027dmB/ZH2HlOo4OLDSW7jKvKs=
X-Google-Smtp-Source: ABdhPJwuan8p5XzcgeHe5QkcyFrisSLbs+v8puqTf7vLHafdSxvQPpO/O2FZsn8UXNKPjfVZYhxlLw==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr2015961wmj.143.1592298949734;
        Tue, 16 Jun 2020 02:15:49 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id l1sm31716690wrb.31.2020.06.16.02.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:15:48 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:15:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2 1/2] mfd: mfd-core: Add mechanism for removal of a
 subset of children
Message-ID: <20200616091545.GP2608702@dell>
References: <20200615150722.5249-1-ckeepax@opensource.cirrus.com>
 <20200616075834.GF2608702@dell>
 <20200616084748.GS71940@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616084748.GS71940@ediswmail.ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020, Charles Keepax wrote:

> On Tue, Jun 16, 2020 at 08:58:34AM +0100, Lee Jones wrote:
> > On Mon, 15 Jun 2020, Charles Keepax wrote:
> > > Happy to discuss other approaches as well, but this one was quite                                                                                                                                                                              │··················
> > > appealing as it was very simple but affords quite a lot of flexibility.                                                                                                                                                                        │··················
> > 
> > What about this?
> > 
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index f5a73af60dd40..a06e0332e1e31 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -283,7 +283,7 @@ int mfd_add_devices(struct device *parent, int id,
> >  }
> >  EXPORT_SYMBOL(mfd_add_devices);
> >  
> > -static int mfd_remove_devices_fn(struct device *dev, void *data)
> > +static int mfd_remove_devices_fn(struct device *dev, void *level)
> >  {
> >         struct platform_device *pdev;
> >         const struct mfd_cell *cell;
> > @@ -294,6 +294,9 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
> >         pdev = to_platform_device(dev);
> >         cell = mfd_get_cell(pdev);
> >  
> > +       if (cell->level && (!level || cell->level != *level))
> > +               return 0;
> > +
> >         regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
> >                                                cell->num_parent_supplies);
> >  
> > @@ -303,7 +306,11 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
> >  
> >  void mfd_remove_devices(struct device *parent)
> >  {
> > +       int level = MFD_DEP_LEVEL_HIGH;
> > +
> >         device_for_each_child_reverse(parent, NULL, mfd_remove_devices_fn);
> > +       device_for_each_child_reverse(parent, &level, mfd_remove_devices_fn);
> >  }
> >  EXPORT_SYMBOL(mfd_remove_devices);
> > 
> > No need for special calls from the parent driver in this case.
> > 
> > Just a requirement to set the cell's dependency level.
> > 
> 
> Apologies if I am missing something here, but this looks like a
> pretty challenging interface from the drivers side.  Rather than
> just statically setting tag in the mfd_cells and separate calls
> to mfd_remove_devices_by_tag, such as:
> 
> 	mfd_remove_devices_by_tag(madera->dev, MADERA_OPTIONAL_DRIVER);
> 
> 	pm_runtime_disable(madera->dev);
> 	regulator_disable(madera->dcvdd);
> 	regulator_put(madera->dcvdd);
> 
> 	mfd_remove_devices(madera->dev);
> 
> You need to statically set the level but then also iterate through
> the children and update the cell level on each subsequent remove,
> in my case:
> 
> static int arizona_set_mfd_level(struct device *dev, void *data)
> {
> 	struct platform_device *pdev = to_platform_device(dev);
> 	if (pdev->mfd_cell)
> 		pdev->mfd_cell->level = MFD_DEP_LEVEL_HIGH;
> }
> ...
> 	mfd_remove_devices(madera->dev);
> 
> 	device_for_each_child(madera->dev, NULL, arizona_set_mfd_level);
> 
> 	pm_runtime_disable(madera->dev);
> 	regulator_disable(madera->dcvdd);
> 	regulator_put(madera->dcvdd);
> 
> 	mfd_remove_devices(madera->dev);
> 
> Does this match how you would expect this to be used?

No, not at all.

> I do have some concerns. The code can't use mfd_get_cell since it
> returns a const pointer, although the pointer in platform_device
> isn't const so we access that directly, could update mfd_get_cell? We
> also don't have access to mfd_dev_type outside of the mfd core so
> its hard to check we are actually setting the mfd_cell of actual
> MFD children, I guess just checking for mfd_cell being not NULL is
> good enough?

Hmmm... looks like I missed the fact that you needed additional
processing between the removal of each batch of devices.  My
implementation simply handles the order in which devices are removed
(a bit like initcall()s).

How about the inclusion of mfd_remove_devices_late(), whereby
mfd_remove_devices() will refuse to remove devices tagged with
MFD_DEP_LEVEL_HIGH.

Not sure why, but I really dislike the idea of device removal by
arbitrary value/tag, as I see it spawning all sorts of weird and
wonderful implications/hacks/abuse.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
