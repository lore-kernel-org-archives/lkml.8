Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B78C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954452076E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584748952;
	bh=OHPvOtNsUG9ufv4YyasMAvod0TxJK97CkI+lWYV4XNs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=jpUFPao6Fr6iiLYqFfvU/sQBfHyy6z1iNxwBZXhDQHoFuq2MKO+OSNNjD0By21pTI
	 VwOhWHSi0MLoIh8+PEdbeLRZUvz4orHW/i49dpJsDkYcyNVIAC0K/dOrnEUECOicVi
	 CYZ0a+YZK+53wlQdwwDBA3uP/0FNB7Pt83/4T1xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgCUACb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCUACb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:02:31 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5F582076C;
        Sat, 21 Mar 2020 00:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584748950;
        bh=OHPvOtNsUG9ufv4YyasMAvod0TxJK97CkI+lWYV4XNs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mKeG/Z9FlEaysyo/6+YwQ419Q2vEIIxPkTeu4d7hiqMcqp+CRg5w2oRAdxAOdpg93
         CScqnaU+HMRG+fwUKo1q5OGSr5skbBr9oIID6ueNTNz2+8gp3cUNtmatsAT3CcsLcE
         27ryLv/xEXQg30TtsqQkkN24ghq2WdAN+YRg4BS8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582215889-113034-3-git-send-email-zhouyanjie@wanyeetech.com>
References: <1582215889-113034-1-git-send-email-zhouyanjie@wanyeetech.com> <1582215889-113034-3-git-send-email-zhouyanjie@wanyeetech.com>
Subject: Re: [PATCH v6 1/7] clk: JZ4780: Add function for enable the second core.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, tglx@linutronix.de,
        ralf@linux-mips.org, paulburton@kernel.org,
        jiaxun.yang@flygoat.com, chenhc@lemote.com,
        mturquette@baylibre.com, mark.rutland@arm.com, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, paul@crapouillou.net,
        geert+renesas@glider.be, krzk@kernel.org, ebiederm@xmission.com,
        miquel.raynal@bootlin.com, keescook@chromium.org,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com,
        dongsheng.qiu@ingenic.com
To:     linux-mips@vger.kernel.org, zhouyanjie@wanyeetech.com
Date:   Fri, 20 Mar 2020 17:02:30 -0700
Message-ID: <158474895008.125146.12417045742769714685@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhou Yanjie(2020-02-20 08:24:43)
> Add "jz4780_core1_enable()" for enable the second core of JZ4780,
> prepare for later commits.

Applied to clk-next
