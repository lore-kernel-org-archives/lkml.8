Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74925C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABA52072D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598869539;
	bh=BhY2az4Cf2Gv9ZzM/Yt/QJbxfEtBddIHD9q0bXBVkM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wwTfiKNO3r8y771prDenYL09afobTArvP58wnq96LPWX0zy7AuLUicO5AciV9JaB7
	 mOd8m2LlrgQg7tLn/t8g0UNjeAaw7W6TnluS4CN76b56zsPDCiI/SLSzLzampaw4uy
	 ADPUKw0Nk8M0CT8cdqcOWr75ET4++WjChy3xeXOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHaKZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgHaKZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:25:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 805DD206E3;
        Mon, 31 Aug 2020 10:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598869535;
        bh=BhY2az4Cf2Gv9ZzM/Yt/QJbxfEtBddIHD9q0bXBVkM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1Tyv8m8g7xWFNOuT/MhrqazBBJXXC2QJs0ToWznB2lQrRSkhoArXdrPMnnjFC7+2
         pWW/KtyNuHGJzBF2+W5asR7aZhQf2Dx2oBsvavW40J4iLfSKV5UoaxAZjLBJMlXvbw
         tyJGq18uCnMeg3PHH1BMJ67U29gGYVKFysUOFsNI=
Date:   Mon, 31 Aug 2020 12:25:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ross Schmidt <ross.schm.dev@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: os_dep: fixed some coding style
 issues
Message-ID: <20200831102543.GA612591@kroah.com>
References: <20200829011405.2869-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829011405.2869-1-ross.schm.dev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 08:14:05PM -0500, Ross Schmidt wrote:
> Fixed some coding style issues.

What issues?  Always be specific please.

Please fix up and resend.

thanks,

greg k-h
