Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F016BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59CD206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="XxIq/hao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCMAZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:25:28 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39224 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgCMAZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:25:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id e16so9639045qkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 17:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Be5NEGu4YJrkQL2c7HnPWgWIEPjdYRo2oZeDR69bUv0=;
        b=XxIq/haoKjduf+BA9w1pR4C7xvp+kb3qC797Hi+oF9ZQqnFUMeHUZCYzvxCVRjznRE
         xrNnbTVZ/zsPV2F93YTBrRDZWp7E1Suh6nASu3LYt3hXLkiWwcDbngFXniE0qMKqAuAc
         8w8ZtlQdbsSUMDueNcSTXhqeDxQvaa2Md8wHjd5IST8TxVXdGgSn/PjibjC4kBEMeybU
         B7CYzuL5Nmkx1mMC59jO4mD3rLZmt5Z7lkINg/oDk63rZXp0LLPOpWtsM4GIZBSvuG+0
         j5KYzHyEg1BAZwVMV2/U3B7FG7CArtZlQ+E9fVPjtduMvqHTHUUEzC7idIp51QGyYXns
         2i5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Be5NEGu4YJrkQL2c7HnPWgWIEPjdYRo2oZeDR69bUv0=;
        b=WTEMJQiOFoq5i040ma+2m5TtVUOY7EXGpOkOUuv7Fu5zbXKFeEtpRaUYj4GKRtCaC1
         u+La67ohfTo+uCCPx0cZTP8wOz8TN/6eyRbTDccdT7vqD5ZbCXfNMsbEeDnAHwohDdU/
         Uf+eYc7RaW4uogPHnIVUuCSQq5xINiPixxhjpUdXnhewLfBVxXhlOPt77TrwA8eyeJIt
         MbE04ZW/z8B77M7bJ/+OGmdtQLvuH2qszONM3uWzleX8KlEdzpOxLmvz4zw3wpPgSNlZ
         tj9cQKb7GCbi5BTGQJMrWn2MJRUn2vbCY4XdsiD9wih8KY/BbRxTOtVjxdVfAkSbpr6/
         DRew==
X-Gm-Message-State: ANhLgQ2TC3aVAbcegMPe1SO0/hZC+Ms1qMsOhQri4B8G/P17Zn0qr0l/
        WX5+7t5GfL+sAbzUZpceknm2URN+O7vK7TSo
X-Google-Smtp-Source: ADFU+vtmZ7+UL9XG4lOMY3eorggTCPDB0G3yh/wu/RlsZWPfft+zyfU9ASfTyRuadu+j5Nx7CpG2WQ==
X-Received: by 2002:a37:9a82:: with SMTP id c124mr10384195qke.193.1584059127227;
        Thu, 12 Mar 2020 17:25:27 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a664:2e00:38a9:cfd2:746b:b1f5])
        by smtp.gmail.com with ESMTPSA id 18sm4147091qkk.84.2020.03.12.17.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 17:25:26 -0700 (PDT)
Date:   Thu, 12 Mar 2020 20:25:25 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Arindam Nath <arindam.nath@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] AMD ntb driver fixes and improvements
Message-ID: <20200313002524.GB13046@kudzu.us>
References: <cover.1580914232.git.arindam.nath@amd.com>
 <a8e98fe8-25da-3ea7-a204-2fee07c6061a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e98fe8-25da-3ea7-a204-2fee07c6061a@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 04:28:53PM +0530, Sanjay R Mehta wrote:
> 
> 
> On 2/5/2020 9:24 PM, Arindam Nath wrote:
> > [CAUTION: External Email]
> > 
> > This patch series fixes some bugs in the existing
> > AMD NTB driver, cleans-up code, and modifies the
> > code to handle NTB link-up/down events. The series
> > is based on Linus' tree,
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > 
> > Arindam Nath (15):
> >   NTB: Fix access to link status and control register
> >   NTB: clear interrupt status register
> >   NTB: Enable link up and down event notification
> >   NTB: define a new function to get link status
> >   NTB: return the side info status from amd_poll_link
> >   NTB: set peer_sta within event handler itself
> >   NTB: remove handling of peer_sta from amd_link_is_up
> >   NTB: handle link down event correctly
> >   NTB: handle link up, D0 and D3 events correctly
> >   NTB: move ntb_ctrl handling to init and deinit
> >   NTB: add helper functions to set and clear sideinfo
> >   NTB: return link up status correctly for PRI and SEC
> >   NTB: remove redundant setting of DB valid mask
> >   NTB: send DB event when driver is loaded or un-loaded
> >   NTB: add pci shutdown handler for AMD NTB
> 
> The patch series looks good to me. Thanks for the changes.
> 
> For all the ntb_hw_amd changes:
> 
> Reviewed-by: Sanjay R Mehta <sanju.mehta@amd.com>

I had to rework the first patch, since Jiasen's patch was already in
my tree for a couple months.  The rest applied fine and will be in my
git trees on github in a couple of hours (sanity build pending).

Thanks,
Jon

> 
> 
> > 
> >  drivers/ntb/hw/amd/ntb_hw_amd.c | 290 ++++++++++++++++++++++++++------
> >  drivers/ntb/hw/amd/ntb_hw_amd.h |   8 +-
> >  2 files changed, 247 insertions(+), 51 deletions(-)
> > 
> > --
> > 2.17.1
> > 
