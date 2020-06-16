Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9104C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59EA2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXJamBMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgFPJ4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:56:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF379C08C5C3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 02:56:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so20094964wru.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s+6tHvkpbMkOKCKAPCqQd0J6Ws3tiYCoTHS327bpUj0=;
        b=MXJamBMdHLtKkvZ1tesqApy0O8/Vj8QXsYt3avAmdmVJ5Ft2SASQEgbNWG3SdYYtdE
         +Ch8m2P48jOuSbe0ixEyumpyKsHKISYBwVMK4W64o8qjCzehFcaXk877uUtMjg6SZHId
         fs64b3Vpv4DcToMy3qpjHzpnChwCU5VdMcbl4NaTPq9++KmQDVtVZcOv3moUKizNQqM1
         S1/OlFY5IbI4oDqjMBrzF6xsMAU0o/pRw+pjq7iEu+Y7a1pD1WX43JOlc6wzD1s+if7G
         QDFuexgobbViQrxQ06pMwumO6fI2NiMJqiSZdkeQQxKpqY1X38hbNAvRJJYycugw1jJh
         qYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s+6tHvkpbMkOKCKAPCqQd0J6Ws3tiYCoTHS327bpUj0=;
        b=q7Bsd2kGLsdrbkgxhy0odzWrEFWcWa/qMDvnVgGcaa9+7MuqWauQ0YIotNZzKBugHu
         P2C8Cw8jbVIa1fY2r3WOVBXH5ldQRO79q9ysorleSZHf2ZyIq3mmBubhQwT/PLE4M+7x
         4NYBfxy6enkkzglLgogthSWf1jTtyaWZCrMx85yhIPMIdrZSp06G1YPIjL66n0ape5CX
         4o8WfNKO0DyKJbPBAKlLzlUCoJRrJaMXID/54mi73bDR1G4phP/r1nbadrMee1eOUwTd
         n/t5GQfk2jOBJ5L/W9aeGgfYHO9zrxkb2KWC9ckj/tMairiKMKAvSq+Cr/342dDV5bDY
         OAyg==
X-Gm-Message-State: AOAM532VXUmyoM0SO7urFa457I7mug/iXgUe/k45QUKoWb1yKdZYq7HO
        qme9plGSOKAEqicjmo8EXojzwQ==
X-Google-Smtp-Source: ABdhPJxqQsR3S5oPKf/oMoJLYKGnFwkzbNCBIFyx1JnikthcMcO/VLtWqWYDBGtu4xDItX3y6livhQ==
X-Received: by 2002:adf:b697:: with SMTP id j23mr2331934wre.201.1592301408232;
        Tue, 16 Jun 2020 02:56:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id c16sm3150742wml.45.2020.06.16.02.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:56:47 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:56:44 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200616095644.GA150003@google.com>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-3-qperret@google.com>
 <20200616043143.obk5k3rv737j5dnd@vireshk-i7>
 <20200616083107.GA122049@google.com>
 <20200616092759.rjnk3lef4tedfust@vireshk-i7>
 <20200616094802.GA139416@google.com>
 <20200616095438.v7wywhfq5ealvyih@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616095438.v7wywhfq5ealvyih@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 Jun 2020 at 15:24:38 (+0530), Viresh Kumar wrote:
> On 16-06-20, 10:48, Quentin Perret wrote:
> > ---8<---
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 0f05caedc320..a9219404e07f 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2340,6 +2340,11 @@ int cpufreq_register_governor(struct cpufreq_governor *governor)
> >  		list_add(&governor->governor_list, &cpufreq_governor_list);
> >  	}
> >  
> > +	if (!strncasecmp(cpufreq_param_governor, governor->name, CPUFREQ_NAME_LEN))
> > +		default_governor = governor;
> > +	else if (!default_governor && cpufreq_default_governor() == governor)
> > +		default_governor = cpufreq_default_governor();
> 
> Instead of the else part here, maybe just do this from
> cpufreq_core_init() only once, and so we will always have
> default_governor set.

Sounds good.

Thanks!
Quentin
