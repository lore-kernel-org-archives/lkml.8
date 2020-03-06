Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6431C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E0B20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583496824;
	bh=qrjGOZLa4Lp6Zr15HcoiifExkEM//CEZFS/Eyg7eolE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=xd3sz6XalgDHzDtG+2fs+3k0vSGvpinLJ1m50CBj1NuJHdKIeRdJVMlFydHvahhPM
	 +QRlxY3sm7yWeTvxoBmAX+PtdsfDJhATYPsMNbhM2eK8FObL4zrZytd3UcATNApolR
	 FhTFNxjKSMawZtFIvCbvRgWFzCjfzM20ISE+TXqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCFMNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:13:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCFMNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 07:13:43 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B82D2072D;
        Fri,  6 Mar 2020 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583496823;
        bh=qrjGOZLa4Lp6Zr15HcoiifExkEM//CEZFS/Eyg7eolE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Wwv10ATU0KcOHrfRY1pSKnH/t9BjEtwdk4f1JMQQtjcEgRN2M30AC5L+FF1dvdXcN
         Ol18A62LgESFeW9iUyQuEnqK0ABevGygQrS+UINMKguF+etrW/ctxPZXuCDz+7FhDq
         HbmGpAEIfxZUOpIUuz+QoctO1X0ILQXDRjxaoiic=
Message-ID: <f7318d47df2074a7a00ea3a8580bc973a8c0b206.camel@kernel.org>
Subject: Re: [PATCH] fs/ceph: return errcode in __get_parent().
From:   Jeff Layton <jlayton@kernel.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 06 Mar 2020 07:13:41 -0500
In-Reply-To: <1583458460-31917-1-git-send-email-hqjagain@gmail.com>
References: <1583458460-31917-1-git-send-email-hqjagain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-06 at 09:34 +0800, Qiujun Huang wrote:
> return real errcode when it's different from ENOENT.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  fs/ceph/export.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index b6bfa94..79dc068 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -315,6 +315,11 @@ static struct dentry *__get_parent(struct super_block *sb,
>  
>  	req->r_num_caps = 1;
>  	err = ceph_mdsc_do_request(mdsc, NULL, req);
> +	if (err) {
> +		ceph_mdsc_put_request(req);
> +		return ERR_PTR(err);
> +	}
> +
>  	inode = req->r_target_inode;
>  	if (inode)
>  		ihold(inode);

Looks good! Merged into the ceph-client/testing branch and should make
5.7. Thanks for the patch!
-- 
Jeff Layton <jlayton@kernel.org>

