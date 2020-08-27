Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC73C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8C82054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgH0OHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:07:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:48117 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbgH0OAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:00:21 -0400
IronPort-SDR: kHbK7rczgrEqwcttoqW3iGJ5Ke99C21DUBS3+6J5okZuDvnTQfW3Q4OpdihBVCC0DDVDe4mgDZ
 Zl7sbKg7k+sA==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="136029221"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="136029221"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 07:00:06 -0700
IronPort-SDR: 2uPs2ch9V4+cMSNTnQsUhQEEE0Q8ba0a1DGS157MvdQRqo9rVDlG6U+m1CNhZdpQtd5CcvzNRb
 DsH4qQBWeYrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="403408069"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 27 Aug 2020 07:00:02 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 27 Aug 2020 17:00:01 +0300
Date:   Thu, 27 Aug 2020 17:00:01 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     cy_huang <u0084500@gmail.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux@roeck-us.net, cy_huang@richtek.com,
        gene_chen@richtek.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb typec: mt6360: Add support for mt6360 Type-C
 driver
Message-ID: <20200827140001.GE813478@kuha.fi.intel.com>
References: <1598527137-6915-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598527137-6915-1-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 07:18:55PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
> It works with Type-C Port Controller Manager to provide USB PD
> and USB Type-C functionalities.
> 
> v1 to v2
> 1. Add fix to Prevent the race condition from interrupt and tcpci port
> unregister during module remove.
> 
> v2 to v3
> 1. Change comment style for the head of source code.
> 2. No need to print error for platform_get_irq_byname.
> 3. Fix tcpci_register_port check from IS_ERR_OR_NULL to IS_ERR.
> 4. Rename driver/Kconfig/Makefile form mt6360 to mt636x.
> 5. Rename DT binding documents from mt6360 to mt636x.

You don't place additional changelog here...

> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---

You put it here, after that '---' marker:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format


>  drivers/usb/typec/tcpm/Kconfig        |   8 ++
>  drivers/usb/typec/tcpm/Makefile       |   1 +
>  drivers/usb/typec/tcpm/tcpci_mt6360.c | 212 ++++++++++++++++++++++++++++++++++
>  3 files changed, 221 insertions(+)
>  create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6360.c

thanks,

-- 
heikki
