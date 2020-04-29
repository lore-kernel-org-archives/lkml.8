Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752A3C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51ABA2072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbULZWEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgD2KpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:45:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24838 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726523AbgD2KpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588157116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ivrbfu7nXm6urIi13dgUtl5GkaF/JA7ff8SBWPZh/VU=;
        b=CbULZWEbZAKH9bV+G8IywQ2Nrlwm0X/us8Vph1uNAI+3tt4/n+Sc6HBfYjMWUDJ03wY8cQ
        yWCbaONHY5XfUXnQUFlm4DEYH2dqlura8NS7Vc/uxjUS3J8mRoRu0Tx4gWoehtm3sJXwKr
        qMAZZvstaD885/aEtu4ULUo1M/NRAJ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-98v2esonMKOv-L-uhbnRpw-1; Wed, 29 Apr 2020 06:45:15 -0400
X-MC-Unique: 98v2esonMKOv-L-uhbnRpw-1
Received: by mail-wr1-f72.google.com with SMTP id v9so1515908wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ivrbfu7nXm6urIi13dgUtl5GkaF/JA7ff8SBWPZh/VU=;
        b=DC284IhM2xZq8Sw+CPzVOh33tNm2RBkGOtx7enzo3YsysHuN7bX8UGI2RaaU95GHMq
         CxGv/adINnAUkBgoM9fMo225M8E0zFGcDy/Nb8dFD0K2IoJ24tJ36u0VIH2Ht2JpH8+x
         BsE3K+rxY/lxfBDd5VyaZEly8peMrC5M2S+Y3h4opRM4KTdB00ksIcZ59b80t0F7LfJ7
         5yHlaX2spoTLkqMjbnrC/qKLkVGqKfupgy1ar/B4yrE2Lb5qNplpl/OnnlKku9A9TEWz
         IsGEiZPDxyw4MgrKRsOOdPRz9dK9N3a6/M5+2QKlhGsOQyQFp6pZEZ+K7BfDLJpyee2x
         Wy9Q==
X-Gm-Message-State: AGi0PuZxPE25Gn7/KDLhINgHR2W495SOWwRJoLB7+HIRoN54MBHoFtS2
        9Des06Wjrxf1gnURg/iHaHTqFInoJO+bXC6OGqSt3P3735ytmjmuUN5Lu/T55X3WAaHJCoTuADx
        tsWMFlffynUfhZCW4F83N90Md
X-Received: by 2002:a1c:770f:: with SMTP id t15mr2494528wmi.178.1588157114025;
        Wed, 29 Apr 2020 03:45:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypLWNbQEy2iyMW7HWmtuY5GYzKFC5cfUOhqKta7BJe6nQlsQf8vGhfuT+8lQWfwqNmKnzgzCfQ==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr2494510wmi.178.1588157113807;
        Wed, 29 Apr 2020 03:45:13 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id y70sm7706812wmc.36.2020.04.29.03.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:45:13 -0700 (PDT)
Date:   Wed, 29 Apr 2020 06:45:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Srivatsa Vaddagiri <vatsa@codeaurora.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, tsoni@codeaurora.org,
        virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com,
        jasowang@redhat.com, christoffer.dall@arm.com,
        virtualization@lists.linux-foundation.org, alex.bennee@linaro.org,
        iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        pratikp@codeaurora.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429064458-mutt-send-email-mst@kernel.org>
References: <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
 <20200429055125-mutt-send-email-mst@kernel.org>
 <20200429100953.GE5097@quicinc.com>
 <20200429061621-mutt-send-email-mst@kernel.org>
 <f52556e2-253e-2dbc-cb7a-a7991e3bcfde@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52556e2-253e-2dbc-cb7a-a7991e3bcfde@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:26:43PM +0200, Jan Kiszka wrote:
> On 29.04.20 12:20, Michael S. Tsirkin wrote:
> > On Wed, Apr 29, 2020 at 03:39:53PM +0530, Srivatsa Vaddagiri wrote:
> > > That would still not work I think where swiotlb is used for pass-thr devices
> > > (when private memory is fine) as well as virtio devices (when shared memory is
> > > required).
> > 
> > So that is a separate question. When there are multiple untrusted
> > devices, at the moment it looks like a single bounce buffer is used.
> > 
> > Which to me seems like a security problem, I think we should protect
> > untrusted devices from each other.
> > 
> 
> Definitely. That's the model we have for ivshmem-virtio as well.
> 
> Jan

Want to try implementing that?

> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

