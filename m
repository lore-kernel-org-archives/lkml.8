Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F3EC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709F42072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584746869;
	bh=ASS//GvAtVvdHk6mIdTRDSE9uGqREpyDkhRDo0uFdus=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Y7gAM65L2mmL9ehKCjrunCp82ZihJDPyfoSyJFL3LnqPq3F0ls8YzGkDDcppB6DMQ
	 u81WM28lkxX0tLTuFedu5V5d/ygpIdSN9IjWsN3JFQnfChmR0Z9pMQSNk58XZoDKtl
	 0VvY/KlvSRHYs5pa4SLaebtotmGdae+s1H0tKsDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgCTX1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTX1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:27:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 853812072D;
        Fri, 20 Mar 2020 23:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584746867;
        bh=ASS//GvAtVvdHk6mIdTRDSE9uGqREpyDkhRDo0uFdus=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kOOtWUuijfJYu4AZjrCwsPeC7JIG9KTRzkz72veEvssf4XQjy285RzhzNTvtYWIlr
         10XrkZAR5ZXJldw2rfVI4HwRZvGADH7F6NRhU9OcSEdAg5omvBuvobP2HQ++2A06Qk
         7EvHdQh+cTfn5HB26jj59KeBVgRaQ2uV7MjduX3s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584596131-22741-1-git-send-email-tdas@codeaurora.org>
References: <1584596131-22741-1-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v7 0/3] Add modem Clock controller (MSS CC) driver for SC7180
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Fri, 20 Mar 2020 16:27:46 -0700
Message-ID: <158474686671.125146.6056513234853643003@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2020-03-18 22:35:28)
> [v7]
>  * Fix Documentation YAML issues reported.

Please pick up Sibi's tested-by tag next time.
