Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F257C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A7D206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593689737;
	bh=CFFtu5Zlg5EFXmXoeTvkwooaWY9hE66618FDsF/kWXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zay7qTnISxxIIy5ZAD0Q00nN4pKe7SmmyyUM5AUzUd1H10jao5EpzBTPjpX+oiUlo
	 3AhbkVgpPGtlllyNLJhqHOjlVS5IMFwl2N4B0M9vsBbJ8uopkEraDOd5yesx9RFlbV
	 1+RocFB3RS4XsVNB6GnY1F9acVLhFd5N9CAFdefQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgGBLfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgGBLff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:35:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1E9F206B7;
        Thu,  2 Jul 2020 11:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593689735;
        bh=CFFtu5Zlg5EFXmXoeTvkwooaWY9hE66618FDsF/kWXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSq/FY5SIqUvVno02FqayWliD567dmauxr1jRDOslGiUMp3o62fapMLJt7kQeJP2p
         7FBXIVQvieTNMlO7U0EkjssH0CyImn0fHBGBvztBV80YozDJZLvzkZp1mSsUoEFHtQ
         TqUHqd2UgtszHwLWKx9C4MIjT4wa9t64C0ZBnRuo=
Date:   Thu, 2 Jul 2020 13:35:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] .gitignore: Do not track `defconfig` from `make
 savedefconfig`
Message-ID: <20200702113538.GA1667088@kroah.com>
References: <20200702111200.39997-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200702111200.39997-1-pmenzel@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:12:00PM +0200, Paul Menzel wrote:
> Running `make savedefconfig` creates by default `defconfig`, which is,
> currently, on git’s radar, for example, `git status` lists this file as
> untracked.
> 
> So, add the file to `.gitignore`, so it’s ignored by git.
> 
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
