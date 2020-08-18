Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14E7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C582D21734
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597744213;
	bh=yHf1nMj3qSYZwUigpJ5j0pYaeeJWLk/yS+cy6ITwANY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R8J1YwPRJh8Lx13O/vvRz/wPM+URGwZMGmrXhoNE/Dr+eRf7/toLGxAuWPZRggqVv
	 TkIxwLcjsx3MvhucxYjIVFl4Bgm+qv2TILrzc+GsWZxihb+Aw+EOiko8UQqO8qBoTT
	 +CmT4xc3j+/qDAG1Y1BgDuMAt8HdTcreSTs4ETHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgHRJuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgHRJuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:50:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA2C6206B5;
        Tue, 18 Aug 2020 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597744211;
        bh=yHf1nMj3qSYZwUigpJ5j0pYaeeJWLk/yS+cy6ITwANY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=liTMIz6hJDZRUcSkh07kCLC8p+qLdxZhE7fdaNfCrfxOo5TSNthAN8tgGDUh8Lrtm
         bIhACY4MVrYo0IYYuil/PaL0do07nGkC9u2NDHNTfxHpfRuu58iNwhQ4j4lH4uxHSA
         SoC2ELSnGZAwWUWDfFDt2AWQZ0RGrI3VktJ3M9kE=
Date:   Tue, 18 Aug 2020 11:50:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomer Samara <tomersamara98@gmail.com>
Cc:     devel@driverdev.osuosl.org, linaro-mm-sig@lists.linaro.org,
        Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 0/4] *** SUBJECT HERE ***
Message-ID: <20200818095035.GA56916@kroah.com>
References: <cover.1597742228.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597742228.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:17:08PM +0300, Tomer Samara wrote:
> *** BLURB HERE ***

Really?

And your subject line could use some work too :(

