Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E81C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C83A206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZvRnrIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgFHHlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:41:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45763 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726009AbgFHHlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591602059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U6KmeXtm0Bl+dSBvtHMHAjusFXpE/4vUyZQzGB+0aKU=;
        b=AZvRnrIOAdpnO9x8lwPWEa37Y1koOPpdkHL7p2g16pWqdf3KRWfyIhnIx/P+it2EgbXaR+
        lFdX+Jp0KckIrITem4Mp5obqfGIum1NAkhKPpvtLGGf7P7jJL0aOBk6qN5TUw3KX30H7vM
        zfM28ryLBKnzokPEJjzYZf3l7jJYLbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-o1MrV7ngMHGzhaEkrzcEMg-1; Mon, 08 Jun 2020 03:40:55 -0400
X-MC-Unique: o1MrV7ngMHGzhaEkrzcEMg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 333088014D4;
        Mon,  8 Jun 2020 07:40:54 +0000 (UTC)
Received: from localhost (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B9EE610F2;
        Mon,  8 Jun 2020 07:40:49 +0000 (UTC)
Date:   Mon, 8 Jun 2020 15:40:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        akpm@linux-foundation.org, ebiederm@xmission.com, jbohac@suse.cz,
        jmorris@namei.org, mjg59@google.com, dyoung@redhat.com
Subject: Re: [PATCH v2] kexec: Do not verify the signature without the
 lockdown or mandatory signature
Message-ID: <20200608074047.GF20367@MiWiFi-R3L-srv>
References: <20200602045952.27487-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602045952.27487-1-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/20 at 12:59pm, Lianbo Jiang wrote:
> Signature verification is an important security feature, to protect
> system from being attacked with a kernel of unknown origin. Kexec
> rebooting is a way to replace the running kernel, hence need be
> secured carefully.
> 
> In the current code of handling signature verification of kexec kernel,
> the logic is very twisted. It mixes signature verification, IMA signature
> appraising and kexec lockdown.
> 
> If there is no KEXEC_SIG_FORCE, kexec kernel image doesn't have one of
> signature, the supported crypto, and key, we don't think this is wrong,
> Unless kexec lockdown is executed. IMA is considered as another kind of
> signature appraising method.
> 
> If kexec kernel image has signature/crypto/key, it has to go through the
> signature verification and pass. Otherwise it's seen as verification
> failure, and won't be loaded.
> 
> Seems kexec kernel image with an unqualified signature is even worse than
> those w/o signature at all, this sounds very unreasonable. E.g. If people
> get a unsigned kernel to load, or a kernel signed with expired key, which
> one is more dangerous?
> 
> So, here, let's simplify the logic to improve code readability. If the
> KEXEC_SIG_FORCE enabled or kexec lockdown enabled, signature verification
> is mandated. Otherwise, we lift the bar for any kernel image.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>

Looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>

> ---
> Changes since v1:
> [1] Modify the log level(suggested by Jiri Bohac)
> 
>  kernel/kexec_file.c | 34 ++++++----------------------------
>  1 file changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index faa74d5f6941..fae496958a68 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -181,34 +181,19 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  static int
>  kimage_validate_signature(struct kimage *image)
>  {
> -	const char *reason;
>  	int ret;
>  
>  	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
>  					   image->kernel_buf_len);
> -	switch (ret) {
> -	case 0:
> -		break;
> +	if (ret) {
>  
> -		/* Certain verification errors are non-fatal if we're not
> -		 * checking errors, provided we aren't mandating that there
> -		 * must be a valid signature.
> -		 */
> -	case -ENODATA:
> -		reason = "kexec of unsigned image";
> -		goto decide;
> -	case -ENOPKG:
> -		reason = "kexec of image with unsupported crypto";
> -		goto decide;
> -	case -ENOKEY:
> -		reason = "kexec of image with unavailable key";
> -	decide:
>  		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
> -			pr_notice("%s rejected\n", reason);
> +			pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
>  			return ret;
>  		}
>  
> -		/* If IMA is guaranteed to appraise a signature on the kexec
> +		/*
> +		 * If IMA is guaranteed to appraise a signature on the kexec
>  		 * image, permit it even if the kernel is otherwise locked
>  		 * down.
>  		 */
> @@ -216,17 +201,10 @@ kimage_validate_signature(struct kimage *image)
>  		    security_locked_down(LOCKDOWN_KEXEC))
>  			return -EPERM;
>  
> -		return 0;
> -
> -		/* All other errors are fatal, including nomem, unparseable
> -		 * signatures and signature check failures - even if signatures
> -		 * aren't required.
> -		 */
> -	default:
> -		pr_notice("kernel signature verification failed (%d).\n", ret);
> +		pr_debug("kernel signature verification failed (%d).\n", ret);
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  #endif
>  
> -- 
> 2.17.1
> 

