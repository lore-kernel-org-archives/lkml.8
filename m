Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799BBC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541A7207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597759908;
	bh=Vqi/42Mlz96SYAOO6+KKIDxvCtnpMfrrWJ/Z01/wrbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u5WXcUqAJDmgKcJpP1qlMvj2lHDWnNasUs0yYGzLMGmtlipqdVizrKNjR1jTuq55W
	 5ymQ1am+imQy75F/IP4ee2Pu8pC/JrDLhxybuWlJd2feNDC4dwoUW2xqCfyXe4HJwC
	 9DHuJE++zlgjkFYvWg+VO0mhCS6Cp62B8YRIAoPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHROLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbgHROLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:11:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C3C207DE;
        Tue, 18 Aug 2020 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597759904;
        bh=Vqi/42Mlz96SYAOO6+KKIDxvCtnpMfrrWJ/Z01/wrbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPuaUiw6KplZId5dUjXhdwWgQwwK/Z334U0FwESa12br3aOOSsMxlwPMDclNcLlYi
         K0tZJRbGHGIpFvz9GkSi4lqC7gEamqwSbICUg4iLn1tl74sZE3ZHs0NmMEBoj7eZQC
         2bf8/BRC+n67kKGaAtnrM8vX3Izke6aOjEbWgijc=
Date:   Tue, 18 Aug 2020 16:12:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomer Samara <tomersamara98@gmail.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Riley Andrews <riandrews@android.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 4/4] staging: android: Add error handling to
 order_to_index callers
Message-ID: <20200818141208.GD562377@kroah.com>
References: <cover.1597602783.git.tomersamara98@gmail.com>
 <c653c468e0c3044b10df375e8245e5d50634a7fa.1597602783.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c653c468e0c3044b10df375e8245e5d50634a7fa.1597602783.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 10:31:22PM +0300, Tomer Samara wrote:
> Add error check to:
> - free_buffer_page
> - alloc_buffer_page
> after calling order_to_index, due to converting BUG to WARN at
> order_to_index.

You are fixing a bug you caused in a previous patch, not good :)

thanks,

greg k-h
