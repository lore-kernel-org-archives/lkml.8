Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77958C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453DE2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="cVDVhHg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgETXuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgETXuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:50:00 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9507EC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:49:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id f13so4582143edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RUfnz+3+Nkh58pbHAS8sjZcUPVeApODwUMmXr4NI2ZY=;
        b=cVDVhHg2q1D6nCUuevO4L9GrF42LCXBhesqGp2oqY+Szm4s6/HGyDkVnnMedHOHVZK
         LykgwAJlryPBcvuXF2ra2GGQUtGGoixKRuBRkoY1hdDKfDap9f7d9cIDRAT5LFl2IHF2
         KeOEFtHXVSe0jQ+iHUDUT/yqM7+JGeJa+akrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RUfnz+3+Nkh58pbHAS8sjZcUPVeApODwUMmXr4NI2ZY=;
        b=gz/wyoZ4ktrAG7YWHMEFyRuQyqCunwEHKNAexDFZjV4OLvqM3Jtl4Oy/voS84KQ2cH
         W1S1SpS+qD+JTdQsO3EcszN7FW/rITC7J+bk6VGwGxy2kYJ4KK27BpIfQN1x3DUfKxbw
         8yVZiF343T/yTX91GmRCjzly99AfDByYOkQa8s+XwPYDROlkGkuUWKh7SwBFhQtR25Ut
         8EWpccozIVxjENThQQXh8M9+Ci3P3MFSXRGs90iX80lMRenZ9dzaLf0PdYr3a6RjbOKX
         74VFQNcEw5fw/1pKuljgk1n68N9tXNX/FesH4Cyp+9WiEZ16Q3Bk8PVlMsXigpir7r43
         lTFg==
X-Gm-Message-State: AOAM5316XbGNg+Z9kIfInvKCgXy9smpYvZfkZb39uoHsHyhzGq0D0vgL
        osnDGBP1lZcYndc/9ksmZrRXQXcL6JrSnvAc
X-Google-Smtp-Source: ABdhPJznwU1I3lqQRpLIzH8obpgeUm97jbOZSvYmp+dcp94Vi9i1I3/6JvVjoaU3Frm22nn60f3clw==
X-Received: by 2002:a50:b586:: with SMTP id a6mr5514320ede.292.1590018597141;
        Wed, 20 May 2020 16:49:57 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4262])
        by smtp.gmail.com with ESMTPSA id x8sm3268142edj.53.2020.05.20.16.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:49:56 -0700 (PDT)
Date:   Thu, 21 May 2020 00:49:56 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: unify reclaim retry limits with page allocator
Message-ID: <20200520234956.GA892595@chrisdown.name>
References: <20200520163142.GA808793@chrisdown.name>
 <20200520164037.e3598bc902e39415f4c263e7@linux-foundation.org>
 <20200520164243.56133fa135f65cc708e70ec0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200520164243.56133fa135f65cc708e70ec0@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andrew,

Andrew Morton writes:
>Ah, my habit of working in reverse time order sometimes does this ;)
>
>I suggest that "mm, memcg: reclaim more aggressively before high
>allocator throttling" and this patch become a two-patch series?

Sure, they can do (sorry, I meant to add a comment mentioning the dependency, 
but forgot). I just didn't want to conflate discussion for both of them, since 
they are separate in nature :-)

I'll hold off on sending v2 until the discussion with Michal is finished.
