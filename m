Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3C6C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CA92467E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581710541;
	bh=iKkjnAjK2qRuw6EPVeGwQLbPNxV16s5T5iR1HhE3JOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TWV3QxsHiAfLvHt7sRvY5I4blLr2og/inIrmNH3p+/eKHANC+F73M47cQfCLDYoWH
	 YU/KY08xcQMqVKJylQNuFyWde4ODiH3r5MPbwikEcNxaebxP71cEcEgTqG13U3AwNF
	 ICwJpy1cVOy3Hz6ldtri0QFiGJy4H1FnbZHhJ9rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbgBNUCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:02:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389352AbgBNUCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:02:14 -0500
Received: from localhost (unknown [12.246.51.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E25C2465D;
        Fri, 14 Feb 2020 20:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581710533;
        bh=iKkjnAjK2qRuw6EPVeGwQLbPNxV16s5T5iR1HhE3JOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDGLP3c/zic7UDxjcou+8zuUSL9tozcKucWgYu4CV6lZUKjf1pj7HTo3kFG/jLGXV
         GhSASbADLjT46cHWpBFKSrizQmeqa+5hCxd+5Gp5fdM3jTBFoJF+FgE68rl9U/9/KD
         qn7svYMI/ouOjLaiqeW7iuntd8VN915HkUdrj4o4=
Date:   Fri, 14 Feb 2020 08:18:10 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Mori.Takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp
Subject: Re: [PATCH v2 1/2] staging: exfat: remove DOSNAMEs.
Message-ID: <20200214161810.GA3964830@kroah.com>
References: <20200214033140.72339-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214033140.72339-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 12:31:39PM +0900, Tetsuhiro Kohada wrote:
> remove 'dos_name','ShortName' and related definitions.
> 
> 'dos_name' and 'ShortName' are definitions before VFAT.
> These are never used in exFAT.
> 
> Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
> ---
> Changes in v2:
> - Rebase to linux-next-next-20200213.

I think you might need to rebase again, this patch doesn't apply at all
to my tree :(

sorry,

greg k-h
