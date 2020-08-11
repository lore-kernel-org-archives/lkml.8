Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685DAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386D420768
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYEouhJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgHKMoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:44:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22928 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728566AbgHKMox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597149891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4gObRQ0Fq7QQ6hAOg5wupZW2BNQ64paK3yGpxjhjhBc=;
        b=ZYEouhJQ0gCp2Xdme9aoM4vokldNKdRGTS7dJDphyXW1burB1shOTOH+z5FJxpAiUBx1qf
        gohF51eVxt7+mMHsQiHCU4ZAIgSTl8rQ/Owj1isiJBLkG15EQSjthDGMBbk08YCZczMZjj
        wxKjuy6n82j+LOLtphl8kVBQmUQI1Vg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-rOrJ3wLLNOSb0eanepYSTw-1; Tue, 11 Aug 2020 08:44:49 -0400
X-MC-Unique: rOrJ3wLLNOSb0eanepYSTw-1
Received: by mail-ed1-f72.google.com with SMTP id t30so4525467edi.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 05:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4gObRQ0Fq7QQ6hAOg5wupZW2BNQ64paK3yGpxjhjhBc=;
        b=UzOXaZdbUojKuGTCq0i1VS9dJmCBdWFVg/KAtOCGnR8pDlL2icSiMrTjUdtgwu8DJE
         1mkAjlXksO6CcTnMoNJwILnNPTRCOryx6XYOBeMnkwy2sd+3yLKgMXEpZ6pqLn8HX/4S
         PpA+fOW3BMLBlR153ZYhfE+wId1J7I6NpIo6gUvsXaiCBE30O2CDjVmX7EFlfYAp7lXH
         91WUbhhbOJpCQ9Kcd95NbmWS957itonADQl/Fj8hgkmFUqOFnzWxF0tqv6vMSFoAUwII
         7MvtKV3eaS2NvNcV1e2eY963PotpuKzUTGeRSZZWCttrVJ3zafLWl81Z+bDgxp2vhci4
         9h4g==
X-Gm-Message-State: AOAM533we0CE786YjArEFTddM2AO8jQnIv75Bfadh3wVJOJxSBefx5zK
        g7XJIFSlcLVUlndGkPc26WVA0KhgMqrKDa9w0AQG4NS44KtkSaB/tqo4zzIk+kA6dD5AtNBL917
        1T1isAsWV6Y8gwCrfbyVaRwk5
X-Received: by 2002:a05:6402:1218:: with SMTP id c24mr25203359edw.44.1597149888542;
        Tue, 11 Aug 2020 05:44:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIaQixLajacpoqLdEsULPbWw/H9fIINTYi9tun3K98B+6Mv/G3SkYZ35zHOyX7A3SBCMINnQ==
X-Received: by 2002:a05:6402:1218:: with SMTP id c24mr25203332edw.44.1597149888269;
        Tue, 11 Aug 2020 05:44:48 -0700 (PDT)
Received: from redhat.com ([147.161.12.106])
        by smtp.gmail.com with ESMTPSA id q11sm14418807edn.12.2020.08.11.05.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 05:44:47 -0700 (PDT)
Date:   Tue, 11 Aug 2020 08:44:43 -0400
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
        Shahaf Shuler <shahafs@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: VDPA Debug/Statistics
Message-ID: <20200811083803-mutt-send-email-mst@kernel.org>
References: <BN8PR12MB342559414BE03DFC992AD03DAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
 <20200811073144-mutt-send-email-mst@kernel.org>
 <BN8PR12MB34259F2AE1FDAF2D40E48C5BAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR12MB34259F2AE1FDAF2D40E48C5BAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:58:23AM +0000, Eli Cohen wrote:
> On Tue, Aug 11, 2020 at 11:26:20AM +0000, Eli Cohen wrote:
> > Hi All
> > 
> > Currently, the only statistics we get for a VDPA instance comes from the virtio_net device instance. Since VDPA involves hardware acceleration, there can be quite a lot of information that can be fetched from the underlying device. Currently there is no generic method to fetch this information.
> > 
> > One way of doing this can be to create a the host, a net device for 
> > each VDPA instance, and use it to get this information or do some 
> > configuration. Ethtool can be used in such a case
> > 
> > I would like to hear what you think about this or maybe you have some other ideas to address this topic.
> > 
> > Thanks,
> > Eli
> 
> Something I'm not sure I understand is how are vdpa instances created on mellanox cards? There's a devlink command for that, is that right?
> Can that be extended for stats?
> 
> Currently any VF will be probed as VDPA device. We're adding devlink support but I am not sure if devlink is suitable for displaying statistics. We will discuss internally but I wanted to know why you guys think.

OK still things like specifying the mac are managed through rtnetlink,
right?

Right now it does not look like you can mix stats and vf, they are
handled separately:

        if (rtnl_fill_stats(skb, dev))
                goto nla_put_failure;

        if (rtnl_fill_vf(skb, dev, ext_filter_mask))
                goto nla_put_failure;

but ability to query vf stats on the host sounds useful generally.

As another option, we could use a vdpa specific way to retrieve stats,
and teach qemu to report them.




> --
> MST

