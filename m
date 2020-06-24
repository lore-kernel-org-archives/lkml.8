Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D57EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D2520899
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592985373;
	bh=j5+LBYVd8DR8wdaBsQhlkf1drPcbVXynthgjqgSEmHw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=nraC+SlqHhRZZmjx5jvf56FuQNkiWYEd5+CXv4DPlyF7AqN4qiKQ7MIbnmPK8G3dR
	 iTk97kqne4kZDIZKB8bWlTtQD4wjzo5lunMFWIbDaU+6l1ykmiiHc9XrxeMMYsoG+S
	 N/9G5tYyAiwGRtwSAncr22zfHCgRcN7Lke4pLM2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389580AbgFXH4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388690AbgFXH4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:56:10 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B2A2088E;
        Wed, 24 Jun 2020 07:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592985369;
        bh=j5+LBYVd8DR8wdaBsQhlkf1drPcbVXynthgjqgSEmHw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ETAxDlTguNfR9AX4210sNW7fe5oxe96ktVB16oPEuBPHrIfuCxsQkiC+GNHcSasG3
         ZWaPnSSwiPBKYA0a9hvFMTFFODz6KmzLJyX2lCGLPgz15rxbF76eHpAjLADwtKIIR3
         H09YUEvtgbiGbpFEO66PCN2VF/aNan4WkJVx+fKY=
Date:   Wed, 24 Jun 2020 09:56:07 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the hid tree
In-Reply-To: <20200624175247.6c7427c8@canb.auug.org.au>
Message-ID: <nycvar.YFH.7.76.2006240955080.13242@cbobk.fhfr.pm>
References: <20200624175247.6c7427c8@canb.auug.org.au>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Stephen Rothwell wrote:

> Commit
> 
>   6d7ccae2e093 ("Revert "HID: allow building hid.ko as an external module"")
> 
> is missing a Signed-off-by from its author and committer.
> 
> Reverts are commits as well and need SOB tags and (preferably) an
> explanatory commit message.

The commit+revert pair is there only for linux-next (to maintain linear 
history there), the branch that contains the actual buggy commit will 
never make it to Linus.

Thanks,

-- 
Jiri Kosina
SUSE Labs

