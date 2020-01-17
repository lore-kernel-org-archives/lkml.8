Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A253C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C03120748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579244940;
	bh=gqGk5RIlVExoRNPo6I1om2kUjaX7YU+qWruRNG80PAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P8w7KrCdcNXemwN/HbZX//iEnwBp/gHZxI9A51BVagjqArOsIsjEfEiiRKN5mvVzb
	 sAvszshKRq9Vwzk9W3kpBld+1CHo1vVwYTo6RMh8RPuGRLHxruHY8+owMXdWUxL8iK
	 zJAjITW0K3dnkRTfjsTMaYQAaPvueQ1fe3VywTtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAQHI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:08:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgAQHI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:08:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD7072073A;
        Fri, 17 Jan 2020 07:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579244938;
        bh=gqGk5RIlVExoRNPo6I1om2kUjaX7YU+qWruRNG80PAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OjbBNUdE8ZtnMma+cgDXMWwN8EfxRjHA2lOPYMbaMFBiz37QcGJcQM9ASMgYzoqb7
         faH64b4cF5R2X9FQHnRJrMHh48+Lriiff6PZvISBTcqzdzatBbusqSwygBM0JogqIe
         LpEGOVOLgFaJj0bD0ylv9wTKlilIrbo/V9w8BpIc=
Date:   Fri, 17 Jan 2020 08:08:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.6
Message-ID: <20200117070844.GA1791561@kroah.com>
References: <CGME20200117010835epcas1p46fbb88eb5e5dc008bfb7e403b215650d@epcas1p4.samsung.com>
 <419d4b76-3973-9167-ea09-24be742f2c3c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419d4b76-3973-9167-ea09-24be742f2c3c@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:15:56AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.6. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Detailed description for this pull request:
> 1. Remove unneeded 'extern' keyword from extcon.h header file
> 2. Clean-up the extcon provider
> - Clean-up the code for readability of extcon-arizona/sm5502.c

Pulled and pushed out, thanks.

greg k-h
