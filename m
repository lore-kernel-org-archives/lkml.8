Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8DDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0123F20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rapGkxmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgHUQ07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbgHUQZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:25:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE0C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=xuVadeWdbw5hMLtCCGfwXhTOKmF3zlYv1VDPzgpU+Gk=; b=rapGkxmx+afo18V0kOITIcUfAH
        suMc3xn/2axABqhmj29cOZIM1M1N78j0ZD7upvgrvPDhQ7QaI21WMYvfADAar+N4y5uwrxaxpYO/U
        25eSELHH+HL5SG6j4YSXQyzFAkRf6ytxpiWOSxdgnCsE8d1G93XO4qWdD7iUQVK+UgkK261mv+wyz
        6aq4nxIfo1b17Rf9iCp/AzAj+O0CB7B/GZSGgdNQ7iPaZtGLHh78seaj1H9IkFroE0YPHQ6oRUdCq
        lKo1XX2ZQsG6pqdOnLIQ6w3H6KGuJTLhEFbZ4jx++CRZPXssvvkC8JRVfotgrQktIsNI0HbbVRi/m
        WUdkexqA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k99r9-0000HT-2k; Fri, 21 Aug 2020 16:25:31 +0000
Subject: Re: [PATCH v4 2/2] staging: android: Remove BUG from
 ion_system_heap.c
To:     Tomer Samara <tomersamara98@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Riley Andrews <riandrews@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1598023523.git.tomersamara98@gmail.com>
 <a39407f84031eaeed5e65a7aab515a079edf5fcc.1598023524.git.tomersamara98@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3eba90dc-128f-49da-41a6-81494653d535@infradead.org>
Date:   Fri, 21 Aug 2020 09:25:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a39407f84031eaeed5e65a7aab515a079edf5fcc.1598023524.git.tomersamara98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/20 8:28 AM, Tomer Samara wrote:
> Remove BUG() from ion_sytem_heap.c
> 
> this fix the following checkpatch issue:
> Avoid crashing the kernel - try using WARN_ON &
> recovery code ratherthan BUG() or BUG_ON().
> 
> Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
> ---
>  drivers/staging/android/ion/ion_system_heap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> index eac0632ab4e8..00d6154aec34 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -30,7 +30,7 @@ static int order_to_index(unsigned int order)
>  	for (i = 0; i < NUM_ORDERS; i++)
>  		if (order == orders[i])
>  			return i;
> -	BUG();
> +	/* This is impossible. */
>  	return -1;
>  }

Hi,
Please explain why this is impossible.

If some caller calls order_to_index(5), it will return -1, yes?

-- 
~Randy

