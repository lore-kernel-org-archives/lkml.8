Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2C2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00FC2206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgHaTs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 15:48:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:38147 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgHaTs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 15:48:26 -0400
IronPort-SDR: CTFXXTrn4/Yoaz4qTqi8O03+bxnONrLRGn6ANWlHJBZ7NAMEwpvHjT9BRiT0Vw/0oEFxL28pdK
 KuozdB6guxaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="137095962"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="137095962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 12:48:25 -0700
IronPort-SDR: gML8hXmqtfjjuG40dmw03exE7XYZXpDxuL5Um8aFGI0ZxnjaK5qgiAog5/r59mPovT8zPll07b
 ASzOLImW+inQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="338320232"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 31 Aug 2020 12:48:21 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 31 Aug 2020 22:48:20 +0300
Date:   Mon, 31 Aug 2020 22:48:20 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Uma Shankar <uma.shankar@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        intel-gfx@lists.freedesktop.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/lspcon: Limits to 8 bpc for RGB/YCbCr444
Message-ID: <20200831194820.GB6112@intel.com>
References: <20200826052143.17607-1-kai.heng.feng@canonical.com>
 <20200826162458.GP6112@intel.com>
 <6D40F1E0-AFF6-4D38-BB9B-C52B43F83266@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6D40F1E0-AFF6-4D38-BB9B-C52B43F83266@canonical.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 01:04:54PM +0800, Kai Heng Feng wrote:
> Hi Ville,
> 
> > On Aug 27, 2020, at 12:24 AM, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > 
> > On Wed, Aug 26, 2020 at 01:21:15PM +0800, Kai-Heng Feng wrote:
> >> LSPCON only supports 8 bpc for RGB/YCbCr444.
> >> 
> >> Set the correct bpp otherwise it renders blank screen.
> > 
> > Hmm. Does 
> > git://github.com/vsyrjala/linux.git dp_downstream_ports_5
> > work?
> > 
> > Actually better make that dp_downstream_ports_5^^^^^^^^^^^ aka.
> > 54d846ce62a2 ("drm/i915: Do YCbCr 444->420 conversion via DP protocol
> > converters") to avoid the experiments and hacks I have sitting on top.
> 
> Can you please rebase it to mainline master or drm-tip?

git://github.com/vsyrjala/linux.git dp_downstream_ports_6

I threw out the hacks/experimental stuff.

> 
> I am getting errors on the branch:
> 
>   DESCEND  objtool
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   Building modules, stage 2.
>   MODPOST 166 modules
>   LD      arch/x86/boot/compressed/vmlinux
> ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definition of `__force_order'; arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first defined here
> ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-only section `.head.text'
> ld: warning: creating DT_TEXTREL in a PIE
> make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/compressed/vmlinux] Error 1
> make[1]: *** [arch/x86/boot/Makefile:113: arch/x86/boot/compressed/vmlinux] Error 2
> make: *** [arch/x86/Makefile:284: bzImage] Error 2
> make: *** Waiting for unfinished jobs....
> 
> Kai-Heng
> 
> > 
> >> 
> >> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/2195
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/gpu/drm/i915/display/intel_lspcon.c | 3 ++-
> >> 1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
> >> index b781bf469644..c7a44fcaade8 100644
> >> --- a/drivers/gpu/drm/i915/display/intel_lspcon.c
> >> +++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
> >> @@ -196,7 +196,8 @@ void lspcon_ycbcr420_config(struct drm_connector *connector,
> >> 		crtc_state->port_clock /= 2;
> >> 		crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR444;
> >> 		crtc_state->lspcon_downsampling = true;
> >> -	}
> >> +	} else
> >> +		crtc_state->pipe_bpp = 24;
> >> }
> >> 
> >> static bool lspcon_probe(struct intel_lspcon *lspcon)
> >> -- 
> >> 2.17.1
> > 
> > -- 
> > Ville Syrjälä
> > Intel

-- 
Ville Syrjälä
Intel
