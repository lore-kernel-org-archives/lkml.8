Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FFCC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975AC20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595468810;
	bh=EOiNumAnyPDROTwhdgRiWEqhBuEsUwA+iRDmm7fQ6vA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=d0g46zNJw4p/Sx9ONoVHmEkgvMkVsYLApYSHt0jXr5+VHZJyzHke57gmoSpkEQo08
	 HwD7TMyHCts1NzJ8fEZcG3D38VieQ5svJIm994gI/Mu9zdQlYUtDj1s9jzNWDS0quG
	 NM7DRLzGyUOKClXD/5LkljPhy7WVgqXpOpU2iYXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbgGWBqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgGWBqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:46:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C5562071A;
        Thu, 23 Jul 2020 01:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595468808;
        bh=EOiNumAnyPDROTwhdgRiWEqhBuEsUwA+iRDmm7fQ6vA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bn4kGklbFxPK4hVYFYxebETRtHXzaiUd36F0ast8l4h50GWFRFuqu5h3qLdHoscTo
         Z4BG+ww734vbZlzUc7H57cItlugHtqS3+Y9qghMsND7fxKrecBdHumNZi6jKFLlgwN
         DJXWo5TrTG1PP2Eb0AxY7WAJG4ptEtfiBuaJt79o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200716122620.4538-1-aford173@gmail.com>
References: <20200716122620.4538-1-aford173@gmail.com>
Subject: Re: [PATCH V3] clk: vc5: Add memory check to prevent oops
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dan.carpenter@oracle.com, luca@lucaceresoli.net,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Date:   Wed, 22 Jul 2020 18:46:47 -0700
Message-ID: <159546880794.3847286.3488756691300636071@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Ford (2020-07-16 05:26:20)
> When getting the names of the child nodes, kasprintf is used to
> allocate memory which is used to create the string for the node
> name.  Unfortunately, there is no memory check to determine
> if this allocation fails, it may cause an error when trying
> to get child node name.
>=20
> This patch will check if the memory allocation fails, and returns
> and -ENOMEM error instead of blindly moving on.
>=20
> Fixes: 260249f929e8 ("clk: vc5: Enable addition output configurations of =
the Versaclock")
>=20
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---

Applied to clk-next
