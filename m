Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA73C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B03206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz1WSRGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgEEVEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729070AbgEEVEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:04:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22412C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 14:04:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so31365wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=l4Y0sqZ/kAnZM7OgWnOCONloms5JRfRmL8w73O2eUuU=;
        b=Gz1WSRGKBr+13Dz5QcNBwMVsnVnPtXIr1roNbruqjNAxcyBTvjs1GcivhM8o/FJvNB
         pq0WGHqSuTxPp51inmI2ASqD1dK8jIFr6vs39OBtND5B/jvKqHg5AzXnPt3XCOy0uuXK
         GmeyeOX7V3IVmB3aTKLDCnG5YLYmIFfSZhtZWHPlCJLZdexWX+16O+Wfvi7xAs9IdiAe
         +RzvVthizW0aO0FulWwAKAl1CyX31vsKfMHbLC0HCzRgzLkWMY746OEVgfQDwRrWnSBO
         tA9OmSysPIkH0+iJDY7l42drJgM7lr15vXW0MGjBEulZyPkkL5TL904SLlLzk89waNcQ
         dZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=l4Y0sqZ/kAnZM7OgWnOCONloms5JRfRmL8w73O2eUuU=;
        b=cZF2Mgz9Tyj2pueTi5ZimLuml8rlcQKWSk/XunZWPMENcLL3+Az1MoH4Z2JSwNxbiL
         OYxkoUuxYBSKyd2xN3Ona6U/k9lvTS2fck3Gv9t27UYos4+WYk8ZckqkGRSGPimSA1If
         Btk+pp6HiZrzTIgk3RYXoCFFlTPVDXL2r2thmy/Fkn5S0sZqJCxPO8X4VkxGGElzAvyn
         NWJzTSqSdyXV6QAoyjDm5IzUophAvOOD9vA3CT8wJjVSFdeIyqg6jYAgkYdpzYydKmI0
         zZWBhWcr1qFGLij6AVwiivohWI2rKSiSfp1Ur9t29j6I64jVB3bTMTssc7auUj6KK2fm
         zZhg==
X-Gm-Message-State: AGi0PuZlT/ElWduccFHSv1UaHo/Zmj3ohYtW/gMVRjg1CnnxmQZ7GSgs
        7RiRm8DkKQpI1fhX4UL6iu//tDFl
X-Google-Smtp-Source: APiQypK6Bgn9UDu9TKgyZ5qgF/Olshp/Y/18OQkAPzlG0O7TtZA2cfaGI947bdierBaKASmVxKmiZg==
X-Received: by 2002:a1c:9a13:: with SMTP id c19mr472178wme.159.1588712681907;
        Tue, 05 May 2020 14:04:41 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id a205sm5957190wmh.29.2020.05.05.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 14:04:41 -0700 (PDT)
Message-ID: <d4a8e881f2f715f17254a840a9a05b088146c2aa.camel@gmail.com>
Subject: Re: [PATCH v4 1/9] w1_therm: creating w1_therm.h
From:   Akira shimahara <akira215corp@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Date:   Tue, 05 May 2020 23:04:39 +0200
In-Reply-To: <20200505144811.GD838641@kroah.com>
References: <20200429225915.198956-1-akira215corp@gmail.com>
         <20200505144811.GD838641@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 05 mai 2020 à 16:48 +0200, Greg KH a écrit :
> > Creating w1_therm.h header to organize code. Organize the
> > w1_therm.c file
> > to gather hardware functions, device specific functions, interface
> > functions and sysfs functions.
> > Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> > ---
> >   drivers/w1/slaves/w1_therm.c | 302 +++++++++++++++---------------
> > -----
> >   drivers/w1/slaves/w1_therm.h | 138 ++++++++++++++++
> >   2 files changed, 269 insertions(+), 171 deletions(-)
> >   create mode 100644 drivers/w1/slaves/w1_therm.h
> 
> 
> Wait, why is a .h file needed for just a single .c file?
> 
> 
> 
> 
> 
> <snip>
> 
> 
> 
> >   static ssize_t read_therm(struct device *device,
> 
> 
> 
> 
> > +/** read_therm()
> > + * @param sl pointer to the slave to read
> > + * @param info pointer to a structure to store the read results
> > + * @return 0 if success, -kernel error code otherwise
> > + */
> > +static ssize_t read_therm(struct device *device,
> > +                     struct w1_slave *sl, struct therm_info
> > *info);
> > +
> 
> 
> Why is this function needed to be declared in this .h file?
> 
> 
> 
> Why is any of this needed?  For some reason I thought you needed a .h
> 
> file to make things simpler for other .c files, but if all of this is
> 
> static, it's not needed at all, right?
> 
> 
> 
> thanks,
> 
> 
> 
> greg k-h

Hello,

Yes, you are right, header file could be avoided. But we separate it
from .c for clarity purpose, and to ease future developpment (for
example adding support of new devices).

If you absolutely want to put everything in the .c file, I can do it,
let me know.

Thanks ahead,

Akira Shimahara

