Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5397C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A068C207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589818904;
	bh=Hy6eh4EEN/gX8lLoYHqML6egri7+0PB5MVzlAu/UEdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SdKJD1lhF4tlth8n7HSv+w5mOZmsi3hT2oAGOwqMKWglqcv41DsCNbpbYK2O/z5xd
	 5MGa3iw7UDUP7IGbKQ8/rj0mOgPNUYsSssPxAQyDI5ViPUAp6fxEYVZe47+kYjTbOM
	 yMwRvlkEAKHmn5XXY7XU1lC4zKVMIVASxK0QaLZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgERQVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbgERQVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:21:43 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE40F20657;
        Mon, 18 May 2020 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589818903;
        bh=Hy6eh4EEN/gX8lLoYHqML6egri7+0PB5MVzlAu/UEdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URW+jr2/ij4OHUH3l1dYu0vEOAqVOp3f/xKs+g59bwgrvslaqrGimYslXAPlRJ5uO
         BZJ87Zco5GGC7EpYcrpQJ/tsFvA13x3Hw50J9OIFYCUx508WirF356eMx82KqXmjdM
         hOD3+MCnp5SY1xYt529jr947ggHOscOMeJKAQYho=
Date:   Mon, 18 May 2020 11:26:29 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: Replace zero-length array with flexible-array
Message-ID: <20200518162629.GC9868@embeddedor>
References: <20200507185710.GA14910@embeddedor>
 <932086.1589814864@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932086.1589814864@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 04:14:24PM +0100, David Howells wrote:
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied to keys-next.
> 

Thanks, David.

--
Gustavo
