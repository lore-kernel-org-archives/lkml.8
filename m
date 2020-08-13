Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209CAC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1F82078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lWi1FzHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHMJtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:49:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67963C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 02:49:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l2so4667004wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0LlvHfm0fDcpoyyMaORTx/eYLC8CvpylDILZS1NvjiE=;
        b=lWi1FzHH1BV+EzmrSga7ApiENnWG4rnFNvY55jJnx4HEYYqFbLTyoosig8cHp1FiY+
         KzDuXOaac641oazK7Pj5mp5b/e6dsFLKNW4tORrAeiih1MKDWVWE0X2vuI1VAcIyx2P7
         Yyv67b5AUWBZMZM3ni5igMfct6/Px27rLKJM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=0LlvHfm0fDcpoyyMaORTx/eYLC8CvpylDILZS1NvjiE=;
        b=hTGT87A4AHSVo89qwbrjODap4YzfTXUZXKxKVzH5ilcJKBb1436XjceeU/MDIUvgCH
         DLMx1xzN0v3CHcf4oT+RAUJ+WfFxwEzgUvsAHNPBi2GmXMRsGoO4vG4tbYx30w2nkR5H
         Tvzf1KW9nqR49cKn3s9+plgX04BOBjnGkb0svK9J4ISTRtE0faBD2uyL7fFnuYZt+x1k
         KKZVsWuNNzY1/aiRl9zZcIfCQ8cz/Ciamu25I39P5B/YYG7YwskdGLprCkgK0VK97UVL
         t4h7ZlU1flacgueCwjKiDnw/1GqXc2qFIaVr8Y8hlyPC1TH2y3kUegkUZ13zCRf1huv1
         rPZg==
X-Gm-Message-State: AOAM533G8yt+eKVwQbhpkf2GEzZp8qCeyTIYSXI+uiwgQP2qFLryleA+
        UCJNCswSi6VOnRVCQKaXJuHvUw==
X-Google-Smtp-Source: ABdhPJycUujEr7rVda86HPb+DkIE8Ht8J0MPhgd4scPfkc4FA7fTcodh9eVHq8K2RnSra1Me1/FpMg==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr3037067wrq.327.1597312188920;
        Thu, 13 Aug 2020 02:49:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 68sm9267182wra.39.2020.08.13.02.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 02:49:48 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:49:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, Wei Liu <wl@xen.org>,
        Yan Yankovskyi <yyankovskyi@gmail.com>,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 2/2] xen: add helpers to allocate unpopulated memory
Message-ID: <20200813094946.GJ2352366@phenom.ffwll.local>
Mail-Followup-To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, Wei Liu <wl@xen.org>,
        Yan Yankovskyi <yyankovskyi@gmail.com>,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200811094447.31208-1-roger.pau@citrix.com>
 <20200811094447.31208-3-roger.pau@citrix.com>
 <20200813073337.GA16160@infradead.org>
 <20200813075420.GC975@Air-de-Roger>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200813075420.GC975@Air-de-Roger>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 09:54:20AM +0200, Roger Pau Monné wrote:
> On Thu, Aug 13, 2020 at 08:33:37AM +0100, Christoph Hellwig wrote:
> > On Tue, Aug 11, 2020 at 11:44:47AM +0200, Roger Pau Monne wrote:
> > > If enabled (because ZONE_DEVICE is supported) the usage of the new
> > > functionality untangles Xen balloon and RAM hotplug from the usage of
> > > unpopulated physical memory ranges to map foreign pages, which is the
> > > correct thing to do in order to avoid mappings of foreign pages depend
> > > on memory hotplug.
> > 
> > So please just select ZONE_DEVICE if this is so much better rather
> > than maintaining two variants.
> 
> We still need to other variant for Arm at least, so both need to be
> maintained anyway, even if we force ZONE_DEVICE on x86.

Why does arm not have ZONE_DEVICE?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
