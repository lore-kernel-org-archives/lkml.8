Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F4CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77644207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595481905;
	bh=po5+Z46HNZ22g6I6H/FxU75BvqaqDGGFkQvPXBB/drI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d2YhF/tQIiKyYUX20r+2psYrRoVcLHT0HNCdirn1Vl7MI0yruGSxfYSuX8SEecF7M
	 ueuaWpJUWyAZu+zHWgR8ET9lOzjVaEQbKK1x/mMu89HyRIxo7h+yD588EKn21SEiEa
	 78ZzrPzE+/VFX0iewvIkCossp2+BRbI0IBMVBM/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgGWFZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgGWFZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 01:25:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1600B20768;
        Thu, 23 Jul 2020 05:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595481903;
        bh=po5+Z46HNZ22g6I6H/FxU75BvqaqDGGFkQvPXBB/drI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFKiDE2WzHIUG0cgm4xcvLClcmPYg9/s5hnwPsBNEjYeILs5fDx8nSD/L6VrUdgoM
         J+6oFaoZWEPN7sZ+F0Ha6QGwoHZAIg0ACnfvG3fgNpzaJ38aj0RFbrKEytqFkVcxPy
         Xg77/+lo34+iv0Xe2t4RbAiAhmq8vHAw79K1oQtY=
Date:   Thu, 23 Jul 2020 07:25:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Weitao Wang(BJ-RD)" <WeitaoWang@zhaoxin.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "hslester96@gmail.com" <hslester96@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Carsten_Schmid@mentor.com" <Carsten_Schmid@mentor.com>,
        "efremov@linux.com" <efremov@linux.com>,
        "Tony W. Wang(XA-RD)" <TonyWWang@zhaoxin.com>,
        "Cobe Chen(BJ-RD)" <CobeChen@zhaoxin.com>,
        "Tim Guo(BJ-RD)" <TimGuo@zhaoxin.com>,
        "wwt8723@163.com" <wwt8723@163.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= USB:Fix kernel
 NULL pointer when unbind UHCI form vfio-pci
Message-ID: <20200723052506.GA645747@kroah.com>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
 <20200722124414.GA3153105@kroah.com>
 <20200722145913.GB1310843@rowland.harvard.edu>
 <1bf449377e3448bc9c8bc7b64d7b7990@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bf449377e3448bc9c8bc7b64d7b7990@zhaoxin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 02:59:55AM +0000, Weitao Wang(BJ-RD) wrote:
> CONFIDENTIAL NOTE:
> This email contains confidential or legally privileged information and is for the sole use of its intended recipient. Any unauthorized review, use, copying or forwarding of this email or the content of this email is strictly prohibited.


This footer is not compatible with Linux mailing lists, sorry, I am not
allowed to respond to it.

greg k-h
