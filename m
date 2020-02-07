Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5210C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794CD218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IB3SDQMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGIro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:47:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39016 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGIro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:47:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so1740694wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 00:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=309I1I7pmnmndXbQ/NrLjRZ5f4RF1ubjPE99EH9brrw=;
        b=IB3SDQMetP4BY0/eWhuXAQOym90cQN+0zLfSkhbRZYzUZ74jSGXrVyDm3f4e3jqS4s
         dmWvlHVO58GacxDzmsAZSthT9AIwjna7LXWIyp92G9LWRJN7lfc8sFJ3W5X4OhlrnKRB
         lXaxxocvYowIZ9RYRJCWxgmZWPhsvOITOJrYcQijufHHhDcCbDuRHK91DfysrPHJ1VPq
         RRmugKvN9NMDF0AlrjJ6achOuMLYc+f7u6uNEogy/6ur0qedNqQsxwbdtC7ZfWWI3vBk
         MN4icM1zoWDA96M7ZqwT9cv/4gBo5MCejS38NmQ1d2O6Gah3ObeXeIxLWMN6Zc3yO7aS
         8Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=309I1I7pmnmndXbQ/NrLjRZ5f4RF1ubjPE99EH9brrw=;
        b=LvW89rrV/p801HNS2tRrfbT18q+bu7yTy641ea7Eo8zpW5RQq30PKnZbNPggdsi9LF
         pOQNI5T0FVnL9bpCyXGHqWmFbKQ67C3+qOsE3Sh70RWrGXbJ7EfZ0tJ3q3ppY9m9OcEd
         JFMNy3KM9JMYLVtj3FVUsntuTtchFs7CKGlhxPtAYDzMIL8AImSELeLRjQSRHZStr5bb
         0rW9kJk1tOsnuistTyGHsWAA9L7GQfo17AzpnRmMzayXQb0sMzffd4CnTXFXOZDz9d6L
         CoNSJE/8ME9ynQvJUdkwcz0gKovSDzkbZdVjisUOHlveGEsOnh9YiMNZtDH95CwDrxHH
         BCSA==
X-Gm-Message-State: APjAAAXpp0Locc7IfLks3NCKknBSGnPHhpDbOchUREc1/n7Eyk92M0c1
        acUmV2fft7nYlbdSuL8PNrbHTQ==
X-Google-Smtp-Source: APXvYqw3+blGRg0QVRTyhSizPcM9fuksHU15TzCcQW2Mtlnt3tqUT1gUsX+krTKQ+KNFLGHY38wGqQ==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr3116111wmj.105.1581065261841;
        Fri, 07 Feb 2020 00:47:41 -0800 (PST)
Received: from myrica ([2001:171b:c9ad:af70:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c141sm2495221wme.41.2020.02.07.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 00:47:41 -0800 (PST)
Date:   Fri, 7 Feb 2020 09:47:32 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
Message-ID: <20200207084732.GA1994440@myrica>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200129144046.3f91e4c1@w520.home>
 <20200129151951.2e354e37@w520.home>
 <20200131155125.53475a72@jacob-builder>
 <20200203112708.14174ce2@w520.home>
 <20200203124143.05061d1e@jacob-builder>
 <20200203141236.4e2d7a74@w520.home>
 <20200203144102.643f9684@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203144102.643f9684@jacob-builder>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 02:41:02PM -0800, Jacob Pan wrote:
> Yeah, that would work as well. I just feel IOMMU UAPI is unlikely to get
> updated frequently, should be much less than adding new capabilities.
> I think argsz could be viewed as the version field set by the
> user, minsz is what kernel current code supports.
> 
> So let me summarize the options we have
> 1. Disallow adding new members to each structure other than reuse
> padding bits or adding union members at the end.
> 2. Allow extension of the structures beyond union, but union size has
> to be fixed with reserved spaces
> 3. Adopt VFIO argsz scheme, I don't think we need version for each
> struct anymore. argsz implies the version that user is using assuming
> UAPI data is extension only.
> 
> Jean, Eric, any comments? My preference is #1. In the apocalyptic event
> when we run out of padding, perhaps we can introduce a new API_v2 :)

I agree, new extensions will most likely want to extend the vendor
specific structures at the end rather than introduce new common fields, so
I prefer #1 which avoids fixing the union size.

Thanks,
Jean
