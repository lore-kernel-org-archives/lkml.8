Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE42FC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913BC24679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579010681;
	bh=iHlBoiWEHE0iPobcdkgXVSMdB0Pebv923SbPBtm3Xd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DplxlWgYOkybuJAi1cuPoKX7MDS7aUmdZWjM+/kBDvEZAasyX4KArOtKBx7td8WgR
	 ZiFPmTokfhHx2KRA/XYK8tvldNBKOdiR2kQNW6OFyLXDmjbeHcR6CrbYK7G8y2IFlo
	 XmP6aCq/jOVzXDDcf1PejURYs7Mu74nVcestnou8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgANOEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:04:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgANOEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:04:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EFDA2072B;
        Tue, 14 Jan 2020 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579010679;
        bh=iHlBoiWEHE0iPobcdkgXVSMdB0Pebv923SbPBtm3Xd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iraABIIRoDS5FdyCTm8XZeR5OLF62WF0i4b42/I5NAqXGgnk1g8RFM2e2qdXhQS4F
         u+kEJ49NznsuP1I5e8wcjUGBGM11xmXS3df3/Fhy2+r51DrNudiEr6HU11YNpTgnUp
         FVoOw+Xsns6zoZIShj1UkbmX5zfsLpq/lqu187IQ=
Date:   Tue, 14 Jan 2020 15:04:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, alexander.antonov@intel.com
Subject: Re: [PATCH v3 1/2] perf x86: Infrastructure for exposing an Uncore
 unit to PMON mapping
Message-ID: <20200114140436.GA1707494@kroah.com>
References: <20200113135444.12027-1-roman.sudarikov@linux.intel.com>
 <20200113135444.12027-2-roman.sudarikov@linux.intel.com>
 <20200113143430.GA390411@kroah.com>
 <9bfcc058-8fde-9b24-3d82-255004e7f057@linux.intel.com>
 <20200114133958.GE170376@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114133958.GE170376@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 02:39:58PM +0100, Jiri Olsa wrote:
> On Tue, Jan 14, 2020 at 04:24:34PM +0300, Sudarikov, Roman wrote:
> 
> SNIP
> 
> > > >   {
> > > >   	struct intel_uncore_pmu *pmus;
> > > > @@ -950,10 +976,19 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
> > > >   			attr_group->attrs[j] = &type->event_descs[j].attr.attr;
> > > >   		type->events_group = &attr_group->group;
> > > > -	}
> > > > +	} else
> > > > +		type->events_group = &empty_group;
> > > Why???
> > Hi Greg,
> > 
> > Technically, what I'm trying to do is to add an attribute which depends on
> > the uncore pmu type and BIOS support. New attribute is added to the end of
> > the attribute groups array. It appears that the events attribute group is
> > optional for most of the uncore pmus for x86/intel, i.e. events_group =
> > NULL.
> > 
> > NULL element in the middle of the attribute groups array "hides" all others
> > attribute groups which follows that element.
> > 
> > To work around it, embedded NULL elements should be either removed from
> > the attribute groups array [1] or replaced with empty attribute; see
> > implementation above.
> > 
> > If both approaches are incorrect then please advice what would be correct
> > solution for that case.
> 
> hi,
> I think Greg is reffering to the recent cleanup where we used attribute
> groups with is_vissible callbacks, you can check changes below:
> 
> b7c9b3927337 perf/x86/intel: Use ->is_visible callback for default group
> 6a9f4efe78af perf/x86: Use update attribute groups for default attributes
> b657688069a2 perf/x86/intel: Use update attributes for skylake format
> 3ea40ac77261 perf/x86: Use update attribute groups for extra format
> 1f157286829c perf/x86: Use update attribute groups for caps
> baa0c83363c7 perf/x86: Use the new pmu::update_attrs attribute group

Yes, that is the case.

Don't abuse things like trying to stick NULL elements in the middle of
an attribute group, that's horrid.  Use the apis that we have build
especially for this type of thing, that is what it is there for and will
keep things _MUCH_ simpler over time.

thanks,

greg k-h
