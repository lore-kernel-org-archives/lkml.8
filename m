Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D4EC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB5A2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585234310;
	bh=qjvx5mZhLZHRKRraYa36bvtb5irZJi+ufK/+Jpcq9Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vTvA8x7xZOLWyA7tFqq38t3FC7KOA9fU+UUrCzqWA4c/2YaUCYCYfvrJzIzPLGWmE
	 GrqG8U/+ugPNOWYhxfJvejBc9YkqNxQsqor02/LNaEwFOeSmx8nOAlop9cIsHnV6aM
	 SfpjhdFxiXde8kCmtqy+etlppK57/1lXr4qgwits=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgCZOvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbgCZOvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:51:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA43320775;
        Thu, 26 Mar 2020 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585234308;
        bh=qjvx5mZhLZHRKRraYa36bvtb5irZJi+ufK/+Jpcq9Ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=14NkS6Z4ZKLEIwO7sARrJkhoLqG910CyR7dvbWQD0ErcBNfhpQJqPhVHXsgchT6s5
         QYuAnSsZrI0IKVDqBn+RXjc1lhoepAlkifc7hGiQsTT4bTKyMKG/YimMOqsA86twZt
         BwqkXycHYkZeFYCHJUMtHPNbhpd7lMZNO/tQOdKU=
Date:   Thu, 26 Mar 2020 15:51:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     davem@davemloft.net, smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Improvements to MHI Bus
Message-ID: <20200326145144.GA1484574@kroah.com>
References: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:40:43AM +0530, Manivannan Sadhasivam wrote:
> Hi Greg,
> 
> Here is the patchset for improving the MHI bus support. One of the patch
> is suggested by you for adding the driver owner field and rest are additional
> improvements and some fixes.

I've taken the first 4 of these now, thanks.

greg k-h
