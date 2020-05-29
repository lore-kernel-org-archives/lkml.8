Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C25C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE622075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgE2Inz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:43:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:55262 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2Iny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:43:54 -0400
IronPort-SDR: 4KEJRaU1gvY6R5LDBjf85J91M/15MmKzZC9SC/w6dcc80HjpELVXsS3xoMLm/TXVG/ZGO7CWnq
 XGI7KJtvmwMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 01:43:45 -0700
IronPort-SDR: t7ZaEPSmD2wb8Bht+VsXhBeIShu3zYq8vv8aNGADdkQk1f0JTS6aL8ahV2UPCVLZYwMvpKlEvy
 lkyrxhb245Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="257283009"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga008.fm.intel.com with SMTP; 29 May 2020 01:43:42 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 29 May 2020 11:43:41 +0300
Date:   Fri, 29 May 2020 11:43:41 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     chenxb_99091@126.com
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Re:[PATCH] drm: fix setting of plane_mask in
 pan_display_atomic() function for linux-4.4
Message-ID: <20200529084341.GI6112@intel.com>
References: <1590586407-4109-1-git-send-email-chenxb_99091@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1590586407-4109-1-git-send-email-chenxb_99091@126.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:33:27PM +0800, chenxb_99091@126.com wrote:
> From: Xuebing Chen <chenxb_99091@126.com>
> 
> On Mon, May 25, 2020 at 04:34:28PM +0200, Daniel Vetter wrote:
> > On Sat, May 23, 2020 at 11:49:07AM +0800, chenxb_99091@126.com wrote:
> > > From: Xuebing Chen <chenxb_99091@126.com>
> > > 
> > > The <include/drm/drm_crtc.h> provides drm_for_each_plane_mask macro and
> > > plane_mask is defined as bitmask of plane indices, such as
> > > 1<<drm_plane_index(plane). This patch fixes error setting of plane_mask
> > > in pan_display_atomic() function.
> > > 
> > > Signed-off-by: Xuebing Chen <chenxb_99091@126.com>
> > 
> > What kernel is this patch against? Latest upstream doesn't have any such
> > code anymore ... I'm assuming that Ville fixed this in one of his patches,
> > but I can't find the right one just now.
> 
> This bug is still present in the longterm-supported versions of kernel 4.4.y, 
> including the latest kernel v4.4.224,
> See https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/?h=v4.4.224

See Documentation/process/stable-kernel-rules.rst on how to request
a stable backport.

-- 
Ville Syrjälä
Intel
