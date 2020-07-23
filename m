Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A07C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C8120714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595525054;
	bh=n8He92OqM4NMOaTK+dVegiNwVJnHaueaVcLgMEhs3ws=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=G0YzDFROd/aOdz+cTK6lqtiYTieePwy74h9EEYjvLDGSMp6GaQpizc529k4ZNivBF
	 8qIKIgrOFcqal9QLyVBo1n/uItMTi5txs5utC8iMoAeykpxxKrU3L27RSnXc5NoqA9
	 VMUBhOIoKCACg8Ckzal+U0tVyKqXdEMhNNXlZfkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgGWRYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgGWRYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:24:13 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4878D20714;
        Thu, 23 Jul 2020 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595525052;
        bh=n8He92OqM4NMOaTK+dVegiNwVJnHaueaVcLgMEhs3ws=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=b2QUR6Y7RdiKbmLf3KmUa+zkKTXOgAsPsdE1URJ07SZvOkW5X/MqPH+OGJTwPaZHQ
         29tL6G0O8JhoqskvPRIwYyT4QSXcXkrugdqA8iwza37Swc1AtBb+Z+RLHK1XA5Iv2d
         BAqPFhargN7zsuqlleh4DtdxtG11uYGPLbs7G3R4=
Message-ID: <853430a6bb4216a5e4a0d734a18b8401b89e7f4b.camel@kernel.org>
Subject: Re: [PATCH] ceph: remove redundant initialization of variable mds
From:   Jeff Layton <jlayton@kernel.org>
To:     Colin King <colin.king@canonical.com>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 Jul 2020 13:24:11 -0400
In-Reply-To: <20200723152240.992946-1-colin.king@canonical.com>
References: <20200723152240.992946-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-23 at 16:22 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable mds is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/ceph/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 070ed8481340..48f5afb56c91 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -272,7 +272,7 @@ static int mds_sessions_show(struct seq_file *s, void *ptr)
>  	struct ceph_mds_client *mdsc = fsc->mdsc;
>  	struct ceph_auth_client *ac = fsc->client->monc.auth;
>  	struct ceph_options *opt = fsc->client->options;
> -	int mds = -1;
> +	int mds;
>  
>  	mutex_lock(&mdsc->mutex);
>  

Thanks, merged into testing branch.
-- 
Jeff Layton <jlayton@kernel.org>

