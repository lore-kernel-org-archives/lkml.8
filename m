Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0927CC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB882077C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579789592;
	bh=tIH9kVRmgiCYBq9n+Cjnfq7nueNr9o74AznFkX77aT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BWS8kiAYYEOZhpnScSo9foNhqqr8mxqB+VQylI0DQn5GLWyYUDWnNQ8BNRIOG/o2D
	 U9xoxnUsGnuQHI7K1L2xzIRPk+pnE8blTM97AZCrPVDFLm2DqEmckj6/SXvckVSQrh
	 dQ4BdEuC04SUv+0VuzAB1Tbiivyvt+YqralQjoAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAWO0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:26:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAWO0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:26:31 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB12F214AF;
        Thu, 23 Jan 2020 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579789590;
        bh=tIH9kVRmgiCYBq9n+Cjnfq7nueNr9o74AznFkX77aT4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2p4yKzn+otgAbcdUHW6Kv9RnLk/uAfkbpbQIsBtd5yGQgND7M/frK+w3C7D1rw+G1
         BRlBGHkY9MfnDt4TeorwfZ6Eznq9/sU0oPOWAOAYDiNdkH//EdFOBN2Y2i1D7uGTnk
         LC9ZsE7FLtaIUZll34KhW+GKFuZVbRhOzGJRuu6Q=
Received: by mail-qk1-f177.google.com with SMTP id c17so3547913qkg.7;
        Thu, 23 Jan 2020 06:26:30 -0800 (PST)
X-Gm-Message-State: APjAAAV0fuFfP0FYyySTSg9hxBM1iWn7O6HadRGBvVqaE63l8A59TgBk
        jMKEJffERTNeReRqtRrqdX1ZNrT4bpRChxfAsg==
X-Google-Smtp-Source: APXvYqxbguRq1iMCSZT45I7kt/wqfNAl2jdrS71ZmilC4ian7XhK+X38BybkHT5YPoQ7j39q2+2CCOdSWxcAgD8tFxU=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr16251977qkg.152.1579789590015;
 Thu, 23 Jan 2020 06:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20200122135741.12123-1-dafna.hirschfeld@collabora.com>
In-Reply-To: <20200122135741.12123-1-dafna.hirschfeld@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 23 Jan 2020 08:26:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKX3fFQCtH0+Hfkfx09Oz72TJFNm6FRdtGu4P4W0gjTQ@mail.gmail.com>
Message-ID: <CAL_JsqJKX3fFQCtH0+Hfkfx09Oz72TJFNm6FRdtGu4P4W0gjTQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fix warnings in validation of qcom,gcc.yaml
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>, dafna3@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 7:57 AM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> The last example in qcom,gcc.yaml set 'sleep' as the second
> value of 'clock-names'. According to the schema is should
> be 'sleep_clk'. Fix the example to conform the schema.
> This fixes a warning when validating the schema:
> "clock-names:  ... is not valid under any of the given schemas"
>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Fixes: d109ea0970cf ("dt-bindings: clock: Document external clocks for
MSM8998 gcc")
Acked-by: Rob Herring <robh@kernel.org>
