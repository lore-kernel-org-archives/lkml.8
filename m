Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC58C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4530A20CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583220360;
	bh=JxpPQT87nGKVa5+tlOfbk4aq2l+X21pKlEqMcbKdh5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yiHPPvLPTQXpc8eQJRiR5ioXAzFPBFz3G487BJnfCxUdEQYtUnJx/TcxkUz2uqgdZ
	 2Tmd0v2IRxPa+/JUznkAvd1G8lm5u16/TpSyrM072kceLqsigxyLYYdvHGjqXFEvOP
	 gQ0ZLoi1yqjwYemkK0JvVsgVRsn9jFOqi+9egi8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgCCHZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:25:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgCCHZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:25:59 -0500
Received: from onda.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 245F620CC7;
        Tue,  3 Mar 2020 07:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583220357;
        bh=JxpPQT87nGKVa5+tlOfbk4aq2l+X21pKlEqMcbKdh5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qRHf+C6p1okj+l9swFCoe2AM65STx5uPFUna7a1tTSZpJFU7/pSBulE6f43pZNaFK
         5QG11n0kbpvZENHgp5/cyilLFBV4PrZByj4/bnd7JpDOb96c5uY7OQH188rk0djnW4
         Hhar5HIn2Xo67SVaOXb/B/TsRyCLWsPKILTZArm4=
Date:   Tue, 3 Mar 2020 08:25:53 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 02/12] docs: dt: convert usage-model.txt to ReST
Message-ID: <20200303082553.6698b29c@onda.lan>
In-Reply-To: <33664e07-c3e4-12fa-9cbe-a3225bb6f343@gmail.com>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
        <0432bc8cdb6abb8618eac89d68db7441b613106d.1583135507.git.mchehab+huawei@kernel.org>
        <33664e07-c3e4-12fa-9cbe-a3225bb6f343@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 2 Mar 2020 15:18:51 -0600
Frank Rowand <frowand.list@gmail.com> escreveu:

> On 3/2/20 1:59 AM, Mauro Carvalho Chehab wrote:
> > - Add a SPDX header;
> > - Adjust document title;
> > - Use footnoote markups;
> > - Some whitespace fixes and new line breaks;
> > - Mark literal blocks as such;
> > - Add it to devicetree/index.rst.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/devicetree/index.rst            |  1 +
> >  Documentation/devicetree/of_unittest.txt      |  2 +-
> >  .../{usage-model.txt => usage-model.rst}      | 35 +++++++++++--------
> >  include/linux/mfd/core.h                      |  2 +-
> >  4 files changed, 23 insertions(+), 17 deletions(-)
> >  rename Documentation/devicetree/{usage-model.txt => usage-model.rst} (97%)
> > 
> > diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
> > index a11efe26f205..7a6aad7d384a 100644
> > --- a/Documentation/devicetree/index.rst
> > +++ b/Documentation/devicetree/index.rst
> > @@ -7,4 +7,5 @@ Open Firmware and Device Tree
> >  .. toctree::
> >     :maxdepth: 1
> >  
> > +   usage-model
> >     writing-schema
> > diff --git a/Documentation/devicetree/of_unittest.txt b/Documentation/devicetree/of_unittest.txt
> > index 3e4e7d48ae93..9fdd2de9b770 100644
> > --- a/Documentation/devicetree/of_unittest.txt
> > +++ b/Documentation/devicetree/of_unittest.txt
> > @@ -11,7 +11,7 @@ architecture.
> >  
> >  It is recommended to read the following documents before moving ahead.
> >  
> > -[1] Documentation/devicetree/usage-model.txt
> > +[1] Documentation/devicetree/usage-model.rst
> >  [2] http://www.devicetree.org/Device_Tree_Usage
> >  
> >  OF Selftest has been designed to test the interface (include/linux/of.h)
> > diff --git a/Documentation/devicetree/usage-model.txt b/Documentation/devicetree/usage-model.rst
> > similarity index 97%
> > rename from Documentation/devicetree/usage-model.txt
> > rename to Documentation/devicetree/usage-model.rst
> > index 33a8aaac02a8..326d7af10c5b 100644
> > --- a/Documentation/devicetree/usage-model.txt
> > +++ b/Documentation/devicetree/usage-model.rst
> > @@ -1,14 +1,18 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=========================
> >  Linux and the Device Tree
> > --------------------------
> > +=========================
> > +
> >  The Linux usage model for device tree data
> >  
> > -Author: Grant Likely <grant.likely@secretlab.ca>
> > +:Author: Grant Likely <grant.likely@secretlab.ca>
> >  
> >  This article describes how Linux uses the device tree.  An overview of
> >  the device tree data format can be found on the device tree usage page
> > -at devicetree.org[1].
> > +at devicetree.org\ [1]_.
> >  
> > -[1] http://devicetree.org/Device_Tree_Usage
> > +.. [1] http://devicetree.org/Device_Tree_Usage  
> 
> I don't know the proper ReST syntax for footnotes, but on the html page
> you kindly provided in 00/12, '.. [1]' is shown as '1(1,2)'.
> 
> -Frank

The syntax is simple: just add an  underline at the end, when referencing
it, like [1]_. The definitions should start with "..", like ".. [1] something".

Sphinx will automatically generate the reverse reference(s) at the html output.

Yet, sometimes (like the above), it needs to be escaped by a "\ ", as ReST would
recognize "foo[1]_" as something else.

Ps.: it also accepts an "auto-numbered" references like [#]_, but such syntax
require some care, in order to avoid wrong cross-references.

Regards,
Mauro
