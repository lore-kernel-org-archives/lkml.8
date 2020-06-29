Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7E6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4C120780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593472524;
	bh=/ypye1Fse2hK/0noVvmGFENb0K1hmH1QkE5HS4u5aXc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=sxqnkSEduUtsfVvRvFqDzg8YkWhz6AHq0OxRctcDRMs4YhOrTlNJsGT5C13tmvjUc
	 L/JEOD/yYQSp4KwAIjBduao5w8OCUOmogvpyqVMC9k4iD/M2X/yW9j8RFMLlZeajoA
	 565wYfzTci5hwwV/FGahH5fXoCrIXvAY/DzA5gtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgF2XPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgF2XPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:15:23 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB1FF2071A;
        Mon, 29 Jun 2020 23:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593472523;
        bh=/ypye1Fse2hK/0noVvmGFENb0K1hmH1QkE5HS4u5aXc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=iU8Q6q87f9oMG2D6RqRAV6bXWYJSwKlovAgIP/BpcIXxghO0qNDlwpBZ3SqWaOLoJ
         93DQa2nXmA8F3ZpcF5BR32gUhnDy/oO3qdYyXPI6k0PBbdGRZydLecHmrTbRaemuqO
         DpTIPiYlxEI8nSVOOXf8BfjWhyk8dxVYOYK84ojU=
Date:   Mon, 29 Jun 2020 16:15:22 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the xen-tip
 tree
In-Reply-To: <20200630083036.648a0743@canb.auug.org.au>
Message-ID: <alpine.DEB.2.21.2006291614530.8121@sstabellini-ThinkPad-T480s>
References: <20200630083036.648a0743@canb.auug.org.au>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   724f239c3401 ("arm/xen: remove the unused macro GRANT_TABLE_PHYSADDR")
> 
> is missing a Signed-off-by from its committer.

Fixed. Thank you so much, I love linux-next :-)
