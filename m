Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5126C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD154207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597759869;
	bh=DzJlUfzeP0TeP+vMc/ad4LTrDoiIKji4+B8EHTU9I/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uTbrfW4AgQlcBWXyo162+wqYUBDHALeK/W87FsLGEfuQ57ZaaxWzr1h5H7wYQB9fb
	 9Mr+gBfX+7GxGgCLDTC0iIBgR3VPNTI3WOyBp7AZMhdGeQ52Yw6ow5ssX05V/5SToD
	 4gPlLMjI0/hfo+SRrlQCjQKoFoEOUOlA/QKmUSH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHROLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHROLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:11:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D322E207FF;
        Tue, 18 Aug 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597759866;
        bh=DzJlUfzeP0TeP+vMc/ad4LTrDoiIKji4+B8EHTU9I/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCPJn/wrcQ95a8TPz+YUVrgTmkvhitNJeu5xmHCElpo4dCNdiPzpvIxo+MXFEO1GF
         a3LVKzU7+aTXg5jVnxwH3LDejNJzX2b+wC11ikAOnDwHbeRfcBcBoKgSmn42TtuqoH
         mmjzET9NHi2j3wASZIxa364MtTW6kbTCRGoFdVTA=
Date:   Tue, 18 Aug 2020 16:11:29 +0200
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
Subject: Re: [PATCH v2 3/4] staging: android: Convert BUG to WARN
Message-ID: <20200818141129.GC562377@kroah.com>
References: <cover.1597602783.git.tomersamara98@gmail.com>
 <3a483158a742a38589c8322e96fc00734da441d9.1597602783.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a483158a742a38589c8322e96fc00734da441d9.1597602783.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 10:30:10PM +0300, Tomer Samara wrote:
> replace BUG() with WARN() at ion_sytem_heap.c, this
> fix the following checkpatch issue:
> Avoid crashing the kernel - try using WARN_ON &
> recovery code ratherthan BUG() or BUG_ON().
> 
> Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
> ---
>  drivers/staging/android/ion/ion_system_heap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> index eac0632ab4e8..37065a59ca69 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -30,7 +30,8 @@ static int order_to_index(unsigned int order)
>  	for (i = 0; i < NUM_ORDERS; i++)
>  		if (order == orders[i])
>  			return i;
> -	BUG();
> +
> +	WARN(1, "%s: Did not found index to order %d", __FUNCTION__, order);

Same question as before, I think this didn't really change anything :(

