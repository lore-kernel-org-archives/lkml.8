Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBC0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5A822BED
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919127;
	bh=9oYax7Vp/sAADx+saTCkAJutmFw9MX576JS3dAW94qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ruFeMhueT2Hek1tjh2bxPERjXKX+DcMRRggslyqn6Y2UMvhm0UHMSfxlLU9zO82Pi
	 tfbt94AUYLASQN+cETcFS8LUaF6yY/CHv8iOEO1ei4GIqSNDJareEuDtonq9hh6LIz
	 Wdpd2uLHTFF2iA20U7FlKAbEvE6UbNdizuHCy+5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbgHTKZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730638AbgHTKZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:25:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2BEB20738;
        Thu, 20 Aug 2020 10:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597919104;
        bh=9oYax7Vp/sAADx+saTCkAJutmFw9MX576JS3dAW94qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v49FYdt+kCIo6yhXddlU3h1I6OicKBQuGqQ3W79GZIj9LChc1S4y8caYW1CC2haEj
         dmqcZQjru+Pd1WrjLObbmK/Z8/g70DH9g6VYW8SXca9uzXEcHmLAALrsrSiy0RFBsy
         UtXnV1Zc9x+ybOoC4S/ZvkJtcb0xf7+RGfXgJgbo=
Date:   Thu, 20 Aug 2020 11:56:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.8 137/232] USB: serial: ftdi_sio: fix break and sysrq
 handling
Message-ID: <20200820095652.GA1266907@kroah.com>
References: <20200820091612.692383444@linuxfoundation.org>
 <20200820091619.460392380@linuxfoundation.org>
 <CAMgPeKX54WqE0Wc56u6W3M2JwttV=E7sBKmM5eRa5_Mu7m+okg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMgPeKX54WqE0Wc56u6W3M2JwttV=E7sBKmM5eRa5_Mu7m+okg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 11:51:56AM +0200, Johan Hovold wrote:
> This was never intended for stable as it is not a critical fix and has
> never worked properly in the first place. Please drop this one and the
> preparatory clean ups from all stable trees.

Ok, but the "fix this thing" and the "Fixes:" tag really did imply this
was actually fixing something :)

I'll drop it from everywhere, thanks.

greg k-h
