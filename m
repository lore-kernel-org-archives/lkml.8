Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16405C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBD820C09
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599419684;
	bh=4ARw/WbP7tmmQg2io7rpNXp1S4AArJidVlO9FVGsffw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dh3Io2xfEBcC8pWtsIpJO4BSAulIFFCK+59U8SQAr6jnHCJdfM8fuGv9d2JISC4Q9
	 xoPH7fiOrt2nmyCZ7rrmQdZ9R9RxtLAJKdvkhbR8i0jXJQRvbLJHpn3ufRE0+JLoWI
	 UVnlNVlNt6TvANJHtc4UxNPdC4jXYohQbO/6CGwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIFTOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgIFTOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:14:41 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 124E020C09;
        Sun,  6 Sep 2020 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599419681;
        bh=4ARw/WbP7tmmQg2io7rpNXp1S4AArJidVlO9FVGsffw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IrXODbXMhb8nYAWw0pBeStNni00eoI+8QjbSre+YfPVxdIug55yF/La6aUo/pGWsE
         IfDnaXdeBD5VC6z74XlM4K67LC8dVfS4x2a4S1GZH0W26n68RfS0BwVEhUuSHBs3fp
         lOs6tXSuBs3sORvoof1jtiuKy5gS7SDe6FSdMmgI=
Date:   Sun, 6 Sep 2020 12:14:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Add a missing word
Message-ID: <20200906121439.1f91a4cc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200905183220.1272247-1-j.neuschaefer@gmx.net>
References: <20200905183220.1272247-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Sep 2020 20:32:18 +0200 Jonathan Neusch=C3=A4fer wrote:
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Applied.
