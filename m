Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FEFC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CFD2065E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599483651;
	bh=KPbjMXr5a2KoDeBSjFIwhuhks/lk8advEYiOtRdNDYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DTH+tW6E749sA9TgCRt79RCP370Y+XB6tnNZ/PLHCqCiAnDjem+dpjFhylBK0LMz8
	 CWSGcPp4qEfMshvRZOaZuu0S8UiwauUWN1M18IHucnZ9H7Uy1pzZKj+HizBOqaT9Az
	 NXHHLJs74wk/gDWZejsuNL4PuBhPidzbPN9EBfKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgIGNAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgIGM7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:59:54 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1BD62168B;
        Mon,  7 Sep 2020 12:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599483590;
        bh=KPbjMXr5a2KoDeBSjFIwhuhks/lk8advEYiOtRdNDYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDidjJfVuCItCR6lXPLVoNazjcCigoXDyX40Paoom0vvf8aCvkpbaJo6OtNVqvrxb
         muBGIMsfFTXNR+oF/maGh9SX/+2vrcV/MhOcHlij2Usxt8TpTo5BXJtI4HCY/6SmB6
         YQirrJ8FN1r/0KRBs8l2HM+brLq9EFGHcW9yD5pM=
Date:   Mon, 7 Sep 2020 15:00:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gage Eads <gage.eads@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: Re: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
Message-ID: <20200907130004.GD2371705@kroah.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
 <20200901191548.31646-2-gage.eads@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901191548.31646-2-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:15:30PM -0500, Gage Eads wrote:
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2813,6 +2813,8 @@
>  #define PCI_DEVICE_ID_INTEL_ESB2_14	0x2698
>  #define PCI_DEVICE_ID_INTEL_ESB2_17	0x269b
>  #define PCI_DEVICE_ID_INTEL_ESB2_18	0x269e
> +#define PCI_DEVICE_ID_INTEL_DLB2_PF	0x2710
> +#define PCI_DEVICE_ID_INTEL_DLB2_VF	0x2711
>  #define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
>  #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b9
>  #define PCI_DEVICE_ID_INTEL_ICH7_30	0x27b0

Doesn't the top of this file say to not add new ids?

Why are you adding these?  Can't they just stick in the driver you use
them in?  And they aren't referenced in this patch either, so even if
you did need them, they shouldn't be here :(

greg k-h
