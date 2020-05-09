Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64F0C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCB521974
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgEICBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 22:01:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:35139 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbgEICBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 22:01:30 -0400
IronPort-SDR: 0jxgFU35Ylq0zUTfW9yvEmOS2RN0WhnbHnD3c0JYhguNHW1Bz78+LwxqGMBEVeXMULx8f/TdvC
 da0io3NnsfGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 19:01:30 -0700
IronPort-SDR: UE4a7l/4mCqwwLOyGLGARhcGiT+OYJaBzv5QYHjcHyLL+OWsz4gyYKRsUQ6vw1cX7aCGIAF/Vv
 eqMl3LssOBfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,369,1583222400"; 
   d="scan'208";a="279209024"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 08 May 2020 19:01:28 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: Failure to shutdown/reboot with intel_iommu=on
To:     Joerg Roedel <jroedel@suse.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
References: <20200506144558.GA4019@taurus.defre.kleine-koenig.org>
 <20200508150734.GP8135@suse.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bd9fb298-1ad3-fd4c-19f7-aae4c2b62daa@linux.intel.com>
Date:   Sat, 9 May 2020 09:58:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508150734.GP8135@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

Have you tried commenting out intel_disable_iommus() in
intel_iommu_shutdowan()?

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0182cff2c7ac..532e62600f95 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4928,8 +4928,10 @@ void intel_iommu_shutdown(void)
         for_each_iommu(iommu, drhd)
                 iommu_disable_protect_mem_regions(iommu);

+#if 0
         /* Make sure the IOMMUs are switched off */
         intel_disable_iommus();
+#endif

         up_write(&dmar_global_lock);
  }

Best regards,
baolu

On 5/8/20 11:07 PM, Joerg Roedel wrote:
> + Baolu, Maintainer of Intel IOMMU
> 
> Baolu, does that ring any bells?
> 
> On Wed, May 06, 2020 at 04:46:02PM +0200, Uwe Kleine-König wrote:
>> Hello,
>>
>> On my Lenovo T460p I cannot shutdown and reboot when the iommu is
>> enabled. This is using linux 5.2.7 as provided by Debian, 5.6.4 has the
>> same problem. Suspend/resume also fails; I suspect this is the same
>> issue.
>>
>> When requesting power off the kernel messages just end with:
>>
>> 	sd 0:0:0:0: [sda] Synchronizing SCSI cache
>> 	sd 0:0:0:0: [sda] Stopping disk
>> 	e1000e: EEE TX LPI TIMER: 00000011
>> 	ACPI: Preparing to enter system sleep state S5
>> 	reboot: Power down
>> 	acpi_power_off called
>>
>> (photo at https://www.kleine-koenig.org/tmp/uklsiommu.jpg in case I
>> mistyped something. Full dmesg and lspci -vvv at
>> https://www.kleine-koenig.org/tmp/uklsiommu.tar.gz with and without
>> iommu enabled.)
>>
>> With the iommu disabled (CONFIG_INTEL_IOMMU_DEFAULT_ON unset or
>> intel_iommu=off on cmdline) the machine just works as expected
>> (including working suspend/resume).
>>
>> I already talked to tglx on irc but unfortunately no new insights
>> resulted from that.
>>
>> Any ideas how to fix or continue debugging the issue?
>>
>> Best regards
>> Uwe
> 
> 
