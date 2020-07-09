Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54AAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85CAF2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgGIMYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:24:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:9232 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgGIMYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:24:05 -0400
IronPort-SDR: RiZqg/TZoIsx8K3kehihIpnYtvk2jFUwAmrLfVZixk6GKfbaVbQ8DHSG2ax1Pu97xKRdlrEasI
 fAw86KDxbugw==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="128052799"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="128052799"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 05:24:05 -0700
IronPort-SDR: y4vJ4FSs9Z6jcJbUsoaKk2oiO26qlStbYq75/4DVBLgd7FD/0d0q/yAHnvQa53UgJnyEX3cm2y
 JZvKe7vq82Gw==
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="484256280"
Received: from unknown (HELO dalessan-mobl1.ir.intel.com) ([10.252.6.39])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 05:24:01 -0700
Message-ID: <491f994c6f87a542e49fe37c8a75ab46f1b3712b.camel@linux.intel.com>
Subject: Re: [PATCH 2/7] mailbox: keembay-scmi-mailbox: Add support for Keem
 Bay mailbox
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>, paul.j.murphy@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Thu, 09 Jul 2020 13:23:56 +0100
In-Reply-To: <20200708203428.GB31671@bogus>
References: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
         <20200616155613.121242-3-daniele.alessandrelli@linux.intel.com>
         <20200708203428.GB31671@bogus>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

Thanks for your review.

On Wed, 2020-07-08 at 21:34 +0100, Sudeep Holla wrote:
> On Tue, Jun 16, 2020 at 04:56:08PM +0100, Daniele Alessandrelli
> wrote:
> > From: Paul Murphy <paul.j.murphy@intel.com>
> > 
> > Keem Bay SoC has a ARM trusted firmware-based secure monitor which
> > acts
> > as the SCP for the purposes of power management over SCMI.
> > 
> > This driver implements the transport layer for SCMI to function.
> > 
> 
> Please use the smc transport support in
> driver/firmware/arm_scmi/smc.c
> for this. You don't need mailbox support for SMC/HVC. Basically you
> don't need this driver at all and you have everything you need to
> support
> what you want.
> 
> Let me know if you face issues.
> 

Sorry, we didn't know about the SMC transport support for SCMI. Looks
like it was added only recently, while our driver was already developed
and waiting to be upstreamed.

I agree that we can drop this driver and switch to the SMC transport as
you suggested, but I think we'll have to modify our bootloader SiP
service slightly. Paul, can you elaborate?

Regards,
Daniele


