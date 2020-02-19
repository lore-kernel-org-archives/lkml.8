Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8965C5ACC4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13642465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ei3vKDzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgBSXzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:55:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52181 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726613AbgBSXzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582156521;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type; bh=gVZETO5ToPW9ORza98Ii24fKRNVEYxysJCTkt8Xpckw=;
        b=Ei3vKDzRLMehLGiO7JJUoEJWFVhwfYnmfVQ57XE0oPqFYrVtD2tD/n7npYmnAmN9FCQJ8c
        TLQkvYrNDZ8TJHEo63yXHHtUlJPUje63C2i/brVZ7PiWoDMKCEla2WW4GUfd3iR7HUKPTU
        ibz7yeQAOfDCpDwpTTkQtZ8yiC4hP2Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-LWYBNX4MPUu7TMq7ka3Akg-1; Wed, 19 Feb 2020 18:55:19 -0500
X-MC-Unique: LWYBNX4MPUu7TMq7ka3Akg-1
Received: by mail-qt1-f197.google.com with SMTP id p12so1387489qtu.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 15:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:mime-version:content-disposition;
        bh=gVZETO5ToPW9ORza98Ii24fKRNVEYxysJCTkt8Xpckw=;
        b=UfweLVPABEmMajOuD+IX1VnsNY4e9Aln/k7eiK07CVN+F6/3Ly4vlDnPdXLTnX79zu
         sKDuXsdUpZHNmGC7d7l/jzEgY919ov1mobGAIaPehg2yC1m7MIZlzjE/ysSpdnokyPGi
         CQpZVU87WOSVSU25BAM5UNhA2Z6whcPbVmY+CmfBv3XjZrFWFXHm1dvaeclrnmWPE3kw
         sXVLdjcQePq7+/z5hPX6jpWl226IPiN+S3dG2RqTcgMTIVZpHa+i/nWSAKbBTqPM5ivv
         RIJwzJOTuucOnv3FKOhRfMMr3d2wDwrHI1jeHncYk1Cmw8Ub5hFzwJ4YlmZpJtCORIJj
         i0wg==
X-Gm-Message-State: APjAAAWHpcDwRlbLNaDeSw+73HtnFG/UlO7KmNvFip+B4ZlAkW6lSgUm
        YKlb4LD6hlfHy1Mc/UcxZaNmDdA8r0P69jlm1XRtUDTmC7Gx5g6vsN9aOIyIAMUrAKY/MEVqMFo
        9K5kzMtbTaU1vum4sTUXgaCD6
X-Received: by 2002:ac8:7773:: with SMTP id h19mr24151852qtu.144.1582156518743;
        Wed, 19 Feb 2020 15:55:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLk9mkKQYUXT76ax9fqf+CkQQ7t28OAi5KYr4prqEib7SPchhm8V2sj9zWJCebg67zNz8Iwg==
X-Received: by 2002:ac8:7773:: with SMTP id h19mr24151842qtu.144.1582156518440;
        Wed, 19 Feb 2020 15:55:18 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id z6sm849662qto.86.2020.02.19.15.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 15:55:17 -0800 (PST)
Date:   Wed, 19 Feb 2020 16:55:16 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: question about iommu_need_mapping
Message-ID: <20200219235516.zl44y7ydgqqja6x5@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible for a device to end up with dev->archdata.iommu == NULL
on iommu_need_mapping in the following instance:

1. iommu_group has dma domain for default
2. device gets private identity domain in intel_iommu_add_device
3. iommu_need_mapping gets called with that device.
4. dmar_remove_one_dev_info sets dev->archdata.iommu = NULL via unlink_domain_info.
5. request_default_domain_for_dev exits after checking that group->default_domain
    exists, and group->default_domain->type is dma.
6. iommu_request_dma_domain_for_dev returns 0 from request_default_domain_for_dev
    and a private dma domain isn't created for the device.

The case I was seeing went away with commit 9235cb13d7d1 ("iommu/vt-d:
Allow devices with RMRRs to use identity domain"), because it changed
which domain the group and devices were using, but it seems like it is
still a possibility with the code. Baolu, you mentioned possibly
removing the domain switch. Commit 98b2fffb5e27 ("iommu/vt-d: Handle
32bit device with identity default domain") makes it sound like the
domain switch is required.

Regards,
Jerry

