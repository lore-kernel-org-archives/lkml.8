Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D93C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB79204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWYVMjGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgE0UdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgE0UdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:33:21 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DF9C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:33:21 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id f3so27630598ioj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vFN875M4SjcSJqsQBhIyGl6yme7p3cXKTVvGnFDckQ=;
        b=PWYVMjGMInGK/+VGo90K1Nt077ISBvqH8S5m6aLr4ibsjLTafr454aQn5QUd9Jb3hg
         HIU8mhDByYhLX3UkQt4D2Rzx+UVqcITBJt/Z4Nm6cp0g3Yl09HlbCDBmvalwwApZDcJq
         TCSN2E+kQC1owKCySYdCL/ZBpO/l+v9tEX/zkwIqcVmYC3Es00307vvVuukW+gfBKFav
         i6oSBJGUvh2sDvYIrnmTx+zjY2VjsXPx1P13677f7kwCF/waz1sJrfeR5w+b0s69jvIE
         AHkw/MwxAJolk8NT1IA/Xyxgf38aptnsu1Ger4NNw9zCeR9Z9AU3V+o4nn5nRSj+QM8o
         ELDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vFN875M4SjcSJqsQBhIyGl6yme7p3cXKTVvGnFDckQ=;
        b=KVAsvAcS8w4LhXxc4vI/gfRWz8tnfUdzH9nUSvFwC573XaYhf9mEKXW/P/GYtboqBs
         EDa0SiSO67SYGZmbK2qN8wNXDA54fqpBWdavygIqKjaVUbMyWFDGMGjmHncSTyEgAExx
         d9xNmE83FmsajGlSUO+VJMIN/oU+7CbQz9vXEQHsTBdia1Isaxg/lpDVedcP7c2ILK0E
         6/Qad5TbGz/NudHwH5X49ExnqCDt/3S5WyxVm8P7jjDp7ov6KbX5ZPLorKxQYdJIubQo
         hg8WzMA8JW1KUVeW2iHmU2by6dxcN34RRDFNSFD8BdM9QrdPvf0ADUWpwzKGL+zSG2iB
         /9wg==
X-Gm-Message-State: AOAM53390CqFgzg/GsgSaA/sCeUzks+0jgVmZ3tiw5Zzx3vl83n6WQ0p
        Y9DYBlsm+Oln2TAFXnqXoYeqRzT6IRnwpDwH5NOLZA==
X-Google-Smtp-Source: ABdhPJwjayx9asTvHrdVtxj1V1NSaSKRT0BosTcJ5cpULOtZMGwSZrsfDFwEsny8NbcaKy/c0xKEWbch/jHI5WEaREE=
X-Received: by 2002:a02:3b4b:: with SMTP id i11mr7539961jaf.16.1590611600730;
 Wed, 27 May 2020 13:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200523212919.33181-1-pterjan@google.com> <20200527194811.GF30374@kadam>
In-Reply-To: <20200527194811.GF30374@kadam>
From:   Pascal Terjan <pterjan@google.com>
Date:   Wed, 27 May 2020 21:33:03 +0100
Message-ID: <CAANdO=LqcHOzxSjudw+G+292sjguOoA-E2y4iAFZtCfa0UFe1A@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Use shared header constants
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 at 20:48, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Sat, May 23, 2020 at 10:29:19PM +0100, Pascal Terjan wrote:
> > This is one of the 9 drivers redefining rfc1042_header.
> >
>
> This is how the patch looks like in my email client:
>
> https://marc.info/?l=linux-driver-devel&m=159026973821890&w=2
>
> Do you see how the subject is far away from the body of the commit
> message?  I normally only read the subject or the body when I'm
> reviewing patches so it's good if the body is clear on its own.  Maybe
> write something like:
>
> "This driver creates a local definitions of "rtw_rfc1042_header" and
> "rtw_bridge_tunnel_header" but it should just use the standard definitions
> from cfg80211.h."

Thanks, I see both together when writing the commit message and need
to remember they are actually separate.

> >  void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
> > @@ -1625,11 +1622,11 @@ sint wlanhdr_to_ethhdr(union recv_frame *precvframe)
> >       psnap_type = ptr+pattrib->hdrlen + pattrib->iv_len+SNAP_SIZE;
> >       /* convert hdr + possible LLC headers into Ethernet header */
> >       /* eth_type = (psnap_type[0] << 8) | psnap_type[1]; */
> > -     if ((!memcmp(psnap, rtw_rfc1042_header, SNAP_SIZE) &&
> > -             (memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2)) &&
> > -             (memcmp(psnap_type, SNAP_ETH_TYPE_APPLETALK_AARP, 2))) ||
> > -             /* eth_type != ETH_P_AARP && eth_type != ETH_P_IPX) || */
> > -              !memcmp(psnap, rtw_bridge_tunnel_header, SNAP_SIZE)) {
> > +     if ((!memcmp(psnap, rfc1042_header, SNAP_SIZE) &&
> > +          memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2) &&
> > +          memcmp(psnap_type, SNAP_ETH_TYPE_APPLETALK_AARP, 2)) ||
> > +         /* eth_type != ETH_P_AARP && eth_type != ETH_P_IPX) || */
> > +         !memcmp(psnap, bridge_tunnel_header, SNAP_SIZE)) {
> >               /* remove RFC1042 or Bridge-Tunnel encapsulation and replace EtherType */
> >               bsnaphdr = true;
>
> Your indenting is correct, but I would probably do that in a separate
> patch.  It makes it harder to review.  Also probably delete the
> commented out code.  Do you see how if we don't touch the indenting then
> it doesn't raise the question about if we should delete the comments as
> well?

I initially didn't want to change it but checkpatch was sad which
makes me sad, maybe I should have cleaned up this area in a first
trivial patch before touching that line.
