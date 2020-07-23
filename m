Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB2DC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB4712086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595488904;
	bh=hzHe2/UKQtRQ+CdSuBofzo9tTWOBUKPss0cCKGiJmKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QdmiUm3Avmnlwhvn9DBBOXN67Hu+f3Lg0pVukhj4ikHvEIT4dKO45Ypdq/nhWovS/
	 129k2hF21Rg6xIPez3IGf69vbq4pTv4N3NDc8IRmgG8e+4xqawknMDnW/A1awAw6CR
	 hWBafoabi+CgjYrGXpNOuwwZGc+cM+b5H5HpMZLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgGWHVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgGWHVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:21:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3024E2086A;
        Thu, 23 Jul 2020 07:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595488902;
        bh=hzHe2/UKQtRQ+CdSuBofzo9tTWOBUKPss0cCKGiJmKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJVr2NKyXBvtwdCfd8Yq1Wt4ywBjwN/E+C1axRnl9cIUzkxPxffUdwVusYFo/o+QF
         U93If/5IcImJiN3ohhXaTVlHay9T1ljm+ECtthRpAb6T5TyWjJIU+HvGY7+KS69KNE
         mhEzgjP1dl9ovqTxdzClHVw2txplEW7HDmHBTpE4=
Date:   Thu, 23 Jul 2020 09:20:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] soundwire updates for v5.9-rc1
Message-ID: <20200723072057.GA1178592@kroah.com>
References: <20200723070813.GV12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723070813.GV12965@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 12:38:13PM +0530, Vinod Koul wrote:
> Hey Greg,
> 
> Here are the updates for soundwire subsystem for 5.9. Please pull.
> 
> 
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.9-rc1

Pulled and pushed out, thanks.

greg k-h
