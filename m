Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E57C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9B72072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591814285;
	bh=h0IuiUWUKsiSNDHyKOYq9b8cM+vZUVCJEUixoQ/k2rg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JrDzqcLTfd3pTTYcfvaeyh824JmkjfOGpE3wYXn/DJExRvUbDXrQ2b57ZOhQ80rAr
	 dzg3N+eFW+PR28/wadOrCPjErwEqdOc+JSWmvR/r4C09DgTjGJ9p+Y8oEYeDvDyRIC
	 SxV/uG5tSTiXh5yxHcWf9jZV0TMv4M4d/Wpj8+K0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgFJSiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgFJSiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:38:03 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66282070B;
        Wed, 10 Jun 2020 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591814283;
        bh=h0IuiUWUKsiSNDHyKOYq9b8cM+vZUVCJEUixoQ/k2rg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=crnAjX31z8TIGe8a8jlhWvGoUJ80oBYc32jpstfZIWEhIXbTU6AoyQeson/GZ45K+
         AIafZtK1wduXHEiig/NuBi1xoaTT/kzoEw8AVJtaNTWi+H0IuQteYb/npwLWK6iqZt
         RNfn8h0cmvQAi1wdm2hdirquOrydwpvJPNi54DKM=
Date:   Wed, 10 Jun 2020 11:38:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Use __scm_install_fd() more widely
Message-ID: <20200610113800.5d7846ce@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <202006101001.6738CA0@keescook>
References: <20200610045214.1175600-1-keescook@chromium.org>
        <20200610094735.7ewsvrfhhpioq5xe@wittgenstein>
        <202006101001.6738CA0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 10:03:03 -0700 Kees Cook wrote:
> If 0-day doesn't kick anything back on this tree, I'll resend the
> series...

Well, 0-day may find more, but I can already tell you that patch 1 has
a checkpatch error:

ERROR: "(foo*)" should be "(foo *)"
#149: FILE: net/core/scm.c:323:
+		(__force struct cmsghdr __user*)msg->msg_control;

total: 1 errors, 0 warnings, 0 checks, 131 lines checked

And patch 2 makes W=1 builds unhappy:

net/core/scm.c:292: warning: Function parameter or member 'file' not described in '__scm_install_fd'
net/core/scm.c:292: warning: Function parameter or member 'ufd' not described in '__scm_install_fd'
net/core/scm.c:292: warning: Function parameter or member 'o_flags' not described in '__scm_install_fd'

:)
