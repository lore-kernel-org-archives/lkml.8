Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55F3C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EDE2072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588078860;
	bh=5Ir3UpjZ3kYs3+3drjIzMAkoscWBNVFvMX3aVN4pc+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R/4zIALZEZTU0tvZ6wxm/PyvA1rxPO0t6C4bfahxT2Qr1Y1SqC1m1R+Q7aOY00B8J
	 yk5ZCa8FT4VNtYIZalzMGK2cxn6hb3sl+lQGoEYJ9qidsQoeIb8Re70+aRxRvii0+G
	 6HV186WNteGtcobFE8BgQOLRqhlX5yhTHGY0D7Xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgD1NA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgD1NA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:00:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0CC206A1;
        Tue, 28 Apr 2020 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588078858;
        bh=5Ir3UpjZ3kYs3+3drjIzMAkoscWBNVFvMX3aVN4pc+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qa/2omsCXT/ZlQ0YBCv5wPm+ofuanYYMhcSrp+mEykw1fVmxANjAoArcEjNk/ilKl
         lGkYvnHaULq1RdiKacK7Ebkf+CZBVtEdW+aSvZiw+QM+ivkYX7IwNc7c5jjkm1Rnix
         kgRKb16/me63EjWFnTqd1+tOQfO/DS0J3t5PGYHs=
Date:   Tue, 28 Apr 2020 15:00:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Youngjun Park <her0gyugyu@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, her0gyu@naver.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fixup redundant indentation.
Message-ID: <20200428130056.GB1302692@kroah.com>
References: <20200424155334.17053-1-her0gyugyu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424155334.17053-1-her0gyugyu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 08:53:34AM -0700, Youngjun Park wrote:
> From: Youngjun Park <her0gyu@naver.com>
> 
> Signed-off-by: Youngjun Park <her0gyu@naver.com>
> 
> fixup redundant indentation on the label.
> ---
>  fs/kernfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

signed-off-by needs to go last.

And this fix is not needed, the existing code is fine.

thanks,

greg k-h
