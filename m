Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8244DC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65087206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgGVJdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:33:24 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:37948 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgGVJdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:33:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id DDBD22006F;
        Wed, 22 Jul 2020 11:33:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oM9Uz6WjvfQF; Wed, 22 Jul 2020 11:33:19 +0200 (CEST)
Received: from cas-essen-01.secunet.de (201.40.53.10.in-addr.arpa [10.53.40.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id A39BB20068;
        Wed, 22 Jul 2020 11:33:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 11:33:19 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 22 Jul
 2020 11:33:19 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
        id 09C0C318471A; Wed, 22 Jul 2020 11:33:19 +0200 (CEST)
Date:   Wed, 22 Jul 2020 11:33:18 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Mark Salyzyn <salyzyn@android.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
        <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: af_key: pfkey_dump needs parameter validation
Message-ID: <20200722093318.GO20687@gauss3.secunet.de>
References: <20200721132358.966099-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200721132358.966099-1-salyzyn@android.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 06:23:54AM -0700, Mark Salyzyn wrote:
> In pfkey_dump() dplen and splen can both be specified to access the
> xfrm_address_t structure out of bounds in__xfrm_state_filter_match()
> when it calls addr_match() with the indexes.  Return EINVAL if either
> are out of range.
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@android.com
> ---
> Should be back ported to the stable queues because this is a out of
> bounds access.

Please do a v2 and add a proper 'Fixes' tag if this is a fix that
needs to be backported.

Thanks!
