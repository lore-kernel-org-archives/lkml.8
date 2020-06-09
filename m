Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470B7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BF120884
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591741551;
	bh=ZiGAAxqcuhhxs9PvbPCqFEGjRFXCgrcwJReQFO7XA/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=posmpuPVi13iqUP+yENgoeNzqguAuUt1FYpn+n8EkqxltyWy8FAOVPmltlgtuxee+
	 2goBftu1n33Gr+s4VcSTTyd+0dR7tXnR0+6PdhUVIcaOd8aMGRae2VEkrS2VO77zjA
	 0g9iGymnCbUPclOdOxrDGmfxYX5HsSsxvLW6fg/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgFIWZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbgFIWZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:25:48 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A942076A;
        Tue,  9 Jun 2020 22:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591741548;
        bh=ZiGAAxqcuhhxs9PvbPCqFEGjRFXCgrcwJReQFO7XA/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSnJYXuAPyspiryhmezalX+GIx2SO/+uaN8GXwI1F2HabMRxXr0kjFyK6SOXCtjK9
         wUUslCpX28JCbXSpwFWhWHKxElpHpvfGN0jX723t5Us5YaPPi7d1O05X8dNh0za+bg
         bL6MZVZY/YwT6XSFVsshHn3CYHyZ3dHYOaMH9Ayk=
Date:   Tue, 9 Jun 2020 15:25:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] f2fs: use kfree() instead of kvfree() to free
 superblock data
Message-ID: <20200609222546.GA24766@sol.localdomain>
References: <20200605181533.73113-1-efremov@linux.com>
 <20200609221446.24537-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609221446.24537-1-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:14:46AM +0300, Denis Efremov wrote:
> Use kfree() instead of kvfree() to free super in read_raw_super_block()
> because the memory is allocated with kzalloc() in the function.
> Use kfree() instead of kvfree() to free sbi, raw_super in
> f2fs_fill_super() and f2fs_put_super() because the memory is allocated
> with kzalloc().
> 
> Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
> Signed-off-by: Denis Efremov <efremov@linux.com>

I don't think "Fixes" is appropriate here.

kvfree() still works on kmalloc'ed memory; it's just not preferred.

So this is more a cleanup than a fix.

- Eric
