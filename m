Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EEAC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D862074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fi9Gct8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504476AbgDNSvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504464AbgDNSve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:51:34 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9B0C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:51:34 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id l60so2714969qtd.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+pj2d/UhEffZ+BGtjmYawglygVQvC6XutQRC9yavuQ8=;
        b=Fi9Gct8ywSHuMzlhqXmHeEouwgNdM/N6XscrCf6dfjOWwL3xnqOO7wmCo9DI1kK9+M
         PvFGEOIM5KxqND8BqDNIyDixTdJHNANHf9DxV4JSJXTyCQ5KOO3ajb6ButNl55OVqrSt
         DpF6PtOmcDiaDXJuy+cCA6Qg6VEAAzDXxPA35roai1S6TnDTNUReZ1hdVUq0sPLN7fCZ
         LPLRr3ZrknbT2Sx1hOPUyA6DuO+C1FS4vz07+CHmu23jNZARj9FbiH+JFyqKWlcKDTIu
         +gTrVk2EhuBmFG0PTWpkpP89xMzrzkyAPRKFL0LdAuUWyI0m/BT+lxZYa/MKuf2/n3jk
         EzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+pj2d/UhEffZ+BGtjmYawglygVQvC6XutQRC9yavuQ8=;
        b=FefVilPC+K/bya09tSfbIP23bqlFpY+E15+ClLFuR1LBoDd2+qy3meBN7mrcmy6C+z
         9XikX4cE4X99RDT/m2y5u9SPb6l+qJJ5EDhhPWnxciTglSuQnC+jIq9qRx1Nb5ZrJxOF
         FGhSPIr6DN2sDwUISrMHJFln8lM2gShImPjngsfYMjD+1V0DlvxmBnP3OFo99pRvj+tv
         TBDMTHZfpJiyHmQZAjxQayrwmWwFlmyF4QWU6y94+1ndAW/z1yQ4MK1C0BYF12V3NAUP
         3R4y1EURqXTaX0k8CkyrV2Ui4PWoGPBArUIU5D9AU7mzhAoYg38RFFBTqgWzP4xliav0
         fdeA==
X-Gm-Message-State: AGi0PuZqkCOtn26P+Rz4XQK4iJJZMjt0TU4K7cutU8kmhKkFIasDB3di
        BCDKj0FqgrFJqtR5tMIl3GLNsA==
X-Google-Smtp-Source: APiQypJPbl2HYS41QgZwy6Kbla3bs4hTTS8H3zzlkOxdjWX2b0lK6R609TRSaWWLbYrQN5WnpagJpg==
X-Received: by 2002:ac8:3874:: with SMTP id r49mr17790847qtb.66.1586890293466;
        Tue, 14 Apr 2020 11:51:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t35sm1715044qte.92.2020.04.14.11.51.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 11:51:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOQei-0001C3-DP; Tue, 14 Apr 2020 15:51:32 -0300
Date:   Tue, 14 Apr 2020 15:51:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, sindhu.devale@intel.com,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] i40iw: fix null pointer dereference on a null wqe
 pointer
Message-ID: <20200414185132.GA4556@ziepe.ca>
References: <20200401224921.405279-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401224921.405279-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 11:49:21PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the null check for wqe is incorrect and lets a null wqe
> be passed to set_64bit_val and this indexes into the null pointer
> causing a null pointer dereference.  Fix this by fixing the null
> pointer check to return an error if wqe is null.
> 
> Addresses-Coverity: ("dereference after a null check")
> Fixes: 4b34e23f4eaa ("i40iw: Report correct firmware version")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
