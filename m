Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5191C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9866B2076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="G3chA2gC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgCXPTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:19:03 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:32338 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCXPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1585063142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6LOjiTIVe0ip8RBIwrOdFf2Q/ZkDUMV510H16AjP3w0=;
  b=G3chA2gC/xWKjmkKVHqb0ZcMCQlYeSldAY9OwauD7iMiyQLaQS3OicMG
   9kcMF6oD+51pQVddQkeFjuwMAXDyjl3H3aty/hFCdwlWBQ7rcUlUb/rJj
   xiktELrriaQZJZ+lUZfYT0dNUy8tnw73Fyz/WqoxmrZqDEFSelHaTxPLu
   g=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 5QemCl6wBFURva8W8zngtn0vw7DZLMoApUhs2KNokvO6J7wrheWdq0sBNQtQuAVqe/HwcBjg24
 fuoo7Jlj9xunwMlUvnVdgHmnNGMLZ2291cAV0fLzmF6bX8VllYrOE97NcW0Wt/w285qq1X67ls
 C8qtHaqDGmUp6rXBws+UVv0LuzkTT3QQRNVrPcBTcyGKTjMKKWoaoJoBpIZX42B4S69ICO9gyt
 UCvBVaXHNRrsJpypyPIQcSmmZp8JnSz05tzmFCE6spv5QiUdapOlo3Aq4tvHYPvA3v2k0Hrl3t
 z2A=
X-SBRS: 2.7
X-MesageID: 15195379
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,300,1580792400"; 
   d="scan'208";a="15195379"
Date:   Tue, 24 Mar 2020 16:18:55 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
CC:     <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 1/2] xen: expand BALLOON_MEMORY_HOTPLUG description
Message-ID: <20200324151855.GN24458@Air-de-Roger.citrite.net>
References: <20200324150015.50496-1-roger.pau@citrix.com>
 <42a7b408-1ea1-04fa-e70b-cbdaba54c558@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42a7b408-1ea1-04fa-e70b-cbdaba54c558@suse.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:13:48PM +0100, Jürgen Groß wrote:
> On 24.03.20 16:00, Roger Pau Monne wrote:
> > To mention it's also useful for PVH or HVM domains that require
> > mapping foreign memory or grants.
> > 
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: xen-devel@lists.xenproject.org
> > ---
> >   drivers/xen/Kconfig | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > index 61212fc7f0c7..57ddd6f4b729 100644
> > --- a/drivers/xen/Kconfig
> > +++ b/drivers/xen/Kconfig
> > @@ -19,6 +19,10 @@ config XEN_BALLOON_MEMORY_HOTPLUG
> >   	  It is very useful on critical systems which require long
> >   	  run without rebooting.
> > +	  It's also very useful for translated domains (PVH or HVM) to obtain
> 
> I'd rather say "(non PV)" or "(PVH, HVM or Arm)".

I'm fine with any of the variants. Would you mind adjusting when
picking it up or would you like me to resend?

> > +	  unpopulated physical memory ranges to use in order to map foreign
> > +	  memory or grants.
> > +
> >   	  Memory could be hotplugged in following steps:
> >   	    1) target domain: ensure that memory auto online policy is in
> > 
> 
> With that:
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks!
