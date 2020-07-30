Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF1CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B5920838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596127569;
	bh=sjUWVqnlQSPnCmcVzA42xZKTz0MB5WjOwvqExeXK3mo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=zU3y96EgQaIX+45fF7PqEpBDDk70VPndzZuLHs96TlVuO9u4ufNqACDTucn3vsZBB
	 oaJNYc4vkfF1YQ74aPk3W6YQaHg5Q/nIjy7PR0JyPHrZ0N2Q1VMaJ59CYvdKI3217G
	 heMrR71UfdwreTy1kSc+Gs+B8Ts/XNimtT+KFtP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgG3QqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbgG3QqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:46:07 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85D87207F5;
        Thu, 30 Jul 2020 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596127567;
        bh=sjUWVqnlQSPnCmcVzA42xZKTz0MB5WjOwvqExeXK3mo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=zeVcJuWMC8bamVJMQkvT6IfOjFGZuWxs2cr/6aNCxkH2resEQjdycMwMAncyVobfy
         05iueRVkIJNhyHWDGkEA8xD92ellgYMZpHxV4vkiB8F3niObue+iLH63HT5jZFyBDR
         /htjNTIAm5BL8bNF129w25bbpTsYCYvrJHMOV5fU=
Message-ID: <e9c69117a1ce870c2a96565d2a2d64d066a6604f.camel@kernel.org>
Subject: Re: [PATCH] ceph: use frag's MDS in either mode
From:   Jeff Layton <jlayton@kernel.org>
To:     Yanhu Cao <gmayyyha@gmail.com>
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 30 Jul 2020 12:46:05 -0400
In-Reply-To: <20200730112242.31648-1-gmayyyha@gmail.com>
References: <20200730112242.31648-1-gmayyyha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-30 at 19:22 +0800, Yanhu Cao wrote:
> if frag.mds != cap->session->s_mds, the client's req will be resent.
> 
> e.g.
> 
> file: mnt/cephfs/dir03/dir003 (0x10000000003)
> ceph.dir.pin="1"
> 
> echo 'aaa' > /mnt/cephfs/dir03/dir003/file29
> 
> kernel: ceph:  __choose_mds 00000000ca362c7a is_hash=1 (0x7c768b89) mode 2
> kernel: ceph:  __choose_mds 00000000ca362c7a 10000000003.fffffffffffffffe frag 0 mds1 (auth)
> kernel: ceph:  __choose_mds 00000000ca362c7a 10000000003.fffffffffffffffe mds0 (auth cap 00000000679c38e2)
> kernel: ceph:  __choose_mds using resend_mds mds1
> 
> Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> ---
>  fs/ceph/mds_client.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

I think you're right that there is a bug here, but this patch
description is not terribly descriptive. Can you explain the problem and
solution a bit better?

A good patch description should walk me through the problem and your
reasoning to fix it. Why is this wrong now, and how does your change
address it?

Thanks,
Jeff

> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index a50497142e59..b2255a9be7c0 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1103,8 +1103,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
>  				     frag.frag, mds);
>  				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
>  				    CEPH_MDS_STATE_ACTIVE) {
> -					if (mode == USE_ANY_MDS &&
> -					    !ceph_mdsmap_is_laggy(mdsc->mdsmap,
> +					if (!ceph_mdsmap_is_laggy(mdsc->mdsmap,
>  								  mds))
>  						goto out;
>  				}

-- 
Jeff Layton <jlayton@kernel.org>

