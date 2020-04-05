Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0370DC2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 08:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95C820659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 08:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgDEI3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 04:29:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:25744 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgDEI3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 04:29:02 -0400
IronPort-SDR: M0adLzQvFZELu7OrhuvN0mX7sdIEa22m5SmlFhhPfZrph5ht36PYVfDuI6tt3lHaZ5efzlr7R6
 71j6hIJJ9UWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 01:29:01 -0700
IronPort-SDR: GkUrYhcg8R10oY7HouQeSWq86gskBmAKtRVzlu7JTmWrleeYOaNI9ekVbKxltV+umcdu350aRE
 jyf84Nixzyfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,347,1580803200"; 
   d="scan'208";a="243222375"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.154]) ([10.254.208.154])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2020 01:28:58 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v11 00/10] Nested Shared Virtual Address (SVA) VT-d
 support
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a1eed4ed-7ad7-a445-7e5c-a5eb1771587c@linux.intel.com>
Date:   Sun, 5 Apr 2020 16:28:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/4 2:42, Jacob Pan wrote:
> Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel
> platforms allow address space sharing between device DMA and applications.
> SVA can reduce programming complexity and enhance security.
> This series is intended to enable SVA virtualization, i.e. enable use of SVA
> within a guest user application.
> 
> This is the remaining portion of the original patchset that is based on
> Joerg's x86/vt-d branch. The preparatory and cleanup patches are merged here.
> (git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git)

With Eric's reviewed-by added, all patches in this series have been
piled up for v5.7.

Thank you all!

Best regards,
baolu
