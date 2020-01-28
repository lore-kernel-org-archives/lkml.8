Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6229C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DFE24681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580235993;
	bh=HpDKEw4ez9ANpCfmqhgbfP3kjfeJyCXEo0WCd3PddhU=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=rLIxss7H7+rfut4qr9kqJx8oRXPOebwKC9ZPVsA2oFCFT7R0IE0Fq9SZwMPEmoAEz
	 nbZM7+ZOUwJgfyYKSROoXT+Y6gTfm48xXEC3AcwsbywtrSPJu7zmxJQf457rxbxmRy
	 WLHpB8z5G4A9w+CI/QpJ0HlYyAeBgg79w8XOPiik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgA1S0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:26:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgA1S0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:26:32 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D97A720716;
        Tue, 28 Jan 2020 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580235992;
        bh=HpDKEw4ez9ANpCfmqhgbfP3kjfeJyCXEo0WCd3PddhU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=myEynNm/RirEu6N7wQbKY7ETK7AJUdQXiAIl3RhxKUZO/JwqbERXYkgi00CT+jCaK
         xz0UE7Qcta7siFNATgXAUPrNeET7Yq5E7ecIYtZetcpgd0tj9vF8SNdJhclzUZb+wP
         naPy1tKcXY5GUW/6ZTEbQa57XBJx9rKFFQn0qZS4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200122135741.12123-1-dafna.hirschfeld@collabora.com>
References: <20200122135741.12123-1-dafna.hirschfeld@collabora.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: fix warnings in validation of qcom,gcc.yaml
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, kernel@collabora.com, dafna3@gmail.com
User-Agent: alot/0.8.1
Date:   Tue, 28 Jan 2020 10:26:31 -0800
Message-Id: <20200128182631.D97A720716@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dafna Hirschfeld (2020-01-22 05:57:41)
> The last example in qcom,gcc.yaml set 'sleep' as the second
> value of 'clock-names'. According to the schema is should
> be 'sleep_clk'. Fix the example to conform the schema.
> This fixes a warning when validating the schema:
> "clock-names:  ... is not valid under any of the given schemas"
>=20
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---

Applied to clk-next

