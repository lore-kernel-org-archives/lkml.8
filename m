Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D085CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D64D20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583850791;
	bh=MXHfn2QUOH61lBXKxaYHDJYxCIjyhOdb6HyxFRWTGHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Km/9O7gOvKi2TuqR4CtFnpGQ3qo3ox5cZZ2q+J2QtrleyLvaP3PFwgBDmEpYM/1Nq
	 47BmQv3tI2G17x78CCZP5oUi2vgHm+MdFvbUjV1vUNfBs3yaDBKJI026uPGtFme66n
	 ASQLdCj0S8mbR2bxC6Gu33mZ0iWD74F5LpHfT6Hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCJOdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgCJOdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:33:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8322D20637;
        Tue, 10 Mar 2020 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583850790;
        bh=MXHfn2QUOH61lBXKxaYHDJYxCIjyhOdb6HyxFRWTGHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sv976ddJj+D4EKiccE4MIvMeH/8PciewJAueIWmub+kXBTAbApd/SKczRznBv9xW4
         Qe9KSDY0ZFPQkdMcuDE2gT4E267HZAKsxkI4oeaJxBM/L9atCVvUXPtfhv2trBtBTI
         c0ILy/4GEwc9DUgjPbi69ZfxTBHxRwGtEbKh3Tyk=
Date:   Tue, 10 Mar 2020 15:33:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/17] drm: subsytem-wide debugfs functions refactor
Message-ID: <20200310143307.GA3376131@kroah.com>
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310133121.27913-1-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 04:31:04PM +0300, Wambui Karuga wrote:
> This series includes work on various debugfs functions both in drm/core
> and across various drivers in the subsystem.
> Since commit 987d65d01356 (drm: debugfs: make drm_debugfs_create_files()
> never fail), drm_debugfs_create_files() does not fail and only returns
> zero. This series therefore removes the left over error handling and
> checks for its return value across drm drivers.
> 
> As a result of these changes, most drm_debugfs functions are converted
> to return void in this series. This also enables the
> drm_driver, debugfs_init() hook to be changed to return void. 
> 
> v2: individual driver patches have been converted to have debugfs
> functions return 0 instead of void to prevent breaking individual driver
> builds.
> The last patch then converts the .debugfs_hook() and its users across
> all drivers to return void.

This looks much better to me, nice job:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
