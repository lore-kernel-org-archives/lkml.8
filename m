Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE651C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03CD2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595272437;
	bh=hLXOHhr7/G2lqFQDj4nvPKc453bOQlXUJx/UKuZzRJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kt01ZmFCWa0lssG2+pwGuiMROae74Oo14PvLTiD27UfqSk4lvrVT+erkEb2dDL0uO
	 htBd63tZB5yDvkF0x/Csyq5JdAPqCRSEAbwyiBPUAaV4PDfAc/Z/Npps6ajNdGGeTz
	 RnYgAr7uNuqKwyTVa+crQATfdaBlRKgiiXU8AOcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgGTTNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbgGTTNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:13:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A46C2176B;
        Mon, 20 Jul 2020 19:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595272434;
        bh=hLXOHhr7/G2lqFQDj4nvPKc453bOQlXUJx/UKuZzRJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBXDlQsr8NG7GoGgB4PpDI4UZSCPnnMRA1YjX9aKE4sQ74fC+ItEdKkJeXt+EBrRb
         /XjQijor7OKyNKRyAgRAoVuNsAdQamO54Hpuu4xf82HH8V0jPXs1UNoJmWfemtqUlV
         +ooY2xvQuzZ0RMEbUFMkTGD7/aOmJV9BlObs+au4=
Date:   Mon, 20 Jul 2020 21:14:03 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "walken@google.com" <walken@google.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zong.li@sifive.com" <zong.li@sifive.com>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>
Subject: Re: [PATCH 5.7 233/244] RISC-V: Acquire mmap lock before invoking
 walk_page_range
Message-ID: <20200720191403.GB1529125@kroah.com>
References: <20200720152825.863040590@linuxfoundation.org>
 <20200720152836.926007002@linuxfoundation.org>
 <CA+G9fYteJs0X1Ctjbt-51Q9J2JHM--cOpYg+02jSdfnbWbwr2g@mail.gmail.com>
 <194a70d4428b96b59594efc5cae7ed26f6da45b3.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194a70d4428b96b59594efc5cae7ed26f6da45b3.camel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 06:50:10PM +0000, Atish Patra wrote:
> On Mon, 2020-07-20 at 23:11 +0530, Naresh Kamboju wrote:
> > RISC-V build breaks on stable-rc 5.7 branch.
> > build failed with gcc-8, gcc-9 and gcc-9.
> > 
> 
> Sorry for the compilation issue.
> 
> mmap_read_lock was intrdouced in the following commit.
> 
> commit 9740ca4e95b4
> Author: Michel Lespinasse <walken@google.com>
> Date:   Mon Jun 8 21:33:14 2020 -0700
> 
>     mmap locking API: initial implementation as rwsem wrappers
> 
> The following two commits replaced the usage of mmap_sem rwsem calls
> with mmap_lock.
> 
> d8ed45c5dcd4 (mmap locking API: use coccinelle to convert mmap_sem
> rwsem call sites)
> 89154dd5313f (mmap locking API: convert mmap_sem call sites missed by
> coccinelle)
> 
> The first commit is not present in stale 5.7-y for obvious reasons.
> 
> Do we need to send a separate patch only for stable branch with
> mmap_sem ? I am not sure if that will cause a conflict again in future.

I do not like taking odd backports, and would rather take the real patch
that is upstream.

I will drop this patch from the tree now, so everyone can figure out
what they want to do in the future :)

thanks,

greg k-h
