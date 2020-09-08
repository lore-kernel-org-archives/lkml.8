Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454B3C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0662177B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVFVXNTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgIHH6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:58:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37955 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729915AbgIHH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599551860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hjajqtvEuISTBRgRpPMUCH8ji6lbeHsCmX5hSQj+D2Q=;
        b=HVFVXNTCn0P8hxdzDQkceEZE95e+2L8CyHiJGAdMFWyTELNh0rCS64n0hyDoSvB+uoXlC2
        as/CK00hPloi+JHHZowUZJFtc47cjpZlZoTF/Q3Touz780mZnTcffk1thObxcy6ig6S2fb
        O4I/8if0CXHx/UFEovyQOwhgHLa9o+Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-7Xnsz1lqMomrMpHZXNA5Tw-1; Tue, 08 Sep 2020 03:57:39 -0400
X-MC-Unique: 7Xnsz1lqMomrMpHZXNA5Tw-1
Received: by mail-ed1-f72.google.com with SMTP id l2so5838113ede.19
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hjajqtvEuISTBRgRpPMUCH8ji6lbeHsCmX5hSQj+D2Q=;
        b=cQqy4lzol9nC4uKfWcOFGnLpn29/DfELVcYBjzgc603IsCWcsHleoEmP2+kn4PpUVv
         BZlU4JYr8umgB/eBEHv0KL5FnubLgKQ1GkF8EywEKCZNWF0VtxLoKOouQK/ndVtihHpQ
         ygbjP4fIMDWo+gkmlRsWirKawAjR5ZEKfUNCjqeL9EFSGCOr+l4lmz1r5hDHuqN6Krty
         Rofey4IsrPy5y1Vwr6ujoXz+Y0R8VMkidh2hn6+ciogF3aWzhsNI9slQV/SJ9dkJH3Zg
         Y7yzmNfz/cJc2eRAEG887/vEAY97uN2QFbIRSCwF1CaQA6RkjCKIjz7AM8wMAeLhtChu
         N9Xw==
X-Gm-Message-State: AOAM530Vxe3joNiTR3PLM1r3SRVDxqZro+6dqPemSRZJCPIt2Rr4e6va
        fjAcSThm9OZEsvHeEVk0GBY2KPbvokBzMnZbCxPU/lHlQTl5zKXXV//bUhoSi90AHzB6EdQ7PN1
        UwmkCVP5UsLhOtjuGHDt7M9L5
X-Received: by 2002:a17:906:4cc6:: with SMTP id q6mr17306533ejt.201.1599551857520;
        Tue, 08 Sep 2020 00:57:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpDLRo1CVGFPV8s2mB7FGn6jr+cgUVgJN/ozC0WS4OAeawUnu+/98JbXILSr3J/Bhzu7egLw==
X-Received: by 2002:a17:906:4cc6:: with SMTP id q6mr17306516ejt.201.1599551857341;
        Tue, 08 Sep 2020 00:57:37 -0700 (PDT)
Received: from redhat.com ([147.161.9.118])
        by smtp.gmail.com with ESMTPSA id e4sm16024501edk.38.2020.09.08.00.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:57:36 -0700 (PDT)
Date:   Tue, 8 Sep 2020 03:57:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com,
        cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v11 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200908035506-mutt-send-email-mst@kernel.org>
References: <1599471547-28631-1-git-send-email-pmorel@linux.ibm.com>
 <20200908003951.233e47f3.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908003951.233e47f3.pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 12:39:51AM +0200, Halil Pasic wrote:
> On Mon,  7 Sep 2020 11:39:05 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > Hi all,
> > 
> > The goal of the series is to give a chance to the architecture
> > to validate VIRTIO device features.
> 
> Michael, is this going in via your tree?

I guess so. Still not really happy about second-guessing
the hypervisor, but this got acks from others
so maybe I'm wrong in this instance. Won't be the first time.

-- 
MST

