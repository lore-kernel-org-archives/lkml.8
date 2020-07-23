Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89380C433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6803A20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMtF2uv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGWW6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgGWW6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:58:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC9C0619D3;
        Thu, 23 Jul 2020 15:58:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g10so7407623wmc.1;
        Thu, 23 Jul 2020 15:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qqXSwfvqheVjYXqW+atWH5qoEuJ9FdUQ20+E0c6/f8=;
        b=lMtF2uv+uBztG8XBoS1w/RHN0Qpm1GVcEUl/qO9TEUN8NTus1jJD+FMjJnYTqrtjN8
         e5CTFbIEhRyYUseNm3oEmPep3vA7xsMjfOGVT77wmg6wtVL06Wc2OxX3VwCPupv43nFV
         xyXjGTOSL1MzHgeFICJoFjknOUzm2DzaAIIW7qC3a6BSQsI6GAn+cotpmYJjGa9+tFOZ
         Jq1THhcFiboZXpZiXBOPxYrpm9Gv6QVrcEFB/v8Mmi//gnHMPwekN9qO61fi6r/OTfSA
         01E3lYNk9F7gzykcTPKx2/JxwKLsErs/T3qtXZwepzq6WThI5xSRj2jXXpDqWf9FoY33
         nnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8qqXSwfvqheVjYXqW+atWH5qoEuJ9FdUQ20+E0c6/f8=;
        b=guA4ge3InadbqS9P/WoJm4YtAPk7U9pqojGxmEHpObDAe5hLQNblylPNKxYa0QTI1k
         N2WvMChQqTlUucHYWYOEmGVUtN6dGzrK+QwBMl2EAkNrX9nKNsDi6QWYCJ8bJDr7anE8
         4VqnLeBCR7hnxt5lpMg53cbGHg6hj3dOUQZg6UoHI1M1cCKUyg0gg5fFBmlQYLO2IihJ
         uAGB7ptfQ8vZH4/hh8e4UAlH0esOtDkJCIqU9AyCCOPvDZrxFEl9A8+Ogr0Uq3HuhORN
         tTaNb/18d+npgzwoAwkX/sVFc5Af/gHxSzGgzWWh70W7/IGjI/PROARiwFD13KmUm+5l
         5AcQ==
X-Gm-Message-State: AOAM530hnBvlzD9cww37LDd++/TwcFp2RZ8RgLpmVikrrAq++rW58bID
        cPSNnJv2GXAf/D7CULkviQrE9Ew6x74=
X-Google-Smtp-Source: ABdhPJxlaSPn6Qlr3WdBmDOLf6XsYVyz44wdckCEc7RVJjfQ1vlAxtbOcrV202cQXprXYEpGD1xWtw==
X-Received: by 2002:a1c:2ec4:: with SMTP id u187mr5883641wmu.188.1595545116395;
        Thu, 23 Jul 2020 15:58:36 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id i8sm3490108wro.34.2020.07.23.15.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 15:58:35 -0700 (PDT)
Date:   Fri, 24 Jul 2020 00:58:34 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Antonio Borneo <borneo.antonio@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hewenliang <hewenliang4@huawei.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: tools: fix build error for multiple definition
Message-ID: <20200723225834.GA3733057@eldamar.local>
References: <20200618000844.1048309-1-borneo.antonio@gmail.com>
 <f914d6a1-20d6-2e00-bcf5-658848ad95a1@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f914d6a1-20d6-2e00-bcf5-658848ad95a1@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 18, 2020 at 11:36:39AM -0600, Shuah Khan wrote:
> On 6/17/20 6:08 PM, Antonio Borneo wrote:
> > With GCC 10, building usbip triggers error for multiple definition
> > of 'udev_context', in:
> > - libsrc/vhci_driver.c:18 and
> > - libsrc/usbip_host_common.c:27.
> > 
> > Declare as extern the definition in libsrc/usbip_host_common.c.
> > 
> > Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> > ---
> >   tools/usb/usbip/libsrc/usbip_host_common.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/usb/usbip/libsrc/usbip_host_common.c b/tools/usb/usbip/libsrc/usbip_host_common.c
> > index d1d8ba2a4a40..ca78aa368476 100644
> > --- a/tools/usb/usbip/libsrc/usbip_host_common.c
> > +++ b/tools/usb/usbip/libsrc/usbip_host_common.c
> > @@ -23,7 +23,7 @@
> >   #include "list.h"
> >   #include "sysfs_utils.h"
> > -struct udev *udev_context;
> > +extern struct udev *udev_context;
> >   static int32_t read_attr_usbip_status(struct usbip_usb_device *udev)
> >   {
> > 
> 
> Looks good to me.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

As Debian (unstable) has switched to GCC 10 by default, we are biten
by this. Patch looks good to me.

Tested-by: Salvatore Bonaccorso <carnil@debian.org>

Regards,
Salvatore
