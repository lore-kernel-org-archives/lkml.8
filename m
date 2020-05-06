Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B2CC47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F81820721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="MmdjAnPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgEFCJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgEFCJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:09:51 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF916C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 19:09:49 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k12so187624qtm.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8gbY87jwoL79rOzujZxuWgYYqNEcM3nQ5vgXMTM9zM=;
        b=MmdjAnPhIcXZFa/Uyr2pGKHtAwLyCHq71NtdsW+6NUKV0VZFYzZT7rIdvsNGn3gk3H
         0/9pErNgqlnBrxGf26yCELIuS9YkBDu6AJyKh1eOUMlYQnR8alRkBPM1355aSY3xRjcR
         v69Wai+kEuOqB5MVlfi54N/CWIjX/pOkBYe7/gZuQyAk8gWmeHtaHzFtbIrdM/mSp89l
         Py1VXrwLrpaSYt+7fZTK4vIhYXDTh1maRxX/gu/3aL8ORh7o794YvS9HJBepVNgJtlWp
         8ZmhAWcRtcJQ7wOwAuqZ5xaMVnpoc9Dfum3JwE/VoRSkLlgwSQPgbQuIz+/Fc1oK9EMF
         Gm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8gbY87jwoL79rOzujZxuWgYYqNEcM3nQ5vgXMTM9zM=;
        b=W2UEe6HFdjl3rFq+T0eGmO71q6yPfz+04EJRKwFJvOltVF5XGV/rtmDHhxq0X3y8HC
         fDO+oOPLpfmIJ7rBY0d3gAcGaglr2zGsg1pM5e5IXDB4f3+cQqiUMUfRYAO95SzREvHQ
         jyMSRGFrmkmahF6RVyWf8Q8JeWDRJ5hOAOPyCFBpvPJdJTsV3ZUjRd1BpSzQMwuboiEv
         aCMCNd+MHGpf9yt/+eepIykF288up+sSQkaIVhz1YIIX8ZRq9FVDrlkbMnHzWbpNojQW
         Evy8bEnfFeI7PEfPdEySABo9Uzo9Y/N9VLid9aSbAvudm41UoeCGwgXzYawcWVFTA+4C
         J8pQ==
X-Gm-Message-State: AGi0PuYjhZIYasgqLxUuNKza2cDmRMHRhUBia3nL9ZnWEal7kPAM3be0
        RDGt+gP0R3TJeUo5IADUJ2vUYdZq/gSkMfcLDcDLbw==
X-Google-Smtp-Source: APiQypLm3V841UNO/xQjYTQ0MN5YrL0FALdP+pBATlxbGvy3OP/IDrcxxlRnz8fLpIrZwLvOu32AXS3gBeQL+h5jtXE=
X-Received: by 2002:ac8:3877:: with SMTP id r52mr5976506qtb.47.1588730988716;
 Tue, 05 May 2020 19:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200506015947.28662-1-baolu.lu@linux.intel.com>
In-Reply-To: <20200506015947.28662-1-baolu.lu@linux.intel.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 6 May 2020 10:09:37 +0800
Message-ID: <CAD8Lp47E2CDmHTEGSpqYfxxKB4a+JY6VzZdL9e65P7YxqfL9Ag@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Replace private domain with per-group default domain
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, "Raj, Ashok" <ashok.raj@intel.com>,
        jacob.jun.pan@linux.intel.com,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 10:03 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> https://lkml.org/lkml/2020/4/14/616
> [This has been applied in iommu/next.]
>
> Hence, there is no need to keep the private domain implementation
> in the Intel IOMMU driver. This patch series aims to remove it.

I applied these patches on top of Joerg's branch and confirmed that
they fix the issue discussed in the thread:

[PATCH v2] iommu/vt-d: consider real PCI device when checking if
mapping is needed
(the patch there is no longer needed)

Tested-by: Daniel Drake <drake@endlessm.com>

Thanks!
