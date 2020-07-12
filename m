Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA46DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3311206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594569495;
	bh=T50MoUDXCTgUobnkzSCiggjgrR6/+SkklTXlLKXrfnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W1P90tl/Tm5fBb74fjq39ePCi5PCp89++vfkC7TrUM2RR9AEXtAS5TZ6oEh0wdAGJ
	 25rBFm6JQO/X7qtPCN53SQ6DRJILV0ulYEGUJwj5GXUpdMnHLOGnvmt8dtuArwptSk
	 VsVAZ8dKRPuN3ISFAywynb4QH3UVWFyh6NEs9YJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgGLP6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 11:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbgGLP6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 11:58:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0F622068F;
        Sun, 12 Jul 2020 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594569493;
        bh=T50MoUDXCTgUobnkzSCiggjgrR6/+SkklTXlLKXrfnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXvJSsggwPMy7Y3puVS98YxQihy52sRicDRsD/d4da0d1hbL9oiae8cSgkr7J84P7
         1NYOLr1STd7dfl4QbnHE6uazOIuzyhqCUdeecWAkkV0A6xHCQ9pPJZOyTCKOnOStJj
         WjpWYKKMXrMT44UG18ign8QOKm5OX5UAOr+LIWmw=
Date:   Sun, 12 Jul 2020 17:58:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gage Eads <gage.eads@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Message-ID: <20200712155810.GC186665@kroah.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-2-gage.eads@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712134331.8169-2-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 08:43:12AM -0500, Gage Eads wrote:
> +static int dlb2_probe(struct pci_dev *pdev,
> +		      const struct pci_device_id *pdev_id)
> +{
> +	struct dlb2_dev *dlb2_dev;
> +	int ret;
> +
> +	dev_dbg(&pdev->dev, "probe\n");

ftrace is your friend.  Remove all of your debugging code now, you don't
need it anymore, especially for stuff like this where you didn't even
need it in the first place :(

Same for everywhere else in all of these patches.  I'll stop reviewing
now, someone at Intel should have caught basic stuff like this before
now, sad...

greg k-h
