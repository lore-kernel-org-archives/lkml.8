Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B05C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BC12173E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595156671;
	bh=rUyPqN7o8n11Cuq/SsXI7IA/ehdlS6u9JPo8pQ6obYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dveKg72Gq6n7kwJqWwTRvsiozHvafOEQP2udBkg2w35U0c8GCiTMaUzwDppcbxwGw
	 9ubPc2ETaRZ3hOiNF2xfPp7zuq45sJcrA7GK6ZSUXwPIUUC93KJXuxl+51KJuaA0Cf
	 k6t9EziFCT/7HzHlpAQDWejL242OI4swY3hpiu44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgGSLE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 07:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgGSLE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 07:04:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D291C207DF;
        Sun, 19 Jul 2020 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595156668;
        bh=rUyPqN7o8n11Cuq/SsXI7IA/ehdlS6u9JPo8pQ6obYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zsX/3lfsy1Ub36Jau67UPnKyl3DBRtw/vDoLXbFs+/bIzT3vcaVvCxsyEs3k8/JC6
         YQKw9FHPotTJoQdwx70r+lXlJoXnZziDrI498/XX9IfDGfpNM8NqsE4BlthPREqGZd
         mjpgNrLOCCnUXjkNTHstbrZKuSo0sI8uYz38FBjM=
Date:   Sun, 19 Jul 2020 13:04:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH 2/4] staging: rtl8188eu: include: fixed multiple
 parentheses coding style issues
Message-ID: <20200719110439.GA266150@kroah.com>
References: <20200718091626.uflhdcgkmhqij5b7@pesu-pes-edu>
 <20200719092652.GA257887@kroah.com>
 <CAAhDqq1LNQ=UfCaNojZ+wf2+njQ+7jD8Yvr1AG1TSrcByfMo+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhDqq1LNQ=UfCaNojZ+wf2+njQ+7jD8Yvr1AG1TSrcByfMo+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 05:35:04AM -0400, B K Karthik wrote:
> On Sun, Jul 19, 2020 at 5:26 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Jul 18, 2020 at 05:16:26AM -0400, B K Karthik wrote:
> > > fixed multiple parentheses coding style issues reported by checkpatch.
> > >
> > > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> > > ---
> > >  drivers/staging/rtl8188eu/include/ieee80211.h |  4 +--
> > >  .../staging/rtl8188eu/include/osdep_service.h |  4 +--
> > >  drivers/staging/rtl8188eu/include/wifi.h      | 34 +++++++++----------
> > >  3 files changed, 21 insertions(+), 21 deletions(-)
> >
> > You can never add warnings to the build, like this patch did.  Always
> > test-build your patches at the very least...
> 
> understood, I will definitely do that.
> but these warnings are (mostly) [-Wunused-value] and [-Wformat].
> that should not have (?) occurred due to the usage of parentheses.

They are not there _before_ your patch, and only show up _after_ your
patch, so perhaps your patch is wrong?  :)

thanks,

greg k-h
