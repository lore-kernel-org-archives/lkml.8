Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D188CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689FD20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589370913;
	bh=ykTFDDPJtL6rFGdVgPJwk5SGdZgJ+ChSeO4E5XNIdUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HKIkPEE7dHM/gOMLdwdTbFTq0hND/U8wkh1s4DQU5ZNQCwEfeN+FE4jHhDjOpr256
	 JsD/+f1wlCOaRlGQBbkQDWxtYRT4ZpEC2X720XffniFGbRlTl25ndfXyjddAwi9cZd
	 7dzX8iwYD61JHgdxfYBonjgay3wNb7ioO+eeV6Pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbgEMLzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728286AbgEMLzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:55:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FF51206CC;
        Wed, 13 May 2020 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589370912;
        bh=ykTFDDPJtL6rFGdVgPJwk5SGdZgJ+ChSeO4E5XNIdUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BB8ZaCzAGicYAjsrmTNygYHijclVy1EBGYzeQfdlrQITjyXFjUa2aA58oMWDiJV0O
         qKlQWQ9GwvhGt6KNkwQVRIxTRGKA2VCof1IsjnaPaqGkmaNb29rRnkKWqDMIo+nVO0
         8cVAuyLyRLrphroaZ1ZfQqxXvJwnnlWMU0Yixg9E=
Date:   Wed, 13 May 2020 13:55:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matej Dujava <mdujava@kocurkovo.cz>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: vt6656: vt6655: clean Makefiles
Message-ID: <20200513115509.GA953616@kroah.com>
References: <1589105615-22271-1-git-send-email-mdujava@kocurkovo.cz>
 <1589105615-22271-2-git-send-email-mdujava@kocurkovo.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589105615-22271-2-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 12:13:34PM +0200, Matej Dujava wrote:
> This patch is removing CFLAGS that are defining flags that are not used.
> 
> Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
> ---
>  drivers/staging/vt6655/Makefile      | 3 ---
>  drivers/staging/vt6655/device_main.c | 1 -

This file is not a Makefile :(

Please properly describe patches.

Also state below the --- line what changed from the first version,
otherwise I have no idea.

Please fix up and send a v3 series.

thanks,

greg k-h
