Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD27C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625642076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="D3mk1+tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgCXPQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:16:37 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:37888 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgCXPQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1585062995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RseeQCj2NR8Swtya70snFlU0fchG/HJCbgy6RmMHvWY=;
  b=D3mk1+ttRkRGz9gxKjc8OBS0BgFgsWB+bkUbNdgkhxRRAiX903nAxFoG
   yYIqg9WUiwCMxZhCtL5/mShfLEhm6gMvJlSshtLGW1PGAYgxiTUtK3lGY
   UKt3uZjy8uFPVcTSbaVWNe1fOzyJeiaYRNv70GaIxj3CpJhQtQlwHzIQd
   I=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: GoWcsj6Go6zh231OquFT09PHhau9utSPaHE2uxd1+btY+8jwzhWMlGKU9W7XlNkIJUJ6JuFvxp
 Dngq1bmuboh97C3KVBpPpQj73soJYHVctl5f5ejvCNs1SYSX5Dw3dtGbq4AJCf5Ql8GO7DrBS4
 6jK0jLV11NAokk5rql/vH0LxZrvX8x7OJXdFHw2xzsU9WZc2T02wXbCHM/Ur6teoN10wW6TrK2
 /i/hnQvUMat51SyZwHUryhv8cFBMPPnIhjhBwV8DhaHr5mBHQ4JQZtdcWq8uDKTIrOJNDvtAtE
 aic=
X-SBRS: 2.7
X-MesageID: 14880194
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,300,1580792400"; 
   d="scan'208";a="14880194"
Date:   Tue, 24 Mar 2020 16:16:28 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
CC:     <linux-kernel@vger.kernel.org>,
        Ian Jackson <ian.jackson@eu.citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 2/2] xen: enable BALLOON_MEMORY_HOTPLUG by default
Message-ID: <20200324151628.GM24458@Air-de-Roger.citrite.net>
References: <20200324150015.50496-1-roger.pau@citrix.com>
 <20200324150015.50496-2-roger.pau@citrix.com>
 <f4ce1d95-c80a-8727-7ddc-9199bb2036c4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4ce1d95-c80a-8727-7ddc-9199bb2036c4@suse.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:09:35PM +0100, Jürgen Groß wrote:
> On 24.03.20 16:00, Roger Pau Monne wrote:
> > Without it a PVH dom0 is mostly useless, as it would balloon down huge
> > amounts of RAM in order get physical address space to map foreign
> > memory and grants, ultimately leading to an out of memory situation.
> > 
> > Such option is also needed for HVM or PVH driver domains, since they
> > also require mapping grants into physical memory regions.
> > 
> > Suggested-by: Ian Jackson <ian.jackson@eu.citrix.com>
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: xen-devel@lists.xenproject.org
> > ---
> >   drivers/xen/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > index 57ddd6f4b729..c344bcffd89d 100644
> > --- a/drivers/xen/Kconfig
> > +++ b/drivers/xen/Kconfig
> > @@ -13,6 +13,7 @@ config XEN_BALLOON
> >   config XEN_BALLOON_MEMORY_HOTPLUG
> >   	bool "Memory hotplug support for Xen balloon driver"
> >   	depends on XEN_BALLOON && MEMORY_HOTPLUG
> > +	default y
> >   	help
> >   	  Memory hotplug support for Xen balloon driver allows expanding memory
> >   	  available for the system above limit declared at system startup.
> > 
> 
> Another variant would be to set: default XEN_BACKEND
> 
> This would match the reasoning for switching it on.

I would rather have it always on if possible, as gntdev or privcmd
(when used to map foreign pages from user-space) will also require it,
and they are not gated on XEN_BACKEND AFAICT.

> Either way would be fine with me, so you can add
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks!

Roger.
