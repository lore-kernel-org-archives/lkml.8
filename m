Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AB4C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B102087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580751500;
	bh=7DceEA2M6fJ7fQhDMyXvM99m0I7lcjwIRZp76B2Fz5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=neEKm2ZOvcNWSBaihhKf8HpWju6Q62DIOPVWMg4Sx1kU9JKE1AisRY3HXl/sDvnQp
	 KEzcmicLDQ+gcBOcbZnDX+sp9g61F6nNpTyqUkimTJ+MXoDANl5+GyBL0jaBTPuhfX
	 0FOBZBb4u2iyNMtx2Y7m14iqB6RveFDxk0p+m8HQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgBCRiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:38:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgBCRiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:38:16 -0500
Received: from cakuba.hsd1.ca.comcast.net (unknown [199.201.64.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FC1A2080C;
        Mon,  3 Feb 2020 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580751495;
        bh=7DceEA2M6fJ7fQhDMyXvM99m0I7lcjwIRZp76B2Fz5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sbHsOQXISEkqWPmrGiUsPIeqH6iLYLzuJ2YxqocZovcivw4CZPVv4cRZmNghrCCGI
         qF5wM1/NgCX9fokH92XwCVASySLaE7Zcx60ysmoEA0v6sGZiF7SdrCRHou2I1RNC+z
         8zV/XEnjasxEQbQCOBxII28a3QDW8qc416XXSjuw=
Date:   Mon, 3 Feb 2020 09:38:14 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] defxx: Fix a sentinel at the end of a 'eisa_device_id'
 structure
Message-ID: <20200203093814.69d33a2a@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <alpine.LFD.2.21.2002031015530.752735@eddie.linux-mips.org>
References: <20200202142341.22124-1-christophe.jaillet@wanadoo.fr>
        <20200203095553.GN1778@kadam>
        <alpine.LFD.2.21.2002031015530.752735@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2020 10:20:46 +0000 (GMT), Maciej W. Rozycki wrote:
>  Right, the code is good as it stands (I should have more faith in my past 
> achievements ;) ).  Except for the whitespace issue, which I suppose might 
> not be worth bothering to fix.  Thanks for your meticulousness!

For the white space clean up please resend after the merge window
(if you care), networking trees are only taking fixes fixes now :)
