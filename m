Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD42C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD7B206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581527050;
	bh=oyNik+kJ34F4CRt3s9kmd1lzGzTnEXIy5TRUWtDfzTw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=nWlF8LGpa2or5mYOIksTP4XS9bxsoPE5LSND6LREH1SSvEgUT+HLYQzDw5iMDYTWS
	 Trbq0SQzjG85trnjAd0jvlUEAMjQXHXkeHGfIgrRHyOeuQR9+I0DbBIpCx2E68ijXh
	 8AN9yMpZlze9trSKVQdLAkd3aBt0PDLjVMNiAn18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgBLREK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:04:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLREJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:04:09 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30F520714;
        Wed, 12 Feb 2020 17:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581527049;
        bh=oyNik+kJ34F4CRt3s9kmd1lzGzTnEXIy5TRUWtDfzTw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DuSGu2uYbxs3QsW/RyTokgR2zVGlVgsNU756y1Xy3UvbO9M+m2uolNAvKSPEkGMyI
         D6D+a0Wm4djCyMclDGshdC8iO0O2sKcv8eTpucztksVBWMqcW/ARQNZMGEDb4S/m8I
         aD9eGgGCHtdfudtNX495WlQWhpmCXaoQhcRI134E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212101736.9126-1-geert+renesas@glider.be>
References: <20200212101736.9126-1-geert+renesas@glider.be>
Subject: Re: [PATCH] powerpc/time: Replace <linux/clk-provider.h> by <linux/of_clk.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Date:   Wed, 12 Feb 2020 09:04:08 -0800
Message-ID: <158152704814.121156.18379102281375554988@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 02:17:36)
> The PowerPC time code is not a clock provider, and just needs to call
> of_clk_init().
>=20
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

This has an ifdef around the of_clk_init() call. Can you remove that too
given that we stub it out in the header?
