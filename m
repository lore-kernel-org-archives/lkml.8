Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECBEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 818DC20781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="PUtHyuV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHMKCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:02:35 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:2786 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMKCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1597312953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kkFMyNBbOdtaKP3s0IKVuqUHyo7Vk4EymQC6D+Rwakc=;
  b=PUtHyuV+1nFCJVxLFo0saWWoqxCPE6AHBTl6JUr6fRLbJXRwswEl3yVs
   v8rDA+0QtH+53JiY72lkWmHtgcR/oxS0Re3xWe/8+zfkblGw3tuegmndO
   VrcIX3/TmVxH44dqUX2jIFF+dHoHR2Q4N4nOOJy8WfmUYy1a3LSCZ+58O
   M=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: wDtbUOGkC+v+QIiO9GW5InSj95+N5bZvHh0cz2sCfx8x8/0y/wKXIBeFTsdWA5IVAl9fHYeLN9
 bkgatnmpc6dbgREHUynY40qpDjj/p707iFysIZlm+vriXLDuiKG2hWjEZM5lJMCBJKbBHnmRzT
 Ek4wVev1cfJou5ZUSJS2/wZJUJSBFN8IxZXcndS/Kdi0ZOoHWEwqy1VaqoDA1I5FfmKdrqia00
 lv846+KFNsoIoemtWsa3un39WI8J3cPm1e5CBVfxjR5zuJsQM3Dozc/9+9CouCiP2ZBQIjfCnw
 Sa8=
X-SBRS: 2.7
X-MesageID: 24601489
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,307,1592884800"; 
   d="scan'208";a="24601489"
Date:   Thu, 13 Aug 2020 12:02:26 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Christoph Hellwig <hch@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>, Wei Liu <wl@xen.org>,
        Yan Yankovskyi <yyankovskyi@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <xen-devel@lists.xenproject.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 2/2] xen: add helpers to allocate unpopulated memory
Message-ID: <20200813100226.GG975@Air-de-Roger>
References: <20200811094447.31208-1-roger.pau@citrix.com>
 <20200811094447.31208-3-roger.pau@citrix.com>
 <20200813073337.GA16160@infradead.org>
 <20200813075420.GC975@Air-de-Roger>
 <20200813094946.GJ2352366@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200813094946.GJ2352366@phenom.ffwll.local>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your email client seems to set 'Reply-to:' to point to everyone on the
'Cc:' field, but not yourself, which is kind of weird. I've manually
fixed it on this reply by moving everyone to the 'Cc:' field and
setting you on 'To:'.

On Thu, Aug 13, 2020 at 11:49:46AM +0200, Daniel Vetter wrote:
> On Thu, Aug 13, 2020 at 09:54:20AM +0200, Roger Pau Monné wrote:
> > On Thu, Aug 13, 2020 at 08:33:37AM +0100, Christoph Hellwig wrote:
> > > On Tue, Aug 11, 2020 at 11:44:47AM +0200, Roger Pau Monne wrote:
> > > > If enabled (because ZONE_DEVICE is supported) the usage of the new
> > > > functionality untangles Xen balloon and RAM hotplug from the usage of
> > > > unpopulated physical memory ranges to map foreign pages, which is the
> > > > correct thing to do in order to avoid mappings of foreign pages depend
> > > > on memory hotplug.
> > > 
> > > So please just select ZONE_DEVICE if this is so much better rather
> > > than maintaining two variants.
> > 
> > We still need to other variant for Arm at least, so both need to be
> > maintained anyway, even if we force ZONE_DEVICE on x86.
> 
> Why does arm not have ZONE_DEVICE?

It's not that Arm doesn't have ZONE_DEVICE, it's just that the
approach used here won't work correctly on an Arm Xen dom0 as-is.

This is due to the usage of an identity second stage translation in
order to workaround the lack of an IOMMU in some Arm boards.

It can be made to work on Arm, but will likely require someone from
the Arm side doing that.

Roger.
