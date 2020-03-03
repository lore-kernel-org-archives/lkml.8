Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D866DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF08B2146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583219865;
	bh=Fe9C3JO/6dFS4hMmkIV4wOTyNTtzIWd54ZQJ+OuoeBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lptrL8l8PigOIM5uLhOvPPjUEo9xV5vYkZIJ1xFksp8YnAokO0xO7OW/ekVG7nkgo
	 Sj4mMx3RTBWHtYgzycHpViD7SiLyr+uCVrE6+zinG1qp9zTXbgZNRgUVtAnWTCmcZN
	 4tmcCYGlycF8Iz8uj/kXDvG9Qgn0v1ais6HyeI0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCCHRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:17:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgCCHRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:17:44 -0500
Received: from onda.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 396F2206D5;
        Tue,  3 Mar 2020 07:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583219863;
        bh=Fe9C3JO/6dFS4hMmkIV4wOTyNTtzIWd54ZQJ+OuoeBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PmIQIKfAYsVQtKrR+L8fjIjigxaH0hJBHCPWaw5HpRAe0kWGc+1M0USf8JNT9m2hh
         dnIKP2izDuwkI4ENVVJCa9LZqaBZVkk4qXcy7eGEHvBs4IsLZCdYBSULBIfD805mkQ
         d0Iuo3sdXkTEXsufaQD2DKNNciWyXOV2ZOVdfEZM=
Date:   Tue, 3 Mar 2020 08:17:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 08/12] docs: dt: convert overlay-notes.txt to ReST
 format
Message-ID: <20200303081739.643dbe94@onda.lan>
In-Reply-To: <3fac6196-e9c4-a23d-c5e3-f17367e5db91@gmail.com>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
        <1685e79f7b53c70c64e37841fb4df173094ebd17.1583135507.git.mchehab+huawei@kernel.org>
        <3fac6196-e9c4-a23d-c5e3-f17367e5db91@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 2 Mar 2020 15:13:21 -0600
Frank Rowand <frowand.list@gmail.com> escreveu:

> On 3/2/20 1:59 AM, Mauro Carvalho Chehab wrote:
> > - Add a SPDX header;
> > - Adjust document title;
> > - Some whitespace fixes and new line breaks;
> > - Mark literal blocks as such;
> > - Add it to devicetree/index.rst.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/devicetree/index.rst            |   1 +
> >  .../{overlay-notes.txt => overlay-notes.rst}  | 141 +++++++++---------
> >  MAINTAINERS                                   |   2 +-
> >  3 files changed, 74 insertions(+), 70 deletions(-)
> >  rename Documentation/devicetree/{overlay-notes.txt => overlay-notes.rst} (56%)
> > 
> > diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
> > index ca83258fbba5..0669a53fc617 100644
> > --- a/Documentation/devicetree/index.rst
> > +++ b/Documentation/devicetree/index.rst
> > @@ -13,3 +13,4 @@ Open Firmware and Device Tree
> >     changesets
> >     dynamic-resolution-notes
> >     of_unittest
> > +   overlay-notes
> > diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.rst
> > similarity index 56%
> > rename from Documentation/devicetree/overlay-notes.txt
> > rename to Documentation/devicetree/overlay-notes.rst
> > index 3f20a39e4bc2..7e8e568f64a8 100644
> > --- a/Documentation/devicetree/overlay-notes.txt
> > +++ b/Documentation/devicetree/overlay-notes.rst  
> 
> There is a collision between 08/12 and a patch I sent a couple of days ago:
> 
>    https://lore.kernel.org/r/1580171838-1770-1-git-send-email-frowand.list@gmail.com

Thanks for pointing it! I'll rebase on the top of linux-next tomorrow
and add your patch on my tree before my series, if not merged on -next
before that.

Regards,
Mauro
