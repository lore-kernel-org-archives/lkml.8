Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003A9C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32A422273
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgDFNDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:03:20 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:34142 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728237AbgDFNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:03:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1E2261800468C;
        Mon,  6 Apr 2020 13:03:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: uncle16_1c73d53e8c256
X-Filterd-Recvd-Size: 3467
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon,  6 Apr 2020 13:03:15 +0000 (UTC)
Message-ID: <ea5e4d82e78140de6591889430a4ded351b18e89.camel@perches.com>
Subject: Re: [PATCH v2 1/1] lib/vsprintf: Add support for printing V4L2 and
 DRM fourccs
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Date:   Mon, 06 Apr 2020 06:01:17 -0700
In-Reply-To: <CAHp75Vdp+PXaJxrm99DgpJSS+6PcD1FfAfE3U1auFr2oxk5-tA@mail.gmail.com>
References: <20200403091156.7814-1-sakari.ailus@linux.intel.com>
         <1105bfe5-88f1-040e-db40-54d7761747d5@rasmusvillemoes.dk>
         <b1e6213ba9f67da8278dd5c5f5e4def8ab927c83.camel@perches.com>
         <20200403193242.38611906@coco.lan>
         <2751400ae13b25d8259a8a9d7b36caf98ec2d367.camel@perches.com>
         <CAHp75Vf+m_qzOwZb38dObLpKV2N27-J_7beqffhFVoSHaNV2vg@mail.gmail.com>
         <20200406094645.5f96457a@coco.lan>
         <CAHp75Vdp+PXaJxrm99DgpJSS+6PcD1FfAfE3U1auFr2oxk5-tA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-06 at 13:44 +0300, Andy Shevchenko wrote:
> On Mon, Apr 6, 2020 at 10:46 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> > Em Fri, 3 Apr 2020 21:32:42 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> escreveu:
> > > On Fri, Apr 3, 2020 at 8:54 PM Joe Perches <joe@perches.com> wrote:
> > > > On Fri, 2020-04-03 at 19:32 +0200, Mauro Carvalho Chehab wrote:
> > > > > Em Fri, 03 Apr 2020 09:56:42 -0700
> > > > > Joe Perches <joe@perches.com> escreveu:
> > > > It _might_ be useful to use a CONFIG_MEDIA_SUPPORT guard
> > > > in lib/vsprintf for this.
> > > 
> > > No need. FourCC, if Sakari makes it more generic, can be used for
> > > other purposes, e.g. printing component names from the chips (not
> > > related to media at all).
> > > 
> > 
> > Hmm... not 100% sure about what you're meaning with "component names".
> 
> 4cc is pretty much wide standard, media is just one of (famous) users of it.
> 
> As I emphasized the example I referring to has nothing to do with media.
> 
> Now, I have already two examples:
> - component name inside hardware register (used by Synopsys DesignWare)
> - CSRT table in ACPI uses this code for vendor ID.

So if this is really u32_to_ascii, perhaps the "-BE" bit
should be separated and "%4pEp" could be used with some
renamed inline used like ERR_PTR so maybe something like
this might work?

static inline void * __must_check FOURCC(u32 val)
{
	return (void *)(unsigned long)cpu_to_be32(val);
}

void test_4cc(void)
{
	u32 val = 0x41424344;

	printk("4cc like: %4pE\n", FOURCC(val));
}


