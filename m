Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACED3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BEB3207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590548482;
	bh=PKeeGNOclksKUaWHBSrhXJ7fyOUwrGaqza09aPlc8Zo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=mK+Gzj+lfmhDzQH8zX128NjgWMiFqSgHJx0eWxCKRXkYEukXNw6iQvxiENllNZzmX
	 7j2a6PwcsSRAbEOalE4FjPLnhFvcsJKHYeVp5O3x1yDQD7SIeATAntLWKq5FQyskLd
	 la1XwXZpOSJCt0GD9f5YwY1ECj1/8sTZNi65u7ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgE0DBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgE0DBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:01:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23AE2075F;
        Wed, 27 May 2020 03:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590548479;
        bh=PKeeGNOclksKUaWHBSrhXJ7fyOUwrGaqza09aPlc8Zo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LpLqlZEtn3iwCy0EHeaD0rx8jin8FqRP0OJVT/Ua9byT/3FNDkbAyWWgUbOjXeokP
         MAKMCZDq0I/tXQd+dP7YXvfedAV/0xquzJaicQKuWVoqEMrDLNz2/2g+HsTu6uttNl
         hOKQTpyqkt1/C/FiH3XWqVF56LeLS9OE0GGyIErc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200501205728.152048-1-konradybcio@gmail.com>
References: <20200501205728.152048-1-konradybcio@gmail.com>
Subject: Re: [PATCH 1/3] clk: qcom: smd: Add support for MSM8936 rpm clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konradybcio@gmail.com>, skrzynka@konradybcio.pl
Date:   Tue, 26 May 2020 20:01:19 -0700
Message-ID: <159054847905.88029.7682212879068510634@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2020-05-01 13:57:26)
> From: Vincent Knecht <vincent.knecht@mailoo.org>
>=20
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---

Applied to clk-next
