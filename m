Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDCBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A642468D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583007429;
	bh=bI6Kadk+Bdf2+EtRrnxOqRex3gc9Gu+/T3sPTnMdPZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FLlYwwT50aYm6x1qDxOWmQRpVIl5VK3rYqgsySAs2cOdGMF1wfny6cIAjV0T0403d
	 fwZ4fT+U5OQq8tYNsiZQ/UpJ+IkufHLzzH/Xvkjmt9mrAIbsg4nDlNMQeH/CChJnBQ
	 vOyhznJMvWq/NLhyMeqH8q2SnQrM6KPdqgNr311A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgB2URI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 15:17:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgB2URI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 15:17:08 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D81E24688;
        Sat, 29 Feb 2020 20:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583007427;
        bh=bI6Kadk+Bdf2+EtRrnxOqRex3gc9Gu+/T3sPTnMdPZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1Rl4VzndwL25YEuRq2WetFDyJfsOmdZzmnB8WEUel2VzfoDNMmrzMkmYdWyIf07Zd
         g2gMXhK2VyKrENRBGrXA06mYhbpT93SN/yiIjrVwaUFnTH0hF0olUMHLDfNqcmCyLY
         usfwxBMA8MVY/vTOvsRLQWlmoOjDGHjn13d6HAEI=
Date:   Sat, 29 Feb 2020 12:17:05 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bitfield.h: add FIELD_MAX() and field_max()
Message-ID: <20200229121705.5e29c886@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <be229ebb-53a5-e048-9c68-1b4c7cc2ab9d@linaro.org>
References: <20200228165343.8272-1-elder@linaro.org>
        <20200228095611.023085fd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <d6bf67ba-3546-c582-21a6-30cbd4edd984@linaro.org>
        <be229ebb-53a5-e048-9c68-1b4c7cc2ab9d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Feb 2020 07:10:45 -0600 Alex Elder wrote:
> I should have actually checked my code before I sent this.  Yes
> I am using the macro as I described, to see if something fits.
> But I'm also using it this way:
> 
> 	foo = u32_get_bits(register, FOO_COUNT_FMASK);
> 	if (foo == field_max(FOO_COUNT_MASK))
> 		;	/* This has special meaning */
> 
> And another way:
> 
> 	size_limit = field_max(FOO_COUNT_MASK) * sizeof(struct foo);
> 
> So field_max() is really what I need here. 

Makes sense, in that case:

Acked-by: Jakub Kicinski <kuba@kernel.org>
