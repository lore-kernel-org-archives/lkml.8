Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286D0C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067CE2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgBXLl3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:41:29 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:63650 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727281AbgBXLl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:41:28 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20330508-1500050 
        for multiple; Mon, 24 Feb 2020 11:40:40 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Emmanuel Vadot <manu@FreeBSD.org>,
        Jani Nikula <jani.nikula@intel.com>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        efremov@linux.com, kraxel@redhat.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        noralf@tronnes.org, sam@ravnborg.org, tzimmermann@suse.de
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <877e0n66qi.fsf@intel.com>
Cc:     Emmanuel Vadot <manu@FreeBSD.Org>,
        Emmanuel Vadot <manu@FreeBSD.org>
References: <20200215180911.18299-1-manu@FreeBSD.org>
 <20200215180911.18299-2-manu@FreeBSD.org> <877e0n66qi.fsf@intel.com>
Message-ID: <158254443806.15220.5582277260130009235@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v2 1/2] drm/client: Dual licence the file in GPL-2 and MIT
Date:   Mon, 24 Feb 2020 11:40:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jani Nikula (2020-02-15 18:33:09)
> On Sat, 15 Feb 2020, Emmanuel Vadot <manu@FreeBSD.org> wrote:
> > From: Emmanuel Vadot <manu@FreeBSD.Org>
> >
> > Contributors for this file are :
> > Chris Wilson <chris@chris-wilson.co.uk>
> > Denis Efremov <efremov@linux.com>
> > Jani Nikula <jani.nikula@intel.com>
> > Maxime Ripard <mripard@kernel.org>
> > Noralf Trønnes <noralf@tronnes.org>
> > Sam Ravnborg <sam@ravnborg.org>
> > Thomas Zimmermann <tzimmermann@suse.de>
> >
> > Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
> 
> I've only converted some logging.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>

Bonus ack from another Intel employee to cover all Intel copyright in
this file,
Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
