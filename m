Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76984C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 08:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A33421744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 08:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDSIGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 04:06:48 -0400
Received: from verein.lst.de ([213.95.11.211]:35721 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDSIGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 04:06:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 820AB68BEB; Sun, 19 Apr 2020 10:06:46 +0200 (CEST)
Date:   Sun, 19 Apr 2020 10:06:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Jeremy Kerr <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 8/8] exec: open code copy_string_kernel
Message-ID: <20200419080646.GE12222@lst.de>
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-9-hch@lst.de> <ffea91ee-f386-9d19-0bc9-ab59eb7b9a41@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffea91ee-f386-9d19-0bc9-ab59eb7b9a41@c-s.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 10:15:42AM +0200, Christophe Leroy wrote:
>
>
> Le 14/04/2020 à 09:01, Christoph Hellwig a écrit :
>> Currently copy_string_kernel is just a wrapper around copy_strings that
>> simplifies the calling conventions and uses set_fs to allow passing a
>> kernel pointer.  But due to the fact the we only need to handle a single
>> kernel argument pointer, the logic can be sigificantly simplified while
>> getting rid of the set_fs.
>
>
> Instead of duplicating almost identical code, can you write a function that 
> takes whether the source is from user or from kernel, then you just do 
> things like:
>
> 	if (from_user)
> 		len = strnlen_user(str, MAX_ARG_STRLEN);
> 	else
> 		len = strnlen(str, MAX_ARG_STRLEN);
>
>
> 	if (from_user)
> 		copy_from_user(kaddr+offset, str, bytes_to_copy);
> 	else
> 		memcpy(kaddr+offset, str, bytes_to_copy);

We'll need two different str variables then with and without __user
annotations to keep type safety.  And introduce a branch-y and unreadable
mess in the exec fast path instead of adding a simple and well understood
function for the kernel case that just deals with the much simpler case
of just copying a single arg vector from a kernel address.
