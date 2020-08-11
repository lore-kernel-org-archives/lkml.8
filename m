Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2D1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D96B20658
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="vi6BpXWY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IXJmmNKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgHKIg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:36:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57687 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728237AbgHKIg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:36:26 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 654F55C00D0;
        Tue, 11 Aug 2020 04:36:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 11 Aug 2020 04:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        XmkOTDau3GA4XwOfKDAkmAamcy7pGy3Ial0qb8HMlms=; b=vi6BpXWYJtMTm5Hf
        19E7qqoMJs/Q3bfqgUknAH/9oQl/znVXHDO7MjKpqHbnZlFLkdj6B/Eo2QCwa9ve
        cnADb4ttKLgus55JqlPzel2K4v53c6B/9hGLgTdp7Ta5oHTiVpSFOkYi8LvHGL4i
        1uM2PyEQnkgvLEFFP08afRPurP5KfeWJkXduVl9nl0kx6+P73W4G70Bn1AiKQEND
        ZV58w0ALWuUfTxDpza4qnYyA4GdwiyWbT917OjgPyZT/8CvfQ6HEaxZjSZjmr7Tk
        1F8XjXJ94mzIRLqdl1zyFNR53HRnaz6O7oNqLBq0Y3F7CFvRsKqAJ/v77YLEkkY2
        PcEFSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=XmkOTDau3GA4XwOfKDAkmAamcy7pGy3Ial0qb8HMl
        ms=; b=IXJmmNKH0HQPxtPlxpnml0NXFCQHdZ7PlpuDGQS2rCWXceSJWsmGdFLzs
        USoFcpA3r7lwtxDVQMb6Wk3owJdo4ICM2KLKW3QscsqxHiB0RaPik5AwXN8SQU/M
        /UyOher5UPYYyF8gaakROT5Ids1ELU2dl5HXcd1HgYZXnkvoYZ0eNJRNCcNDrRMb
        soj82EXXl8MF87L7rHTtURnEFAM6DbtbgRhgQEbiymhZiVipXd46bbM1n0kboC6A
        veuUtPjzNktHJXzIKkBReq1sowVAcvGRRfyGa/euyRobG1TnBQNtvIhVJRMXJk5F
        lNHkZuftnrSOaFv3CIskZY45kK9SA==
X-ME-Sender: <xms:hlgyX6Z-HyEut2jhq-jqwW4SxaWz8XsFnQ2lB-llARYr3rhAFQG5hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrledtgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvddtfedruddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:hlgyX9YsMGOWBMsaTs1_eHdDMvR-bMWkmTad6g8F8ns44w47c-kruQ>
    <xmx:hlgyX0-zc2SrAzt-aAje5gQDYRePFB5CLYCJnvKi8vJexn6AxqcGwg>
    <xmx:hlgyX8q-E8ykGbfUudosCG3hEoHdHD8zJy5meyDQPMYp-xsMmYOKjg>
    <xmx:iVgyXy3YBsm-K8dxTSBZPJPgfRvLO2S28OHQaPi3SFv5e3OHaZkieA>
Received: from mickey.themaw.net (58-7-203-114.dyn.iinet.net.au [58.7.203.114])
        by mail.messagingengine.com (Postfix) with ESMTPA id 57C9030600B7;
        Tue, 11 Aug 2020 04:36:21 -0400 (EDT)
Message-ID: <75e04b06be0561c3cec936cd3bbc44fe82ca73f4.camel@themaw.net>
Subject: Re: [PATCH] fs: autofs: delete repeated words in comments
From:   Ian Kent <raven@themaw.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     autofs@vger.kernel.org
Date:   Tue, 11 Aug 2020 16:36:17 +0800
In-Reply-To: <20200811021817.24982-1-rdunlap@infradead.org>
References: <20200811021817.24982-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-10 at 19:18 -0700, Randy Dunlap wrote:
> Drop duplicated words {the, at} in comments.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ian Kent <raven@themaw.net>
> Cc: autofs@vger.kernel.org

Acked-by: Ian Kent <raven@themaw.net>

> ---
>  fs/autofs/dev-ioctl.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200807.orig/fs/autofs/dev-ioctl.c
> +++ linux-next-20200807/fs/autofs/dev-ioctl.c
> @@ -20,7 +20,7 @@
>   * another mount. This situation arises when starting automount(8)
>   * or other user space daemon which uses direct mounts or offset
>   * mounts (used for autofs lazy mount/umount of nested mount trees),
> - * which have been left busy at at service shutdown.
> + * which have been left busy at service shutdown.
>   */
>  
>  typedef int (*ioctl_fn)(struct file *, struct autofs_sb_info *,
> @@ -496,7 +496,7 @@ static int autofs_dev_ioctl_askumount(st
>   * located path is the root of a mount we return 1 along with
>   * the super magic of the mount or 0 otherwise.
>   *
> - * In both cases the the device number (as returned by
> + * In both cases the device number (as returned by
>   * new_encode_dev()) is also returned.
>   */
>  static int autofs_dev_ioctl_ismountpoint(struct file *fp,

