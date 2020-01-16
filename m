Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71DAC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C4A20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="cH5daPaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgAPPFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:05:31 -0500
Received: from www413.your-server.de ([88.198.28.140]:59790 "EHLO
        www413.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberus-technology.de; s=default1911; h=Content-Transfer-Encoding:
        MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZexOn4FEQsloo7emu6e0E5yv/ua4j8MP3CCsOZRUTrA=; b=cH5daPaIgIih/Pf96nB99OLLk
        He2uzFd9DbAroxYeSqMNge2LxXZrOBo0v9OmLE1S1Lx6nZDqfcfSUgRRsALGbAG6E0i3u9JEOoLeO
        nW8ahzkp0DymxyHCyrb8Lpgu8dDWPvaZBgthAi6iJ6k3RMozor0uQuZVcP18d1Kpdi3rjJr9/D93w
        YCYKZS4ffZBVmP4qGFJjIvCR2lV95riAy6Ynqt3L9SGKqmK97KlJbSORWmZeIQ7ZkC0OnfYRwsphz
        I5+MAvoMGMdH7r3DNTwUd2/voreF9TX9qKfWfK7oGJ64qA47BDI8Gy3Lhadp1enI/h8niGUyqBCSq
        tYsAw7+fQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www413.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1is6i5-0002D5-DF; Thu, 16 Jan 2020 16:05:25 +0100
Received: from [2a02:8106:231:700:38db:ba68:aa3a:bbaa] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1is6i5-000K38-4Y; Thu, 16 Jan 2020 16:05:25 +0100
Message-ID: <edb721906354e26c26883edf5bce09690ca07d6d.camel@cyberus-technology.de>
Subject: Re: [RFC PATCH 4/4] drm/i915/gvt: move public gvt headers out into
 global include
From:   Julian Stecklina <julian.stecklina@cyberus-technology.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhiyuan.lv@intel.com, hang.yuan@intel.com,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Thomas Prescher <thomas.prescher@cyberus-technology.de>
Date:   Thu, 16 Jan 2020 16:05:22 +0100
In-Reply-To: <20200116142345.GA476889@kroah.com>
References: <4079ce7c26a2d2a3c7e0828ed1ea6008d6e2c805.camel@cyberus-technology.de>
         <20200109171357.115936-1-julian.stecklina@cyberus-technology.de>
         <20200109171357.115936-5-julian.stecklina@cyberus-technology.de>
         <20200115152215.GA3830321@kroah.com>
         <9b32e225ee680e61716e300eb1ed8387599cc0dd.camel@cyberus-technology.de>
         <20200116142345.GA476889@kroah.com>
Organization: Cyberus Technology GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: julian.stecklina@cyberus-technology.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25697/Thu Jan 16 12:42:45 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, 2020-01-16 at 15:23 +0100, Greg KH wrote:
> On Thu, Jan 16, 2020 at 03:13:01PM +0100, Julian Stecklina wrote:
> > Hi Greg, Christoph,
> > 
> > On Wed, 2020-01-15 at 16:22 +0100, Greg KH wrote:
> > > On Thu, Jan 09, 2020 at 07:13:57PM +0200, Julian Stecklina wrote:
> > > > Now that the GVT interface to hypervisors does not depend on i915/GVT
> > > > internals anymore, we can move the headers to the global include/.
> > > > 
> > > > This makes out-of-tree modules for hypervisor integration possible.
> > > 
> > > What kind of out-of-tree modules do you need/want for this?
> > 
> > The mediated virtualization support in the i915 driver needs a backend to
> > the
> > hypervisor. There is currently one backend for KVM in the tree
> > (drivers/gpu/drm/i915/gvt/kvmgt.c) and at least 3 other hypervisor backends
> > out
> > of tree in various states of development that I know of. We are currently
> > developing one of these.
> 
> Great, then just submit this patch series as part of your patch series
> when submitting yoru hypervisor code.  That's the normal way to export
> new symbols, we can't do so without an in-kernel user.

Fair enough.

As I already said, the KVMGT code is the in-kernel user. But I guess I can
extend the already existing function pointer way of decoupling KVMGT from i915
and be on my way without exporting any symbols.

Somewhat independent of the current discussion, I also think that it's valuable
to have a defined API (I'm not saying stable API) for the hypervisor backends to
define what's okay and not okay for them to do.

Thanks,
Julian

