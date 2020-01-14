Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE57C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406ED206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlLo+h70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgANNkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:40:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59879 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbgANNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579009213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/OUNp+8eiwyelLTvZ+VWbwPArDWt2E+tZJCkFYGzyI=;
        b=DlLo+h70F5LbBFuSDSw9pI7MViebRH/hppymEwhLChpQqhDM3b2GjYqtSFKuvyye3fT5cZ
        PCY6HKnc+JGTt8Arydqhp0bC2Svmf49uKqn3LNr1me0iVyqCIxOmO3GrqRjphHQ6B5tiqn
        0pLBw5zFvvcFHlM7CpQ4nj9mgJbN9S4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-PEUzUONqOYWMl4g-bG-mTA-1; Tue, 14 Jan 2020 08:40:08 -0500
X-MC-Unique: PEUzUONqOYWMl4g-bG-mTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71285A0689;
        Tue, 14 Jan 2020 13:40:06 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2991C5DA70;
        Tue, 14 Jan 2020 13:40:00 +0000 (UTC)
Date:   Tue, 14 Jan 2020 14:39:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v3 1/2] perf x86: Infrastructure for exposing an Uncore
 unit to PMON mapping
Message-ID: <20200114133958.GE170376@krava>
References: <20200113135444.12027-1-roman.sudarikov@linux.intel.com>
 <20200113135444.12027-2-roman.sudarikov@linux.intel.com>
 <20200113143430.GA390411@kroah.com>
 <9bfcc058-8fde-9b24-3d82-255004e7f057@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bfcc058-8fde-9b24-3d82-255004e7f057@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 04:24:34PM +0300, Sudarikov, Roman wrote:

SNIP

> > >   {
> > >   	struct intel_uncore_pmu *pmus;
> > > @@ -950,10 +976,19 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
> > >   			attr_group->attrs[j] = &type->event_descs[j].attr.attr;
> > >   		type->events_group = &attr_group->group;
> > > -	}
> > > +	} else
> > > +		type->events_group = &empty_group;
> > Why???
> Hi Greg,
> 
> Technically, what I'm trying to do is to add an attribute which depends on
> the uncore pmu type and BIOS support. New attribute is added to the end of
> the attribute groups array. It appears that the events attribute group is
> optional for most of the uncore pmus for x86/intel, i.e. events_group =
> NULL.
> 
> NULL element in the middle of the attribute groups array "hides" all others
> attribute groups which follows that element.
> 
> To work around it, embedded NULL elements should be either removed from
> the attribute groups array [1] or replaced with empty attribute; see
> implementation above.
> 
> If both approaches are incorrect then please advice what would be correct
> solution for that case.

hi,
I think Greg is reffering to the recent cleanup where we used attribute
groups with is_vissible callbacks, you can check changes below:

b7c9b3927337 perf/x86/intel: Use ->is_visible callback for default group
6a9f4efe78af perf/x86: Use update attribute groups for default attributes
b657688069a2 perf/x86/intel: Use update attributes for skylake format
3ea40ac77261 perf/x86: Use update attribute groups for extra format
1f157286829c perf/x86: Use update attribute groups for caps
baa0c83363c7 perf/x86: Use the new pmu::update_attrs attribute group

jirka

> 
> [1] https://lore.kernel.org/lkml/20191210091451.6054-3-roman.sudarikov@linux.intel.com/
> 
> Thanks,
> Roman
> > Didn't we fix up the x86 attributes to work properly and not mess around
> > with trying to merge groups and the like?  Please don't perpetuate that
> > more...
> > 
> > thanks,
> > 
> > greg k-h
> 
> 

