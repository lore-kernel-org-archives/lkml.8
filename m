Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA226C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9602206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgFHTLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:11:03 -0400
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:37176 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbgFHTLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:11:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B0712187D2615;
        Mon,  8 Jun 2020 19:11:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boot46_231759b26dbc
X-Filterd-Recvd-Size: 6430
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon,  8 Jun 2020 19:10:58 +0000 (UTC)
Message-ID: <ed5c0b84693231ae0197e35765488a53c524f32f.camel@perches.com>
Subject: Re: [PATCH] drm/amd/display: Fix indenting in
 dcn30_set_output_transfer_func()
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Mon, 08 Jun 2020 12:10:57 -0700
In-Reply-To: <20200608174943.GU22511@kadam>
References: <20200608141657.GB1912173@mwanda>
         <dcce7f702c674999c31fd358c3970d5fee1a6725.camel@perches.com>
         <20200608174943.GU22511@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-08 at 20:49 +0300, Dan Carpenter wrote:
> On Mon, Jun 08, 2020 at 10:16:27AM -0700, Joe Perches wrote:
> > On Mon, 2020-06-08 at 17:16 +0300, Dan Carpenter wrote:
> > > These lines are a part of the if statement and they are supposed to
> > > be indented one more tab.
> > > 
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> > > index ab20320ebc994..37c310dbb3665 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> > > @@ -203,9 +203,9 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
> > >  					stream->out_transfer_func,
> > >  					&mpc->blender_params, false))
> > >  				params = &mpc->blender_params;
> > > -		 /* there are no ROM LUTs in OUTGAM */
> > > -		if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
> > > -			BREAK_TO_DEBUGGER();
> > > +			 /* there are no ROM LUTs in OUTGAM */
> > > +			if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
> > > +				BREAK_TO_DEBUGGER();
> > >  		}
> > >  	}
> > >  
> > 
> > Maybe the if is at the right indentation but the
> > close brace below the if is misplaced instead?
> > 
> 
> Yeah.  I considered that, but the code is correct, it's just the
> indenting is wrong.  I normally leave drm/amd/ code alone but this
> indenting was so confusing that I though it was worth fixing.

This file seems to heavily use function pointers,
multiple dereferences
with visually similar identifiers,
and it generally makes my eyes hurt
reading the code.

> There are lots of ugly stuff which is not confusing like this:  (The
> line numbers are from next-20200605).

Ick.  Don't give me line numbers.  Now I might have to look...

drivers/gpu/drm/amd/amdgpu/../powerplay/amd_powerplay.c:1530 pp_asic_reset_mode_2() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3387 bw_calcs() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dwb.c:104 dwb2_enable() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp_cm.c:450 dpp20_get_blndgam_current() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp_cm.c:543 dpp20_get_shaper_current() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_mpc.c:306 mpc20_get_ogam_current() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1519 dc_link_dp_perform_link_training() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:3137 core_link_enable_stream() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:207 dcn30_set_output_transfer_func() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dpp.c:650 dpp3_get_blndgam_current() warn: inconsistent indenting

OK, so I picked this one at random.

It looks like someone avoided using intentional programming
along with copy/paste combined with being lazy.

It seems as if AMD should use more code reviewers and
perhaps some automated code reformatters before submitting
their code.

This code is:

static enum dc_lut_mode dpp3_get_blndgam_current(struct dpp *dpp_base)
{
	enum dc_lut_mode mode;
	uint32_t mode_current = 0;
	uint32_t in_use = 0;

	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);

	REG_GET(CM_BLNDGAM_CONTROL,
			CM_BLNDGAM_MODE_CURRENT, &mode_current);
	REG_GET(CM_BLNDGAM_CONTROL,
			CM_BLNDGAM_SELECT_CURRENT, &in_use);

		switch (mode_current) {
		case 0:
		case 1:
			mode = LUT_BYPASS;
			break;

		case 2:
			if (in_use == 0)
				mode = LUT_RAM_A;
			else
				mode = LUT_RAM_B;
			break;
		default:
			mode = LUT_BYPASS;
			break;
		}
		return mode;
}

Generic style defects:

o unnecessary initializations
o uint32_t where u32 is simpler
o doesn't fill to 80 columns where reasonable
o magic numbers
o duplicated switch/case blocks
o unnecessary code:
  in_use is only used by case 2
  dpp doesn't seem used at all, but it is via a hidden CTX
  in the REG_GET macro

drivers/gpu/drm/amd/display/dc/inc/reg_helper.h:#define REG_GET(reg_name, field, val)   \
drivers/gpu/drm/amd/display/dc/inc/reg_helper.h-                generic_reg_get(CTX, REG(reg_name), \
drivers/gpu/drm/amd/display/dc/inc/reg_helper.h-                                FN(reg_name, field), val)

And no, I'm not going to look at the entire list...

But something like this could be simpler:

{
	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
	u32 mode_current;
	u32 in_use;

	REG_GET(CM_BLNDGAM_CONTROL, CM_BLNDGAM_MODE_CURRENT, &mode_current);
	if (mode_current != 2)
		return LUT_BYPASS;

	REG_GET(CM_BLNDGAM_CONTROL, CM_BLNDGAM_SELECT_CURRENT, &in_use);
	return !in_use ? LUT_RAM_A : LUT_RAM_B;
}


