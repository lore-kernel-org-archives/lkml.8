Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD19C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9C92067D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgBUAAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:00:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:27875 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbgBUAAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:00:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:00:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="254645732"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.224]) ([10.254.211.224])
  by orsmga002.jf.intel.com with ESMTP; 20 Feb 2020 16:00:46 -0800
Subject: Re: [PATCH] iommu/vt-d: fix the wrong printing in RHSA parsing
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
References: <20200115102815.264-1-zhenzhong.duan@gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <470b6a1b-458e-0c81-71d7-51e2a6b70b9b@linux.intel.com>
Date:   Fri, 21 Feb 2020 08:00:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200115102815.264-1-zhenzhong.duan@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/1/15 18:28, Zhenzhong Duan wrote:
> When base address in RHSA structure doesn't match base address in
> each DRHD structure, the base address in last DRHD is printed out.
> 
> This doesn't make sense when there are multiple DRHD units, fix it
> by printing the buggy RHSA's base address.
> 
> Signed-off-by: Zhenzhong Duan<zhenzhong.duan@gmail.com>
> Cc: David Woodhouse<dwmw2@infradead.org>
> Cc: Lu Baolu<baolu.lu@linux.intel.com>
> Cc: Joerg Roedel<joro@8bytes.org>
> Cc:iommu@lists.linux-foundation.org

Queued for v5.7. Thanks!

Best regards,
baolu
