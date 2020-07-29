Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063E0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47272078E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vfemail.net header.i=@vfemail.net header.b="ZG+6AwQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgG2CmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:42:23 -0400
Received: from nl101-3.vfemail.net ([149.210.219.33]:12627 "EHLO
        nl101-3.vfemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731120AbgG2CmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 22:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=date:from
        :to:cc:subject:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=2018; bh=FmncsGltNbBm
        9DrnbETpoZufhhj5tXE7ZJm+sjYOeS8=; b=ZG+6AwQc6INJ7Yvl7GWEGEP4II9M
        fDCwnVelBLcnc4pGN2JabiybdrfNdyMwVFe3i43sw05IjTIpQ0vibjCv8hbjPhmp
        9Wg015n64hilK9h/df02sLQtriemcY1/ZUovJ9qN2Vmt4A0rvR3aJpysiirSz0ug
        yOUI21M8LE8jBPA=
Received: (qmail 93195 invoked from network); 29 Jul 2020 02:35:42 -0000
Received: by simscan 1.4.0 ppid: 93122, pid: 93191, t: 0.2773s
         scanners:none
Received: from unknown (HELO d3d3MTkyLnZmZW1haWwubmV0) (aGdudGt3aXNAdmZlbWFpbC5uZXQ=@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 29 Jul 2020 02:35:41 -0000
Date:   Tue, 28 Jul 2020 22:34:40 -0400
From:   David Niklas <Hgntkwis@vfemail.net>
To:     reiserfs-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: IO lockup on reiserfs FS.
Message-ID: <20200728223440.0fd8681e@Phenom-II-x6.niklas.com>
In-Reply-To: <20200728222041.5d88b2e1@Phenom-II-x6.niklas.com>
References: <20200728222041.5d88b2e1@Phenom-II-x6.niklas.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I should add that in chasing down this bug I have tried all the IO
schedulers available (noop deadline and cfq). Cfq is the one I'm now
using to reproduce this.

Also, I don't know if it makes a difference, but when the system first
starts up it takes 20m to get from the login manager to having my web
browsers restart and get all their pages from online. It might be because
there is a lot of IO going on or it might be that there are several
stalls in the scheduling; just not bad enough to cause a hung task
problem like above.
