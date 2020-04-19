Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F220AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 08:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A7421744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 08:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDSIFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 04:05:09 -0400
Received: from verein.lst.de ([213.95.11.211]:35714 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDSIFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 04:05:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 03BEB68BEB; Sun, 19 Apr 2020 10:05:07 +0200 (CEST)
Date:   Sun, 19 Apr 2020 10:05:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 1/2] signal: Factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
Message-ID: <20200419080506.GD12222@lst.de>
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-3-hch@lst.de> <87pnc5akhk.fsf@x220.int.ebiederm.org> <87k12dakfx.fsf_-_@x220.int.ebiederm.org> <c51c6192-2ea4-62d8-dd22-305f7a1e0dd3@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c51c6192-2ea4-62d8-dd22-305f7a1e0dd3@c-s.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 10:05:19AM +0200, Christophe Leroy wrote:
>
>
> Le 17/04/2020 à 23:09, Eric W. Biederman a écrit :
>>
>> To remove the use of set_fs in the coredump code there needs to be a
>> way to convert a kernel siginfo to a userspace compat siginfo.
>>
>> Call that function copy_siginfo_to_compat and factor it out of
>> copy_siginfo_to_user32.
>
> I find it a pitty to do that.
>
> The existing function could have been easily converted to using 
> user_access_begin() + user_access_end() and use unsafe_put_user() to copy 
> to userspace to avoid copying through a temporary structure on the stack.
>
> With your change, it becomes impossible to do that.

As Eric said we need a struct to clear all padding.  Note that I
though about converting to unsafe_copy_to_user in my variant as we
can pretty easily do that if pre-filling the structure earlier.  But
I didn't want to throw in such unrelated changes for now - I'll volunteer
to do it later, though.
