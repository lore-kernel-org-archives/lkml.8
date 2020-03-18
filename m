Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30146C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007FB20724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuYo0TaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCRCty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 22:49:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48268 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgCRCty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 22:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584499793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFq/oyp7WPPv1SjVdPo1z9wGSo67RbSVgYjJA/hOaFE=;
        b=RuYo0TaR1m856MYSuGjRO0FneesgbUT9m4iro0Re6+xOrghspzXS3ZTKmG5YOuB6dOkiQw
        txARBlgfzZ4ibbxxYMQ4gEEP5U+PDPgnrpfO/eF0Avfo0UwYXExZWnYf9mJKNegVsrxGdn
        WeiOur7RKy6LPp/TYetfwiL3F+D08io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-_53wWppWNlm6j-eLR6iu_g-1; Tue, 17 Mar 2020 22:49:48 -0400
X-MC-Unique: _53wWppWNlm6j-eLR6iu_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7493218A5513;
        Wed, 18 Mar 2020 02:49:47 +0000 (UTC)
Received: from localhost (ovpn-12-66.pek2.redhat.com [10.72.12.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A52260BF1;
        Wed, 18 Mar 2020 02:49:44 +0000 (UTC)
Date:   Wed, 18 Mar 2020 10:49:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@suse.de>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/mm] x86/mm: Remove the now redundant N_MEMORY check
Message-ID: <20200318024942.GA30899@MiWiFi-R3L-srv>
References: <20200311011823.27740-1-bhe@redhat.com>
 <158446925404.28353.8374899643384906431.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158446925404.28353.8374899643384906431.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/17/20 at 06:20pm, tip-bot2 for Baoquan He wrote:
> The following commit has been merged into the x86/mm branch of tip:
> 
> Commit-ID:     aa61ee7b9ee3cb84c0d3a842b0d17937bf024c46
> Gitweb:        https://git.kernel.org/tip/aa61ee7b9ee3cb84c0d3a842b0d17937bf024c46
> Author:        Baoquan He <bhe@redhat.com>
> AuthorDate:    Wed, 11 Mar 2020 09:18:23 +08:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Tue, 17 Mar 2020 19:12:39 +01:00

Just a soft reminder, I also got a notice from Andrew that this was picked 
into his -mm tree before. Maybe one can be dropped to avoid conflict
when sending to Linus.

Thanks for taking care of this.

> 
> x86/mm: Remove the now redundant N_MEMORY check
> 
> In commit
> 
>   f70029bbaacb ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE")
> 
> the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY.
> Before, CONFIG_HIGHMEM && !CONFIG_MOVABLE_NODE could make (N_MEMORY ==
> N_NORMAL_MEMORY) be true.
> 
> After that commit, N_MEMORY cannot be equal to N_NORMAL_MEMORY. So the
> conditional check in paging_init() is not needed anymore, remove it.
> 
>  [ bp: Massage. ]
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Link: https://lkml.kernel.org/r/20200311011823.27740-1-bhe@redhat.com
> ---
>  arch/x86/mm/init_64.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index abbdecb..0a14711 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -818,8 +818,7 @@ void __init paging_init(void)
>  	 *	 will not set it back.
>  	 */
>  	node_clear_state(0, N_MEMORY);
> -	if (N_MEMORY != N_NORMAL_MEMORY)
> -		node_clear_state(0, N_NORMAL_MEMORY);
> +	node_clear_state(0, N_NORMAL_MEMORY);
>  
>  	zone_sizes_init();
>  }
> 

