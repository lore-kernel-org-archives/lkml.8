Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F217EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28E620786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgGKSQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 14:16:37 -0400
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:45692 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728507AbgGKSQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 14:16:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id EFC91180A7FFC;
        Sat, 11 Jul 2020 18:16:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pear57_100d03026ed9
X-Filterd-Recvd-Size: 3417
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Jul 2020 18:16:34 +0000 (UTC)
Message-ID: <04ce5199522b4136909fa4926282b7da8abddc4a.camel@perches.com>
Subject: Re: [PATCH 0/4] drm: core: Convert logging to drm_* functions.
From:   Joe Perches <joe@perches.com>
To:     Suraj Upadhyay <usuraj35@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Sat, 11 Jul 2020 11:16:33 -0700
In-Reply-To: <20200711151126.GA12262@blackclown>
References: <cover.1594136880.git.usuraj35@gmail.com>
         <20200710175643.GF17565@ravnborg.org> <20200711151126.GA12262@blackclown>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-07-11 at 20:41 +0530, Suraj Upadhyay wrote:
> On Fri, Jul 10, 2020 at 07:56:43PM +0200, Sam Ravnborg wrote:
> > Hi Suraj.
> > 
> > On Tue, Jul 07, 2020 at 10:04:14PM +0530, Suraj Upadhyay wrote:
> > > This patchset converts logging to drm_* functions in drm core.
> > > 
> > > The following functions have been converted to their respective
> > > DRM alternatives :
> > > dev_info()      --> drm_info()
> > > dev_err()       --> drm_err()
> > > dev_warn()      --> drm_warn()
> > > dev_err_once()  --> drm_err_once().
> > 
> > I would prefer that DRM_* logging in the same files are converted in the
> > same patch. So we have one logging conversion patch for each file you
> > touches and that we do not need to re-vist the files later to change
> > another set of logging functions.
> 
> Agreed.
> 
> > If possible WARN_* should also be converted to drm_WARN_*
> > If patch is too large, then split them up but again lets have all
> > logging updated when we touch a file.
> > 
> > Care to take a look at this approach?
> > 
> 
> Hii,
> 	The problem with WARN_* macros is that they are used without any
> drm device context. For example [this use here](https://cgit.freedesktop.org/drm/drm-misc/tree/drivers/gpu/drm/drm_edid.c#n1667) in drm_edid.c,
> doesn't have a drm device context and only has one argument (namely !raw_edid).
> There are many more such use cases.
> 
> And also there were cases where dev_* logging functions didn't have any
> drm_device context.

Perhaps change the __drm_printk macro to not
dereference the drm argument when NULL.

A trivial but perhaps inefficient way might be
used like:

	drm_<level>(NULL, fmt, ...)

---
 include/drm/drm_print.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 1c9417430d08..9323a8f46b3c 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -395,8 +395,8 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
 /* Helper for struct drm_device based logging. */
 #define __drm_printk(drm, level, type, fmt, ...)			\
-	dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
-
+	dev_##level##type((drm) ? (drm)->dev : NULL, "[drm] " fmt,	\
+			  ##__VA_ARGS__)
 
 #define drm_info(drm, fmt, ...)					\
 	__drm_printk((drm), info,, fmt, ##__VA_ARGS__)




