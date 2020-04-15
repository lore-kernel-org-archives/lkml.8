Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C723C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAFB720857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961653;
	bh=ZAn4fVnJ4h8lZBxjSOeAHVxgiPImQxaKF8vbfwxbuBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oil7emkbwOVdZrvbFFyDdH9d+L774vM7gnCIGWddydfcVrcAd1XuceyiD06o+vRzg
	 biZiYFIvMw8b4cW9Rj9jg0zTM94vZYt0Vg9mUnskX+dc1Pj5DyqVT7qeUoDeeaXqEu
	 1ytQy7tO3LJpSAAKm308VSpL/UyAdXB1HEe/+ByM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370844AbgDOOks (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636694AbgDOOi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:38:56 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0355208FE;
        Wed, 15 Apr 2020 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961535;
        bh=ZAn4fVnJ4h8lZBxjSOeAHVxgiPImQxaKF8vbfwxbuBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tY9DqELbHXMpCmMz7SI/RXBBslV4N4wsou2WI3/3UnO+r12JlS/Hw5tBYAhh8CBYa
         VOJeIo9y1326Vwm+Ljt/F8EfjAgXoiV380QX1+aANgr5WJWJ4Ky2OORGjt0IW4Qa6b
         sWpxqqs2ekudjFMLk89UTtCnUiJrPxx8b/tKGReg=
Date:   Wed, 15 Apr 2020 16:38:51 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     rishi gupta <gupt21@gmail.com>
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Correct place to put the new doc for "How to use this driver"
Message-ID: <20200415163851.2e5f96f8@coco.lan>
In-Reply-To: <CALUj-gsRgkEyRe3vubEeWx8ENwEyE+Fzv4bKKDZ+iq3urRG0BA@mail.gmail.com>
References: <CALUj-gsRgkEyRe3vubEeWx8ENwEyE+Fzv4bKKDZ+iq3urRG0BA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 15 Apr 2020 09:25:02 +0530
rishi gupta <gupt21@gmail.com> escreveu:

> Hi Team,
> 
> I need to add a documentation file to let users know "how to use this driver".
> Specifically this one (tty-ttyvs.rst): https://lkml.org/lkml/2020/2/15/153
> 
> (1) I am unable to find any directory where it will fit. This driver
> belongs to Virtual TTY device category.
> Any suggestions where to put it?

Docs focused on driver usage belongs to the admin-guide.

> 
> (2) After putting it is it mandatory to link it to
> Documentation/index.rst as suggested here
> https://www.kernel.org/doc/html/latest/doc-guide/index.html

You should actually add it to Documentation/admin-guide/index.rst.

> 
> Regards,
> Rishi



Thanks,
Mauro
