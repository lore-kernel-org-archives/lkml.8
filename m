Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CF8C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 19:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041E82063A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 19:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580586405;
	bh=QOdbLBgNsKPlKhivRd9jBP7VuM30nUSl/VU5X9DdsOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yerpJOs147YDoF6h1bX4WZewbzOGc1f/fmbk/jJ1b+PYZECx0vOhdh0VOkVmxR9b3
	 anlEoTNtTwPKcdicTgnjGVecbz8g3b3PRAoqDu65j7pzFZnMZQOE+tqwSll2vfn07O
	 moUUuoy55qXFez8AhMQbPpTGTVR7mbeSo29qh58I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgBATqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 14:46:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgBATqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 14:46:43 -0500
Received: from cakuba.hsd1.ca.comcast.net (c-73-93-4-247.hsd1.ca.comcast.net [73.93.4.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1303B205F4;
        Sat,  1 Feb 2020 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580586403;
        bh=QOdbLBgNsKPlKhivRd9jBP7VuM30nUSl/VU5X9DdsOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kLQLBDuE21hmogayPuzhaiXG24T67Xds4fpIAhSWqby+mes90yDKTbd8OBNFUeHIA
         Nr2mx8bFT3jJbf7Q5jCApw3qxGrkbyNYWy4V0imZPajkwtXpodjbvhmOpwK8Ya94yC
         ekrMUHAsbSsqBg1oXXNom4Ya/kK9aOm1nTadmLew=
Date:   Sat, 1 Feb 2020 11:46:42 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org, info@alten.se
Subject: Re: [PATCH] MAINTAINERS: Orphan HSR network protocol
Message-ID: <20200201114642.1dc93192@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20200131085919.18023-1-sven@narfation.org>
References: <20200131085919.18023-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 09:59:19 +0100, Sven Eckelmann wrote:
> The current maintainer Arvid Brodin <arvid.brodin@alten.se> hasn't
> contributed to the kernel since 2015-02-27. His company mail address is
> also bouncing and the company confirmed (2020-01-31) that no Arvid Brodin
> is working for them:
>=20
> > Vi har dessv=C3=A4rre ingen  Arvid Brodin som arbetar p=C3=A5 ALTEN. =20
>=20
> A MIA person cannot be the maintainer. It is better to mark is as orphaned
> until some other person can jump in and take over the responsibility for
> HSR.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied, thank you!
