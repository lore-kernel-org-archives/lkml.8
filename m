Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9B3C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABAF21739
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583219625;
	bh=MMe65kbCVcfKfueOAeVuThyQ2JCDq6d+uBHKyNTEgBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ydf0JxB2dVRdmsZAoFRzNrOKuMusdXOOW6Jq65gk2My82u46ljaJUn425ARr9HU8I
	 ciiXwwlgqZcQn3UVJ2CFSOlVWdTmw5QK7GdKKSDO7PhCFeGaOOjOYA0VanowJiGowc
	 hm8GOOYw9uaKBMFrNgP9+O+5E8crATiWciEnUBVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgCCHNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbgCCHNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:13:43 -0500
Received: from onda.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6243B20CC7;
        Tue,  3 Mar 2020 07:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583219622;
        bh=MMe65kbCVcfKfueOAeVuThyQ2JCDq6d+uBHKyNTEgBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ywi1FkjUfaAhMj87r2SnYskJ5HpQuZ5ro1CgFCWCHX863mm0qum+EX670jHusWSWO
         gi/iFuFRB/oZ1cu7nliMe+4qK7aVlcDaUH098cIhEWgmR6eBmKCMqN+Fnrv/tbeALv
         dnENZUQDVo7aAHbGo8Rrd7wqKnZNC+6Q/YJRLKaw=
Date:   Tue, 3 Mar 2020 08:13:38 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 02/12] docs: dt: convert usage-model.txt to ReST
Message-ID: <20200303081338.2534f4a6@onda.lan>
In-Reply-To: <03f37836-2e70-3fb0-4bbe-3a3846992b90@gmail.com>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
        <0432bc8cdb6abb8618eac89d68db7441b613106d.1583135507.git.mchehab+huawei@kernel.org>
        <03f37836-2e70-3fb0-4bbe-3a3846992b90@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 2 Mar 2020 15:11:07 -0600
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
> 
> You caught this in 03/12.  The file has moved to:
> 
>    https://elinux.org/Device_Tree_Usage

Thanks for noticing it!

In order to make the changelogs clearer, instead of modifying this
patch, I'll add an extra hook on patch 03/12 also changing this one. 

> 
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
> And same moved location here.

And this one too.

> 
> -Frank
