Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F3AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58CF2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590741810;
	bh=VyCSLeUoTcm+HYLHqTUpLzKRl6yPeQLRy59awbnDnJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OtruHCpK0mFH5kmVDFmkzF8KIE38XCZT0kz7BpvuRpAQ9oLykUC9+uxZ7oRKVyY0U
	 fceQ5LzuxXP0XeM5H2P2++xsd1PugoqAswYQVumZmM2riSS1bS8QJWq3I1DdX2uN7s
	 pCz6hxvSJVk/ZEotDDnnkTIc23rsJi74iHnakbc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgE2Ina (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2In2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:43:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BFC92075A;
        Fri, 29 May 2020 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590741808;
        bh=VyCSLeUoTcm+HYLHqTUpLzKRl6yPeQLRy59awbnDnJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WSyvJ9pX3LJ/pIlIIAaUeeVwuWEBoJDeNU9E+opEsMC7TKrEzNQ0ZqPgOCf5JCbbL
         li0Nl/F3B4Dm+GfRBZcIydTPmXnL/ZGa6XzecZtczuKsX7MZzs32maB4x5XCb6ip9Z
         ei5hOalljQz+HTXdi0GTWxvGLiDv31LD4yQCxa4U=
Date:   Fri, 29 May 2020 10:43:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL v2] extcon next for v5.8
Message-ID: <20200529084325.GB996343@kroah.com>
References: <CGME20200529083435epcas1p437fe64ae869c24adc001eab41dde68f4@epcas1p4.samsung.com>
 <169a5d0a-6e64-d2f6-99db-4c1c9090e004@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169a5d0a-6e64-d2f6-99db-4c1c9090e004@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 05:44:55PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.8. I add detailed description of
> this pull request on below. Please pull extcon with following updates.

Much nicer, thanks, now pulled and pushed out.

greg k-h
