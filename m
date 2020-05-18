Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E55C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9605E207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589818527;
	bh=q5HTwfOBGfBfZxqrTNTQaJvKuZMjmDhuRNoGsyo1ALM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j0X8M2BZXzXZQu3Sj0K4rbucgSqoNbvcGIt3Xk3AEnBAauqSQsjylwckr2UtXBeMy
	 pMPQSnkpA47bRWLjxoeYevNinhP0fijG5U+vwgzLjDo/61aRaDBa3BYdJoeqIhsSGm
	 o9Xhl8az/sE4iXJQvz6E3+1TNm5AQcaR1em2X5Aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgERQP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:15:26 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5908A20674;
        Mon, 18 May 2020 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589818526;
        bh=q5HTwfOBGfBfZxqrTNTQaJvKuZMjmDhuRNoGsyo1ALM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYozICMkI4U5sVPYxuNXif+RiK9FF5K1kfQIRY1GQEd0hKFpapQDkVjcRkWWb8MVa
         2amD3xnHM0zy7C4GX+zqgxn85hIjfdWtuMANqWW7Du5nbexhDcoVEyKihWAm1RVB9+
         tdqJXcUCLASNAqypMZ85sQmW3obEgVcs7y42PNLo=
Date:   Mon, 18 May 2020 11:20:11 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Replace zero-length array with
 flexible-array
Message-ID: <20200518162011.GA9868@embeddedor>
References: <20200513171556.GA21969@embeddedor>
 <5C6DAE24-2E3B-4E89-AFA2-9B0E27B40815@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C6DAE24-2E3B-4E89-AFA2-9B0E27B40815@holtmann.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 09:58:22AM +0200, Marcel Holtmann wrote:
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > include/net/bluetooth/l2cap.h | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> patch has been applied to bluetooth-next tree.
> 

Thanks, Marcel.

--
Gustavo
