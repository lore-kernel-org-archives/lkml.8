Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A051DC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA8E20CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583220690;
	bh=1T0/XnPDbJDk2pBKVErlNQNAmU8fCNU87LT0UhuUwwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xrdsl5yEGKS//36OGzUCV/t7gWR0I+gJmnDJyzuSweKuL0AZGYsylUNb3+s6iT37B
	 zCsV9Fi54GQHZg5tcNtxrE1+F6q8t3pEbQvoPLYUdi0Ys3Weab0usQna4QbM5YxQiH
	 k7JCdq1RB+Cwmk8U/uOkiqD7XXUT0B5c8Z8cBIlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgCCHb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:31:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgCCHb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:31:29 -0500
Received: from onda.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3929F20CC7;
        Tue,  3 Mar 2020 07:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583220688;
        bh=1T0/XnPDbJDk2pBKVErlNQNAmU8fCNU87LT0UhuUwwc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xyih+dCXVSGNn5XEPLi6Zc+a9ZY8ES8LVEzV1hUqsu9xNdZKXuDyOoemqaem9P0pm
         yByEJcMpzAA5WsPqsEIf1BneOKPdfsvarmXzB0SUPSPGBtHmJ+q3CPheRHs0diFl0i
         5B4/VCRFdSKGNYx/+gKsOCTRvpR0EkdRQx1mU9Aw=
Date:   Tue, 3 Mar 2020 08:31:22 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/12] docs: dt: usage_model.rst: fix link for DT
 usage
Message-ID: <20200303083122.10637da3@onda.lan>
In-Reply-To: <CAL_JsqJwKcR4UVit=VBnvOcKx0z9UuUw5aXd0Y7+2nMgk3X_zw@mail.gmail.com>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
        <a7e0a5597ace97503c8ff67cdab2351151c7f267.1583135507.git.mchehab+huawei@kernel.org>
        <7a4d92e5-a1e2-6bd2-9a40-dcdb52e80801@gmail.com>
        <CAL_JsqJwKcR4UVit=VBnvOcKx0z9UuUw5aXd0Y7+2nMgk3X_zw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 2 Mar 2020 15:40:37 -0600
Rob Herring <robh+dt@kernel.org> escreveu:

> On Mon, Mar 2, 2020 at 3:11 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > On 3/2/20 1:59 AM, Mauro Carvalho Chehab wrote:  
> > > The devicetree.org doesn't host the Device_Tree_Usage page
> > > anymore. So, fix the link to point to a new address.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  Documentation/devicetree/usage-model.rst | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devicetree/usage-model.rst
> > > index 326d7af10c5b..e1b42dc63f01 100644
> > > --- a/Documentation/devicetree/usage-model.rst
> > > +++ b/Documentation/devicetree/usage-model.rst
> > > @@ -12,7 +12,7 @@ This article describes how Linux uses the device tree.  An overview of
> > >  the device tree data format can be found on the device tree usage page
> > >  at devicetree.org\ [1]_.  
> >
> > s/devicetree.org/elinux.org/  
> 
> I wonder if we should make the devicetree.org link work again instead.
> Primarily just to avoid the appearance of it being Linux specific.

Makes sense to me. Another alternative would be to convert this file to
ReST and add to the Kernel docs (it should be easy to convert with pandoc).

Yet, as those references are part of the Linux Kernel documentation, it 
doesn't sound wrong to me to have them pointing to a linux-specific site.

In any case, I'll update this patch, placing all such changes altogether.
This way, if you decide to re-add this at devicetree.org, we could simply
drop (or revert) it.

> 
> The website is hosted on github[1] and I'd assume there's a way to do
> redirects as a start.
> 
> Rob
> 
> [1] https://github.com/devicetree-org/devicetree-website
