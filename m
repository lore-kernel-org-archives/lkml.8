Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AFEC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B013C2074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fuWEoD/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgDIXba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:31:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45241 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgDIXb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 19:31:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id w11so202442pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 16:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZkCPBxxxyjSx1oGDDyt3nqc/uvcZpVvRJITDOMA3zxE=;
        b=fuWEoD/XFcHkrla7dX8M4ijHH1Z+/O/saTKokpSm7SO9G2hVpT7AB3ekqHRvcftqVU
         yX59m7l+c9k2M/J1FKQtnPpz+9HwqkPIS42tskaufVbXLMtZXYFW0apDvgLoQca/ykdF
         eRmD7/0a4g8vckwgsGXGoj6mqkGyP+VmyUVj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZkCPBxxxyjSx1oGDDyt3nqc/uvcZpVvRJITDOMA3zxE=;
        b=XQ/KuX9i4XrvfveicYsQKnsdX2FOY1Qn7nwkotU2DRgWh0UMSB6GT3oR9TXf0suLls
         MILDoskpxhKx0Lc0AW7XfGo56PN0Z8Ir1U9dZbPLGuLekvQAM97AP1dviaLcG5M1Goxe
         Gw7BcJfcNbMxIu6pn9QoJIKet77xz+v9J3WLGA+2LSSkI9+9G0h8aLVl0/AjS3L+Q40W
         D0kDFprz+pUpQM2JXER8fvnoMc6gjv13ENTa5CNPnDVSW1nXcl3yXktW+7Et8QA89VRX
         blHx7cQ3JC6w6B0hYmVG6oeZMNxLF2AaiOrSIr0fO0TLmpa+3HD/Dey4crUigyI1SMF1
         xnOQ==
X-Gm-Message-State: AGi0PuYrZAmZ3m/URrWGtAVc9AQXN1uXJqeNjg5Q8hEx+e9hy40TgJNy
        eXP7fDYq8jpzGDzt5T1QUMZl6A==
X-Google-Smtp-Source: APiQypLeHsiNvXa0fC/JPIAYREoiHIIj7McMv+L0VkX3HCS8JHN0sjKPyH19uJztvV+NMbXtBVLxZg==
X-Received: by 2002:a63:ee4f:: with SMTP id n15mr1817524pgk.149.1586475087419;
        Thu, 09 Apr 2020 16:31:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id v25sm186190pgl.55.2020.04.09.16.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 16:31:26 -0700 (PDT)
Date:   Thu, 9 Apr 2020 16:31:24 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH 0/2] iommu/arm-smmu: Allow client devices to select
 direct mapping
Message-ID: <20200409233124.GW199755@google.com>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <7761534cdb4f1891d993e73931894a63@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7761534cdb4f1891d993e73931894a63@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 11:12:17PM +0530, Sai Prakash Ranjan wrote:
> Hello Robin, Will
> 
> On 2020-01-22 17:18, Sai Prakash Ranjan wrote:
> > This series allows drm devices to set a default identity
> > mapping using iommu_request_dm_for_dev(). First patch is
> > a cleanup to support other SoCs to call into QCOM specific
> > implementation and preparation for second patch.
> > Second patch sets the default identity domain for drm devices.
> > 
> > Jordan Crouse (1):
> >   iommu/arm-smmu: Allow client devices to select direct mapping
> > 
> > Sai Prakash Ranjan (1):
> >   iommu: arm-smmu-impl: Convert to a generic reset implementation
> > 
> >  drivers/iommu/arm-smmu-impl.c |  8 +++--
> >  drivers/iommu/arm-smmu-qcom.c | 55 +++++++++++++++++++++++++++++++++--
> >  drivers/iommu/arm-smmu.c      |  3 ++
> >  drivers/iommu/arm-smmu.h      |  5 ++++
> >  4 files changed, 65 insertions(+), 6 deletions(-)
> 
> Any review comments?

Ping

What is the status of this series, is it ready to land or are any changes
needed?

Thanks

Matthias
