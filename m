Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4B1C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABF720757
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AN0/jotY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCTJni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:43:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35634 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTJnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:43:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so6624592wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lYxvjXA9SuRqdZ2yHHpJOFiSDlizNvxYxQBAXFzGsQM=;
        b=AN0/jotY82HkOV40gcAtQ6S/IqIUIIOT0kFkdTYMalnn8PgFiMqhSgdS4obDDhJv/d
         VK6mkXj5WYfZ6uDDyCSyns/IuVPNHC7APKVKGC5BZqIGehAvyMXND3T0SwVY4uotygYC
         HYESDVGXpZ6PW4rU1oTHLRVwExmqzGaTG4R14+9DiQt9lQziGrNBkhSu1jz3HuMxh9FM
         gdoVDBZFI5YAyKVqgEAGej7HEWqxZbj2MAnhktqo+mdY+gvdf2SRLThr9a2YCNJmN0Te
         eC4mWE14h7Ttk3kgfN/CJ0lVdA5Aa/G06NCdpSu5AMd6CEL66UmrGqTLHrEVE69T1hGY
         bKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lYxvjXA9SuRqdZ2yHHpJOFiSDlizNvxYxQBAXFzGsQM=;
        b=Yl6FURUmiuhvS4tkiQtukFKW+eLLKWxbAiFjXS27lszByAfOPDjaA2jFMqewOzWkYr
         mp9R+QWr5Zn4DylcKFwkWZRolk8N2QbB5ZXso+W+8hkyslxzTZz5yQtCFInBLp5Pt6ey
         eRDb3N6wIQoAJrVY68lkET2sktoFGyx5I+nm/73h+2uqoiR9G+5XDlcDqDCmA6Gk9Sn+
         bAbTmj3w5orJmftrFGeRixIV7enWM8Do0f3sQKqKoqrg2aFp2YE5xTTLq/DNV/5TGwKH
         IkgMvsW3PbNNWmLkbuDAlIeKw34Hdauxyr6lxM32rTjOOE3michFcv1Wv6YW0KF8ECiA
         yT+g==
X-Gm-Message-State: ANhLgQ10Rtva6uOH7aTJE15tR7LIuym9EEDYHe78TV1UeExYACD4CLVQ
        SPeuHRo2fzkTEQWQ0VISZf0ozTGxZmk=
X-Google-Smtp-Source: ADFU+vs0OaE+k3p1TmQgvJ0/q3PZZxrH9T9K2EGNdAaKfRF6SRtzcOgiqRgrusNm3EepCULGlvNNJw==
X-Received: by 2002:a5d:4b8e:: with SMTP id b14mr9264279wrt.33.1584697415630;
        Fri, 20 Mar 2020 02:43:35 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n1sm7532148wrj.77.2020.03.20.02.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 02:43:35 -0700 (PDT)
Date:   Fri, 20 Mar 2020 10:43:28 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Replace intel SVM APIs with generic SVA
 APIs
Message-ID: <20200320094328.GC1702630@myrica>
References: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1582586797-61697-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200320092955.GA1702630@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320092955.GA1702630@myrica>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 10:29:55AM +0100, Jean-Philippe Brucker wrote:
> > - success:
> > -	*pasid = svm->pasid;
> > +success:
> > +	sdev->pasid = svm->pasid;
> > +	sdev->sva.dev = dev;
> > +	if (sd)
> > +		*sd = sdev;
> 
> One thing that might be missing: calling bind() multiple times with the
> same (dev, mm) pair should take references to the svm struct, so device
> drivers can call unbind() on it that many times.

Please disregard this, I missed sdev->users

Thanks,
Jean

