Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C52CC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2781E20714
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgCRQpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:45:43 -0400
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:50386 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726780AbgCRQpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:45:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id AE11318028500;
        Wed, 18 Mar 2020 16:45:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boys55_88d5603ee8550
X-Filterd-Recvd-Size: 2457
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Mar 2020 16:45:39 +0000 (UTC)
Message-ID: <1c01f0bae24856e4139c551ca07b9581424aa995.camel@perches.com>
Subject: Re: [PATCH 1/3] drm: drm_vm: Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 09:43:49 -0700
In-Reply-To: <20200318134909.GW2363188@phenom.ffwll.local>
References: <cover.1584040050.git.joe@perches.com>
         <398db73cdc8a584fd7f34f5013c04df13ba90f64.1584040050.git.joe@perches.com>
         <20200317164806.GO2363188@phenom.ffwll.local>
         <623eb1bc61951ed3c68a9224b9aa99a25e763913.camel@perches.com>
         <20200318134909.GW2363188@phenom.ffwll.local>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-18 at 14:49 +0100, Daniel Vetter wrote:
> On Tue, Mar 17, 2020 at 03:13:29PM -0700, Joe Perches wrote:
> > On Tue, 2020-03-17 at 17:48 +0100, Daniel Vetter wrote:
> > > On Thu, Mar 12, 2020 at 12:17:12PM -0700, Joe Perches wrote:
> > > > Convert /* fallthrough */ style comments to fallthrough;
> > > > 
> > > > Convert the various uses of fallthrough comments to fallthrough;
> > > > 
> > > > Done via script
> > > > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/
> > > > 
> > > > And by hand:
> > > > 
> > > > This file has a fallthrough comment outside of an #ifdef block
> > > > that causes gcc to emit a warning if converted in-place.
> > > > 
> > > > So move the new fallthrough; inside the containing #ifdef/#endif too.
[]
> > > I'm assuming this all lands through a special pull? Or should I apply
> > > this?
[]
> > I think you should apply this.
> > 
> > The idea here is to allow a scripted conversion at some
> > point and this patch is necessary to avoid new compiler
> > warnings after running the script.
> 
> Ok, put into the queue but missed the 5.7 feature freeze for drm so 5.8
> probably.

Thanks, no worries.
Any scripted conversion like this isn't a high priority.


