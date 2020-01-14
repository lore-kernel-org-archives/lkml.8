Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECD0C33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBBF24680
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579012782;
	bh=lOs37hOnrQT7SgscZsq92ePpEfahhgnQ+dSZoT0y7oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IL0kPu4EMq2MsyeWKdMudKBUHSp+7cqBtwnevmKTBN/4ixmbKNnOizZYRxP5fq0y0
	 P/XK6hSXEZO3P3kn//kAI/cO3HKcHomfieSJFSb6BPXVmWhi0ig4Lv0mJ0U0ISbhve
	 jrWAAlwH/upcq7FAAdTdzXDyNBiZcDCOLbxZ2c4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgANOjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgANOjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:39:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0F252467D;
        Tue, 14 Jan 2020 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579012781;
        bh=lOs37hOnrQT7SgscZsq92ePpEfahhgnQ+dSZoT0y7oQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hrK2wvGXQfIEz4bWCjxUo4o0RYzhmYTLWQes8JS2a1oI5LJ4eg66VqZmfRYCFNt7r
         tAwTTIz6Z2taxIcYupEufpQ8wgZdwDC4vfvyH21OjsbbRHu3Ol4xjKmkf7lMkgWLsn
         ko/+zhVejeenrz1fj7k7zcPzBEwUBEmF33it5Ffo=
Date:   Tue, 14 Jan 2020 15:39:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Cui, Flora" <Flora.Cui@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 5.4 24/78] drm/amdgpu: add DRIVER_SYNCOBJ_TIMELINE to
 amdgpu
Message-ID: <20200114143938.GA1859808@kroah.com>
References: <20200114094352.428808181@linuxfoundation.org>
 <20200114094356.995503791@linuxfoundation.org>
 <CH2PR12MB3912AB5EEE1BBD2B20D71424F7340@CH2PR12MB3912.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH2PR12MB3912AB5EEE1BBD2B20D71424F7340@CH2PR12MB3912.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 02:31:26PM +0000, Deucher, Alexander wrote:
> [AMD Public Use]
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Tuesday, January 14, 2020 5:01 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > stable@vger.kernel.org; Zhou, David(ChunMing) <David1.Zhou@amd.com>;
> > Cui, Flora <Flora.Cui@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: [PATCH 5.4 24/78] drm/amdgpu: add DRIVER_SYNCOBJ_TIMELINE to
> > amdgpu
> > 
> > From: Chunming Zhou <david1.zhou@amd.com>
> > 
> > commit db4ff423cd1659580e541a2d4363342f15c14230 upstream.
> > 
> > Can expose it now that the khronos has exposed the vlk extension.
> > 
> > Signed-off-by: Chunming Zhou <david1.zhou@amd.com>
> > Reviewed-by: Flora Cui <Flora.Cui@amd.com>
> > Reviewed-by: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> 
> This can be dropped for 5.4.  According to ChunMing, there is missing functionality in 5.4 so it's not required.

Ok, thanks for letting me know, now dropped.

greg k-h
