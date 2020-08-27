Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C188C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66BBB2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tCVVttP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgH0Oqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:46:49 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:17944 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgH0Olh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598539296; x=1630075296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=unv0Tfgwvb0KrAP7CtFheOrORuCI+KCsaG06ffbe73s=;
  b=tCVVttP1Bfeg4ipx2aMzXOscAk4Mx0qjZwlbidJfVoWGqwm69I0JwNJ0
   Hh+eweloNKKRnollBKD5nEtm7xgTuBxoRHfVJa11psuSwzR3H7jOrfjdV
   pdjkJCvKy1bSG4qARm9021b3LZ9XN0tFJYMQDXqIRpT+sMohbs5hI6sFi
   A=;
X-IronPort-AV: E=Sophos;i="5.76,359,1592870400"; 
   d="scan'208";a="50441316"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 27 Aug 2020 14:41:35 +0000
Received: from EX13MTAUEE001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 8F52BA222F;
        Thu, 27 Aug 2020 14:41:34 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.226) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 14:41:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 14:41:33 +0000
Received: from dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (172.19.34.216)
 by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 27 Aug 2020 14:41:33 +0000
Received: by dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (Postfix, from userid 800212)
        id 2ADE31A3; Thu, 27 Aug 2020 14:41:32 +0000 (UTC)
Date:   Thu, 27 Aug 2020 14:41:32 +0000
From:   Clint Sbisa <csbisa@amazon.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Benjamin Herrenschmidt <benh@amazon.com>,
        Ali Saidi <alisaidi@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Guy Tzalik <gtzalik@amazon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200827144132.ob6ugfrebfgbxwxc@amazon.com>
References: <20200821155154.umharcbew46hkhuq@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200821155154.umharcbew46hkhuq@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 03:51:54PM +0000, Clint Sbisa wrote:
> Using write-combine is crucial for performance of PCI devices where
> significant amounts of transactions go over PCI BARs.
> 
> arm64 supports write-combine PCI mappings, so the appropriate define
> has been added which will expose write-combine mappings under sysfs
> for prefetchable PCI resources.
> 
> Signed-off-by: Clint Sbisa <csbisa@amazon.com>
> ---
>  arch/arm64/include/asm/pci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index 70b323cf8300..b33ca260e3c9 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -17,6 +17,7 @@
>  #define pcibios_assign_all_busses() \
>  	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
>  
> +#define arch_can_pci_mmap_wc() 1
>  #define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
>  
>  extern int isa_dma_bridge_buggy;
> -- 
> 2.23.3
> 

Ping. Let me know if any more info is needed.

Clint
