Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7B8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07597205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgHXPql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:46:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:54490 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgHXPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:46:33 -0400
IronPort-SDR: wzWOcaVaAOoJkM4BHPp4A/WFfMBqAVBahyEEq57b47V7F3plUW6oHwrv7RweijURoyLU4KQLSt
 92ar8YSvHcTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="173967474"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="173967474"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 08:46:33 -0700
IronPort-SDR: i7xHs3m94j+1i3c9HXOILdk4W9Z9gJTr27gBBejZQ8KOIcu6cMQhKqui/tQzcYc+PagzTKe9ht
 Q57pUhHYNWEw==
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="443257291"
Received: from ideak-desk.fi.intel.com ([10.237.68.141])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 08:46:29 -0700
Date:   Mon, 24 Aug 2020 18:46:26 +0300
From:   Imre Deak <imre.deak@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Sean Paul <sean@poorly.run>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [RFC 13/20] drm/i915/dp: Extract drm_dp_downstream_read_info()
Message-ID: <20200824154626.GA19658@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20200811200457.134743-1-lyude@redhat.com>
 <20200811200457.134743-14-lyude@redhat.com>
 <20200819151547.GB46474@art_vandelay>
 <4d74a74aefcd8d0ea048b70252efda18820bc911.camel@redhat.com>
 <20200820223754.GA17451@ideak-desk.fi.intel.com>
 <597b83ace909f97bfefbe15ffbb0370c2101ff0f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <597b83ace909f97bfefbe15ffbb0370c2101ff0f.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 01:43:39PM -0400, Lyude Paul wrote:
> [...] 
> > The wording is a bit unclear, but as I understand the Standard only
> > calls for the above:
> > 
> > """
> > A DP upstream device shall read the capability from DPCD Addresses 00080h
> > through 00083h. A DP Branch device with multiple DFPs shall report the
> > detailed
> > capability information of the lowest DFP number to which a downstream device
> > is connected, consistent with the DisplayID or legacy EDID access routing
> > policy
> > of an SST-only DP Branch device as described in Section 2.1.4.1.
> > """
> 
> So-I saw this too, but notice the use of the language "A /DP Branch/ device with
> multiple DFPs shall report the detailed…". This makes me think it's implying
> that this is a requirement for MSTBs and not SST sinks, just a guess.

Not sure either. The above could also refer to an SST branch device with
multiple DFPs (for instance a DP Replicator branch device).

--Imre
