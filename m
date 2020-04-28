Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516A9C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28EB7206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100621;
	bh=bq2Ry7YDkP+guG9GE3lk3Dcu/BwjlgDRMOvlmkR2+eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J9PZ7+zVPsm57/4u+DwBwfiEUa2C0VbPKADF3fbr7XuJzqrEQkqj+sW3qekF4fnSa
	 C29AW5eRFOH4FDlcIH5g0iHQaodBXtHLtcUwbjkpIZ+5LeDsgDPbwUYN5BYDvoTAdj
	 mk697OC8UZxvGjkZ+JFrXrHZkFvdQ7RbnddNHXW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgD1TDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbgD1TDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:03:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 026DE206A1;
        Tue, 28 Apr 2020 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588100619;
        bh=bq2Ry7YDkP+guG9GE3lk3Dcu/BwjlgDRMOvlmkR2+eQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLB3Ve5xabIMRXaegfagjdTWWG43N/8nmRHntZYu70H60rCKCV3vU/GdI2n2BvTaS
         lW0S43bFHpqRpx9D538wBW3u1yc01q3/io20bIYYf1aL7j0Cqxh1IwlDDbNpBrR2KG
         XPcZGzsIchhPJ7LuggGodw6Tbo90pvYhrinJV+IY=
Date:   Tue, 28 Apr 2020 21:03:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drivers: base: Fix NULL pointer exception in
 __platform_driver_probe()
Message-ID: <20200428190337.GA1719585@kroah.com>
References: <20200408214003.3356-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408214003.3356-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 02:40:03PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> If platform bus driver registration is failed then,

How is your platform driver registration failing?  What caused that, is
it an in-kernel problem with something?  How can it be triggered?

thanks,

greg k-h
