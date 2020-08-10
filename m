Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7E7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11EF206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJvq3feY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHJJqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgHJJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:46:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D47BC061756;
        Mon, 10 Aug 2020 02:46:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mt12so4529318pjb.4;
        Mon, 10 Aug 2020 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3fQqRDOEEK3chzUCl0lL9Ogs6I8yGgHjcMYgs480q6A=;
        b=tJvq3feYTqDjpFSHsGa2nJp192C6I/gC+CaEBcq+Rjc10MIMDQEU3hwx8IX6Kd9idz
         AruD5txahoyc/RfHJNXbJrjPl6nc7UFpzVUaQeNGh5Pn6Jt3C6tfMbmw3RcNqymAsb6f
         IByBxrDQLihGva6ZJJSzfOCbQOMpoQ89ePpCdAc06+LDjHNe49iOuezNAf5j5IfaBJ/G
         Kaf58/2KRp1dnSVJNv3TXUz7ETLosn6Q61C9Akr0W6sQHuPPrT7nj2IqhwwwPfHNaL3G
         mArAkvtKlrcZT8j3HfLZqz4krYEZdlGTf2oFVGjHDUPYFOU3TK4n0dw6NweWPnPV3oP4
         dIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3fQqRDOEEK3chzUCl0lL9Ogs6I8yGgHjcMYgs480q6A=;
        b=Pj7swVnK/iwmFca0JbzvUQJLQpeHJ+pVKRe3cWnX53cGG/38sYSgDVZW1w3yd4O1IB
         /HaapkV9RtGrtqPWJ+Z+2Biq3fSDMbGe9ECiKCVCwVxDvmL65XzvlcC8twYzU4Xd0B0B
         ecIeKy8jEzQYmAb9GIcDSLEPNU2yXHEcBVjZeAok2zzCqnnfJ+stl3optILokXXz4c6X
         F1rYaTGOn1Q7AaMgOqAsPJLKnPbfdSNTFqJBciG7X6QdHJP6Zv/dnIPYXzWXMLd0FxRp
         2VJ/eg5PM5s9XHUd8YZc4wmcfRhOIlU+WKmLU8dc+QNdDCJpklemVAQ473tMS8TaDYN8
         Q6fg==
X-Gm-Message-State: AOAM530PlqdEzr8Ji4xMrZTfxEMiozmQIhLNvh1QO+C4wxz1dpwbmo2h
        sZNv3vD70iWAG+L9mQcMfNI=
X-Google-Smtp-Source: ABdhPJwvz+1J3dgGouXI08GF3iGqfuD+/RYt1n1Cm2Iz11htOXNeqE5EI6zW35FtLcFUJzc2qTBLsw==
X-Received: by 2002:a17:902:d3c6:: with SMTP id w6mr21348487plb.209.1597052764753;
        Mon, 10 Aug 2020 02:46:04 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id l4sm9385502pgk.74.2020.08.10.02.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 02:46:04 -0700 (PDT)
Date:   Mon, 10 Aug 2020 15:14:13 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Andres Salomon <dilinger@queued.net>,
        Antonino Daplas <adaplas@gmail.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-geode@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 01/12] fbdev: gxfb: use generic power management
Message-ID: <20200810094413.GA7579@gmail.com>
References: <20200805180722.244008-1-vaibhavgupta40@gmail.com>
 <20200805180722.244008-2-vaibhavgupta40@gmail.com>
 <20200808111746.GA24172@ravnborg.org>
 <20200810093948.GB6615@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200810093948.GB6615@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > -static int gxfb_suspend(struct pci_dev *pdev, pm_message_t state)
> > > +static int __maybe_unused gxfb_suspend(struct device *dev)
> > >  {
> > > -	struct fb_info *info = pci_get_drvdata(pdev);
> > > +	struct fb_info *info = dev_get_drvdata(dev);
> > I do not see any dev_set_drvdata() so I guess we get a NULL pointer
> > here which is not intended.
> > Adding a dev_set_data() to gxfb_probe() would do the trick.
> > 
> gxfb_probe() invokes pci_set_drvdata(pdev, info) which in turn calls
> dev_set_drvdata(&pdev->dev, data). Adding dev_get_drvdata() will be redundant.
> 
s/dev_get_drvdata/dev_set_drvdata

Thanks
Vaibhav Gupta
