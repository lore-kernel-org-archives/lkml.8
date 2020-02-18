Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A23C3404B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921FF206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582059458;
	bh=uPhmjrMzElpgjg+mWfS9DJ1xFFC29FeL6qWViNklHrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T4TfbwO5mFi4Zf9xuOVlwGTMglmm5dGrcvw9VRP2TNGBG9gOvEExSbKh1jgC4IZHL
	 BHhDQ3QCBjzxql9Lwxv76w9ozOcaH4Rk5no0WYV4WDnoxTICnYL8CRI3K04oDFpOun
	 4YlbEIUe1sMGMHv+szpSC0UGxNeZ6IK6FwtHSF8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBRU5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:57:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39386 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRU5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:57:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id z2so21562559oih.6;
        Tue, 18 Feb 2020 12:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8v/Yv2bBz+JS6zS39M7KIp7wfnBe7kSHb1JqlCwBB7A=;
        b=izN4sOPI5RTmoYowViMX16iWSXL6V+/fK8GhoXMvNb9RcvY29tzUG7qWhFEm/MK2/E
         X5cQns97EKomPYVnddEpyGAJDB1QbGFWskLJH6W2l5aPCViwUf1UJArHvbXFf1QGi83t
         7yU60G2kD67fbfQMvUDifOoiIeHKgGF+z+5qPuR+pPYCKH5/yL+7XFrJ1LIFrqf9/2Vw
         wW2TqaGZPr4yvQVRKGmIP9icSuePzJE5eLlQq444HWMKqeTVYMT2UCZH50oEDRlAwfdA
         Qdt/lGN+j/zo2nyHW13aAm4u1dMRO22jtYxraisI6XhWv5AI2E5O/e9vVOorMJQa6aSK
         I5Cw==
X-Gm-Message-State: APjAAAVQkMk3MOK7UzKqLgH9nNHUOpzO4FXFR8+CR8cMsqtQ0ooyLAQJ
        ej12xn8xMyzzBhe3iCnh0LVH45k=
X-Google-Smtp-Source: APXvYqwyCWaIWb/EOivdLe4KzOnlqcCXN5vxUwSFdJZrurWk2pYTTDOa2XCxMjJdbIXHWkszEGMnqA==
X-Received: by 2002:a54:4106:: with SMTP id l6mr2449018oic.76.1582059456098;
        Tue, 18 Feb 2020 12:57:36 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d131sm1582039oia.36.2020.02.18.12.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 12:57:35 -0800 (PST)
Received: (nullmailer pid 24025 invoked by uid 1000);
        Tue, 18 Feb 2020 20:57:35 -0000
Date:   Tue, 18 Feb 2020 14:57:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joe Perches <joe@perches.com>, Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: checkpatch - "DT binding docs and includes should be a separate
 patch"
Message-ID: <20200218205735.GA9953@bogus>
References: <20200209081931.GA5321@ravnborg.org>
 <0d0c4ad9e15ce696ad4b470d724fb0d1423f26c0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d0c4ad9e15ce696ad4b470d724fb0d1423f26c0.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2020 at 12:35:26AM -0800, Joe Perches wrote:
> On Sun, 2020-02-09 at 09:19 +0100, Sam Ravnborg wrote:
> > Hi Joe.
> > 
> > The following warnings triggers on the patch below:
> > 
> > c55d0a554843 (HEAD -> drm-misc-next) dt-bindings: panel: Convert orisetech,otm8009a to json-schema
> > -:15: WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
> > #15:
> > deleted file mode 100644
> > 
> > -:18: WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.txt
> > 
> > -:43: WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.txt
> > 
> > total: 0 errors, 3 warnings, 0 checks, 53 lines checked
> > 
> > 1)
> > yaml files include maintainer information in the file.
> > I dunno if this replaces/overrules MAINTAINERS - so first warning may be
> > OK. Also because we delete a file it seems semi relevant.
> > 
> > 2)
> > As the patch only touches files in Documentation/devicetree/bindings the
> > warning about a separate patch seems wrong.
> 
> Rob Herring wrote that bit.  He's now cc'd.  lkml too.

Yeah, I'd noticed this, but haven't dug into how to fix it. Given it 
mainly happens in these schema conversion patches, I haven't been to 
worried about it. Just 3300 more conversions todo and it will be 
"fixed".

> > But the general feedback - in this very special case - is that
> > checkpatch seems a bit too noisy.
> > 
> > If we as a bonus could get a warning when new yaml files do not
> > use:
> > # SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > That would be great.
> 
> Submitted here:
> 
> https://lkml.org/lkml/2020/1/29/292

The bigger review issue is to check the above license is what's used 
(but not on conversions).

Rob
