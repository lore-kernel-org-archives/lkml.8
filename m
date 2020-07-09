Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7896C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977B120708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594286985;
	bh=gpkObb//2/k0Iy0WmqlzWU+vJjSNziglB/IVJFbeIMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0uXVy9N5ACLUDuFZ4G7GWOCJZRldu2VVqrSpqvJvnmGqo/bDaJ9J19R9nfBQXxHEt
	 4w7ApP/PuHe1tVmt+gbn6hHhnzjy+Jm78sfSW9nzYzpgdhhdcjj6H4jsFk0gOYtS37
	 LYJDbOROFQ+9RiHwUAbaCSvTm/UwkCAVS8pPR778=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgGIJ3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgGIJ3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:29:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52FCD206A1;
        Thu,  9 Jul 2020 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594286983;
        bh=gpkObb//2/k0Iy0WmqlzWU+vJjSNziglB/IVJFbeIMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbrH5P0UfjfmLA22jpnIW4y1hcmj9RH8Pi3sXPv+zRe86ZDiJkbHqpwHa8QuILNRv
         GvQf5aE2zNDgJrdKkww5GMKqi2ipPIihF48pxLapCC2tmTWKTTDTmj2WssFco5/SU+
         H4gC9H2wKu4j8ZddiXt5CbnvZYQdoFrbDKzYKKVk=
Date:   Thu, 9 Jul 2020 11:29:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.7 000/112] 5.7.8-rc1 review
Message-ID: <20200709092950.GA46127@kroah.com>
References: <20200707145800.925304888@linuxfoundation.org>
 <20200708175339.GF224053@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708175339.GF224053@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 10:53:39AM -0700, Guenter Roeck wrote:
> On Tue, Jul 07, 2020 at 05:16:05PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.7.8 release.
> > There are 112 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 431 pass: 431 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
