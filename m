Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12440C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE46206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550730;
	bh=SagTHuxEwnio4j42XiH0Rt3krAe38n1UYehH5PgY31k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=JIDVkdhoo+iI062X0iUqf/OAbluBTER4RMg4EYC0EPADOMjdNw0st06q+3FkpvCPX
	 +j7otWtVBJxZc3+Ss3/Ex38bHN2oJF0wh02anSFFctQiihysHz2O9jKBQGTzjfABe+
	 Gf7zgs730oGk/ZNNAUVN5qB1ySuoX018Rt1DZ8JU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgBLXiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:38:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:57014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLXit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:38:49 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 284F020578;
        Wed, 12 Feb 2020 23:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550729;
        bh=SagTHuxEwnio4j42XiH0Rt3krAe38n1UYehH5PgY31k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YPEObhMFSwfNdyQqb/mJEF2rN37HkVHxltxyOpKOv9MP09LT1ZxqXtsCfdgZfoxhq
         2hjZk6Si5PVpKissE7zvdsA30Bq1tsJPJN9/XOGVXkMCMImFZtklBrjiiEe7Y2sZBc
         GICzONDqLpV+MXWxkbtiKBKQ64lJu4SMKpnJvd8I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200121233349.28627-1-pakki001@umn.edu>
References: <20200121233349.28627-1-pakki001@umn.edu>
Subject: Re: [PATCH] clk: samsung: Remove redundant check in samsung_cmu_register_one
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kjlu@umn.edu, Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     pakki001@umn.edu
Date:   Wed, 12 Feb 2020 15:38:48 -0800
Message-ID: <158155072841.184098.6053108532542917536@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aditya Pakki (2020-01-21 15:33:49)
> Consistent with other instances of samsung_clk_init, the check
> if ctx is NULL is redundant. The function currently does not
> return NULL.
>=20
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---

Applied to clk-next
