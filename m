Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D43C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A395520888
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592950443;
	bh=i4JI7Wlg1bRXKCVQ70zwdpyCQhPCsjcBPSKZS7v3IWY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=GfRSn5owJxcpw7lL7gE1ZDNOsVr1mFGCYBWj6oY9mO9WYp/0YdFEiE8HW8wqYZQo6
	 MJLdEAyZy7Avns9tibKBAZLtl4gcwKuNmcJZQGmt2tghbiVPASj/rA0sa448g0j5c3
	 CMe680TUjBfoIb9GKkfxNEmPUU35akk9ggSPnjFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbgFWWOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387609AbgFWWOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:14:01 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A17D420724;
        Tue, 23 Jun 2020 22:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592950441;
        bh=i4JI7Wlg1bRXKCVQ70zwdpyCQhPCsjcBPSKZS7v3IWY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=g5GRLEgnX5RuHYiIAAHJ6VpF3ogoy853hF421Cx+cQgz/pXWZFIZH1CtC+B84295Y
         CNuKhhNNjrMQM9B2sRZxhAAd4gxM+Cpww9KuiSxk7fWmRvE7cNA4z+06q7CD1p89yX
         Z/GT/1ck/+Kpwmf5VxbKY9yDkv1VfuhFAoUpUYPo=
Date:   Wed, 24 Jun 2020 00:13:57 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cristian Klein <cristian.klein@elastisys.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: linux-next: build failures after merge of the hid tree
In-Reply-To: <20200623103736.25f67de5@canb.auug.org.au>
Message-ID: <nycvar.YFH.7.76.2006240012170.13242@cbobk.fhfr.pm>
References: <20200621140421.7f4552df@canb.auug.org.au> <20200623103736.25f67de5@canb.auug.org.au>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020, Stephen Rothwell wrote:

> > I don't know what caused it, but commit
> > 
> >   470376737e88 ("HID: allow building hid.ko as an external module")
> > 
> > did not fix it.  BTW, I build with "make O=...".

That's actually the patch that almost certainly broke it.

CCing Cristian (author of that patch) and Nathan, who apparently sent a 
fixup patch for this, but I haven't seen it, as our corporate mailserver 
had severe issues yesterday.

If there is no resolution by tomorrow, we'll just drop it.

-- 
Jiri Kosina
SUSE Labs

