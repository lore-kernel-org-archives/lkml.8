Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726F7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B3E2065F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594200534;
	bh=DIJGvZ0alP9ZUdvdZplwqWFpRCOlhg8G3MZAH6czqq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iPODr+XLeJcC5W54oBfJ736GyzqEa148hyUwq0d+2YqdTThbyMmG4wCcs+nyXHqQu
	 hLFsX98Z3h3UHxJ/J/IscFbh+eCf65DDUWv9TMFZyjangrDqqnt7axb0BrfVwr4TUT
	 3JDrcm3EShXmjZfCr1ex0oqAZRrUbC+B+RrNcJdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGHJ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgGHJ2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:28:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D66D72065D;
        Wed,  8 Jul 2020 09:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594200532;
        bh=DIJGvZ0alP9ZUdvdZplwqWFpRCOlhg8G3MZAH6czqq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2MtrR5iKUR0XJzfzYtyZW5sx12eMF9ZPjjlwJGC5JVy5LeoD7SBC2uFDgBBZQhvYy
         V/pTcQ2Cq78jmweDTIXM+6+VgDwBfe5XGY/8tf0ZObWVd1seKF3nePB8ioJ6C/to5i
         x4eBs1wFZDRmhEtkbbdzwvivEyQnQsjql9FesCV8=
Date:   Wed, 8 Jul 2020 11:28:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Zaharinov <micron10@gmail.com>
Cc:     "linux-kernel@vger kernel. org" <linux-kernel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: Bug Report High CPU Usage events_power_efficient
Message-ID: <20200708092848.GB405531@kroah.com>
References: <E2C5FE67-C85E-469C-9B81-10F7555F836B@gmail.com>
 <91805D0F-2D74-4EA3-A2D7-13E4FBBEAB51@gmail.com>
 <6AD52867-83C1-4C6C-A0AE-4DE0D6C16310@gmail.com>
 <C89D167C-E03F-4116-9647-F50607DF3A45@gmail.com>
 <20200708070912.GA351187@kroah.com>
 <CALidq=UYNMxLQTT_D=EOESUxr82LYH04YCjT6igwqdnw3YwyiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALidq=UYNMxLQTT_D=EOESUxr82LYH04YCjT6igwqdnw3YwyiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jul 08, 2020 at 11:34:52AM +0300, Martin Zaharinov wrote:
> Yes i search but not find any information.

Please do the testing yourself, using 'git bisect' to find the offending
commit.

thanks,

greg k-h
