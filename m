Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC1DC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B9920707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MdA9bJwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgAaMEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:04:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgAaMEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LmGDQNqTKZx9Fhue8Qo2e0s5I/QBmtbZevvhKn8XPLk=; b=MdA9bJwQGCBCEK1/ha1URQahL
        sbzwN/3aXZXjCREEIN532/FdEqwhRbLLEY8D/fKvVr+jqC8rSWfhZuBsYN/mA8/mo4NnMPfhPDmUJ
        sPZQvRlpC5DqghEqqoEDFD2q9d2aOVy+gp/G8la/MqHiAlwirLn3ThNgqWLXlvejMtmhav5RmbPlw
        hD1XXN6frY8PxKbKsP2AGr7sMA5srghkQF4r1CViiJjDD6qEaxIQDnwUOIlYI/RS/yctwDQ7/vEJQ
        Rrz8yfzHADmnmTNKYaCqhMkgHWOUnGCCchym7xUrvW1BDBy8KN7ddGZ6QiSvyqV5SURwrhiR0M0y4
        HjTvXAooQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixV2R-0007vq-Bh; Fri, 31 Jan 2020 12:04:43 +0000
Date:   Fri, 31 Jan 2020 04:04:43 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Armijn Hemel <armijn@tjaldur.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/ida: remove abandoned macros
Message-ID: <20200131120443.GC4437@bombadil.infradead.org>
References: <1579595645-251250-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579595645-251250-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:34:05PM +0800, Alex Shi wrote:
> 3 IDA_ started macros aren't used from commit f32f004cddf8 ("ida: Convert
> to XArray"). so better to remove them.

Thanks, applied.
