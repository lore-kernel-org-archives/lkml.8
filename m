Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6309AC35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECED20702
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582398125;
	bh=1rkRBZi5YP+19xd/13OkEarv3q1ztt2FziYQzWdvT4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qgWYVKlIfbP5G2BruGmlnmFb0b+O8JSb7bPBIfKlU+n+MmquGRBgmR0JEC4c9ixF8
	 fDJqmlXYkZstIqEUeTZg8gQa6GdD7zBPwAjmqmhQqL9zVN3sbyIzXdmi3K1Am3wAsB
	 EI9y4DzEK18l/LlIKzVELoFKQRnTZCcTIhlbKsHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgBVTCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 14:02:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgBVTCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 14:02:03 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C3B206EF;
        Sat, 22 Feb 2020 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582398122;
        bh=1rkRBZi5YP+19xd/13OkEarv3q1ztt2FziYQzWdvT4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2BkUXwoXXgsAiOuQlo/y0EOPQiMVeg1gnI84VSykIP7XcQI5c7I3ZZE/sqdHZ7ur9
         dNNwM9ZquPy4LdL0vkAsqoT9tG3pFevEDOt2d9N/tUfuLIBCWWLndFR+eEZBukdnZy
         pc6yjvuyJOXRrqx+Nr66tfaH06l01pbvZje7gNqQ=
Date:   Sat, 22 Feb 2020 14:02:01 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: [PATCH 4.19 011/191] nfsd4: avoid NULL deference on strange COPY
 compounds
Message-ID: <20200222190201.GC26320@sasha-vm>
References: <20200221072250.732482588@linuxfoundation.org>
 <20200221072252.497508893@linuxfoundation.org>
 <20200221105104.GB14608@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200221105104.GB14608@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:51:04AM +0100, Pavel Machek wrote:
>Hi!
>
>> With cross-server COPY we've introduced the possibility that the current
>> or saved filehandle might not have fh_dentry/fh_export filled in, but we
>> missed a place that assumed it was.  I think this could be triggered by
>> a compound like:
>>
>> 	PUTFH(foreign filehandle)
>> 	GETATTR
>> 	SAVEFH
>> 	COPY
>>
>> First, check_if_stalefh_allowed sets no_verify on the first (PUTFH) op.
>> Then op_func = nfsd4_putfh runs and leaves current_fh->fh_export NULL.
>> need_wrongsec_check returns true, since this PUTFH has OP_IS_PUTFH_LIKE
>> set and GETATTR does not have OP_HANDLES_WRONGSEC set.
>>
>> We should probably also consider tightening the checks in
>> check_if_stalefh_allowed and double-checking that we don't assume the
>> filehandle is verified elsewhere in the compound.  But I think this
>> fixes the immediate issue.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Fixes: 4e48f1cccab3 "NFSD: allow inter server COPY to have... "
>
>AFAICT 4e48f1cccab3 "NFSD: allow inter server COPY to have... " is not
>part of 4.19 series, so this should not be needed in 4.19.

Not only 4e48f1cccab3 isn't in 4.19, it isn't in any tree! :)

Looks like an error in the patch, I'll drop this commit from everywhere.

-- 
Thanks,
Sasha
