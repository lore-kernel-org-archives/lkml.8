Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00FDC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8150A207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598257321;
	bh=g1S66EmQWAV+k+EayM/kYnCFQAJRtZEtgeJDF7d3p9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KTKrdJn/uaF93qfr44CI3Vep6+dDgw1F6Qs9d4ESdPwEsVFab1jnZ67jnvlK6gVO4
	 6j5G+y2SOjfDW1nVL0fzf/il54etlaYPV+pE/u3TbX9/PdFk6DTAE0//BjTLHahzNT
	 OmF3TgU+1/ZChfRQ/wzpK0luxoij592lJ/eSKB8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHXIWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHXIV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:21:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B55CB20738;
        Mon, 24 Aug 2020 08:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598257318;
        bh=g1S66EmQWAV+k+EayM/kYnCFQAJRtZEtgeJDF7d3p9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3Tbj7rBibaJ+C2ENJxhgissd5Q6VtXGau2WFAyZ288dVyb2QTeqecv5ie+4DhmCU
         1QpaiH6w1yRIkBiZck0QWdBsgT74JH7XBJJKoQJdaXec7TUoxx0fsurWUmFoELiwV3
         C9Gzzp+J8BtGzJxudbb9cDUPUkR5bER2kaMCOhG4=
Date:   Mon, 24 Aug 2020 10:22:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     syzbot <syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, jslaby@suse.cz,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nico@fluxnic.net,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Write in vcs_read
Message-ID: <20200824082216.GC336539@kroah.com>
References: <0000000000005d511305ad725632@google.com>
 <c432d894-eae6-1541-0f29-267b4a16b3ae@kernel.org>
 <2e94ac46-7f0c-c322-d217-afe021214eaf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e94ac46-7f0c-c322-d217-afe021214eaf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 10:03:54AM +0200, Jiri Slaby wrote:
> On 22. 08. 20, 9:34, Jiri Slaby wrote:
> > On 22. 08. 20, 9:31, syzbot wrote:
> >> syzbot has bisected this issue to:
> >>
> >> commit b1c32fcfadf5593ab7a63261cc8a5747c36e627e
> >> Author: Jiri Slaby <jslaby@suse.cz>
> >> Date:   Tue Aug 18 08:57:05 2020 +0000
> >>
> >>     vc_screen: extract vcs_read_buf_header
> > 
> > It's like 7th e-mail about the very same issue. Can it be
> > suspended/acknowledged somehow?
> > 
> >> Reported-by: syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com
> > 
> > I haven't managed to find the root cause on Fri yet, I will chase it on
> > Mon again.
> 
> Ah, I see now. And the easiest way of handling this is simply revert the
> commit now, re-think and redo during the next merge window.
> 
> There are two issues with the patch:
> 1) vcs_read rounds the 'count' up to an even number. So if we read odd
> bytes from the header (3 in the reproducer), the second byte of
> (2-byte/ushort) write to temporary con_buf won't fit. It is because with
> the patch applied, we only subtract the real number read (3 bytes) and
> not the whole header (4 bytes).
> 
> 2) in this scenario, we perform unaligned accesses now. 2-byte/ushort
> writes to odd addresses. Due to the same reason as above.
> 
> So Greg, could you revert with the above reasoning? It reverts cleanly.
> Or do you want me to send a revert?

If you send a revert it is always easier for me to apply that :)

thanks,

greg k-h
