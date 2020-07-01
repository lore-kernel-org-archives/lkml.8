Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E154FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0300206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593571681;
	bh=WTGi74V/M6JRB3BLDWs0zeSTaQWxQakpQtHy05f1GGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=q/+yNYIlpehMqVwCNSE8jLJ6mWExXHpZGLb8fNw222+8RovLIGj7dX7MnEc59b7DT
	 m+n8JJze4JHj1olhCETuImsEfBA9RRN/UAwrvp/knHFEXEeIz59I+PS96mhQrqM3lu
	 4HbPhDxOZj4+EXhkAUDF6yWkUlReMFXalvSyNu7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgGACsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgGACr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:47:59 -0400
Received: from X1 (071-093-078-081.res.spectrum.com [71.93.78.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C58206EB;
        Wed,  1 Jul 2020 02:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593571678;
        bh=WTGi74V/M6JRB3BLDWs0zeSTaQWxQakpQtHy05f1GGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mUY4V98q0IugIwaSjIBz0UE5DT7Y59IxduswVw5uo7NzpDfjNo8GRdV8kvAjjGnyO
         x5HTMhgZAaqfXE8borCroalaROYxeqO2w/SSgJvvqfiCG5M1TyV0+fKDmIKsNVfi/Z
         arubItYYt+8QyyeRmClKXcCdrjIOYglPFyJuWc70=
Date:   Tue, 30 Jun 2020 19:47:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ben.widawsky@intel.com, alex.shi@linux.alibaba.com,
        dwagner@suse.de, tobin@kernel.org, cl@linux.com, stable@kernel.org
Subject: Re: [PATCH] mm/vmscan: restore zone_reclaim_mode ABI
Message-Id: <20200630194755.61f56a55d46222f8d0c84bdd@linux-foundation.org>
In-Reply-To: <791c47ad-5a6b-1f1b-c34b-d8bbf7722957@intel.com>
References: <20200626003459.D8E015CA@viggo.jf.intel.com>
        <20200629065203.GJ3346@MiWiFi-R3L-srv>
        <3ba94f19-3b18-9d52-a070-f652620c88e6@intel.com>
        <20200629233043.GK3346@MiWiFi-R3L-srv>
        <791c47ad-5a6b-1f1b-c34b-d8bbf7722957@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 16:37:37 -0700 Dave Hansen <dave.hansen@intel.com> wrote:

> On 6/29/20 4:30 PM, Baoquan He wrote:
> >> The only way I can plausibly think of "cleaning up" the RECLAIM_ZONE bit
> >> would be to raise our confidence that it is truly unused.  That takes
> >> time, and probably a warning if we see it being set.  If we don't run
> >> into anybody setting it or depending on it being set in a few years, we
> >> can remove it.
> > So adding the old bit back for compatibility looks good, thanks.
> > 
> > Then we have to be very careful when adding and reviewing new
> > interface introducing, should not leave one which might be used
> > in the future.
> > 
> > In fact, RECLAIM_ZONE is not completely useless. At least, when the old
> > bit 0 is set, it may enter into node_reclaim() in get_page_from_freelist(),
> > that makes it like a switch.
> > 
> > get_page_from_freelist {
> > 
> > 	...
> >                         if (node_reclaim_mode == 0 ||                                                                                             
> >                             !zone_allows_reclaim(ac->preferred_zoneref->zone, zone))
> >                                 continue;
> > 	...
> > }
> 
> Oh, that's a very good point.  There are a couple of those around.  Let
> me circle back and update the documentation and the variable name.  I'll
> send out another version.

Was the omission of cc:stable deliberate?

