Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3A8C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E4C20787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJVoxwSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbgDAODO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:03:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51891 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732843AbgDAODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:03:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id z7so4057740wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 07:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BZh/ep1PwflYg/TcVbQWbI9WFDXF6Zf/SxB/stv9Mls=;
        b=iJVoxwSIw2BIZ9rBNHiu4pE8g1NRc7+PSPp8la7NhJdpFxjHDKyGinpPbVA1bDBaLy
         JWfME5yxhkc0t37BG7HoUNLT70weCKWmItcDq5pcwKANEh1mfSNCHu+WNxUOuM90Evj3
         ZLzyrwwdewYiP+Z/VKq5UJvhZ29tuA1NFNz/n2e8pAk+s3dnA12Ql+oP4EJ71n2k5wJZ
         TO18IJqyFdcr9oOGeS/goHgQt2Bn0WgayCd4kyqLcx1v+uoPQpObXXJ5HS1ugxgEcox4
         7LWh57pxFDBkrYWVopK6w27ruQetrT4T7a1RAyR6Ast04V8tGXwqOp0ISbts6Riw+0hy
         zgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BZh/ep1PwflYg/TcVbQWbI9WFDXF6Zf/SxB/stv9Mls=;
        b=moQOEeQOInhglOksI+8XGMHfXcpoEMcsZrOBQFqWwgKiVNlAXIFIRu98lTu3jk2Zw6
         +x3scV3TECE/aqMT2zZWPGRovaiFYBb/2tdtjz6/PD/vjs3J1jT/q1cHrQI/pvQ1dKn5
         Ck9to0FMPfD/jn3vZn1RHazbbhBPi4taPWFK9NyUrurATfqE2OX/lQZFIeWPpuiEqGle
         OyOq5P0vWMYb0YypLpMJh8fGh+Y5wSTedJnUW0P830hc7OZKcpYBSKdGmQpsZbtAQFRh
         wqDSauQ/7LYZr5c4q94lY2BHhj4O5WuiX9saVpQn24Po6ezA38fAMDkPMQ2jCk/14tOR
         PLQA==
X-Gm-Message-State: AGi0PuZ61WNyhL3ejo2rBHPcLm6Ln1UINPRAoIoF0r0HmlTlvtue1kFu
        ihlev0DudA5G+45zaE5lO7Gb7w==
X-Google-Smtp-Source: APiQypK9DSjnsSakIQglnIUiMrqd7eWrNRxGsgEAIFwatDbnZWJ4FFPhmKQLr32+hb+lvqulo78TJg==
X-Received: by 2002:a1c:7216:: with SMTP id n22mr4371537wmc.41.1585749789988;
        Wed, 01 Apr 2020 07:03:09 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
        by smtp.gmail.com with ESMTPSA id 71sm3267508wrc.53.2020.04.01.07.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 07:03:09 -0700 (PDT)
Date:   Wed, 1 Apr 2020 16:03:01 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 00/10] IOASID extensions for guest SVA
Message-ID: <20200401140301.GJ882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On Wed, Mar 25, 2020 at 10:55:21AM -0700, Jacob Pan wrote:
> IOASID was introduced in v5.5 as a generic kernel allocator service for
> both PCIe Process Address Space ID (PASID) and ARM SMMU's Sub Stream
> ID. In addition to basic ID allocation, ioasid_set was introduced as a
> token that is shared by a group of IOASIDs. This set token can be used
> for permission checking but lack of some features needed by guest Shared
> Virtual Address (SVA). In addition, IOASID support for life cycle
> management is needed among multiple users.
> 
> This patchset introduces two extensions to the IOASID code,
> 1. IOASID set operations
> 2. Notifications for IOASID state synchronization

My main concern with this series is patch 7 changing the spinlock to a
mutex, which prevents SVA from calling ioasid_free() from the RCU callback
of MMU notifiers. Could we use atomic notifiers, or do the FREE
notification another way?

Most of my other comments are just confusion on my part, I think, as I
haven't yet properly looked through the VFIO and VT-d changes. I'd rather
avoid the change to ioasid_find() if possible, because it adds a seemingly
unnecessary indirection to the fast path, but it's probably insignificant.

Thanks,
Jean

