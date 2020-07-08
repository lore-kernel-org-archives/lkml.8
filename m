Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECA8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4686206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594231577;
	bh=3WAxbYcZzMW/TcJX8/XWqMwfUmvub+waRqvFUfmZjCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dvaQdtMNZ5aIJyZHW6/w4SOsfbs34hIXchjH9nVBHEtYsYPm80peRIehiC7mttNEn
	 gdNgwiQy70XI8EKzm7WGp7Asl2PqswSbJe/xExyMfiTdtdfKDRIkUmsCelAfQQBEwl
	 2VxaJNn1996+qhh4iIxwGAEv3q8bnof/ubZ3njSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgGHSGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgGHSGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:06:16 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895FB206E2;
        Wed,  8 Jul 2020 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594231576;
        bh=3WAxbYcZzMW/TcJX8/XWqMwfUmvub+waRqvFUfmZjCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V08aCCywH2UCy5fEon4akfLyKJL8qZYvSOzwiDHvhO4pvJvnn1oN5FF93pelrboo7
         Vm4MegbyqJNifecK+zyF/VHZyrcYuqw1axSTxyNGHFbwW4nWKn5cyfrAC/iWZbSBg2
         6D/7OlD5MLGQw4pvWilxNmQaHcdhDGR2KTBJ1DDw=
Date:   Wed, 8 Jul 2020 13:11:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: Use fallthrough pseudo-keyword
Message-ID: <20200708181144.GB11533@embeddedor>
References: <20200707195214.GA3932@embeddedor>
 <977e88c2-58cb-9507-c889-854e574a8f31@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977e88c2-58cb-9507-c889-854e574a8f31@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 02:06:26PM -0600, Shuah Khan wrote:
> On 7/7/20 1:52 PM, Gustavo A. R. Silva wrote:
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> > 
> 
> Is fallthrough syntax supported on our min gcc version?
> 

The __attribute__((__fallthrough__)) has been supported since GCC 7.1
and it should be no problem for early versions because fallthrough is
a macro that also expands to: do {} while (0)  /* fallthrough */

> Does checkpatch or coccicheck catch these cases?
> 

checkpatch does:

https://git.kernel.org/linus/f36d3eb89a43047d3eba222a8132585da25cebfd

> The patch looks good.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 

Thanks
--
Gustavo
