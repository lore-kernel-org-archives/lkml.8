Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0122C38A29
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A040D2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEfA6DnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391286AbgDNQyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:54:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58057 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2440696AbgDNQw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586883177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NH9riSJWIwA5MJGEKQ1bph+dSoJ7N2LR20v9on+n36c=;
        b=DEfA6DnDToVNektqackuxJE0Xrq80DG3HGf9ipu5rPxtHVlwa3XMWz7rd/aLpJ0EMrZSX+
        gTtxuXotWmbXGfyGU2H2mT0+sL6x+aOGLcEFq1Z+Ws5khk0kGddUe16zZdNdDMCqxU7B7W
        z2nkN7nUvd8p1Sg1si8hmFikUXl1B/8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-PidPBT5jME6izHRyTxvetg-1; Tue, 14 Apr 2020 12:52:53 -0400
X-MC-Unique: PidPBT5jME6izHRyTxvetg-1
Received: by mail-qt1-f199.google.com with SMTP id u13so2201376qtk.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=NH9riSJWIwA5MJGEKQ1bph+dSoJ7N2LR20v9on+n36c=;
        b=GrSTyJyVRi5vfs2Y6gjTDrvDlzts65DelqWKQc9aJGdr1NG8OqwVO9nJ9WrIBlyHkg
         NQbUeU98ZyE7uS3XGc7R5JMRrnQ8FZUUIjVNswoittL/aar0SBQWUti0qjaPIZtUkI2H
         rBrAMM+FjPjF6dBiurmYmYwU17U5p8tDGF84W4N/ntCmjtiH5/kDqwwgQti/OI2+BNH9
         HxwqzX1ZYtG68inoUKnhcC8y6NtRAQ+mA4sxeUh8jjSmiGQ88sbbM0IjsCt6PhhdfCQU
         faBeflIiXA8XTKEPSivMusAGuOGYKHPSRsurzZP/ViBBqhoR3w1lTD6jKrYZDGHyjw9k
         aGVg==
X-Gm-Message-State: AGi0PuYxBl6kT5kUXAmeEIh5MgIGYjZFMt5J8cosd8A2YkwcS1vXb8e3
        IZcCZ6pXwTALjHv2388JA7Lurn0ieb/0dPN7x/lFrq0MHywOdjCwvGyi0O/ruY0m0FfXKSklicj
        2K2KINJopVLZnmbtXPPaa7KEx
X-Received: by 2002:aed:33a4:: with SMTP id v33mr16397042qtd.289.1586883173353;
        Tue, 14 Apr 2020 09:52:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypLJ3Yw9j9pzYkEgXk1oqksYr1eCgriQZ9BixGsOQAVs0d1y/GYfsWqxFhJ8l+Ojwa6qT9mvYQ==
X-Received: by 2002:aed:33a4:: with SMTP id v33mr16397015qtd.289.1586883173059;
        Tue, 14 Apr 2020 09:52:53 -0700 (PDT)
Received: from Ruby.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id c27sm11511330qte.49.2020.04.14.09.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:52:52 -0700 (PDT)
Message-ID: <a2d9da054ace3f0ff59373c5a6252f25e1c3df4b.camel@redhat.com>
Subject: Re: [PATCH 1/9] drm/vblank: Add vblank works
From:   Lyude Paul <lyude@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Date:   Tue, 14 Apr 2020 12:52:51 -0400
In-Reply-To: <20200413204243.GL60335@mtj.duckdns.org>
References: <20200318004159.235623-1-lyude@redhat.com>
         <20200318004159.235623-2-lyude@redhat.com>
         <20200318134657.GV2363188@phenom.ffwll.local>
         <e4fb0c39ec024d60587e5e1e70b171b99eb537f4.camel@redhat.com>
         <faf63d8a9ed23c16af69762f59d0dca6b2bf085f.camel@redhat.com>
         <96cb912809f99d04cd5cdd46c77b66b8c1163380.camel@redhat.com>
         <20200413204243.GL60335@mtj.duckdns.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-13 at 16:42 -0400, Tejun Heo wrote:
> Hello,
> 
> On Mon, Apr 13, 2020 at 04:18:57PM -0400, Lyude Paul wrote:
> > Hi Tejun! Sorry to bother you, but have you had a chance to look at any of
> > this yet? Would like to continue moving this forward
> 
> Sorry, wasn't following this thread. Have you looked at kthread_worker?
> 

Hi, thanks for the response! And yes-I think this would actually be perfect
for what we need, I guess one question I might as well ask since I've got you
here: would patches to expose an unlocked version of kthread_queue_worker() be
accepted? With something like that I should be able to just reuse the
delayed_work_list and spinlocks that come with kthread_worker which would make
the vblank works implementation a bit easier
>  
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kthread.h#n71
> 
> And, thanks a lot for the vblank explanation. I really enjoyed readin it. :)
> 
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat

