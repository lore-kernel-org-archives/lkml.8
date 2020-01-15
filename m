Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ABBC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894A02467E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579047736;
	bh=UtpU7GKNkRFzSFzb5w/At6XsQajSL3o+lfDntCrvHDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=i/j9NgA0mO0dcvZZQf1HVAV1fSlrOWLuLpAkFhTW3EiRyqlNAzKOC/Tjh1mwMEuMF
	 GWENHz5wR63sCcKtnzsacAX9jUMH6J205gZWDbWwtIAE5y4av43QSzf54KaDvYXrj/
	 c6QP9OP6CFKNdZ0XVoOXVcPNYtwdCO72U9BkyRVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgAOAWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:22:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728774AbgAOAWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:22:14 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C7524658;
        Wed, 15 Jan 2020 00:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579047733;
        bh=UtpU7GKNkRFzSFzb5w/At6XsQajSL3o+lfDntCrvHDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vTMcilFUO2Nw5IgIWCfgkIFZJoqx7kFNZ9qZYhSPzcEH/u2629A/9/INGzSvc461a
         V5EhIe9XbO7GyJkLZF/CnnGiXLAs0Vh2khuUkA3oVjKzSPJ7q0UgW0E2XHLQFownFC
         aFbRhQAZ/p2dnB/CtWfVnDjk7qyYov8vMNIV9XhY=
Date:   Tue, 14 Jan 2020 16:22:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: remove unused RECLAIM_OFF/RECLAIM_ZONE
Message-Id: <20200114162213.59a9b6bafe21305deb694b23@linux-foundation.org>
In-Reply-To: <1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 20:39:33 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> commit 1b2ffb7896ad ("[PATCH] Zone reclaim: Allow modification of zone reclaim behavior")'
> defined RECLAIM_OFF/RECLAIM_ZONE, but never use them, so better to remove them.
> 
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4126,8 +4126,6 @@ static int __init kswapd_init(void)
>   */
>  int node_reclaim_mode __read_mostly;
>  
> -#define RECLAIM_OFF 0
> -#define RECLAIM_ZONE (1<<0)	/* Run shrink_inactive_list on the zone */
>  #define RECLAIM_WRITE (1<<1)	/* Writeout pages during reclaim */
>  #define RECLAIM_UNMAP (1<<2)	/* Unmap pages during reclaim */

--- a/mm/vmscan.c~mm-vmscan-remove-unused-reclaim_off-reclaim_zone-fix
+++ a/mm/vmscan.c
@@ -4118,8 +4118,8 @@ module_init(kswapd_init)
  */
 int node_reclaim_mode __read_mostly;
 
-#define RECLAIM_WRITE (1<<1)	/* Writeout pages during reclaim */
-#define RECLAIM_UNMAP (1<<2)	/* Unmap pages during reclaim */
+#define RECLAIM_WRITE (1<<0)	/* Writeout pages during reclaim */
+#define RECLAIM_UNMAP (1<<1)	/* Unmap pages during reclaim */
 
 /*
  * Priority for NODE_RECLAIM. This determines the fraction of pages
_

This might be a bit picky ;)

