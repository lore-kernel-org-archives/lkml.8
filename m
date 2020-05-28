Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73231C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496FE2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWr8IXeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406843AbgE1Tt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:49:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51058 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406793AbgE1Ttz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590695394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGEwxwS7tZTWjiMY8Vu7E2VO0RKA+bB59w6D9Y1acyk=;
        b=RWr8IXePEfJaW2u/XvhoM3WoMGIbAYoUlMNlMMYTtamR342Xn/WTxelw2vKps5bhuX7OLn
        VizRqz9HK7IYZH+Uzev8+1EMR6YaWsQyS8L1TNbEBlXsPNc19HU/7gNd5vHd3hXUKJJXwy
        iVsbc+y43rpICrMsNVEN87s3rtAZzwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-DMIMTC5sN_WX3GnguJDP0Q-1; Thu, 28 May 2020 15:49:51 -0400
X-MC-Unique: DMIMTC5sN_WX3GnguJDP0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 164AB107ACCA;
        Thu, 28 May 2020 19:49:50 +0000 (UTC)
Received: from localhost (unknown [10.10.110.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DF991992F;
        Thu, 28 May 2020 19:49:47 +0000 (UTC)
Date:   Thu, 28 May 2020 12:49:46 -0700 (PDT)
Message-Id: <20200528.124946.275321353658990898.davem@redhat.com>
To:     arnd@arndb.de
Cc:     linux-net-drivers@solarflare.com, ecree@solarflare.com,
        mhabets@solarflare.com, kuba@kernel.org, amaftei@solarflare.com,
        tzhao@solarflare.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] sfc: avoid an unused-variable warning
From:   David Miller <davem@redhat.com>
In-Reply-To: <20200527134113.827128-1-arnd@arndb.de>
References: <20200527134113.827128-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 May 2020 15:41:06 +0200

> 'nic_data' is no longer used outside of the #ifdef block
> in efx_ef10_set_mac_address:
> 
> drivers/net/ethernet/sfc/ef10.c:3231:28: error: unused variable 'nic_data' [-Werror,-Wunused-variable]
>         struct efx_ef10_nic_data *nic_data = efx->nic_data;
> 
> Move the variable into a local scope.
> 
> Fixes: dfcabb078847 ("sfc: move vport_id to struct efx_nic")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applid, thanks.

