Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA811C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F04A20737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585855257;
	bh=mdROf5FDATZ7QP97pw47LQyxagMXuoP+y7Kaxh6NErM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PQoL8DySZGjfca5rDAUwd6xPLRpnh6MJ3GXMV3a8IWVEyaRZShNG5ldDNMIHpUXAe
	 8X15D6OcFbZUk7e29dL0hOjg6hn7l90BxHRZmCPJW/8P6ST7zHApJsL2y37PDDQFW9
	 JGRgkWjGp7yJpGVfwdAioKLBueCbO7xvCiZKW1kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389838AbgDBTU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389261AbgDBTU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:20:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 208E8206F8;
        Thu,  2 Apr 2020 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585855255;
        bh=mdROf5FDATZ7QP97pw47LQyxagMXuoP+y7Kaxh6NErM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+rTAt0fHo/krTsbIxVlaFbiH3a630gdyVE6f4HA6qC54/KKEwURGtEMnU21vWygR
         del+6EMtTZ+Amw3nflUoCTHRWjiIMsiCrNwu5XGTQ7OZZrkstHbAga8OmPyLZDuO81
         LI0QpDjAFcnNDavJEKpe0aDJIDhmaJl9549G/Kyw=
Date:   Thu, 2 Apr 2020 21:20:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Alistair Delva <adelva@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 4.19 105/116] bpf: Explicitly memset the bpf_attr
 structure
Message-ID: <20200402192053.GB3243295@kroah.com>
References: <20200401161542.669484650@linuxfoundation.org>
 <20200401161555.630698707@linuxfoundation.org>
 <20200402185320.GA8077@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402185320.GA8077@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 08:53:21PM +0200, Pavel Machek wrote:
> Should we fix gcc, instead?

Also, this is allowed in the C standard, and both clang and gcc
sometimes emit code that does not clear padding in structures.  Changing
the compiler to not do this would be wonderful, but we still have to
live with this for the next 10 years as those older compilers age-out.

sorry,

greg k-h
