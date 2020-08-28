Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE06C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FF82078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgH1L6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:58:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:49036 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbgH1L5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:57:50 -0400
IronPort-SDR: 1dBjlFzOexjYpmJlV7DZee+2rJCEMlk+Rl65FLjP5RaMxfzCj8BcSkud4sn/tgkGoKaD/3GxCN
 PF1WV9p0PDgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="218203527"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="218203527"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 04:57:49 -0700
IronPort-SDR: zbqzJ1v11VIvW5bralVZkEHGh69hEJPSzeh8h951iMTGpgL9Jfq/uzANhJGMbzqQP94TYtpjdN
 mrsaGGmJDEBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="403733952"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 28 Aug 2020 04:57:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 28 Aug 2020 14:57:45 +0300
Date:   Fri, 28 Aug 2020 14:57:45 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb typec: mt6360: Add support for mt6360 Type-C
 driver
Message-ID: <20200828115745.GE174928@kuha.fi.intel.com>
References: <1598527137-6915-1-git-send-email-u0084500@gmail.com>
 <20200827140001.GE813478@kuha.fi.intel.com>
 <CADiBU393V_iQw_8Hx2braL=8QpvQuTY0059C-XkqmjO9W=aBgQ@mail.gmail.com>
 <20200828093835.GC174928@kuha.fi.intel.com>
 <CADiBU3-S025q10WYzLk+v2K-5V+iTP=zDu4i8srTpHQvRkm0UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiBU3-S025q10WYzLk+v2K-5V+iTP=zDu4i8srTpHQvRkm0UQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 06:27:26PM +0800, ChiYuan Huang wrote:
> Heikki Krogerus <heikki.krogerus@linux.intel.com> 於 2020年8月28日 週五 下午5:39寫道：
> >
> > On Thu, Aug 27, 2020 at 10:51:43PM +0800, ChiYuan Huang wrote:
> > > Heikki Krogerus <heikki.krogerus@linux.intel.com> 於 2020年8月27日 週四 下午10:00寫道：
> > > >
> > > > On Thu, Aug 27, 2020 at 07:18:55PM +0800, cy_huang wrote:
> > > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > > >
> > > > > Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
> > > > > It works with Type-C Port Controller Manager to provide USB PD
> > > > > and USB Type-C functionalities.
> > > > >
> > > > > v1 to v2
> > > > > 1. Add fix to Prevent the race condition from interrupt and tcpci port
> > > > > unregister during module remove.
> > > > >
> > > > > v2 to v3
> > > > > 1. Change comment style for the head of source code.
> > > > > 2. No need to print error for platform_get_irq_byname.
> > > > > 3. Fix tcpci_register_port check from IS_ERR_OR_NULL to IS_ERR.
> > > > > 4. Rename driver/Kconfig/Makefile form mt6360 to mt636x.
> > > > > 5. Rename DT binding documents from mt6360 to mt636x.
> > > >
> > > > You don't place additional changelog here...
> > > >
> > > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > > > ---
> > > >
> > > > You put it here, after that '---' marker:
> > > > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
> > > >
> > > HI Hekki:
> > >      after reading the document, I have a little bit confused how to
> > > use diffstat for the changelog.
> > >       Is there any example that make me know to write a clear
> > > description for the changelog?
> >
> > Picking the latest patch from linux-usb ml. with version history:
> > https://lore.kernel.org/linux-usb/1598083553-31896-11-git-send-email-chunfeng.yun@mediatek.com/
> >
> > See how the last tag line "Signed-off-by: Chunfeng Yun..." is followed
> > by marker "---", which then is followed by the version history (the
> > version history is then also ended with the marker "---", a step that
> > I don't think is mandatory, but commonly used and often recommended).
> >
> > That way that patch version history does not contaminate the actual
> > commit message.
> >
> >
> > thanks,
> >
> Ah, I already send the patch v4, I only add the changelog after the
> sign-off --- label, but forget to add --- after changelog ended
> 
> Please let me resend the patch v4 to add --- label after the change log eded.

You do not need to do that. Like I said, it is not mandatory.

thanks,

-- 
heikki
