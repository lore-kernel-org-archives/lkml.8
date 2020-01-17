Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1774C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE7521D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579302847;
	bh=v0YVk8S4SZUlGrRcCxvJLlZjm9za0AdDfoBmPLz+R7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2vPdIy5bMf6JYd41e54H/ApbQzxPqaoobhljaG60GHDLjXzzc2YAEL6+/EvfDAR6B
	 23vDLn0sMO2SVQ0+gYO+fd0Eta9kVoOMxIldZpoaBB3gb6JccKkNv0HTTmWT2skdQ9
	 JtUaZus1ZTuvVEtQnFv8dG72sPlarY/vQwGB77c8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgAQXOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:14:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgAQXOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:14:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E3E21835;
        Fri, 17 Jan 2020 23:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579302846;
        bh=v0YVk8S4SZUlGrRcCxvJLlZjm9za0AdDfoBmPLz+R7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alpuonwavCzr6Oo8IytbhRkRRrlWERwxrRXu/NYoOtnBJEQTJPQ5Zs9BuWzA9Gnsz
         phdqcCC+cote6rdizsJ/EOlRXaZe6HzCfQZUd8+WQ40seD1d0mMOTBYSaXUoBLbFyP
         oQjEiV2YAJu0Iw04JREdE/d3X0tbRBnAKvqeOaMw=
Date:   Sat, 18 Jan 2020 00:14:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] coresight: next v5.5-rc6
Message-ID: <20200117231403.GA2132864@kroah.com>
References: <20200117185607.24244-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117185607.24244-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 11:56:06AM -0700, Mathieu Poirier wrote:
> Hi Greg,
> 
> Just a single patch to add for the next cycle.

Next cycle?

This doesn't apply to my char-misc-linus branch at all.  But it does
apply to my -next branch which is for 5.6-rc1.

So which does this go to?

confused,

greg k-h
