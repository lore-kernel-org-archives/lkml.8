Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B31C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FD4221EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587120090;
	bh=lHB1NoiGfUWFSxW01s7mCG3LNiTaqRJg8T1vS2BHcBU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=nwqifs53BRkoz7637tnd/HzxvxCjO5cM/L7fNl3j0HVEkIuuQzvxIMOiS3jiCGBuZ
	 uKYWItY9rh7R81AYgIA5VYIZfGmTt3SV2bds2u2eN4ZYng1vpkVj/ibsyM4XPIUXmi
	 YaBVZCZkBifvMYgXWpFnaf/Bpd28dSw46cJalzlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgDQKl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgDQKl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:41:29 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A14D2221EA;
        Fri, 17 Apr 2020 10:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587120089;
        bh=lHB1NoiGfUWFSxW01s7mCG3LNiTaqRJg8T1vS2BHcBU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=k9CleFO05+Sm/1UuSuKkUY01NFgjtGs8zgfK6CZmawo5OAMlytqJ1y8tTLaF8f/P7
         rfvZgNdpms/NGDCdtzzaPuDkMNZRFidrG48GgEHLPrajOIkVgY3rpKNL/xHoQd1qkI
         oSOrdTGsOqrgs34zI5+WXpEe0n7tPmmGd/121aFU=
Message-ID: <faaf27530cafc9b00e81de58fb4ad153a1687622.camel@kernel.org>
Subject: Re: [v2] ceph: if we are blacklisted, __do_request returns directly
From:   Jeff Layton <jlayton@kernel.org>
To:     Yanhu Cao <gmayyyha@gmail.com>
Cc:     sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Apr 2020 06:41:27 -0400
In-Reply-To: <20200417093626.10892-1-gmayyyha@gmail.com>
References: <20200417093626.10892-1-gmayyyha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 17:36 +0800, Yanhu Cao wrote:
> If we mount cephfs by the recover_session option,
> __do_request can return directly until the client automatically reconnects.
> 
> Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> ---
>  fs/ceph/mds_client.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 486f91f9685b..e6cda256b136 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2708,6 +2708,12 @@ static void __do_request(struct ceph_mds_client *mdsc,
>  
>  	put_request_session(req);
>  
> +	if (mdsc->fsc->blacklisted &&
> +	    ceph_test_mount_opt(mdsc->fsc, CLEANRECOVER)) {
> +		err = -EACCES;
> +		goto finish;
> +	}
> +
>  	mds = __choose_mds(mdsc, req, &random);
>  	if (mds < 0 ||
>  	    ceph_mdsmap_get_state(mdsc->mdsmap, mds) < CEPH_MDS_STATE_ACTIVE) {

We do have an EBLACKLISTED error defined, which is the same as
ESHUTDOWN. The read and write code can return that when the client is
blacklisted. Same for cap handling (in __ceph_pool_perm_get. Should this
return -EBLACKLISTED instead?

-- 
Jeff Layton <jlayton@kernel.org>

