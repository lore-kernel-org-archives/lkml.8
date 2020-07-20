Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C543C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6824F2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595233160;
	bh=EtZ9AhynlGhfBWyIDxGxkbdjeCY/mrbQUUjyIFA87HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ADWv9GPjenQMuzJsWMhPWJtllQieJfZd0e7c+/UbjBiUAAP5HaqpGMAA0+64zCiyi
	 KzJRYf8ZxC/OUPnB1ZiVvZDSXaQgQ01WxQPdDfD7RUPjHjf+WGKrd7BldvmbjUpD0y
	 PgKky1EDsMb5+IWBDb14purdiKqboU1L5s8EinB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGTITS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgGTITR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:19:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68982080D;
        Mon, 20 Jul 2020 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595233157;
        bh=EtZ9AhynlGhfBWyIDxGxkbdjeCY/mrbQUUjyIFA87HU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YF/LJ8/PYqVCNTC9nEdwYHwGsSUGCAP4XblC812s9WO/qGz1FiiKuS+7eZH/otrQl
         bc6nKiY2dclZvhOBBhCZC1flVILlCb9+wSdcCDGGygq/naFoerYbvwKGSBRJQuaXvF
         qfuQh8WgbOH2boGqzcoGoj1gy0uvs1YAkJIx5KpU=
Date:   Mon, 20 Jul 2020 10:19:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] staging: comedi: INSN_CONFIG_DIGITAL_TRIG fixes
Message-ID: <20200720081927.GA688558@kroah.com>
References: <20200717145257.112660-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717145257.112660-1-abbotti@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 03:52:53PM +0100, Ian Abbott wrote:
> These patches correct problems with INSN_CONFIG_DIGITAL_TRIG comedi
> configuration instructions in various comedi drivers, in particular the
> use of unconstrained bit shift amounts from userspace leading to
> undefined behaviour (although hopefully not the kernel crashy sort).
> 
> The patches have been marked for inclusion in the stable tree.  Note
> that patch 4 changes a similar area of code to Dan Carpenter's commit
> ef75e14a6c93 ("staging: comedi: verify array index is correct before
> using it"), so I have indicated it as a prerequisite.
> 
> *Note to Greg KH*: I have based these patches on your "staging-linus"
> branch due to the prerequisite ef75e14a6c93 mentioned above being
> present in neither "staging-next" nor "staging-testing" at the time of
> posting.

Thanks for the note, all now queued up to the proper branch.

greg k-h
