Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BE3C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0B6207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBTMBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:01:18 -0500
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:55220 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727772AbgBTMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:01:17 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 83219181D3039;
        Thu, 20 Feb 2020 12:01:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: low15_af1a30c2f956
X-Filterd-Recvd-Size: 1554
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 20 Feb 2020 12:01:15 +0000 (UTC)
Message-ID: <0d8dd389a5061f7e178d4e974001236ec33290e5.camel@perches.com>
Subject: Re: drm_dp_mst_topology.c and old compilers
From:   Joe Perches <joe@perches.com>
To:     paulmck@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 20 Feb 2020 03:59:51 -0800
In-Reply-To: <20200220004232.GA28048@paulmck-ThinkPad-P72>
References: <20200220004232.GA28048@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-19 at 16:42 -0800, Paul E. McKenney wrote:
> Hello!
> 
> A box with GCC 4.8.3 compiler didn't like drm_dp_mst_topology.c.  The
> following (lightly tested) patch makes it happy and seems OK for newer
> compilers as well.
> 
> Is this of interest?
[]
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
[]
> @@ -5396,7 +5396,7 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
>  {
>  	struct drm_dp_mst_port *immediate_upstream_port;
>  	struct drm_dp_mst_port *fec_port;
> -	struct drm_dp_desc desc = { 0 };
> +	struct drm_dp_desc desc = {{{ 0 }}};

Perhaps this is simpler as:

	struct drm_dp_desc desc = {};


