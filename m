Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32F2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14A920708
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592815756;
	bh=7RBxNqTSgkHRzfNfoXTX5jNC+BHeai6UfzTzh7p4E84=;
	h=In-Reply-To:References:Subject:From:To:Date:List-ID:From;
	b=Y/UKsqhzryY0TTuYg3FlzhjQ3dTj2EJ7CMtyhWQ/j6o1yj1wDvQ/YhtJh6GDW7Fgr
	 g3gdsuCEG75eVM1jcrirQNGaEIltSKldlAZ1EYntL8bbMvOd9bDTSTVg6HylmTObdL
	 cw8tIyusdl7MWxkUridMU2KNsaAYwjfmO+SzOJG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFVItP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgFVItN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:49:13 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C26120578;
        Mon, 22 Jun 2020 08:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592815753;
        bh=7RBxNqTSgkHRzfNfoXTX5jNC+BHeai6UfzTzh7p4E84=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=CHwGVlwsnrwnYg/S7D71exA5aaVXsfZs9O85EGzpNE6NksMxb853JGNMxpgHxzv1p
         tMvkU/1aGkQMuRoF6X91MtRQyZjtmJUU7Uja7QfaJAog4XDnNgKJosUWz+gaGTE2yV
         +RHEy3PyceW+myO/ONclolAd3t87Q651W5XQlBMI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1592800092-20533-3-git-send-email-sivaprak@codeaurora.org>
References: <1592800092-20533-1-git-send-email-sivaprak@codeaurora.org> <1592800092-20533-3-git-send-email-sivaprak@codeaurora.org>
Subject: Re: [PATCH V8 2/4] clk: qcom: Add ipq apss pll driver
From:   Stephen Boyd <sboyd@kernel.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        sivaprak@codeaurora.org
Date:   Mon, 22 Jun 2020 01:49:12 -0700
Message-ID: <159281575255.62212.17572491818970058801@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sivaprakash Murugesan (2020-06-21 21:28:10)
> The CPUs on Qualcomm ipq based devices are clocked by an alpha PLL.
> Add support for the apss pll found on ipq based devices which can
> support CPU frequencies above 1Ghz.
>=20
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---

Applied to clk-next
