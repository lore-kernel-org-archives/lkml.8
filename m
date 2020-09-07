Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289B8C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05932075A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599481861;
	bh=W4V9kVZfecfE8xIBo6XS9gugVAs/6HAok3326/9CEcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dz35lUstElUD58QfVmW9J5QsxMo0AOI24+aLQUHohir7EDuD67E+Tc4HiXMhyJhgc
	 k2TtguBaPMRorAM72sHsAWd0TCPTKGa0H6oP3hxx2xb1zJAiUCoKqonw1J3ow8xw73
	 FDmueKP3vNAQoMIeGZM2VXGZS8BvW9VzwLNRdg1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgIGMap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729304AbgIGMXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:23:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E39FB2137B;
        Mon,  7 Sep 2020 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599481397;
        bh=W4V9kVZfecfE8xIBo6XS9gugVAs/6HAok3326/9CEcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBctklgWtGVWv4ELibkECQtm0Z21EkvcN4Gem+PNpj6TKQDFqI1E2BLx0TnramhvA
         MHD42DzigNYdFsbnfNCurcLW4nA3hxvvOpx5jWWgreRGPJRuUeSIdQx9C+jDE120BO
         mM+jbBwF5nWgon0RrDDQCS8tPt37DIbKd/8nxAEw=
Date:   Mon, 7 Sep 2020 14:23:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Move fwnode_connection_find_match() under
 drivers/base/property.c
Message-ID: <20200907122331.GA2029056@kroah.com>
References: <20200907120532.37611-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907120532.37611-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 03:05:30PM +0300, Heikki Krogerus wrote:
> This is second version of this series. I forgot to remove the file
> from Documentation/driver-api/index.rst. Hopefully these are now OK.
> 
> The original cover letter:
> 
> Hi,
> 
> This was the last patch in my series that removed struct
> device_connection [1]. It's now split into two separate patches.
> 
> [1] https://lore.kernel.org/lkml/20200904125123.83725-1-heikki.krogerus@linux.intel.com/
> 
> thanks,
> 
> *** BLURB HERE ***

But you do have a blurb!  :)

Anyway, thanks for the update, both now applied.

greg k-h
