Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54DCC433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B546720714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595328278;
	bh=hKuAGs+rUZGDsVHOETa/8eOzLxdSKKQ5+Xvus7yx3To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aHftiXkmmRd8xU9mxuASvzRy5MHnGD51iYp3IzYwvWmXNbaqotdwyMgQXAw0bPwqK
	 3zBDDiF+1MyHlzNB+W1i8mhVmOye14l3OLfvmAxvWxeNUjziw5W4OX8e1E8WBh9hp2
	 gBS5d/eRuE5I/h6ieFV07eAattGTV1kFb5oHxzsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgGUKoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729208AbgGUKoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:44:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A519920714;
        Tue, 21 Jul 2020 10:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595328274;
        bh=hKuAGs+rUZGDsVHOETa/8eOzLxdSKKQ5+Xvus7yx3To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lidGLm0vuEFLVdGjNS9+LIQqgAKZtjjCZWgF4v+dLWiU2yA9rJupWOCrIE7rJ505S
         jjYAJA3kNoGHNz6IdG4M+JGpPZtNEKjs5rNKMT8jxA7Zp7oEBj4p93NQQ1KMkZLnKS
         oqscEzWz6n4qq61BkRTIdUBucMsE4Nn73icspVUg=
Date:   Tue, 21 Jul 2020 12:44:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        vishal.l.verma@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/11] driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}
Message-ID: <20200721104442.GF1676612@kroah.com>
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159528288766.993790.5647904882591265970.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159528288766.993790.5647904882591265970.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 03:08:07PM -0700, Dan Williams wrote:
> A common pattern for using plain DEVICE_ATTR() instead of
> DEVICE_ATTR_RO() and DEVICE_ATTR_RW() is for attributes that want to
> limit read to only root.  I.e. many users of DEVICE_ATTR() are
> specifying 0400 or 0600 for permissions.
> 
> Given the expectation that CAP_SYS_ADMIN is needed to access these
> sensitive attributes add an explicit helper with the _ADMIN_ identifier
> for DEVICE_ATTR_ADMIN_{RO,RW}.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/device.h |    4 ++++
>  include/linux/sysfs.h  |    7 +++++++
>  2 files changed, 11 insertions(+)

This is 3022c6a1b4b7 ("driver-core: Introduce
DEVICE_ATTR_ADMIN_{RO,RW}") in linux-next now, if anyone cared :)

thanks,

greg k-h
