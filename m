Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B309DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5D52081A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593234961;
	bh=lB7QHcwNHl3AMdjVulKKrNrmLEOsHkSLJPONMrO8A2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YjFvNO8ONw8xmDGiweVTYMKzrxiUenYJ9c/4JVIRbY1mOG/0YDP5oOgWs6Wo+1Ezb
	 P3uNnom27bGUnCotjlNWJqm75j+89D8lwlWsbSpZgvWMRQv4YT8Ezc5k8YEC+rXIWC
	 M+BFOqeBUmyXr4DMrGLtAvEAKRzemZSAlYswq2jA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgF0FQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 01:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgF0FP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 01:15:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2133020720;
        Sat, 27 Jun 2020 05:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593234959;
        bh=lB7QHcwNHl3AMdjVulKKrNrmLEOsHkSLJPONMrO8A2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAHDekf/EuAQJsMsJEhjmKyc/6kfNB+GFTubCBoOpQKES/DLHhrdIVFzziiKIX+Jk
         mUxc8+tSMtYwbzUwTpxiUrSGAdLYfgo26R4NxBpx0eUE7rDLLlAInTM8mMj6bQCnQB
         pAiGIf+gzr4YYw3jsZUUFhldmIh2QeR4QxC8y2Pk=
Date:   Sat, 27 Jun 2020 07:15:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     richard.gong@linux.intel.com, atull@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH V3] firmware: stratix10-svc: Fix some error handling code
Message-ID: <20200627051556.GD233327@kroah.com>
References: <0ecc14c7-b4df-1890-fbe7-91307c2db398@wanadoo.fr>
 <20200626193720.949431-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626193720.949431-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:37:20PM +0200, Christophe JAILLET wrote:
> ---
> v2: takes Dan's comment into account and fix another resource leak.
> v3: merge the previous 4 patches in a single one to ease review


No, 4 small patches are _MUCH_ easier to review than one larger one that
mixes everything together.  Who told you to put them together?

