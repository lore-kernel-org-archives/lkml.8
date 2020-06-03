Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC24C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D885C20734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgFCUdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgFCUdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:33:31 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18FDC08C5C0;
        Wed,  3 Jun 2020 13:33:31 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9056D2E4;
        Wed,  3 Jun 2020 20:33:30 +0000 (UTC)
Date:   Wed, 3 Jun 2020 14:33:29 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: reference to Linux Foundation NDA program obsolete?
Message-ID: <20200603143329.6e303a46@lwn.net>
In-Reply-To: <alpine.DEB.2.21.2005240722560.5201@felia>
References: <alpine.DEB.2.21.2005240722560.5201@felia>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 May 2020 07:33:29 +0200 (CEST)
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

>     http://www.linuxfoundation.org/en/NDA_program
> 
> This kind of review is often enough to avoid serious problems later on
> without requiring public disclosure of the project.
> 
> <--
> 
> The link is dead; internet search only showed some references from 
> meeting minutes in 2008, but nothing more since then.
> 
> Has this LF NDA program simply been phased out?

That information has now resurfaced at:

	https://www.linuxfoundation.org/nda/

I guess somebody should see to it that the docs get updated...:)

Thanks again,

jon
