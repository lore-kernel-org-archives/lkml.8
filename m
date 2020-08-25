Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF27C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7BE2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qaGf7SUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgHYKV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbgHYKVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:21:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912C3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:21:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m20so10745176eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LjRa4FQ6fIW8k3lExhbXpv5P4bFiw7U6KH50o8/5jhw=;
        b=qaGf7SUMf6jQPM2DzTed4vDnvHWuC2vRK/dPvwea/rHQbUw77IgDCVbAM8229duO92
         7kAOTXB+zSY1Q5XNRGFwDo22uoTtTYu2rkrcNbWWhk0DPKGZ69s9bGduEvj1ZBkfsFl3
         VdugzHIbNr0FBZt+8e45XJkowlpakZNt6/+Ll4XdrQ94Ozn2E++xfsKy6Ex62Vm0dCgI
         zNEZFlQbjLs8y8QD+qyJEHyscypVntkw5ILvi1n8g9wFAnIHGy1XDxhz2T7+e+DaknMC
         A1wKh0oPuLqLzoHwRoZrZijBqlG3RzRclnd7B2GJl5G8nvcpnehxLUKu/ce2+KTbMfWh
         OgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LjRa4FQ6fIW8k3lExhbXpv5P4bFiw7U6KH50o8/5jhw=;
        b=HsPgRmRnVI1uzQTpDF6vBNzQeBGvgUarD98csg/4BuBgT8V0hHI/n5hv5aHaIqv5D9
         dFRHmZjjzxYYW5hh/WhH+DBFTp4LjqVArvaVRhqLxtTsH1QXN9FKyX5UQeJwQG8cu+hE
         wA0WKYIrY0Qa7LpOISlzEZOxVsBj0apS0cBc8tf2ACeQa239crQn6PdxC5hLs/B2bjYQ
         6i0BuFDVwQI5Pd2wBJDRmGTShP2VnlDznISR6Zh7sM0x2gRzrR26YtrW/njeepKnBoTE
         Z1dNsarOUSLdV+oZwxorgwEVVT/rI74PYu+dPJut6lZf0lc/dMovKbpF4cXklQEytoAS
         ZVwQ==
X-Gm-Message-State: AOAM533/Vmp0K+tVt9BNF6nf8CRc6qJg2OrBwNaHAYxoqJR3BAJm7spH
        3wnpH8XxziiKL2NWqG7gxCjgYg==
X-Google-Smtp-Source: ABdhPJyiGqORFfeKlP8JY29iWKw1QT/obxeeskT93nDSsopvatJzI1jtO/7wBK3j51lLq2puLQOdoQ==
X-Received: by 2002:a05:6402:b32:: with SMTP id bo18mr9521784edb.201.1598350865212;
        Tue, 25 Aug 2020 03:21:05 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t22sm9816317edr.66.2020.08.25.03.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 03:21:04 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:20:48 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jacob Pan <jacob.pan.linux@gmail.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v2 4/9] iommu/ioasid: Add reference couting functions
Message-ID: <20200825102048.GB3252704@myrica>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <31af38ba-5cda-5d60-237e-f98cfc87da1b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31af38ba-5cda-5d60-237e-f98cfc87da1b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 10:26:55AM +0800, Lu Baolu wrote:
> Hi Jacob,
> 
> On 8/22/20 12:35 PM, Jacob Pan wrote:
> > There can be multiple users of an IOASID, each user could have hardware
> > contexts associated with the IOASID. In order to align lifecycles,
> > reference counting is introduced in this patch. It is expected that when
> > an IOASID is being freed, each user will drop a reference only after its
> > context is cleared.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
[...]
> > +/**
> >    * ioasid_find - Find IOASID data
> >    * @set: the IOASID set
> >    * @ioasid: the IOASID to find
> 
> Do you need to increase the refcount of the found ioasid and ask the
> caller to drop it after use? Otherwise, the ioasid might be freed
> elsewhere.

ioasid_find() takes a getter function as parameter, which ensures that the
returned data is valid. It fetches the IOASID data under rcu_read_lock()
and calls the getter on the private data (for example mmget_not_zero() for
bare-metal SVA). Given that, I don't think returning with a reference to
the IOASID is necessary. The IOASID may be freed once ioasid_find()
returns but not the returned data.

Thanks,
Jean
