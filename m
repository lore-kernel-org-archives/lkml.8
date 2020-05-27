Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6873CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4D420DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590567337;
	bh=FgEJNJxnkD29tnmwm4kxlLiPKgLjVh209CcrJrd9R8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qB9C38fkKnlxKNt2lwcE8BKSwCLwBrI2NAMBW30JkEQ0vfUSaIMsLsuZfxs5119Vs
	 rE34r6tCRiJpuOr9y9Z5VT0CdSxrryQ/3J0pmKD/nwdjBMmqMJX7t6sHZw36FzFZ6t
	 YYl5+/D3LYLPgO4bSfFMX7OOHM8CncH0V6g5zE5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbgE0IPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387787AbgE0IPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:15:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78FF5208B8;
        Wed, 27 May 2020 08:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590567335;
        bh=FgEJNJxnkD29tnmwm4kxlLiPKgLjVh209CcrJrd9R8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=akFgrBu9QyImdWbTpRA2alV+Jkys5EaIaOQ2RQwKzd9d6GerSO6fjyd4atnru3GTe
         lAHkkotroGtwywU2/tUw6sWYsjRjuXtZR+w/gHoXpeXWxTCHwh9s99rVJsYZ7QszTF
         S717mT3Y2Q8DgmBGKZ02yCRMN/P4Xdo8HJGWk+0M=
Date:   Wed, 27 May 2020 10:15:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pascal Terjan <pterjan@google.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Use shared header constants
Message-ID: <20200527081532.GA122680@kroah.com>
References: <20200523212919.33181-1-pterjan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523212919.33181-1-pterjan@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 10:29:19PM +0100, Pascal Terjan wrote:
> This is one of the 9 drivers redefining rfc1042_header.

I do not understand what this changelog is trying to say.  Can you fix
this up to be more explicit and detained and resend?

thanks,

greg k-h
