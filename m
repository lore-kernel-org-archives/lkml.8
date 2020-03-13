Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2BCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FDC206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="jmVephLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCMMBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:01:13 -0400
Received: from one.firstfloor.org ([193.170.194.197]:40168 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCMMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:01:12 -0400
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Mar 2020 08:01:12 EDT
Received: by one.firstfloor.org (Postfix, from userid 503)
        id AB0A08684B; Fri, 13 Mar 2020 12:51:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1584100262;
        bh=n7ebr8CIADsM9tj3H3JRlE7EP41LvIJXYOqe5sj5lqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmVephLyA1jYljk7iIclfJA1dr9azRpru+nJgTyJckKMaG8CBSSnfRdV/yjUxcdQz
         6bFxkMnPz2ufG+StfF9dEqD7RCgkx2j06wqVbIVd12U65FIXqpRRtRggV2V6PByZVx
         4r0N/WpnBlArZuov1h66MTDtZmvJBCY3mbu8W/58=
Date:   Fri, 13 Mar 2020 04:51:02 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86: Add trace points to (nearly) all vectors
Message-ID: <20200313115100.3gdbfxkplrbe6wvy@two.firstfloor.org>
References: <20200312231916.132753-1-andi@firstfloor.org>
 <742AF79F-BAE4-4E6C-944D-10C3E6F66CD0@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <742AF79F-BAE4-4E6C-944D-10C3E6F66CD0@amacapital.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 04:39:04PM -0700, Andy Lutomirski wrote:
> 
> > On Mar 12, 2020, at 4:19 PM, Andi Kleen <andi@firstfloor.org> wrote:
> > 
> > ﻿From: Andi Kleen <ak@linux.intel.com>
> > 
> > In some scenarios it can be useful to count or trace every kernel
> > entry.
> 
> Can you elaborate?  What problem does this solve?

So that we know how often or where kernel entries happen,
how long every kernel execution is, and also can do an accurate break
down.

> 
> > Most entry paths are covered by trace points already,
> > but some of the more obscure entry points do not have
> > trace points.
> > 
> > The most common uncovered one was KVM async page fault.
> 
> NAK.  This path is going away. 

Okay. Can you provide details? When will it go away?

Anyways KVM async is just one case, my patch covers lots of other cases
too. Even if KVM async goes away it still makes sense
for the other entry points and can be easily rebased (just drop
that hunk)

-Andi

