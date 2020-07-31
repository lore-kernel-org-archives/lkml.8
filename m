Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5558EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274C82245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596196641;
	bh=+k3lFtYGhDnloybocGoXeHOCVdx05t4BuYuTBWRbY8k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=nSmKPiQy+zlElng4Zff3NyDHRPCpwkcZMZTrTf3+HJyCBNs2fR5Zlh1tEJNQUv7Ss
	 hq14b8upwGak2NRLPNeQzoHi2Lf40jkt7TnPAMVA8ZoMymFYOP8QtIeW0X6TuwKKIL
	 NKGYOo7HGOdJsV8pQTBnmW/CJUbqKHC0+HjzZxo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbgGaL5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732689AbgGaL5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:57:19 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30952245C;
        Fri, 31 Jul 2020 11:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596196639;
        bh=+k3lFtYGhDnloybocGoXeHOCVdx05t4BuYuTBWRbY8k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=I/U5X4ann1uOLkPXYvcX5ePUiDBHlhMCR+wxShGSNt3JZrl9GLDjd/Qz/F9QwbyiE
         kRmHHFytj+OXysKHDnnHbstpFVOesoPhMql6z3xtr8WNBSfUwD7BB1n2uzgEUVNmfb
         fxB1+fvihvnCQomBRiVmpDGwrOveHHUnQcAT8z/M=
Message-ID: <8e87954aa5d04dd25330afd68b396ef40ff53398.camel@kernel.org>
Subject: Re: [v2] ceph: use frag's MDS in either mode
From:   Jeff Layton <jlayton@kernel.org>
To:     Yanhu Cao <gmayyyha@gmail.com>
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 31 Jul 2020 07:57:17 -0400
In-Reply-To: <20200731082513.11806-1-gmayyyha@gmail.com>
References: <20200731082513.11806-1-gmayyyha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-31 at 16:25 +0800, Yanhu Cao wrote:
> When doing some tests with multiple mds, there are many
> mds forwarding requests between them and then the client request
> is resent.
> 
> If the request is a modification operation and the mode is set to USE_AUTH_MDS.
> Auth mds should be selected to handle the request, and if auth mds for
> frag is already set, it can be returned directly without the logic behind it.
> 
> But the current logic doesn't return directly because the condition
> 'mode == USE_AUTH_MDS', and sometimes frag's mds is not equal to
> cap's session mds, which then causes the request to be resent.
> 
> Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> ---
>  fs/ceph/mds_client.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
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


Much better! A good changelog is as important as the patch, esp in code
like this that is quite non-obvious.

Merged into testing branch. I did clean up the changelog a bit before I
merged it. Please take a look when you have time and let me know if you
think I got it wrong.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

