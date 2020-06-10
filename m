Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB0AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054362070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgFJRQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:16:35 -0400
Received: from foss.arm.com ([217.140.110.172]:33340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgFJRQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:16:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5611C1FB;
        Wed, 10 Jun 2020 10:16:33 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B65A63F6CF;
        Wed, 10 Jun 2020 10:16:31 -0700 (PDT)
References: <20200610122500.4304-1-benjamin.gaignard@st.com> <20200610122500.4304-3-benjamin.gaignard@st.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     hugues.fruchet@st.com, mchehab@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, rjw@rjwysocki.net
Subject: Re: [PATCH v6 2/3] media: stm32-dcmi: Set minimum cpufreq requirement
In-reply-to: <20200610122500.4304-3-benjamin.gaignard@st.com>
Date:   Wed, 10 Jun 2020 18:16:25 +0100
Message-ID: <jhjsgf23kpi.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/06/20 13:24, Benjamin Gaignard wrote:
> Before start streaming set cpufreq minimum frequency requirement.
> The cpufreq governor will adapt the frequencies and we will have
> no latency for handling interrupts.
> The frequency requirement is retrieved from the device-tree node.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

For the cpufreq qos / irq affinity parts:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
