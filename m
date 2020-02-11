Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190C5C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5E92086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581449224;
	bh=d9iTIU7z0h/UAxXemQIRG88N34pgT887tmSXs635Ibg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0PRLYkrAGONXFDzuL6B8C36mTWzO3ULghLLI9FBnmYTRse6XKJQ+x/ZeC3omTuUvY
	 dpxrxFHXfctFVykkAEPRI8NmywC1uCGkcqCMJWnIcxRtyQ9MlsawGDI6sU210K861C
	 uPsN9ymfwt6R5Lkd7aylCQdsSlbwe0jKihdgjRF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbgBKT1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbgBKT1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:27:02 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5674C20873;
        Tue, 11 Feb 2020 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581449222;
        bh=d9iTIU7z0h/UAxXemQIRG88N34pgT887tmSXs635Ibg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQY4MmpobVgaVaTP6qsCiIjySAMLzVQE3jZ/E5xMAk1pJ+Ut1QYPMb+tUrg73yxuB
         GP57yThJgV+rPR8Mpxl7iG7GB/bm5HksdTaptyuDfR1AydFmBQs8QgO6uEqvLly+VS
         W21zUBINJu/dqV0oI3gZqdmbZnG0pVVHo4lh7JYk=
Date:   Tue, 11 Feb 2020 11:27:01 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.or,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 01/18] staging: exfat: Rename function "ffsUmountVol" to
 "ffs_umount_vol"
Message-ID: <20200211192701.GA1971434@kroah.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
 <20200211123859.10429-2-pragat.pandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211123859.10429-2-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 06:08:42PM +0530, Pragat Pandya wrote:
> Fix checkpatch warning: Avoid CamelCase
> Change all occurrences of function "ffsUmountVol" to "ffs_umount_vol"
> in the source.

I've said this before about this type of change, but there's no need for
the "ffs" prefix at all for almost all of these functions.  Can you just
name them sanely instead?

thanks,

greg k-h
