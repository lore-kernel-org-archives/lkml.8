Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A79AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3978E206CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hcyn6fKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbgDANzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:55:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35959 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732774AbgDANzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:55:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so160046wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BokcsbFHdrrz/l4PyjTUoW+8uB/MqRMjCTweSlnNCdg=;
        b=Hcyn6fKHUAWfyXHU0AQI42LD9l04dXQT2av71U4PkGbjP1d8X5ejQCIr6m6I8zply1
         y8ng/jzsrvOEIlv8YqJZzMFhcwDwbkuyqlz2yvuRbQVyaqUGswaO9CNCy9IrzGWiN8hT
         cFE+955zBtH6yc/aEP2P52gHsEhgURQjFPIZpzhw3Hze/Fc5q/uyfnDn8FSctAt65FG9
         9kM1BSabVwbx+rvRSKTrXaLxMRAyfQNDJ23fZKm86OfAiSB69A6ywoCoKMJHavK0GPO/
         y6FOyxUw98OPpXYcbhlSDeKwSp23hkf8OsdgmqtEUQoqQguBvFBe70cMzXxajkFcMHGT
         w23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BokcsbFHdrrz/l4PyjTUoW+8uB/MqRMjCTweSlnNCdg=;
        b=cyxkIVmAaep5EyXQuNGSFbjVZMRM+Zhe7jOZuuASwu2xsAxGL7diZTSAkp5AjUWZ3W
         djf45GAgNYMT/ynKAEYfQYXE9Fq87felyPUq5zpL4QhpxsgMjjoNggGMyNSk+NVHtsYG
         6L/Xpy+lZjEDzBmJ9wOmQvA5KJy/l3KSZ3Um5SUvryUBPTpseIW3p5JDv4S5LcJ+e0pe
         fFd270HxBXuTikEIthYPWnQFoRKn9uUAyi+fC5VNzQekr/2ynqw5QfJiLxPIb84gyYmC
         oj9IpEDawjEV4yM0CH6tPIe/v48sf8AZAUaUA15eEmwysJ+dLbu7tVjxG9p6lm1FIu2s
         VDyA==
X-Gm-Message-State: ANhLgQ19+rTrfHykspME2VtJOOVI4HecZUvL9ONDu4GKCayP1LiHmmW6
        pbS5UjeVs2f8it9SVPribSsQXA==
X-Google-Smtp-Source: ADFU+vtmh9pjwAtzFVJ9AOztFnbZs+VXIuHpNaBbP7+Bz5tpaP97qcOdEJJmKnjKxhSpeN/c6TG6Bw==
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr25721435wrh.7.1585749333948;
        Wed, 01 Apr 2020 06:55:33 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
        by smtp.gmail.com with ESMTPSA id c189sm2853560wmd.12.2020.04.01.06.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 06:55:33 -0700 (PDT)
Date:   Wed, 1 Apr 2020 15:55:25 +0200
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
Subject: Re: [PATCH 06/10] iommu/ioasid: Convert to set aware allocations
Message-ID: <20200401135525.GG882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-7-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585158931-1825-7-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:55:27AM -0700, Jacob Pan wrote:
> The current ioasid_alloc function takes a token/ioasid_set then record it
> on the IOASID being allocated. There is no alloc/free on the ioasid_set.
> 
> With the IOASID set APIs, callers must allocate an ioasid_set before
> allocate IOASIDs within the set. Quota and other ioasid_set level
> activities can then be enforced.
> 
> This patch converts existing API to the new ioasid_set model.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

[...]

> @@ -379,6 +391,9 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  	}
>  	data->id = id;
>  
> +	/* Store IOASID in the per set data */
> +	xa_store(&sdata->xa, id, data, GFP_KERNEL);

I couldn't figure out why you're maintaining an additional xarray for each
set. We're already storing that data in active_allocator->xa, why the
duplication?  If it's for the gPASID -> hPASID translation mentioned by
the cover letter, maybe you could add this xa when introducing that
change?

Thanks,
Jean

