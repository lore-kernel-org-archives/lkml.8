Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D565C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E51E20678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585859356;
	bh=GBHk4UCAA1zLIgYWesP8DpXfSMcvydzIHJmDmLdbR7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z7LNeavqZIeLdJwTWK/jsdzTUfVuXQus5PIDzLW8TWm+sb0OtLFvt7MyLUPkX7aEU
	 MCn2VJPTiMK7eyoZ9RBCri9qkOt9lydJjSgnAjJZZI3NTjhpXSnmtsx84gCuSkWxeT
	 6+J55VJpvF4CU4BgzwwY7B8LD8FC5xFeayCWns70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389694AbgDBU3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730837AbgDBU3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:29:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58D7220678;
        Thu,  2 Apr 2020 20:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585859354;
        bh=GBHk4UCAA1zLIgYWesP8DpXfSMcvydzIHJmDmLdbR7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJHw/yzGINsfJECCl1jHFqtDrmMsXcYAYLDEmGyyJhDWw0jASzuZMVo8h1XCqhsQP
         FgnE7sv/JndgNrpidm47LOVXFnP15i2P8USV4HqaUCgWpzlLYM/2+WrbNMYTa4zpiZ
         cqStVtZQbdZiUBzN2wO5r87z8RG8HTFnqxXMd6zQ=
Date:   Thu, 2 Apr 2020 22:29:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Cc:     Jari Ruusu <jari.ruusu@gmail.com>
Subject: Re: linux-4.14.175 broke audio
Message-ID: <20200402202910.GA3259980@kroah.com>
References: <CACMCwJ++6kikxaEUon3xfwm1h3hTQ+V9BoJEAeToJQKwTufDsA@mail.gmail.com>
 <s5hblo9u326.wl-tiwai@suse.de>
 <CACMCwJK-tdLciXkUjLsLshma0O3=_89w0SfNKXgkp6Fh9Fcd=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMCwJK-tdLciXkUjLsLshma0O3=_89w0SfNKXgkp6Fh9Fcd=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 11:24:05PM +0300, Jari Ruusu wrote:
> On 4/2/20, Takashi Iwai <tiwai@suse.de> wrote:
> > Does the patch below change the behavior?
> 
> Yes, it fixes the problem. No issues observed so far.
> Thank you for your quick fix.
> 
> Tested-by: Jari Ruusu <jari.ruusu@gmail.com>

Is this something that is only needed for 4.14.y, or is it relevant for
Linus's tree as well?
