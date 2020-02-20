Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD529C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BD02465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582197058;
	bh=PPwnWxzwvNXS74gjMmbqMy1Kx3XA2KRGRfVzxtOXCCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sc1dhb9/10RIk+poscUuPfDI87+4W2UWF0fx/TjSQBppXKHgEkT1F2SY//e3P37oA
	 NfiqUvNooqcww5BQjs3KogPX8mFsvS+DQPuMuizlNf0IkFHd1Kz2uzuU6f+tP7SE5V
	 qrEfwJcls77o6n8zxRyQF2M0Z0oyJeyTqu+t7k/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBTLK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTLK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:10:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37571207FD;
        Thu, 20 Feb 2020 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582197056;
        bh=PPwnWxzwvNXS74gjMmbqMy1Kx3XA2KRGRfVzxtOXCCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0GhvvH31fk/K+Vj/DDEYKjsY7UVLWjQ92i6iNtywbVtUixfYK47KuEXQUkF7rysdm
         mw3bSoDexv6E66NPd+pJyRB22K9WYWIa7ym9s7taQ0iA1xcxTNWUTvofa5aXK0WgjY
         WNQVUjv9xtTqkenknPe+FlnGvYRv+5HNMWms7gis=
Date:   Thu, 20 Feb 2020 12:10:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/9] sysfs: add
 sysfs_file_change_owner{_by_name}()
Message-ID: <20200220111054.GB3374196@kroah.com>
References: <20200218162943.2488012-1-christian.brauner@ubuntu.com>
 <20200218162943.2488012-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218162943.2488012-2-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:29:35PM +0100, Christian Brauner wrote:
> Add helpers to change the owner of a sysfs files.
> This function will be used to correctly account for kobject ownership
> changes, e.g. when moving network devices between network namespaces.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

