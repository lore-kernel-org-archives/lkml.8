Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640F3C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 01:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED2B2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 01:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595985939;
	bh=atZ9AkzW3Qv3jxfEDY51j0RiPv1nKHAC31IX+cq2vWI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=suGiT9RO8k1TMGl2gGTnkxthk8/jUxprEUn1fgzjAQ3JfjPDtvMVpMMtE5RQsQXrB
	 P/6HHgOJzZrzZjiUhB9yFXjEF4geQxO3j6LsNkLDDg6lKHNtUWbhOJFv9hzESn99El
	 2OnLCROWU0/9HaAP0GF7tqGOfbkOA3U/KU2uTCBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgG2BZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgG2BZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 21:25:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D38A2076E;
        Wed, 29 Jul 2020 01:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595985937;
        bh=atZ9AkzW3Qv3jxfEDY51j0RiPv1nKHAC31IX+cq2vWI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ndTn7GILon9rsTm77a8cOy64DLBd0YU5FtGXMoqNzxdHulhh8sXXJeroo6GsuiSzV
         1T7BTWInoyG7d+R/wjPRWb0Jp2NMruWbIz6O6acT0f8W518vE1/Leo/enM7pdN6svS
         MaDktGTdVG+ALixpd6V0qqolW5ZFHFKp6xUfX5v4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728082857.10829-3-akshu.agrawal@amd.com>
References: <20200728082857.10829-1-akshu.agrawal@amd.com> <20200728082857.10829-3-akshu.agrawal@amd.com>
Subject: Re: [v2 2/4] clk: x86: Change name from ST to FCH
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rafael@kernel.org, Michael Turquette <mturquette@baylibre.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     akshu.agrawal@amd.com
Date:   Tue, 28 Jul 2020 18:25:35 -0700
Message-ID: <159598593596.1360974.1741408050799159465@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akshu Agrawal (2020-07-28 01:28:54)
> AMD SoC general pupose clk is present in new platforms with
> minor differences. We can reuse the same clk driver for other
> platforms. Hence, changing name from ST(SoC) to FCH(IP)
>=20
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
