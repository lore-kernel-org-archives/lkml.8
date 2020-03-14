Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632FCC0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3192720637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ftBgpQu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgCOCS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:18:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36913 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgCOCS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:18:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id p14so7719387pfn.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d5M5DPd0RI2rczhP4P91gPN3FdPDlZFf0L0WRN91en4=;
        b=ftBgpQu/ef2KodsvtSBhktXBWOQD4w9838z0rkLa+o4/07RNwOHKopdPqSn8ckau9l
         WdZEmfHBs4x2qhwM+8cgBdHQR2Esicxravh9cL1UcN4dDQCZhyytm+THZnb6xjdJR6PQ
         Jte/OP6iyl2N5LeE/63/taq/zteoeqywc4lVRlzKTCsUgr12Y7mHT/yk4pMBlt5u2rGC
         Btpa9qUhLSHJCcXsON5aVTv5XGoHLeCZMHo57RCdN39ZOB7fv6sslQFQ8FzJOHcSUlsY
         e9Y94BBnVLDMSjA7RsS+toQmJEpyPhqa8jhVUPOv6F3bqIfJU5/p0gwhxwQdBzK9eoV7
         twiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d5M5DPd0RI2rczhP4P91gPN3FdPDlZFf0L0WRN91en4=;
        b=fBnvqUEbg6Xr3AW3fMYfFibR0xOlcKQbNItgzu3f23UwAvjQC8sA8LAp5uLs2hDv2/
         GgI3guJ8mT0NgLngkWW4c1FnURn3enFxqqQjZDkMatv39YwK71XvlirEcQyxK4N1nXpT
         mf7b/Jju+WSDqB2lhT8uRmnD7WtQ4bmN3xVbkzwQrCGW3pdslmGrNatkeChUO4ccPhgi
         FMlkCfQLcpayYUBzo1so75+vYgbsCa5eJPIHGuYt1ELB4oSsk5COsHC6EXdifQQHQJaf
         XbUshkxjQHN9PT6w28vUPkqAeC/kGtH6RJeZPmsoeXxAYXdQleruY4lj0ClhelM3iRIr
         BB0Q==
X-Gm-Message-State: ANhLgQ2lw6mrHWPOed2pLMh5rnSeDtGL44aTYkIIx/FBunLAW7yexWrG
        /iyaLETEZbRvNlvGjKXzH9qVlJL+wLY=
X-Google-Smtp-Source: ADFU+vus4vyzIYl9CFaEFiSMQ3/xkopLUxwv+ptaZRMSeLor25vsGi8XSvzH8is+QFcumbpMiK4Xpg==
X-Received: by 2002:a62:1bd6:: with SMTP id b205mr17822879pfb.242.1584159158923;
        Fri, 13 Mar 2020 21:12:38 -0700 (PDT)
Received: from localhost (c-73-170-36-70.hsd1.ca.comcast.net. [73.170.36.70])
        by smtp.gmail.com with ESMTPSA id g18sm14106109pfh.174.2020.03.13.21.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 21:12:38 -0700 (PDT)
Date:   Fri, 13 Mar 2020 21:12:37 -0700
From:   Sandeep Patil <sspatil@android.com>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [EXTERNAL] Re: [PATCH v4 2/4] power_supply: Add additional
 health properties to the header
Message-ID: <20200314041237.GA121329@google.com>
References: <20200116175039.1317-1-dmurphy@ti.com>
 <20200116175039.1317-3-dmurphy@ti.com>
 <20200117010658.iqs2zpwl6bsomkuo@earth.universe>
 <20200306235548.GA187098@google.com>
 <20200310213050.si7gcr2wbmjgr7jf@earth.universe>
 <de919edb-79b3-82ec-f55c-31a127d6c751@ti.com>
 <66b2ac86-8513-b540-8a2c-c2ebef4124dd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b2ac86-8513-b540-8a2c-c2ebef4124dd@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 11:43:00AM -0500, Ricardo Rivera-Matos wrote:
> Sebastian
> 
> On 3/11/20 6:29 AM, Dan Murphy wrote:
> > Sebastian
> > 
> > On 3/10/20 4:30 PM, Sebastian Reichel wrote:
> > > Hi Sandeep,
> > > 
> > > On Fri, Mar 06, 2020 at 03:55:48PM -0800, Sandeep Patil wrote:
> > > > On Fri, Jan 17, 2020 at 02:06:58AM +0100, Sebastian Reichel wrote:
> > > > > Hi,
> > > > > 
> > > > > On Thu, Jan 16, 2020 at 11:50:37AM -0600, Dan Murphy wrote:
> > > > > > Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
> > > > > > 
> > > > > > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > > > > > ---
> > > > > Looks good. But I will not merge it without a user and have comments
> > > > > for the driver.
> > > > Android has been looking for these properties for a while now [1].
> > > > It was added[2] when we saw that the manufacturers were
> > > > implementing these
> > > > properties in the driver. I didn't know the properties were
> > > > absent upstream
> > > > until yesterday. Somebody pointed out in our ongoing effort to
> > > > make sure
> > > > all core kernel changes that android depends on are present upstream.
> > > > 
> > > > I think those values are also propagated in application facing APIs in
> > > > Android (but I am not sure yet, let me know if that's something
> > > > you want
> > > > to find out).
> > > > 
> > > > I wanted to chime in and present you a 'user' for this if that helps.
> > > With user I meant an upstream kernel driver, which exposes the
> > > values. But thanks for the pointer. This should be mentioned in
> > > the patch description, also the fact that the status values are
> > > directly taken from JEITA spec.
> > 
> > I mentioned the JEITA in the cover letter but I guess you would like the
> > description in the commit message as well
> > 
> > Dan
> > 
> > 
> I have added a note mentioning that the properties are taken from the JEITA
> spec in the commit message and listing the bq2515x_charger driver as a user.
> I am waiting for feedback on my other patches in the series before sending
> you v5 patches.

Ricardo, I'll appreciate if you CC me if/when you send the v5 and followup.
I want to track this series so we can uncheck yet another out-of-tree
dependency that Android has.

Thanks for the quick followup.

- ssp
