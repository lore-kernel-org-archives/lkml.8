Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A081C43333
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F374120757
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584748890;
	bh=gFghtmuT5b/qelH+xNfJE25I+zds6yg9fOMrztNSUVg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=xYdjWUYbuQCxgVL83zE0rE3gXltFqUZjc5YEGhCqEXlGT1DKo9NR8xz3QuyKFhdyv
	 u3KF7CGoxFtnmgdL2Gq8HM2liHWMrx5g4mPEq7pU6ZOf/Ma4fyIWEDfyca0X3c4tYn
	 tyqaKUh4DHbYYG75SGpMevUZWr2JqT1aWnWbyxLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCUAB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUAB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:01:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F62E20753;
        Sat, 21 Mar 2020 00:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584748888;
        bh=gFghtmuT5b/qelH+xNfJE25I+zds6yg9fOMrztNSUVg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NvBmkcIUHg/25Bx29s9QEEYVHYRHcyqaSv1S+FAqCVbvg8LpVHBmtPpqdXoqEuS0k
         V0ZuVOjb7z7X7YHgcQZ1PrvA0c4OFfE2oxSkzViorapMqM91uVwF0rhSIJD71TXJj/
         ygjB14l4Fp6dPLWWJ3aJcFaKgEMie83n7QCNPSrM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584457893-40418-3-git-send-email-zhouyanjie@wanyeetech.com>
References: <1584457893-40418-1-git-send-email-zhouyanjie@wanyeetech.com> <1584457893-40418-3-git-send-email-zhouyanjie@wanyeetech.com>
Subject: Re: [PATCH RESEND] clk: Ingenic: Add support for TCU of X1000.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
To:     linux-clk@vger.kernel.org, zhouyanjie@wanyeetech.com
Date:   Fri, 20 Mar 2020 17:01:27 -0700
Message-ID: <158474888730.125146.13229900040153582170@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhou Yanjie (2020-03-17 08:11:33)
> X1000 has a different TCU, since X1000 OST has been independent of TCU.
> This patch is add TCU support of X1000, and prepare for later OST driver.
>=20

Ok. I can just take it.

Applied to clk-next
