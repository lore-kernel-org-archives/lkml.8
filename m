Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1860B2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="NSCwOIJ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uLS2UPQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHLADm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:03:42 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:59485 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbgHLADl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:03:41 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id AB3D5A90;
        Tue, 11 Aug 2020 20:03:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 11 Aug 2020 20:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        kGifzmVGohkcjzjJYIDd7v3omhl5y0GHMaOegwXuLr4=; b=NSCwOIJ+26IOv8Ny
        q1bNKLh5XgI1duThB2HsZXSyn/DX6U4JxFo6pLYMUnGRDkOjxrukzZMq2XFWeT7U
        LcrUSUaMqx5nBMw1kc108Wb6vIIY6DWhXAYnyJk6M91PoU4LkCJWMqwLeB2NMrtT
        XaZeBQWa1oAYYtbLOlI6mFsB80aAKGNQ6TDcwMaRWrSpo+UpY2GXaKtW7gBhMBw8
        I/CXDbZgWF6i880JlWoyTazD3Ke4eTShooQX8xfN+LHijuOdQt8a2yjUWaPx071K
        WQXRBDZzi8UO1ZOvRGRhZNvopSeVQjIDumpyGhtPj5yOkR7mHHUTz33AtbJXvzvg
        v+0+og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=kGifzmVGohkcjzjJYIDd7v3omhl5y0GHMaOegwXuL
        r4=; b=uLS2UPQUJgXX+yUdXMCtIrasj5hGV5znNtGp26pDIGvWfF2yZLVzm4xTP
        lVcT8+80lrQf8jccUOX9CXleOGtgQrJXzUv5Aq7WeTlNE8bmNSR0B/y/0I+ORKYF
        ueghXjgGA3xnmZLBmoVX/3iYfu6L990NdwgjWBrGDB1m04Vmx7gHq/z5wCCfpQL+
        Ed6waam5qj2aA0UXCMpf29dKIrP3LdpzUDvsMs5CdNF13zCyfPz02JpC+TGF34yP
        0LSwwgODxGeNiN/ldfq6AxFcckfTKnj4BYdxtZa5UchS2abWJBqjXaGc2Q+1a4li
        46KCZl+rHw1hF0eVU2BBCu/7qstvw==
X-ME-Sender: <xms:2zEzX6DvkQr1ZVs5eU7oDI0lDcOC2ik53f_CaJov5iY9kU0TmYbxsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrledugddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvddtfedruddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:2zEzX0jj4oy2_FAPf0VaaykghkL7W28vX9tswo5EwBoFoXg76qByRQ>
    <xmx:2zEzX9nNjcIV89QmeYvdVReUlleB3bByC9vqRBhPb9WFPhlT_ZjhRA>
    <xmx:2zEzX4wHQXSdgqjexWumWNLoh-0LS2abP1J13uwsdkFqpgoML90DEw>
    <xmx:3DEzXyM3lRXZzOFUDNtKUg5i2FIllDqwIeJx_dSEIqqCeo7YtgTi7w>
Received: from mickey.themaw.net (58-7-203-114.dyn.iinet.net.au [58.7.203.114])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6B8F13280060;
        Tue, 11 Aug 2020 20:03:37 -0400 (EDT)
Message-ID: <b597b764341317fd8b32345265e570dae3c25040.camel@themaw.net>
Subject: Re: [PATCH] fs: autofs: delete repeated words in comments
From:   Ian Kent <raven@themaw.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     autofs@vger.kernel.org
Date:   Wed, 12 Aug 2020 08:03:33 +0800
In-Reply-To: <811e011e-2f45-87c3-d92d-729680da5917@infradead.org>
References: <20200811021817.24982-1-rdunlap@infradead.org>
         <75e04b06be0561c3cec936cd3bbc44fe82ca73f4.camel@themaw.net>
         <811e011e-2f45-87c3-d92d-729680da5917@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-11 at 07:42 -0700, Randy Dunlap wrote:
> On 8/11/20 1:36 AM, Ian Kent wrote:
> > On Mon, 2020-08-10 at 19:18 -0700, Randy Dunlap wrote:
> > > Drop duplicated words {the, at} in comments.
> > > 
> > > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Ian Kent <raven@themaw.net>
> > > Cc: autofs@vger.kernel.org
> > 
> > Acked-by: Ian Kent <raven@themaw.net>
> 
> Hi Ian,
> 
> Since you are the listed maintainer of this file, does this mean
> that you will be merging it?

I could but that would mean double handling since I would send it
to Andrew anyway.

Andrew, could you take this one please?

> 
> thanks.
> 
> > > ---
> > >  fs/autofs/dev-ioctl.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > --- linux-next-20200807.orig/fs/autofs/dev-ioctl.c
> > > +++ linux-next-20200807/fs/autofs/dev-ioctl.c
> > > @@ -20,7 +20,7 @@
> > >   * another mount. This situation arises when starting
> > > automount(8)
> > >   * or other user space daemon which uses direct mounts or offset
> > >   * mounts (used for autofs lazy mount/umount of nested mount
> > > trees),
> > > - * which have been left busy at at service shutdown.
> > > + * which have been left busy at service shutdown.
> > >   */
> > >  
> > >  typedef int (*ioctl_fn)(struct file *, struct autofs_sb_info *,
> > > @@ -496,7 +496,7 @@ static int autofs_dev_ioctl_askumount(st
> > >   * located path is the root of a mount we return 1 along with
> > >   * the super magic of the mount or 0 otherwise.
> > >   *
> > > - * In both cases the the device number (as returned by
> > > + * In both cases the device number (as returned by
> > >   * new_encode_dev()) is also returned.
> > >   */
> > >  static int autofs_dev_ioctl_ismountpoint(struct file *fp,

