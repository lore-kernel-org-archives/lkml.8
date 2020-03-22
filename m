Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6391C54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB4D20774
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584876468;
	bh=Zlt25t7XisTrtu+UdnuJ5QG6TBUbTde7SUL83ydeDjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E3O8Y7pg4JAkDwkaIiZ5Z70M7FRfgR0jybxUJzssjKcl9x2jAee2nYKx99L2hI9e5
	 Ki4q6MvybIY94Qc8OHFm7peK5WlmpxTLBiGDmekcExy3fa/Zer/bWSbCKT+MImh4Op
	 qObZbC8ZXRY25Bm8W8N+wuFOxaCpxGCHgA3flsm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCVL1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgCVL1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:27:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BEFE20714;
        Sun, 22 Mar 2020 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584876466;
        bh=Zlt25t7XisTrtu+UdnuJ5QG6TBUbTde7SUL83ydeDjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fm/5Npgl1pGyF0sBACsLEEeeXNojurSvhC1lKABFeruhHdMdEmHj74QyF1cDqq3OT
         eeMrO7OpPpQYOVLGqJrkMFLzrL8/2FSpRf/nIG5jlVWTsiaUjIxKLNFce89CsvHfWt
         oEYX+JwfYlrYBoJIdS1oMpvGiDqUbbRDwqQ7sTXA=
Date:   Sun, 22 Mar 2020 12:27:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH 01/11] Staging: rtl8188eu: hal_com:
 Add space around operators
Message-ID: <20200322112744.GC75383@kroah.com>
References: <cover.1584826154.git.shreeya.patel23498@gmail.com>
 <19950c71482b3be0dd9518398af85e964f3b66b1.1584826154.git.shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19950c71482b3be0dd9518398af85e964f3b66b1.1584826154.git.shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 03:51:13AM +0530, Shreeya Patel wrote:
> Add space around operators for improving the code
> readability.
> Reported by checkpatch.pl
> 
> git diff -w shows no difference.
> diff of the .o files before and after the changes shows no difference.

There is no need to have these two lines on every changelog comment in
this series :(

And pick a column to line wrap on (usually 72) and stick with that.  You
are using two different ones here, and for this whole series, and it
looks very odd, don't you think?

thanks,

greg k-h
