Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A367C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E071E24655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582070726;
	bh=sH5O3xWAIkvm8LQwxC8TtAEp/a7Uo9nlFDZX5BpE1BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kUY9jC/3yFcJkHiGc093x1GqYMUBU+Z2GKwG9sNjmEwnim9in+1qyK+NTKcNU1Jm0
	 nCFKiXWbIN3sgnEXPHmSrPzWjG/Jmvlhk2X8hkAPFU4WvkxpeUoTVMoK3T4xyAjZ3h
	 6monm55ATZ1p+GG8xqIzyapjrgqknwyGJXuqxM2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgBSAFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgBSAFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:05:25 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64EB2208E4;
        Wed, 19 Feb 2020 00:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582070724;
        bh=sH5O3xWAIkvm8LQwxC8TtAEp/a7Uo9nlFDZX5BpE1BI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n34GwqorcOZe9+n/DJqkx+bN9uzQ3LmSN0iQe6xFjGjG2VrjWSeePqaDBPfsjHmBB
         XHc+QPAj7qb4SLqaMeTvJlpBRBwdVgQ7QZUHpfDDGMo9DZQN9aExDG7T8SEexciv+4
         8YzeJZIbJBUwKe8xctNcBGrU1/YzCHJNjjDs9QF0=
Date:   Wed, 19 Feb 2020 09:05:19 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Edmund Merrow-Smith <edmund@sucs.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] drivers: NVME: host: core.c: Fixed some coding style
 issues.
Message-ID: <20200219000519.GB18306@redsun51.ssa.fujisawa.hgst.com>
References: <20200218230131.12135-1-edmund@sucs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218230131.12135-1-edmund@sucs.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 11:01:31PM +0000, Edmund Merrow-Smith wrote:
> Fixed a number of style issues highlighted by scripts/checkpatch.pl.
> Mostly whitespace issues, implied int warnings,
> trailing semicolons and line length issues.

But checkpatch.pl is on the wrong side of the 'unsigned'/'unsigned int'
debate! The C standard defined unsigned since forever ago, its usage is
not at all confusing.
