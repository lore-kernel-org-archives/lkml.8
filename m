Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0503AC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5CD2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585051960;
	bh=Bphhgfsbe3p7ol339Zk73OCu5K+a0Ym80sypX+2urW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AyGDiDL73BFzXPNKE9XmJPkMtJVSWVl8OyuPs1nnCA0LNbbkrLanO3SZRe0lra2C3
	 3FgcljG9RN9X5hhNKWv7INftwz0kLoGjhjbxo/9g+4oa71R96c2wATsrmxUX45AAy1
	 yxzSvFW6TY/q2eXcZpF27TsiFjt7Ge0L5xqEf/lI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgCXMMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgCXMMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:12:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E8620714;
        Tue, 24 Mar 2020 12:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585051959;
        bh=Bphhgfsbe3p7ol339Zk73OCu5K+a0Ym80sypX+2urW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htbhJMh0x5pzv+XcQvFnFLIRlXvmGZDclymYJtwvKThgR3Xd3rb3+/KTMp/VGRmcc
         bGxbBZ3Z6smX8zAncVv7pRncDNP6ORZ6Li13BuClqCfitCivXW5LKPlj46yCy5p4TA
         v2zvnsjQo6tgBPBevP+QzE6Jvr/fFaupWoYHgOVk=
Date:   Tue, 24 Mar 2020 13:12:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     jslaby@suse.com, slyfox@gentoo.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, rei4dan@gmail.com,
        Dave Tian <dave.jing.tian@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: UBSAN: Undefined behaviour in drivers/tty/vt/keyboard.c
Message-ID: <20200324121236.GB2333340@kroah.com>
References: <CAEAjamv3wT4aqF0y1_PHG_=cbzH-ATsP6TiV5Zt5Qc+ACVnOPw@mail.gmail.com>
 <20200323064616.GB129571@kroah.com>
 <CAEAjamvv7LzaTBu-Xh5rg4r1-_NaDDGVoe9LZ7NmZv3gpLXkuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEAjamvv7LzaTBu-Xh5rg4r1-_NaDDGVoe9LZ7NmZv3gpLXkuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 04:44:31PM -0400, Kyungtae Kim wrote:
> On Mon, Mar 23, 2020 at 07:46:16AM +0100, Greg KH wrote:
> > On Sun, Mar 22, 2020 at 11:34:01PM -0400, Kyungtae Kim wrote:
> > > We report a bug (in linux-5.5.11) found by FuzzUSB (modified version
> > > of syzkaller)
> > >
> > > Seems the variable "npadch" has a very large value (i.e., 333333333)
> > > as a result of multiple executions of the function "k_ascii" (keyboard.c:888)
> > > while the variable "base" has 10.
> > > So their multiplication at line 888 in "k_ascii" will become
> > > larger than the max of type int, causing such an integer overflow.
> > >
> > > I believe this can be solved by checking for overflow ahead of operations
> > > e.g., using check_mul_overflow().
> > >
> > > kernel config: https://kt0755.github.io/etc/config_v5.5.11
> >
> > Great, can you send a patch for this?
> >
> > thanks,
> >
> > greg k-h
> 
> I'm not sure the following works best.
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 15d33fa0c925..c1ae9d2e6970 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -869,6 +869,7 @@ static void k_meta(struct vc_data *vc, unsigned
> char value, char up_flag)
>  static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
>  {
>         int base;
> +       int bytes, res;
> 
>         if (up_flag)
>                 return;
> @@ -884,6 +885,8 @@ static void k_ascii(struct vc_data *vc, unsigned
> char value, char up_flag)
> 
>         if (npadch == -1)
>                 npadch = value;
> +       else if (check_mul_overflow(npadch, base, &bytes) ||
> check_add_overflow(bytes, value, &res))
> +               return;
>         else
>                 npadch = npadch * base + value;
>  }

Does this solve the issue for you?  If so, can you fix it up and resend
it in a format that I can apply it in?

thanks,

greg k-h
