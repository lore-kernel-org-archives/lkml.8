Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B323DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9A3206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056837;
	bh=/+bX9sUSuviQfDod9nEL4+0Dlkf7WVqWQHv9g42s2A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iZ+3J3ZsmPvjdK0kJqULZRdVbzZ4nQO8bAGffyCpN8BiZYoIkT+5k1YCLHX9nfnKz
	 zlR1PGRrpeU24LIVlnGJ22JHAebeFWdYlvmjU+XO6SkP49UQvz64J9FgAlb6L044I8
	 IhVTtUWPlNccxeO7szGqF9vzxwo2SRW+Ub+Xc8CY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgCXNd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbgCXNdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:33:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A81620775;
        Tue, 24 Mar 2020 13:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056834;
        bh=/+bX9sUSuviQfDod9nEL4+0Dlkf7WVqWQHv9g42s2A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vEAReR4wr7IhLnUm9SUF5+gLVTzns5yVBIbD5yCs/7qrSJIdH/sPUNdmlmlyxq+OF
         D+1Dz09M06satQQP6ybfku16IoKhCovu34kbyaKtz+NQDGOaoaHZFVfQDX7AO9AL6f
         oBeJtfMvTV4M0erPhKz0a+snRUgUfAKr9sXexijw=
Date:   Tue, 24 Mar 2020 14:33:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] nvmem: Add support for write-only instances
Message-ID: <20200324133352.GA2503959@kroah.com>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
 <20200323150007.7487-6-srinivas.kandagatla@linaro.org>
 <20200323190505.GB632476@kroah.com>
 <4820047d-9a99-749c-491d-dbb91a2f5447@linaro.org>
 <20200324122939.GA2348009@kroah.com>
 <300e8095-3af4-15a2-069f-87ac7cbb83bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <300e8095-3af4-15a2-069f-87ac7cbb83bb@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 01:25:46PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 24/03/2020 12:29, Greg KH wrote:
> > > But the Idea here is :
> > > We ended up with providing different options like read-only,root-only to
> > > nvmem providers combined with read/write callbacks.
> > > With that, there are some cases which are totally invalid, existing code
> > > does very minimal check to ensure that before populating with correct
> > > attributes to sysfs file. One of such case is with thunderbolt provider
> > > which supports only write callback.
> > > 
> > > With this new checks in place these flags and callbacks are correctly
> > > validated, would result in correct file attributes.
> > Why this crazy set of different groups?  You can set the mode of a sysfs
> > file in the callback for when the file is about to be created, that's so
> > much simpler and is what it is for.  This feels really hacky and almost
> > impossible to follow:(
> Thanks for the inputs, That definitely sounds much simpler to deal with.
> 
> Am guessing you are referring to is_bin_visible callback?

Yes.

