Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA1FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F2D20658
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI/FeK23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgHKLdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:33:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36941 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728681AbgHKLdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597145628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GiCPzZPtpDgWrMbwVo68Gc9UUX4p+0NK8qKoCf+Lg2k=;
        b=gI/FeK23M41k5meXY2J3IjYS42tHdB/K+Q1SVuMTLjw/wOcxZKxrHCBl5TYqCEDw3L38MC
        vOvtkbvH0nJ7WoGChrB5viI0Sqm8a6EcILU1BhptpSKGVDYxRKVdGHZoKy0wL5MbqRxTLb
        0b6Duxx1rjRItchpsi4zA7l+V2aYmWk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-dHyKlMmDMjy9IUCaWdNOQQ-1; Tue, 11 Aug 2020 07:33:46 -0400
X-MC-Unique: dHyKlMmDMjy9IUCaWdNOQQ-1
Received: by mail-wm1-f72.google.com with SMTP id v8so867072wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GiCPzZPtpDgWrMbwVo68Gc9UUX4p+0NK8qKoCf+Lg2k=;
        b=fouaew8Nw2fV4S9YkfArMg8WkcisQYxH1GTsbLo6yb1n233MKJLFxs1rVM3SmsrJgP
         1v0WFwzQPS/guY4Br9XONX9x0+bjd85kgQCeuaXG/vfBqThpAfxczYycu4oatx5cPgIw
         YTGURwwC5fNs8FE35KBVgTU3QhSZZVr7WV87cXtnzJSfUv6Ii5y+oxpIGkj8Eg9/Pp8j
         EsHE+ctsDY8GxpBLz9HhZcIvefJO1hIIWHc+1Mml/OVG3Ylm7SLXNwfrLB5jZmH0fYn3
         cCYJXsrMAP3n4FYojScOr3FEraNdFj5BAa2LN6dgVl0z3y7EWb0d0iOMZ1ijZTdSsPXc
         64Hg==
X-Gm-Message-State: AOAM531WW3HuxOPzVFAgcutG2bU4h6DEwZafmeA+WjFzA8Xi1Wtlp/13
        D5ltwfb2jEEn9ZMBHF7DOkLSOdl8V30UatE47LJIisYYqOzb2Yha8R0y7KE3rYy3X+XO8Gg/Lo1
        JIDwBAVBCBmFlqigzErJOjmXV
X-Received: by 2002:a1c:2dcb:: with SMTP id t194mr3499780wmt.94.1597145625675;
        Tue, 11 Aug 2020 04:33:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEaIvjLTJL/NIBPByzAEwifrGXrzHsoFwTXAZoU9RkSJbGkn6bslOVl7J4dDyoTVHhx7FazQ==
X-Received: by 2002:a1c:2dcb:: with SMTP id t194mr3499766wmt.94.1597145625527;
        Tue, 11 Aug 2020 04:33:45 -0700 (PDT)
Received: from redhat.com ([147.161.8.240])
        by smtp.gmail.com with ESMTPSA id 32sm27064327wrn.86.2020.08.11.04.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 04:33:44 -0700 (PDT)
Date:   Tue, 11 Aug 2020 07:33:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eli@mellanox.com" <eli@mellanox.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        Majd Dibbiny <majd@nvidia.com>,
        Maor Dickman <maord@nvidia.com>,
        Shahaf Shuler <shahafs@mellanox.com>
Subject: Re: VDPA Debug/Statistics
Message-ID: <20200811073144-mutt-send-email-mst@kernel.org>
References: <BN8PR12MB342559414BE03DFC992AD03DAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR12MB342559414BE03DFC992AD03DAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:26:20AM +0000, Eli Cohen wrote:
> Hi All
> 
> Currently, the only statistics we get for a VDPA instance comes from the virtio_net device instance. Since VDPA involves hardware acceleration, there can be quite a lot of information that can be fetched from the underlying device. Currently there is no generic method to fetch this information.
> 
> One way of doing this can be to create a the host, a net device for each VDPA instance, and use it to get this information or do some configuration. Ethtool can be used in such a case
> 
> I would like to hear what you think about this or maybe you have some other ideas to address this topic.
> 
> Thanks,
> Eli

Something I'm not sure I understand is how are vdpa instances created
on mellanox cards? There's a devlink command for that, is that right?
Can that be extended for stats?

-- 
MST

