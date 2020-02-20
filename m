Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192BDC11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75E92465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582190849;
	bh=XgKAWIq9e6qAgZoVDhw9r2LNsJdmFShHckDTrw/YwQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OPNB1j3+hUYg6SzN7xy+x/IMaTcs5W+DQWraYamATVLSldqI+x11BAHSWYOiZZ7ri
	 CAfrQZTP3QnyQ/X3K7lJpMZ6arCz40tRHrRDk9YGa/RqE1Vw0bbjagtvxbPtWmPjXk
	 VV8+Fe4NjWPltiqQmKnyzN24XyBqXGVOwmIJsNoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBTJ12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgBTJ11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:27:27 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9EB820801;
        Thu, 20 Feb 2020 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582190847;
        bh=XgKAWIq9e6qAgZoVDhw9r2LNsJdmFShHckDTrw/YwQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0hINo/Z0z0lHhBBiiUKy1fk51vRDZ8cxOvOQ0UFCdwyy5Hd9E/z9sUBe2gYguR0s
         eZMkfFLEY84H4JrrB24U/XbanQSWUBvjHnLYKv4zxSawW+Zthkn4+fOANXlAYOv3XF
         LicQQ/pCuojfq6hcKl7i/bxGdFc90S6Ppl5jJDlk=
Date:   Thu, 20 Feb 2020 09:27:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <trivial@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: arm64: fix trivial spelling enought to enough in
 memory.rst
Message-ID: <20200220092721.GA12780@willie-the-truck>
References: <20200219221403.16740-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219221403.16740-1-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 02:14:03PM -0800, Scott Branden wrote:
> Fix trivial spelling error enought to enough in memory.rst.
> 
> Cc: trivial@kernel.org
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  Documentation/arm64/memory.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can take this along with the other arm64 fixes I have pending.

Will
