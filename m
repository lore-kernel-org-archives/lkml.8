Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CF5C54FD2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC4820714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585103634;
	bh=AvA8oO+nGO+Fqj87/wMvXZnjbd/focwYI0y4gQoIMQY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=h20o8zzY1lj8Iy3w2u/NBIUNDUGjZme/NsAlXTlqMwa4xFbcezev9ebEv3g0uwcDb
	 v6RTk0Ul6iW2TJ91PyUqZXbTmLplrS2s/m6rG+/UtC9WHQREXdLnA8pBqI8bmCLQXu
	 n5jv/pSdUQBxYWg0tj/d7A+88lWOsCFlRTRUgFMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCYCdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 22:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbgCYCdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:33:52 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F79C20724;
        Wed, 25 Mar 2020 02:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585103632;
        bh=AvA8oO+nGO+Fqj87/wMvXZnjbd/focwYI0y4gQoIMQY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=2M8zExUiDz1eH1VoOlxZbWnIP0FDsiEqv2m4PihQUNYsLv8FBzbKFFTXvBwMoyKAv
         M+KjgBzqXJZIvwVGy/OC+wcuNN+Xtci6OvoASZJ72h/hyq84NSBOQKfukABY/fmzn/
         frDOO7HB5VdXRXJeMIQ55/LsHK+faL+l+MRLpTTc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309221232.145630-3-sboyd@kernel.org>
References: <20200309221232.145630-1-sboyd@kernel.org> <20200309221232.145630-3-sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: qcom: rpmh: Drop unnecessary semicolons
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Tue, 24 Mar 2020 19:33:51 -0700
Message-ID: <158510363123.125146.1108786142813393278@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-03-09 15:12:32)
> Some functions end in }; which is just bad style. Remove the extra
> semicolon.
>=20
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
