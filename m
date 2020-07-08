Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BACC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DF0206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGHWiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHWhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 18:37:31 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58258C061A0B;
        Wed,  8 Jul 2020 15:37:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 65BDA1277ED54;
        Wed,  8 Jul 2020 15:37:30 -0700 (PDT)
Date:   Wed, 08 Jul 2020 15:37:29 -0700 (PDT)
Message-Id: <20200708.153729.1570943134510183928.davem@davemloft.net>
To:     jarod@redhat.com
Cc:     linux-kernel@vger.kernel.org, huyn@mellanox.com,
        saeedm@mellanox.com, j.vosburgh@gmail.com, vfalico@gmail.com,
        andy@greyhouse.net, jeffrey.t.kirsher@intel.com, kuba@kernel.org,
        steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next] bonding: deal with xfrm state in all modes
 and add more error-checking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200708174631.15286-1-jarod@redhat.com>
References: <20200708174631.15286-1-jarod@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 Jul 2020 15:37:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarod Wilson <jarod@redhat.com>
Date: Wed,  8 Jul 2020 13:46:31 -0400

> It's possible that device removal happens when the bond is in non-AB mode,
> and addition happens in AB mode, so bond_ipsec_del_sa() never gets called,
> which leaves security associations in an odd state if bond_ipsec_add_sa()
> then gets called after switching the bond into AB. Just call add and
> delete universally for all modes to keep things consistent.
> 
> However, it's also possible that this code gets called when the system is
> shutting down, and the xfrm subsystem has already been disconnected from
> the bond device, so we need to do some error-checking and bail, lest we
> hit a null ptr deref.
> 
> Fixes: a3b658cfb664 ("bonding: allow xfrm offload setup post-module-load")
> Signed-off-by: Jarod Wilson <jarod@redhat.com>

Applied, thanks Jarod.
