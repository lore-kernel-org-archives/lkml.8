Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111CDC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D740922464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581068776;
	bh=ZRczVq8huS30y5na4+I2se7v9Uv/Sjaw+uD78GP3QtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SwzRbs2DfHN4Af71OHCekht0xgVR5kJ5ROqs1e18rUASVNR+Xt+/+J4E8JzuA4nO5
	 FvNsmbsR2TpQLhTBeXErnv93qdbXPN9zyAsjXERbvuI1jqjvJNl+Wd0vnTQ6gQWrwo
	 +kbiRlzmo7xHWhh7qhKHzsGTYyQmRBmtQSrA5Xbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgBGJqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:46:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgBGJqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:46:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC4C722314;
        Fri,  7 Feb 2020 09:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581068775;
        bh=ZRczVq8huS30y5na4+I2se7v9Uv/Sjaw+uD78GP3QtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fHgfkjw0Ypl+1TcQRFuzJAfU1WwSx87eqQZZ8FgBcbTay1WBHfcRR58zgp/Eu6SdL
         +w/EeOG/Bc05fx1OKZKACJoYxSo36OFwHANIQTblgVou81ATSucC/Sv5IB4KSS4IBD
         F/tKrKJmPUKtQTecJlUUQkmhLXDiuM1WLieFnuJo=
Date:   Fri, 7 Feb 2020 10:46:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 02/22] staging: exfat: Rename variable "Month" to "mont"h
Message-ID: <20200207094612.GA562325@kroah.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
 <20200127101343.20415-3-pragat.pandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127101343.20415-3-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 03:43:23PM +0530, Pragat Pandya wrote:
> Change all the occurrences of "Month" to "month" in exfat.

Your subject line is a bit "odd" :(

Anyway, can you rebase this series and resend only what you want to do
here instead of me having to randomly pick out different parts?

thanks,

greg k-h
