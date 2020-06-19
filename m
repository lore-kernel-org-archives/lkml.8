Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAC9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0B420890
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592555657;
	bh=wKBHEpDsQikjcIxt+ZRpjMu/NuHWUnr40ZxYE8BFme4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xJYxS1U+ZNVtX5bmVU4JQUQ9fSPM8UHfJYD+zwsTk+iG7tTjLOtE2WLsxDdu3kKgU
	 aFhFLnOvhWLwWOU1LXVxOcDb8xAiBQ3nXpg99sqTNXoTJguHLemV/ksbkMrD/zO39+
	 dK9ayLWEiAzFQrJrvON6n7hWh4Jy84SenLj45pI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgFSIeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731168AbgFSIeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:34:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EFF920776;
        Fri, 19 Jun 2020 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592555652;
        bh=wKBHEpDsQikjcIxt+ZRpjMu/NuHWUnr40ZxYE8BFme4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AjKKSvrZpIamBHuZPYXFmDeeJ46yte1TAe/soLGpP+Ae7Bi1P9t9T4iWYJA01AUNy
         9/HeueXK+xwWsT2iGjEWyHVW6CwWxAJKlxTADoTd5x2yudjNGEg+m5O8OjiUVChmbn
         x7le3EJgMe6bM4iKvkf9GfyxnZ6E8BUOFnw/wKgI=
Date:   Fri, 19 Jun 2020 10:34:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     jim.cromie@gmail.com, Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and
 filtering on flags
Message-ID: <20200619083409.GB473790@kroah.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
 <20200617162536.611386-23-jim.cromie@gmail.com>
 <20200618161912.GD3617@alley>
 <20200618174058.GE3617@alley>
 <746984fb-00ee-9079-efac-50167f3c3e40@akamai.com>
 <CAJfuBxwLKDSx6RA_ZOk=eEHw0P3FeAcT=PCr-aHjUFKDS2p8cQ@mail.gmail.com>
 <20200619074555.GF3617@alley>
 <20200619081024.GG3617@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619081024.GG3617@alley>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:10:24AM +0200, Petr Mladek wrote:
> On Fri 2020-06-19 09:45:55, Petr Mladek wrote:
> > On Thu 2020-06-18 13:11:05, jim.cromie@gmail.com wrote:
> > > On Thu, Jun 18, 2020 at 12:17 PM Jason Baron <jbaron@akamai.com> wrote:
> > > > Yes, I'm wondering as well if people are really going to use the
> > > > new flags and filter flags - I mentioned that here:
> > > > https://lkml.org/lkml/2020/6/12/732
> > > 
> > > yes, I saw, and replied there.
> > 
> > No, the repply only explains how the interface might be used. There is
> > no prove that people would actually use it.
> > 
> > > but since that was v1, and we're on v3, we should refresh.
> > > 
> > > the central use-case is above, 1-liner version summarized here:
> > > 
> > > 1- enable sites as you chase a problem with +up
> > > 2- examine them with grep =pu
> > > 3- change the set to suit, either by adding or subtracting callsites.
> > > 4- continue debugging, and changing callsites to suit
> > > 5- grep =pu control > ~/debugging-session-task1-callsites
> > > 6- echo up-p >control   # disable for now, leave u-set for later
> > > 7- do other stuff
> > > 8 echo uP+p >control # reactivate useful debug-state and resume
> > 
> > In short, this feature allows repeatedly enable/disable some
> > slowly growing maze of debug messages. Who need this, please? !!!
> > 
> > If I am debugging then I add/remove debug messages. But I never
> > enable/disable all of them repeatedly.
> 
> Not to say that I usually need to reboot when I reproduce the problem
> and before I could try it again. So all dyndbg flags gets lost
> between two tests anyway.

I agree, this feels way too complex for no good reason.  Users only need
a specific set of "run this command to enable messages and send us the
logs" instructions.  Nothing complex like this at all.

thanks,

greg k-h
