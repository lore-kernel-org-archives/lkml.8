Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFA5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0662D208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590627696;
	bh=j1Cwhp+MH8Kk4E8xmJNO9CpZqOY9hYn6fArceRHafsg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=d6LLnLn/ev0PsXXKqwUq41j/TEAEy7N4aJiKXN6L8nXKOrLK1hPSh73OxwHsSy1YK
	 GHnOyPF51Yxd+bgRBJLhwCHH+zbesOxGYFYEr7M3H4WPUIBQuPyR0aZWoxlvfoYZDL
	 +Nbd2oF/jk3IAlm+ny0iytSdEqGJMWHQBYQs1KKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgE1BBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgE1BBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:01:30 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A087208B8;
        Thu, 28 May 2020 01:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590627690;
        bh=j1Cwhp+MH8Kk4E8xmJNO9CpZqOY9hYn6fArceRHafsg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fKvZOu2EuUMlNXBB878WfmTHvvutF+lWcuOHsqfRHhqzY0yAJOBnkjsmGfC9KSQTQ
         mD5uDGJ/iX6JlD31h0zJkNTqDqJKVv2+5JSGvIatEYW3VsEq8aOARMhJf5dsTKRqac
         d5wn6Z9Se3qJ4wS/FfrVAIzqbfKVN6iZKfsQzlUA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200519224151.2074597-10-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk> <20200519224151.2074597-10-lkundrak@v3.sk>
Subject: Re: [PATCH v3 09/13] dt-bindings: clock: Make marvell,mmp2-clock a power controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Wed, 27 May 2020 18:01:29 -0700
Message-ID: <159062768959.69627.47616154297435181@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-05-19 15:41:47)
> This is a binding for the MMP2 power management units. As such apart from
> providing the clocks, they also manage the power islands.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Applied to clk-next
