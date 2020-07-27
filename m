Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D20FC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF8F20719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595877493;
	bh=qOVvcnYqwCVqq0+ZdjTf0kW+Rnz/XSf109njFSrOtoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=133lnVde/qaLIJuMhnSvYIow0vx4vy/rwQDhSLOORFymsreIaiYiSeCFTntZzX5Yv
	 i/Xt84fq5ab9xx3iXW892ht6Fy+lNG66rHPosN9LQxuDbZEPAtsm201XN1sGRppVLv
	 p0riTmSBO6H7EuR/fFLtiA/oFdkvMev8sV20pung=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgG0TSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgG0TSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:18:11 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA56A20719;
        Mon, 27 Jul 2020 19:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595877491;
        bh=qOVvcnYqwCVqq0+ZdjTf0kW+Rnz/XSf109njFSrOtoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oijlgmFoRyScVVXwJJ1pFQmGmrgDeQewSrxRm5dkibMCvspEDDlMXte/cVPuAQffu
         IdEdqSu+68V1C/sUSmR5Dvk3ZPX+m6e3f5TC5esmBAPLDhZdA2H4dYn5ljNDJ83tny
         1VQsZWQ7kpvXpnhqy8CpkoCg9o+Hc5O5kaBjCGnc=
Date:   Mon, 27 Jul 2020 15:18:09 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     John Donnelly <John.P.donnelly@oracle.com>, stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (resend) [PATCH [linux-4.14.y]] dm cache: submit writethrough
 writes in parallel to origin and cache
Message-ID: <20200727191809.GI406581@sasha-vm>
References: <37c5a615-655d-c106-afd0-54e03f3c0eef@oracle.com>
 <20200727150014.GA27472@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200727150014.GA27472@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:00:14AM -0400, Mike Snitzer wrote:
>This mail needs to be saent to stable@vger.kernel.org (now cc'd).
>
>Greg et al: please backport 2df3bae9a6543e90042291707b8db0cbfbae9ee9

Hm, what's the issue that this patch addresses? It's not clear from the
commit message.

-- 
Thanks,
Sasha
