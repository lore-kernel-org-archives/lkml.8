Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1A3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDF82081E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579891520;
	bh=dGB8kebwnSDsnoTqQ5uaB5KlcwF3BEdMp8/VYDFuqZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f/zxGDOsTaK0053wPJa2foGEHey/2gkA+4aucVUyGsSmAq9n1o/FQA8MIRe0BoGOH
	 +AnRc2Tgzr8bFUJ4ywgb0/ZkJ1zCbVcO/6zRaKuW9hG191sVCWjYoikARhppYKIpAe
	 Shk9LMAfCH/53JmgHa0PWm2OamnG5LzI2Blcmvoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391529AbgAXSpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388325AbgAXSpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:45:19 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5046F2077C;
        Fri, 24 Jan 2020 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579891518;
        bh=dGB8kebwnSDsnoTqQ5uaB5KlcwF3BEdMp8/VYDFuqZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ViJDPCwzPtouadbVBV+Pfuhb3+Gdqsaq8mixX7FeDS63hiScV796g3/lCp1XeqFqP
         ZxsbjvzR1mv1WlcJRCAmjFAFbv9gpbflxZRfSNe1xYdW9AHG8ge3TXhBBoFJlGUVo8
         w1ZDiLkZa4LqAlPGiGTza2jw7mWTAJ8TnTuohEPc=
Date:   Fri, 24 Jan 2020 10:45:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: oopsably broken case-insensitive support in ext4 and f2fs (Re:
 vfat: Broken case-insensitive support for UTF-8)
Message-ID: <20200124184516.GB41762@gmail.com>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120073040.GZ8904@ZenIV.linux.org.uk>
 <20200120074558.GA8904@ZenIV.linux.org.uk>
 <20200120080721.GB8904@ZenIV.linux.org.uk>
 <20200120193558.GD8904@ZenIV.linux.org.uk>
 <20200124042953.GA832@sol.localdomain>
 <CAHk-=wgwFMW09uz0HLUuQFMpi_UYtKAUvcCJ-oxyVqybry1=Ng@mail.gmail.com>
 <20200124180323.GA33470@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124180323.GA33470@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:03:23AM -0800, Jaegeuk Kim wrote:
> On 01/24, Linus Torvalds wrote:
> > On Thu, Jan 23, 2020 at 8:29 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > Thanks Al.  I sent out fixes for this:
> > 
> > How did that f2fs_d_compare() function ever work? It was doing the
> > memcmp on completely the wrong thing.
> 
> Urg.. my bad. I didn't do enough stress test on casefolding case which
> is only activated given "mkfs -C utf8:strict". And Android hasn't enabled
> it yet.
> 

It also didn't cause *really* obvious breakage because in practice it only
caused ->d_compare() to incorrectly return false, and that just caused new
dentries to be created rather than the existing ones reused.  So most things
continued to work.

It can be noticed by way of deleting files not actually freeing up space... Or
the way I noticed it is that my reproducer for the ->d_hash() crash worked on
ext4 but not f2fs.

- Eric
