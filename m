Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248A4C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE4F217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgATUVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:21:35 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:46646 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATUVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 15:21:34 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B005720028;
        Mon, 20 Jan 2020 21:21:30 +0100 (CET)
Date:   Mon, 20 Jan 2020 21:21:29 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm: fix parameters documentation style
Message-ID: <20200120202129.GB17555@ravnborg.org>
References: <20200114160135.14990-1-benjamin.gaignard@st.com>
 <20200118094156.GB12245@ravnborg.org>
 <372573cc-b0ae-72cb-f2c3-3f9310c3cf27@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <372573cc-b0ae-72cb-f2c3-3f9310c3cf27@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=8b9GpE9nAAAA:8
        a=lKaM5KJSvNEHRUbUXN8A:9 a=wPNLvfGTeEIA:10 a=T3LWEMljR5ZiDmsYVIUa:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin.

On Mon, Jan 20, 2020 at 08:11:01AM +0000, Benjamin GAIGNARD wrote:
> 
> On 1/18/20 10:41 AM, Sam Ravnborg wrote:
> > Hi Benjamin
> >
> > On Tue, Jan 14, 2020 at 05:01:35PM +0100, Benjamin Gaignard wrote:
> >> Remove old documentation style and use new one to avoid warnings when
> >> compiling with W=1
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > Thanks for the warning fixes.
> > This is legacy stuff that is not even wired into the kernel-doc stuff.
> > But that is no excuse for old-style comments.
> 
> There is still quite a few of them in other drm files (drm_context.c,  
> drm_bufs.c, drm_vm.c, drm_lock.c)
> 
> but I don't know how to fix them. Your advices are welcome.

I have no strong opinion on way forward here.
But if someone (you?) type the patches and they are even acked,
we should not ignore them.

	Sam
