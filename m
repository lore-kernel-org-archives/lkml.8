Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD425C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CA320760
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594030979;
	bh=hyubO64upSNhqMywGjKfEDtfPQCLU+NfTnStguiiInQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vYNLwoY0aNMfHzYwZrJsSY7+wHJHkxPJ9Pa1hZynTiEGCvSLQ4mgg82K1Fb7QvBA+
	 08nDq/yXFTsbxSa8FwrdyCx8rBoQsciCumT9K4zDzn0VhRrrrfdUb4f1n8s2se2XI3
	 biSK9nyLQNlJbm9T2cqRrW4MWsjrIqHzyZFD6gR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgGFKW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbgGFKW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:22:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3834720739;
        Mon,  6 Jul 2020 10:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594030977;
        bh=hyubO64upSNhqMywGjKfEDtfPQCLU+NfTnStguiiInQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4G5rNnJWpkPLV7AlSxzZjB4OL/dkUxu4G2J3uDie1OFt2hgg4W+EoO2DFQTwNTP2
         44OhXBEGR0OXw7WB4966lqDNIa3Il4jASWf2p4v/3GYBEv50TfM06jQgqUNNEZ/zYO
         ucyO/bNVvwYYAQpaQdrBfkr9cYGkIFT3bGPnJRpE=
Date:   Mon, 6 Jul 2020 12:22:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     NeilBrown <neilb@suse.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200706102254.GA10206@kroah.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAFhKne_ZVWVhZX5hNEbeGBfU6BMRN9JKQeTsVYOcMmEH1cd3xg@mail.gmail.com>
 <87h7ul15le.fsf@notabene.neil.brown.name>
 <20200706072221.GA1947246@kroah.com>
 <CAMuHMdWj2d5GF1ZkuhzQxg9teA51zjF0oQQPWcphzK=kJ6-x9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWj2d5GF1ZkuhzQxg9teA51zjF0oQQPWcphzK=kJ6-x9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:53:55AM +0200, Geert Uytterhoeven wrote:
> On Mon, Jul 6, 2020 at 9:22 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > look at the USB spec for an example of these terms being used in this
> > way for many decades.
> 
> And when does the "gadget" enter the show? ;-)

It doesn't, as the USB spec does not describe that in any reasonable way
for us to use when dealing with drivers for both "types" of devices.  So
we came up with the word "gadget" on purpose to be able to talk about
those things in a specific manner.

thanks,

greg k-h
