Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E14C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9978321741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="AEeeIKet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHZOZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgHZOZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:25:44 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD27C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:25:43 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id b2so766564qvp.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0MQzhYw1eFCZ4OasAAPt/4uM+WwEYftpqDc/VYHMtbk=;
        b=AEeeIKetXtIdWWb5SAUNf0CT75v612rlaNccc1LnuJpBb5OvgTvnreoT4A4OjAHh83
         2gkDSfW8afxE84LI039FqJeIhxV2oGZ4RnkHwrgT7gaJY5kFVxvgD7z3kcBB0nmwawYl
         CS15Jy0Be3rJh0nkvXUGExE957xE1b+7UhD8hCHGOAkgpPAPwOWMKzZ3o/gby8vQ+sfN
         wDB5+JA+w8e/Hdgudw8JPIy+J6slyE1vtbucRIPeRAxApuJujob6n7+1FX7GzcKFLkOs
         Chs9V5WR7ttQDJxLdP5QRuGU/ZbDFDC5QqvZOLj2rWLfNycVtJZza+7sI/jmL4cSLtEa
         UEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0MQzhYw1eFCZ4OasAAPt/4uM+WwEYftpqDc/VYHMtbk=;
        b=uAnVeEDt3p7Vlv1V7+AtJvORMsSOVjwbIotJWa9XzhhDnXin2Q9bOPRWZOWdODx3Yu
         sP9qWtmDCC4Z4VKKaUs55I6Mo5TJ4qI17f5ybRE8drhJlOGqSoG67M3J301oDQHgt/iy
         xbtZpSC1oiiHDp7FSj6e92nlUqKgpi47NfBhZcNE0K9k7hSrApA2Fi1oBzwupduEhsHP
         kEoRN0J5bnofEpKZ9Q8osx/VaOic5eyfh9g1ESeY335XsI4EfrA6pdcwEKosxx9UflW3
         CwK6bJBNLA93Dj/lJWNljBUwQvCcpsqAUo4gxFRwyuNQSEv2kPj93sTcpRvjQQ9uJblm
         IFjg==
X-Gm-Message-State: AOAM531K/cxzaGNdQWGipEDnIJl8zcersWihR3jGeo17mSVz3C6Gel9h
        ltwIEygC9gMzwYQ5HnaxdEDqHQ==
X-Google-Smtp-Source: ABdhPJyT1CcTFQngIw1LDN+6nfpS4iP5F+zti+vFgyKwmJgBJWLjcNUPyeRDliUrfesVkOYVF2X/xA==
X-Received: by 2002:a0c:ea21:: with SMTP id t1mr14182769qvp.62.1598451942396;
        Wed, 26 Aug 2020 07:25:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:67b9])
        by smtp.gmail.com with ESMTPSA id a25sm2076443qtd.8.2020.08.26.07.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:25:41 -0700 (PDT)
Date:   Wed, 26 Aug 2020 10:24:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] proc: Optimise smaps for shmem entries
Message-ID: <20200826142427.GC988805@cmpxchg.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819184850.24779-5-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 07:48:46PM +0100, Matthew Wilcox (Oracle) wrote:
> Avoid bumping the refcount on pages when we're only interested in the
> swap entries.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
