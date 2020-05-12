Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BF1CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4448220673
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589306881;
	bh=LWmUKZyevZ4s49ZIFHcXHU4Dxegp29kPOzyrCIn6oYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HVxtWMb+nzY6UuFRYr2eaWPTMl3C8raz27nrC1gYQSuWpOAQnnKru4J+H235tgX9n
	 /Q4WFjeIt32mtm88IKUUbUHKanlvNMFq11O6DCGxp/+5bYNzoa6YbuJ4bFrimpFMrL
	 0YWg1zUzDlgyYioKON2w6FnaW61CuM7xNcUk/6zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgELSIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgELSIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:08:00 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E04320673;
        Tue, 12 May 2020 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589306879;
        bh=LWmUKZyevZ4s49ZIFHcXHU4Dxegp29kPOzyrCIn6oYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PaH71D2XSM/vCwQ+nOClPYnnd7Pc9hmUmr0MPNDvIe3tqy1z2tyU19dY+/YnXPH4L
         qj963yMQ561GCVC171BboTHhgD8NwZTJMjR+e3Yh52JMEisP8G8+gNhqRTKUOnovRH
         3KDrqPgM+audW/Nz6UsATHadSmxNY69op+w0SihA=
Date:   Tue, 12 May 2020 13:12:33 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Replace zero-length array with
 flexible-array
Message-ID: <20200512181233.GI4897@embeddedor>
References: <20200507192524.GA16580@embeddedor>
 <20200511103415.GG487496@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511103415.GG487496@lahna.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 01:34:15PM +0300, Mika Westerberg wrote:
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied, thanks!

Thanks, Mika.

--
Gustavo
