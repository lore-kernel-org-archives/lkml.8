Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E69C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B199420775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsO97eGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgD2JwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:52:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22799 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2JwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588153932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7IZWphU6PtHquCqE0i6um38oK8paShAt54dfHnz8KmQ=;
        b=CsO97eGEro2k/1INTTfYCmqXYsEZCa94o+Uc9h222lwfBC2Qp9/eY2eRzR4EPG0SNO4Kh9
        oF/CCAbvdItLITpSscG5xrVmYYWhZTHVzcBp4YHreXkbBLDgqCaEh0AUpjgLwpsZnH++Tj
        pyoUGCesv002+pJ+R9jnE26+3AGKFqY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-3afm3bLfPB-2rngRqcUbIQ-1; Wed, 29 Apr 2020 05:52:11 -0400
X-MC-Unique: 3afm3bLfPB-2rngRqcUbIQ-1
Received: by mail-wr1-f70.google.com with SMTP id p2so1447174wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 02:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7IZWphU6PtHquCqE0i6um38oK8paShAt54dfHnz8KmQ=;
        b=eLBomcssjpplmoOlixHM23l0E7QYH+DIehCNrqToxJez36vliZAOv6xLFIVdiwjkAE
         VQ728R+UtQfNyBDfCljMUgdwSJAzTsD4T7mWHVBl4CGpRZ4/1bzyQWGDDP21VgDLAmNW
         lEawercJa8a5gzpiivvwFD1FyfvBpQD8EMJlTnWEo86fYF/g/yNrJk5glALrWpF+BaRF
         D4V2300Aom1Rb0jO0cvDObPCq7MtN/qqBGfS0L6NgS2+/52Q1FZvAYJBvw56m/JgWvK0
         YpWHp97e5eyMCWHRHEd0thzL1KZKNjhAgBReF85nU5IqvDK47/NlN60Q1tYNQ/jnDVQQ
         Vohg==
X-Gm-Message-State: AGi0PubmvJAXVTvIzjnjfWSa8naf8f4R5OisBOA/E4jCpiJaUI+q+ima
        6lI6d6W+Gg+uxGZ3DaqXmwKqst7RSOqdCUfCS2nQqQ4uCC/27rt7RfcfCIC8zrtoYzjqrTDLSUy
        txew2B9/upii6FbnIuHm/9NnO
X-Received: by 2002:a5d:6851:: with SMTP id o17mr37134241wrw.267.1588153929722;
        Wed, 29 Apr 2020 02:52:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypKRdM34lQ/3OGcwItQoxnplrvwZwErBKY2jH3AvTLAgP599BhH8xTgBBhPvAXTcnaVguo7aJg==
X-Received: by 2002:a5d:6851:: with SMTP id o17mr37134206wrw.267.1588153929489;
        Wed, 29 Apr 2020 02:52:09 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id s24sm7232898wmj.28.2020.04.29.02.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 02:52:08 -0700 (PDT)
Date:   Wed, 29 Apr 2020 05:52:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, tsoni@codeaurora.org,
        virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com,
        jan.kiszka@siemens.com, jasowang@redhat.com,
        christoffer.dall@arm.com,
        virtualization@lists.linux-foundation.org, alex.bennee@linaro.org,
        iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        pratikp@codeaurora.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429055125-mutt-send-email-mst@kernel.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429094410.GD5097@quicinc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 03:14:10PM +0530, Srivatsa Vaddagiri wrote:
> * Michael S. Tsirkin <mst@redhat.com> [2020-04-29 02:50:41]:
> 
> > So it seems that with modern Linux, all one needs
> > to do on x86 is mark the device as untrusted.
> > It's already possible to do this with ACPI and with OF - would that be
> > sufficient for achieving what this patchset is trying to do?
> 
> In my case, its not sufficient to just mark virtio device untrusted and thus
> activate the use of swiotlb. All of the secondary VM memory, including those
> allocate by swiotlb driver, is private to it.

So why not make the bounce buffer memory shared then?

> An additional piece of memory is
> available to secondary VM which is shared between VMs and which is where I need
> swiotlb driver to do its work.
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

