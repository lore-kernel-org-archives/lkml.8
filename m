Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E1FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCC0206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589524662;
	bh=/sejV8BirlA+9XJW7afKnpotS1fQXEqPb8/TeQ6TDYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zvN4qFER39bVRnfFTtNbFT1EJMgjGPzNIXjGZ8NWv2l3PJjF7gkZLZaRpEvOAoejY
	 Rw9pLeEOXGa2Iv9W0rikDwaaA7WfmQ4TgHEHVwC3Ba1xpUH15ExAbyKIgs4v0sy3e6
	 me2f73hzhX43kbZ/j97nZOnoc/+xrefDXtN8iLvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgEOGhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 02:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgEOGhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:37:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 718992065F;
        Fri, 15 May 2020 06:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589524660;
        bh=/sejV8BirlA+9XJW7afKnpotS1fQXEqPb8/TeQ6TDYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xxppYZUv2kisbDZrnltv/c6K4fzrP9l7WQz1h1yifRH3No6IR1HFWaAEvQdB6QxOn
         Yo376PHcJjyyqnHjzp8yJ5swSubvROWSCeI4gp/Q3z0YET3LnSw8T8+nnlJxz3Qt7V
         +V7jy71pWwfHu+RtWWNHDBIB7V8aJJi57utGHspQ=
Date:   Fri, 15 May 2020 08:37:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     arnd@arndb.de, manivannan.sadhasivam@linaro.org,
        bjorn.andersson@linaro.org, wufan@codeaurora.org,
        pratanan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] qaic: Add skeleton driver
Message-ID: <20200515063738.GA1006524@kroah.com>
References: <1589465266-20056-1-git-send-email-jhugo@codeaurora.org>
 <1589465266-20056-2-git-send-email-jhugo@codeaurora.org>
 <bc74cb1d-cd97-819c-5e0d-e9cd1e01dbf4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc74cb1d-cd97-819c-5e0d-e9cd1e01dbf4@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 06:43:06PM -0600, Jeffrey Hugo wrote:
> On 5/14/2020 8:07 AM, Jeffrey Hugo wrote:
> > +#define QAIC_NAME			"Qualcomm Cloud AI 100"
> <snip>
> > +static struct pci_driver qaic_pci_driver = {
> > +	.name = QAIC_NAME,
> 
> A question about the community's preference here.
> 
> Our driver name is very verbose due to the desire to have the proper
> "branding".  However, I can see it being a bit obtuse, particularly in logs.
> 
> Would the community prefer something more succinct here, such as "qaic"?

Make it the same a KBUILD_MODNAME and then no one can complain :)

thanks,

greg k-h
