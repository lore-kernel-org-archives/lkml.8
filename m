Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA306C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE86820872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgESFqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:46:10 -0400
Received: from verein.lst.de ([213.95.11.211]:42337 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgESFqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:46:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F31C968B02; Tue, 19 May 2020 07:46:06 +0200 (CEST)
Date:   Tue, 19 May 2020 07:46:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/18] maccess: unify the probe kernel arch hooks
Message-ID: <20200519054606.GA23853@lst.de>
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-11-hch@lst.de> <20200514101318.1c14647e41b7038b99b91fcd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514101318.1c14647e41b7038b99b91fcd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:13:18AM +0900, Masami Hiramatsu wrote:
> > +		bool strict)
> >  {
> >  	long ret;
> >  	mm_segment_t old_fs = get_fs();
> >  
> > +	if (!probe_kernel_read_allowed(dst, src, size, strict))
> > +		return -EFAULT;
> 
> Could you make this return -ERANGE instead of -EFAULT so that
> the caller can notice that the address might be user space?

That is clearly a behavior change, so I don't want to mix it into
this patch.  But I can add it as another patch at the end.
