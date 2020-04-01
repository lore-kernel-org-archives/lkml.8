Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED093C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6C4206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzmEe8Wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbgDAOAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:00:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32783 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732783AbgDAOAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:00:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so208474wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7rS/8GAVkEamS2Iw0cTDnTD2JAlO3q0kknKABrOv+d8=;
        b=MzmEe8Wb1f4sYGiJmM/FaLWztqC5DpKffgfWvkmSMbDUSKl/5csxUbFnp2rh1rRYxs
         ab0BaMovVvXe39LftLGa1bpjTKqwju0QfjYj7kH/IRXTrKVr0BH9wuz73PVUigZya9ta
         uyMfaAKFZ0V8HqWLCbSlP5VfjdSwHhWfcIBlqSH64R9bOD+8VyLK4n47eFxqf038ci/Q
         VTZ5qrtE3sRpWzx5GwWyhtoqRm3lsODzbMD/NL0mhfeOQihZpbpsSbD44GqA0Mclmx1M
         XMlYygz8TatBnLWtDdPQOn/XuCMST+rR4XvKbnqZCKFRqtbLOaRsmp4Q/uiEzqhvtRTO
         B6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7rS/8GAVkEamS2Iw0cTDnTD2JAlO3q0kknKABrOv+d8=;
        b=YupN+1OsVBjw8f0L1eiBCs++TW1B000CvE9bx32uF1FhWiQrbg9grkk3D2lPoh8FkE
         rgWGkCNBlb98EnH+fZXbT+ShwxoeObdJ3bHZNeegBMD1Af85lBSBCpWuR+0S8zpH2DEC
         IDOPd6c4mbBlEgAgakQEyGiUW/NlvMUJdMKUWcRgE1Q6i8W4ngE9mhVAGt+WpVowauv7
         nMqpYcKQwvIqbFN06shvHy43yAuyQyjdxuHguYfPY/UT8YRwGnDmVbRSXbqszpI9aU80
         9NToCgUfMvlG16ZlVVYnYrUHs3NSW5kXOyY4jIp/TRAl0KCacYwIJyJJfb3qYZW5LjgQ
         C54g==
X-Gm-Message-State: ANhLgQ0/H4ycrFdrA4gyMh3NwMmcJRC+Wz2NkdHwyu7NVFFRAiyeKe1u
        WJoMGaWar9beFaUwqs3Xt786UB2Zd9E=
X-Google-Smtp-Source: ADFU+vveXkKZf5++LKfsqGZzL6IVUMB7L+TaJuGsujpDR3D5zTli+cX5tEZUdUtZJLYdCR8P3IaCPQ==
X-Received: by 2002:a5d:604a:: with SMTP id j10mr25552947wrt.126.1585749615283;
        Wed, 01 Apr 2020 07:00:15 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
        by smtp.gmail.com with ESMTPSA id 19sm2765896wmi.32.2020.04.01.07.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 07:00:14 -0700 (PDT)
Date:   Wed, 1 Apr 2020 16:00:06 +0200
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
Subject: Re: [PATCH 08/10] iommu/ioasid: Introduce notifier APIs
Message-ID: <20200401140006.GI882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-9-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585158931-1825-9-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:55:29AM -0700, Jacob Pan wrote:
> IOASID users fit into the publisher-subscriber pattern, a system wide
> blocking notifier chain can be used to inform subscribers of state
> changes. Notifier mechanism also abstracts publisher from knowing the
> private context each subcriber may have.
> 
> This patch adds APIs and a global notifier chain, a further optimization
> might be per set notifier for ioasid_set aware users.
> 
> Usage example:
> KVM register notifier block such that it can keep its guest-host PASID
> translation table in sync with any IOASID updates.

When you talk about KVM, is it for

  [PATCH 0/7] x86: tag application address space for devices

or something else as well? (I don't see mentions of KVM in that series)

> 
> VFIO publish IOASID change by performing alloc/free, bind/unbind
> operations.

I was rather seeing IOASID as the end of the VFIO-IOMMU-IOASID chain,
putting it in the middle complicates locking. If you only need to FREE
notifier for this calse, maybe VFIO could talk directly to the IOMMU
driver before freeing an IOASID?  gpasid_unbind() should already clear the
PASID contexts, no?

Thanks,
Jean

> IOMMU driver gets notified when IOASID is freed by VFIO or core mm code
> such that PASID context can be cleaned up.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
