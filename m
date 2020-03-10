Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD79C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9E1222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583877509;
	bh=PplOYQqEmWIiTN9MSGofr3Cpe2UGMzUlC3Gk0ty0kAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MhY6hM97GhWlCNSdRCeD4XcEr1vjSHuIRqjHToUBGHvSeGwCNKc9kDYJmy8hUosfS
	 45ly1KVWZWBTvKrkf4DFXqJFcM4QLxF9QcvdvdWoeqP/DxkyFBGLYrA6JHbB/6B0fX
	 sbWVh6maeeKqXnFrA8HeaGxEXIuVIeub/QzwZZnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCJV62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgCJV62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:58:28 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD4921927;
        Tue, 10 Mar 2020 21:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583877507;
        bh=PplOYQqEmWIiTN9MSGofr3Cpe2UGMzUlC3Gk0ty0kAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vjUc4r/iYALDocXbYw7hovmUARxxENdgs3DvpnGSjlaTWz4uvQaqcAy/H9REhRY9i
         8kFoxG+HgXiYj52Uwo1xRE5isHdIy7x7Tiw3bxclGDHEwgw5uO+4KVC6eUp6lOdAtV
         aI6JleLE4M5zdp4uhhJYXYo5IA1sPGdCk14SQlsI=
Date:   Tue, 10 Mar 2020 14:58:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alex Elder <elder@linaro.org>, David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] bitfield.h: add FIELD_MAX() and field_max()
Message-ID: <20200310145825.6ddb3797@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20200310212938.GA17565@ubuntu-m2-xlarge-x86>
References: <20200306042302.17602-1-elder@linaro.org>
        <20200310212938.GA17565@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 14:29:38 -0700 Nathan Chancellor wrote:
> Without this patch, the IPA driver that was picked up a couple of days
> ago does not build...

=F0=9F=98=B3=20

Yes please, Alex could you repost ASAP with [PATCH net-next] subject
and CC netdev to get it into the netdev patchwork?

Please also make IPA:

	depends on (ARCH_QCOM || COMPILE_TEST) && 64BIT && NET

Otherwise it's really hard to make sure the code builds.
