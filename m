Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9856EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791E7207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589914988;
	bh=yGKJu1xlG42vBKIuRnBWXZQM+NLQT8MzF+RRBMa5FQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O+S4sDVTzGr2i3LulyPsgrvqUoild11voqCOcIFoRQ+k4s1MVpQ0sPeC0/18FtQ2H
	 ypVXBmyYyqPGgFkfXpJ2eCtzK5+SaNfS7VQvjDwZ4YYzFzLpUadOniclK4AmSdTWGc
	 6sFH33ILcXpcLqtCneQRS+an1wIss/UxPWGKOMUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgESTDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgESTDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:03:07 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 735D8206C3;
        Tue, 19 May 2020 19:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589914986;
        bh=yGKJu1xlG42vBKIuRnBWXZQM+NLQT8MzF+RRBMa5FQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtrDy/VdWXUK6kmNCsHw2vh9EIETgrekvcLoGJuk2Xv3rgo+2KWuI9joZxl25cakV
         O0J8rc8IlWTaNBQgo1hQJYcEwVY6CmjofXJ60HUZxkdcuhXMtQs9Nl/1GxpfB4no4M
         xolp7DYp2DpKeXm3XoLFcg2yNRyyGg0vUXRGtk+Y=
Date:   Tue, 19 May 2020 14:07:53 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: locking/core] locking/lockdep: Replace zero-length array
 with flexible-array
Message-ID: <20200519190753.GA10690@embeddedor>
References: <20200507185804.GA15036@embeddedor>
 <158991386428.17951.3540978557111480073.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158991386428.17951.3540978557111480073.tip-bot2@tip-bot2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 06:44:24PM -0000, tip-bot2 for Gustavo A. R. Silva wrote:
> The following commit has been merged into the locking/core branch of tip:
> 
> Commit-ID:     db78538c75e49c09b002a2cd96a19ae0c39be771
> Gitweb:        https://git.kernel.org/tip/db78538c75e49c09b002a2cd96a19ae0c39be771
> Author:        Gustavo A. R. Silva <gustavoars@kernel.org>
> AuthorDate:    Thu, 07 May 2020 13:58:04 -05:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Tue, 19 May 2020 20:34:18 +02:00
> 
> locking/lockdep: Replace zero-length array with flexible-array
> 

Thanks, Peter.

--
Gustavo
