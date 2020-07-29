Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1E1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4C12076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596005770;
	bh=kh1VsqAFdvoIwnbd4u/yWyXxzaqDdZRI3AOfNdCIOHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UCKS/pnm4EBynkK0EZn2SDJMVm+mMBFmqRffcziD5NKi0E7nuI473LC4vgklDI+yt
	 PEJieN4THCvemAKhTIyKpmDnWeQknjzMHZSY/w02jVpws5dOMxB2AbtMIRQxQQzgCD
	 YXF+gsePHrgDPTKfvZZ5BXuzbr/sQeGi9wQXYgXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgG2G4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgG2G4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:56:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32DB2206D4;
        Wed, 29 Jul 2020 06:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596005768;
        bh=kh1VsqAFdvoIwnbd4u/yWyXxzaqDdZRI3AOfNdCIOHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0IdOqB0Ooku1vMr/HKKyRhQ3ee8JHb5Z6P4C9RSaaGMySgLJZt2AgdNQ86rjZmB8
         G4SQA2maX0uyxZahCHG4JjpZPnETYxzXqrZ2qdUE9zYXbff0wZWf8VBTLCEcr8cZYo
         lPYR7TPH/lBD8ZakK0Los4OCwY2LJ44wnwQ2qat4=
Date:   Wed, 29 Jul 2020 08:55:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jessica Yu <jeyu@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] modules: inherit TAINT_PROPRIETARY_MODULE
Message-ID: <20200729065559.GA476238@kroah.com>
References: <20200729062711.13016-1-hch@lst.de>
 <20200729062711.13016-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729062711.13016-8-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 08:27:11AM +0200, Christoph Hellwig wrote:
> If a TAINT_PROPRIETARY_MODULE exports symbol, inherit the tain flag

s/tain/taint/

> for all modules importing these symbols, and don't allow loading
> symbols from TAINT_PROPRIETARY_MODULE modules if the module previously
> imported gplonly symbols.  Add a anti-circumvention devices so people
> don't accidentally get themselves into trouble this way.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Ah, the proven-to-be-illegal "GPL Condom" defense :)

Nice, work, thanks for doing this:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
