Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4488C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3361207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2TuXafH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405275AbgE1RAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:00:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60733 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405254AbgE1RAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590685216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0AbgdM89I1fch23T6oXHrlkE5eBQV/JX1tB7m1TZRI=;
        b=d2TuXafHBgTRGeBpvmUyU/pI9KJSX7ejwOSWDQm/7TRVU81kEGnK5yFtDz28IAKr+5HQlE
        DdxaHiD59VaOsPBb8S7+O+tXYadNbNZgUodTeqY19CUAKeS0w0figjVeNwv5lsEgVD9S1g
        hl2PihAU0ClbEIKPqbIsnW4kg3aKMA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-ey1vtCkwMGKYtdV7WbWLtA-1; Thu, 28 May 2020 13:00:14 -0400
X-MC-Unique: ey1vtCkwMGKYtdV7WbWLtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A55B835B40;
        Thu, 28 May 2020 17:00:13 +0000 (UTC)
Received: from treble (ovpn-117-65.rdu2.redhat.com [10.10.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B689610013DB;
        Thu, 28 May 2020 17:00:12 +0000 (UTC)
Date:   Thu, 28 May 2020 12:00:10 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 2/3] objtool: Find relocation base section using
 sh_info
Message-ID: <20200528170010.xe46x3tvz4npvovj@treble>
References: <cover.1590597288.git.mhelsley@vmware.com>
 <d848189dac6c41193a6c55c3588b78114bbcb0f8.1590597288.git.mhelsley@vmware.com>
 <20200528140916.6crguzfpehf6lext@treble>
 <20200528160247.GW9040@rlwimi.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528160247.GW9040@rlwimi.vmware.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:02:47AM -0700, Matt Helsley wrote:
> On Thu, May 28, 2020 at 09:09:16AM -0500, Josh Poimboeuf wrote:
> > On Wed, May 27, 2020 at 09:42:32AM -0700, Matt Helsley wrote:
> > > Currently objtool uses a naming heuristic to find the "base"
> > > section to apply the relocation(s) to. The standard defines
> > > the SHF_INFO_LINK flag (SHF => in the section header flags)
> > > which indicates when the section header's sh_info field can
> > > be used to find the necessary section.
> > > 
> > > Warns when the heuristic is used as a fallback and changes
> > > the name heuristic calculation to handle rela (explicit
> > > addend) and now rel (implicit addend) relocations.
> > 
> > Does this fallback case actually happen?
> 
> Not that I could see. I was thinking about taking it out but
> I haven't tried this set with clang or other toolchains. So
> I was wondering if you think holding off before removing it
> would be wise or if you'd rather just remove it.

I just realized somebody already submitted an almost identical patch:

  https://lkml.kernel.org/r/20200421182501.149101-1-samitolvanen@google.com

Which I'll be merging soon... so you can just drop this one.

Then you can base your next version of this set on top of that patch, if
it hasn't been merged yet.

-- 
Josh

