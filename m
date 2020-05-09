Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E79CC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFA624957
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589003323;
	bh=TgS9MtMjz7KXafC7VnNNn066qVO9U1mjiVXyT19oQAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fGBWTE8KuEe2pHSVZizdoL7zSnnwywRpKzcWQrJwF+k7j3LJRkAG6+v4v0EMZDy9p
	 R18s87q53DnaDKIM+LWFy7OtMumjVBf3LZNMRqZ7PZqQkZ5MSULDBRIZ4pFtb84QNZ
	 sWLE62NAOblFBxoJ2PRGtPNyrvDtjjzdIj99dtDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgEIFsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 01:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgEIFsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:48:41 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4696721582;
        Sat,  9 May 2020 05:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589003321;
        bh=TgS9MtMjz7KXafC7VnNNn066qVO9U1mjiVXyT19oQAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xM20/+DG85Z+6OTDG9gd24Y45Hj6TidXgU1TOr6nULERkw/a7Z9P6CZNBSCj/Zov0
         7+3V2YEMeU4pBlKONQ8ENfYWU4hDj8ccij1a5WTHdX7JHnIOkdQKlfkohVh/1PiiUH
         jvv8irKc/qAscAZyrzTFwYSVmHkwHZYMANUd3wmQ=
Date:   Fri, 8 May 2020 22:48:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: lio_core: remove redundant assignment to variable
 tx_done
Message-ID: <20200508224839.050d90b1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200508225810.484331-1-colin.king@canonical.com>
References: <20200508225810.484331-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 May 2020 23:58:10 +0100 Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable tx_done is being assigned with a value that is never read
> as the function returns a few statements later.  The assignment is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you!
