Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84DFC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FA420776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587735468;
	bh=gFBTnIYqZLLeI2GghhjJi85ZDzdGTRSLwVVnJACwjs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IA1b0dL5ncpL0hVwDd7JvZBWDa1vBv0WDuaD9r8naUxAvqD5PAhoJ0oP3kq/0KkeF
	 97OuGkCDZfanEeQQO85H1nQyP00M6qumQnGTpASd9ROv7SpiUf6BJ8CQurqpEZC7E9
	 CJwdMGdusH5TfG7n2G6+8QBVKzFNiBq19fXw3jGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgDXNhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgDXNhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:37:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAB0D20767;
        Fri, 24 Apr 2020 13:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587735467;
        bh=gFBTnIYqZLLeI2GghhjJi85ZDzdGTRSLwVVnJACwjs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ys2FikCIGbXh4CT9vibWxKEiQ9uIze1Yhc6AXHzkShBsS1fSKWB/7s3mfLq5EggVC
         6wJmxvmDpqTnJ+Q1MoK0fBBORlTwg28USb8H4K2I3TnRpYZt4f5mfOgv3FFnRMH71w
         FtGVVEWR14h3fHymGabiXXCa5ooiIK4yQ93DEIBA=
Date:   Fri, 24 Apr 2020 15:37:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH USB v2 2/2] usb: raw-gadget: fix typo in uapi headers
Message-ID: <20200424133745.GA600581@kroah.com>
References: <9c99c508da044822baf53db5e3fccd4f21b0f8d3.1587734346.git.andreyknvl@google.com>
 <635f48fcb4bb99c70ab9d7f0dfe84d1ec7dc540e.1587734346.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635f48fcb4bb99c70ab9d7f0dfe84d1ec7dc540e.1587734346.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 03:20:20PM +0200, Andrey Konovalov wrote:
> Change "trasferred" into "transferred".
> 
> Change-Id: I2d8d1dcc9ba6aacafc03f4b76caca7409a6da1a6

What is that?  :)

And no signed-off-by?

