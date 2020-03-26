Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16071C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D864D20748
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585227862;
	bh=8CBek8byWQq1OiX3MTE8S+FkLHPI+O3ZHdR3hz3MjKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OcVC7qrYVYLLkM9lkN1QkpQW58bzM94faUoGYXt2wM8780PgX9Xc1fhI48wgb/f4Z
	 M/3e9hyGXji1UO1koxa3sFKUSNunrrAcbaVE0eNzlzQXFAdI4yXbjCYfUwJXJ56OV4
	 HJxAmlPS27dwq8vcx3YG8DuIb7exSt77CXHzqzLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgCZNEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgCZNEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:04:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A392D20737;
        Thu, 26 Mar 2020 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585227861;
        bh=8CBek8byWQq1OiX3MTE8S+FkLHPI+O3ZHdR3hz3MjKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3z6UEDoX7ulcbGrLEmk3yLFGNAMZW4LFFP3vCjJdr5Lc6GCF73JzccD5TwIYIu8K
         8jAt/RB/IMr9gYYSOY9nVARjAk2kbSfx3MBZT0wVKpgKFQ5EbDOVp1yHnqWXv+wjYK
         eLrWbpWHT9mmbDqcmt01+0JE1Elq7/qYVKmj0neY=
Date:   Thu, 26 Mar 2020 14:04:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Colin King <colin.king@canonical.com>, kbuild-all@lists.01.org,
        Sekhar Nori <nsekhar@ti.com>, Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Pawel Laszczak <pawell@cadence.com>, linux-usb@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] usb: cdns3: cdns3_clear_register_bit() can be static
Message-ID: <20200326130418.GA1295433@kroah.com>
References: <20200325125041.94769-1-colin.king@canonical.com>
 <20200326122858.GA50118@cde5a4ed3207>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326122858.GA50118@cde5a4ed3207>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 08:28:58PM +0800, kbuild test robot wrote:
> 
> Fixes: 87db1192dc33 ("usb: cdns3: make signed 1 bit bitfields unsigned")

This original patch did not "cause" this problem, it's just that you for
some reason ran sparse for the first time on the file.

So I can't take this as-is, can you remove this line and resend?

thanks,

greg k-h
