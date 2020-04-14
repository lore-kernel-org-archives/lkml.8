Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF03C38A29
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3C920578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586873115;
	bh=hVpr3xCUkRKguWKyc1ILzFBoFkjzpErKoe/9LdPq1gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SxFMPZ6mLjpsVsx11Om8mVDRydIcxhe4ejzuLb1Efu1svbTB5MChVM3U1x4HzXG/b
	 ikFxQwBnXL48Hl7cfi/bEcw76X0U+2IZ5mSjKgnmqjuQ5FvTNDunJjZuPldqQm06fi
	 zUjlJFoGH+p25kPRR5KTu8/6/U49++dmmth390qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbgDNOFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388896AbgDNOEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:04:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AF0720578;
        Tue, 14 Apr 2020 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586873093;
        bh=hVpr3xCUkRKguWKyc1ILzFBoFkjzpErKoe/9LdPq1gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kfo1/la7UmQmGIQOQ/UwqeJYeFaWCo9vV3JK+zTRtdlUcXRAhPCvWAINbcOFbvMRZ
         moRVRrPOBZhKEZxa3/S8gGwSxuK8clwxVUoWMpxHv5bE4bNf4SWyrnmMy243nvwQ/V
         3IDFBXOMOnDorntQTi+KkdpRpNvMMHFs4dOl/m3k=
Date:   Tue, 14 Apr 2020 16:04:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?=D8rjan?= Eide <orjan.eide@arm.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        john.stultz@linaro.org, anders.pedersen@arm.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] staging: android: ion: Skip sync if not mapped
Message-ID: <20200414140451.GA845920@kroah.com>
References: <20200414134629.54567-1-orjan.eide@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414134629.54567-1-orjan.eide@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 03:46:27PM +0200, Ørjan Eide wrote:
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

Does not work for kernel patches, sorry, now deleted :(
