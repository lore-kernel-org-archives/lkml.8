Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A694C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559D022B43
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595924330;
	bh=B515u9GQzqUi22VFho713maxbIP9u3h3KeXl5xC8GvQ=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=NVbLJGgyJXuGKftQR7sm/JBUp2d/N4RPaKns5iAidkw9azisaHLkA5svwIbno2t/6
	 etM7Lu6BNhyS9F+LH47Lqly6SeBy7QPE7li6nOu0/kizd44M0I1HuoS/TunChuyk+U
	 epVD5fw3fNtzTuTVqrM2SuYJSpGjm15JiC3gDugI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgG1ISt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgG1ISs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:18:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA32D2177B;
        Tue, 28 Jul 2020 08:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595924328;
        bh=B515u9GQzqUi22VFho713maxbIP9u3h3KeXl5xC8GvQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=fEfnYNDg6WoNkW9pj4ZQ84fLTNNlte3IywsNzsDERRPwTA5L2ZZ2zylJCxrWhCu+g
         a6AeOyuM7S6LQIlUI4PK/oG3gHDbhM6P14Mp4lQuNb4Ax3L81iaja1M93rXu3RIFeZ
         K6af6wtcQJgOzIroKYzaSEXHqhp19/JgSR5BbBTM=
Date:   Tue, 28 Jul 2020 10:18:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@braille.uwo.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/speakup: Update TODO list
Message-ID: <20200728081842.GA1648133@kroah.com>
References: <20200726165452.qhos3wrjcm6jmcmx@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726165452.qhos3wrjcm6jmcmx@function>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 06:54:52PM +0200, Samuel Thibault wrote:
> Thanks to Okash's latest work, the TODO list is essentially empty, so
> the way out from staging now seems open.
> 
> The status of the remaining issue mentioned in TODO is not clear, we
> asked the speakup user mailing list for reproducer cases, but didn't get
> a really specific scenario. One serious bug was fixed by 9d32c0cde4e2
> ("staging/speakup: fix get_word non-space look-ahead"), which does not
> seem to really be related to the bug mentioned in TODO. Possibly the bug
> mentioned in TODO has been fixed long ago and people have been thinking
> that it was not because they can not distinguish the symptoms mentioned
> in TODO from the symptoms of the bug fixed by 9d32c0cde4e2.

I think it's time we move speakup out of staging.  Care to submit a
patch series that does this?

thanks,

greg k-h
