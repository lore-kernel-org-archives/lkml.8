Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAF4C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE23E206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589354056;
	bh=DLr2UF6e0IHfcW2xoKKLz/KEhDxSLoxOz8Ehzzq0pOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PEmHESHsbeYYz1t9WBoeuCQUzc3OwXZmSSoSkGroh/mlE/Qkz1Vbvp7lOKRv7b216
	 V+eMaDQhMNyIf4PpolndXUVnj7lxSsrzd6cExEB9FU5hORB2z4Md5BWfgTnU6wtvs6
	 LA3aSf6hPVEL9h9umJ9m768tRI2i+x5oLO+Fdgdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbgEMHOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEMHOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:14:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99B9206D6;
        Wed, 13 May 2020 07:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589354055;
        bh=DLr2UF6e0IHfcW2xoKKLz/KEhDxSLoxOz8Ehzzq0pOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgtWzUv5Pg1zRmc16W7qpkqqRqludZO1T7kog9p3eecl7JMcb5IxeW5U9A2y3pi07
         l9WRB5Dpp95/qBln3UUKhkMmykr7W2pl5z1cpYtBIxmIlUbleEBZMkPa8aXmEOi43d
         7O4k8NtL6nwaZ0pHpd5u4Cf5pXxpfhKeZ+BwelpA=
Date:   Wed, 13 May 2020 09:14:13 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Idgar, Or" <Or.Idgar@dell.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Ravich, Leonid" <Leonid.Ravich@dell.com>
Subject: Re: CMA enhancement - non-default areas in x86
Message-ID: <20200513071413.GB766804@kroah.com>
References: <CH2PR19MB3767236EDC9BE964FC3AB91BFEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
 <20200513064755.GA763968@kroah.com>
 <CH2PR19MB376794E120B9B02856DC87C3FEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR19MB376794E120B9B02856DC87C3FEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 07:00:12AM +0000, Idgar, Or wrote:
> > For what type of device?
> NTB (Non-Transparent Bridge).


Very odd quoting style...

Anyway, what exactly is a non-transparent bridge, and why doesn't your
bios/uefi implementation properly reserve the memory for it so that the
OS does not use it?

thanks,

greg k-h
