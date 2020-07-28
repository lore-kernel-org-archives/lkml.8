Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F3C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790F920829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595899167;
	bh=gK7UmM5vfmzppaHiSyye27V0GjCHwq+eJUokyna06nY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=eV68BMB6RXSg43CwC2LZZ3AiQ1YVOL1VehQwVHO/posi9pW9NMmotbcYMgM8sfbDF
	 W0H5TKTPJO79llfXy73IacALxd/xA6hbgynY8uTPd4dlv9mlw25qGg/OpLTdLvnKj7
	 X9cu5JbKciQMsOoFSsipoY/uX/U5VTBjPm3aterk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgG1BT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:19:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG1BTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:19:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A6EC20714;
        Tue, 28 Jul 2020 01:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595899165;
        bh=gK7UmM5vfmzppaHiSyye27V0GjCHwq+eJUokyna06nY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SbEa8qQBBXKO1LrACrTPoleUgKNfKCd0a/SxMzJc6vD9xOTkpHUDylWCUEe1hQyo6
         uKFl3jF+TINnuD1gWb3z7qrFaksbEYQRnVjCBeDnEVeLhmpMuK+j20xD6l5VRAzfQ4
         x8FydSOhNtTikSORMWAVeFgASd0aRNhQTwdu66QY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d4899cde-ac7c-e7a4-5819-59fcacbd3745@wanyeetech.com>
References: <20200630163852.47267-1-zhouyanjie@wanyeetech.com> <d4899cde-ac7c-e7a4-5819-59fcacbd3745@wanyeetech.com>
Subject: Re: [PATCH v3 0/3] Add functions to operate USB PHY related clock.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, paul@crapouillou.net,
        mturquette@baylibre.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>, linux-clk@vger.kernel.org
Date:   Mon, 27 Jul 2020 18:19:24 -0700
Message-ID: <159589916426.1360974.7420398609893038@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhou Yanjie (2020-07-24 21:01:38)
> Gentle ping.
>=20

I was hoping Paul would review but I guess not. I applied the patches to
clk-next.