> 
> Part #1:
> IOASIDs used by each VM fits naturally into an ioasid_set. The usage
> for per set management requires the following features:
> 
> - Quota enforcement - This is to prevent one VM from abusing the
>   allocator to take all the system IOASIDs. Though VFIO layer can also
>   enforce the quota, but it cannot cover the usage with both guest and
>   host SVA on the same system.
> 
> - Stores guest IOASID-Host IOASID mapping within the set. To
>   support live migration, IOASID namespace should be owned by the
>   guest. This requires per IOASID set look up between guest and host
>   IOASIDs. This patchset does not introduce non-identity guest-host
>   IOASID lookup, we merely introduce the infrastructure in per set data.
> 
> - Set level operations, e.g. when a guest terminates, it is likely to
> free the entire set. Having a single place to manage the set where the
> IOASIDs are stored makes iteration much easier.
> 
> 
> New APIs are:
> - void ioasid_install_capacity(ioasid_t total);
>   Set the system capacity prior to any allocations. On x86, VT-d driver
>   calls this function to set max number of PASIDs, typically 1 million
>   (20 bits).
> 
> - int ioasid_alloc_system_set(int quota);
>   Host system has a default ioasid_set, during boot it is expected that
>   this default set is allocated with a reasonable quota, e.g. PID_MAX.
>   This default/system set is used for baremetal SVA.
> 
> - int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int
> *sid);
>   Allocate a new set with a token, returned sid (set ID) will be used
>   to allocate IOASIDs within the set. Allocation of IOASIDs cannot
>   exceed the quota.
> 
> - void ioasid_free_set(int sid, bool destroy_set);
>   Free the entire set and notify all users with an option to destroy
>   the set. Set ID can be used for allocation again if not destroyed.
> 
> - int ioasid_find_sid(ioasid_t ioasid);
>   Look up the set ID from an ioasid. There is no reference held,
>   assuming set has a single owner.
> 
> - int ioasid_adjust_set(int sid, int quota);
>   Change the quota of the set, new quota cannot be less than the number
>   of IOASIDs already allocated within the set. This is useful when
>   IOASID resource needs to be balanced among VMs.
> 
> Part #2
> Notification service. Since IOASIDs are used by many consumers that
> follow publisher-subscriber pattern, notification is a natural choice
> to keep states synchronized. For example, on x86 system, guest PASID
> allocation and bind call results in VFIO IOCTL that can add and change
> guest-host PASID states. At the same time, IOMMU driver and KVM need to
> maintain its own PASID contexts. In this case, VFIO is the publisher
> within the kernel, IOMMU driver and KVM are the subscribers.
> 
> This patchset introduces a global blocking notifier chain and APIs to
> operate on. Not all events nor all IOASIDs are of interests to all
> subscribers. e.g. KVM is only interested in the IOASIDs within its set.
> IOMMU driver is not ioasid_set aware. A further optimization could be
> having both global and per set notifier. But consider the infrequent
> nature of bind/unbind and relatively long process life cycle, this
> optimization may not be needed at this time.
> 
> To register/unregister notification blocks, use these two APIs:
> - int ioasid_add_notifier(struct notifier_block *nb);
> - void ioasid_remove_notifier(struct notifier_block *nb)
> 
> To send notification on an IOASID with one of the commands (FREE,
> BIND/UNBIND, etc.), use:
> - int ioasid_notify(ioasid_t id, enum ioasid_notify_val cmd);
> 
> This work is a result of collaboration with many people:
> Liu, Yi L <yi.l.liu@intel.com>
> Wu Hao <hao.wu@intel.com>
> Ashok Raj <ashok.raj@intel.com>
> Kevin Tian <kevin.tian@intel.com>
> 
> Thanks,
> 
> Jacob
> 
> Jacob Pan (10):
>   iommu/ioasid: Introduce system-wide capacity
>   iommu/vt-d: Set IOASID capacity when SVM is enabled
>   iommu/ioasid: Introduce per set allocation APIs
>   iommu/ioasid: Rename ioasid_set_data to avoid confusion with
>     ioasid_set
>   iommu/ioasid: Create an IOASID set for host SVA use
>   iommu/ioasid: Convert to set aware allocations
>   iommu/ioasid: Use mutex instead of spinlock
>   iommu/ioasid: Introduce notifier APIs
>   iommu/ioasid: Support ioasid_set quota adjustment
>   iommu/vt-d: Register PASID notifier for status change
> 
>  drivers/iommu/intel-iommu.c |  20 ++-
>  drivers/iommu/intel-svm.c   |  89 ++++++++--
>  drivers/iommu/ioasid.c      | 387 +++++++++++++++++++++++++++++++++++++++-----
>  include/linux/intel-iommu.h |   1 +
>  include/linux/ioasid.h      |  86 +++++++++-
>  5 files changed, 522 insertions(+), 61 deletions(-)
> 
> -- 
> 2.7.4
> 
